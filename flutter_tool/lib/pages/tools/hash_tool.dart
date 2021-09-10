import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

const String kHashToolReadMe = '''
## 简介

Hash，一般翻译做散列、杂凑，或音译为哈希，是把任意长度的输入（又叫做预映射pre-image）通过散列算法变换成固定长度的输出，该输出就是散列值。
这种转换是一种压缩映射，也就是，散列值的空间通常远小于输入的空间，不同的输入可能会散列成相同的输出，所以不可能从散列值来确定唯一的输入值。
简单的说就是一种将任意长度的消息压缩到某一固定长度的消息摘要的函数

## 算法

### FNV-1

算法描述

```
hash = offset_basis
for each octet_of_data to be hashed
    hash = hash * FNV_prime
    hash = hash xor octet_of_data
return hash
```

### FNV-1a

算法描述

```
hash = offset_basis
for each octet_of_data to be hashed
    hash = hash xor octet_of_data
    hash = hash * FNV_prime
return hash
```




''';

class HashToolPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('消息摘要')),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 800,
            child: Column(
              children: [
                HashTool(),
                Card(
                  elevation: 5,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: MarkdownBody(
                      selectable: true,
                      data: kHashToolReadMe,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HashTool extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HashToolState();
}

class _HashToolState extends State<HashTool> {
  late TextEditingController _messageTextController;
  late TextEditingController _passwordTextController;
  String _convertedNum = '';
  String _convertedHex = '';
  bool _enableBase64 = false;

  @override
  void initState() {
    super.initState();
    _messageTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _messageTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.fromLTRB(10, 50, 10, 20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _messageTextController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '消息',
                hintText: '请输入消息',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  splashRadius: 20,
                  onPressed: () {
                    _messageTextController.clear();
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            SwitchListTile(
              title: Text("Base64"),
              value: _enableBase64,
              onChanged: (bool value) {
                setState(() {
                  this._enableBase64 = value;
                });
              },
            ),
            SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 30,
              runSpacing: 10,
              children: [
                "fnv32",
                "fnv64",
                "fnv128",
                "fnv32a",
                "fnv64a",
                "fnv128a",
                "fnv32a",
                "fnv64a",
                "fnv128a",
                "crc32",
                "crc64-ecma",
                "crc64-iso",
                "adler32",
                "murmur3-32",
                "murmur3-64",
                "murmur3-128",
              ]
                  .map((e) => ElevatedButton(
                        onPressed: () async {
                          final Response<Map> res =
                              await Dio().post('http://k8s.rpc.tool.hatlonely.com/v1/tool/hash', data: {
                            'hash': e,
                            'text': _messageTextController.value.text,
                          });
                          print(res);
                          if (res.statusCode != 200) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('发生错误: ${res.toString()}'),
                            ));
                          }
                          setState(() {
                            this._convertedNum = (res.data as Map)['num'].toString();
                            this._convertedHex = (res.data as Map)['hex'].toString();
                          });
                        },
                        child: Text(e),
                      ))
                  .toList(),
            ),
            SizedBox(height: 10),
            Divider(),
            Column(
              children: [
                ['数值', _convertedNum],
                ['十六进制', _convertedHex],
              ]
                  .map((e) => ListTile(
                        title: Text(e[0]),
                        subtitle: SelectableText(
                          e[1],
                          onTap: () {
                            Clipboard.setData(new ClipboardData(text: e[1]));
                          },
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
