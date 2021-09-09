import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

const String kBase64ToolReadMe = '''
## 简介

Base64 编码是一种将二进制流转化成可见字符的编码，使用 64 个可见字符，二进制中的每 6 位编码成一个可见字符，
剩下不足 6 位，用 0 填充

## 编码表

标准编码表

```
ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/
```

URL 编码表

```
ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_
```
''';

class Base64ToolPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Base64 编解码')),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 800,
            child: Column(
              children: [
                Base64Tool(),
                Card(
                  elevation: 5,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: MarkdownBody(
                      selectable: true,
                      data: kBase64ToolReadMe,
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

class Base64Tool extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Base64ToolState();
}

class _Base64ToolState extends State<Base64Tool> {
  late TextEditingController _base64TextController;
  String _convertedText = '';

  @override
  void initState() {
    super.initState();
    _base64TextController = TextEditingController();
  }

  @override
  void dispose() {
    _base64TextController.dispose();
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
              controller: _base64TextController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '转换文字',
                hintText: '请输入要转换的文字',
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 30,
              runSpacing: 10,
              children: [
                ["StdEncode", (String text) => base64.encode(utf8.encode(text))],
                ["URLEncode", (String text) => base64Url.encode(utf8.encode(text))],
                ["StdDecode", (String text) => utf8.decode(base64.decode(text))],
                ["URLDecode", (String text) => utf8.decode(base64Url.decode(text))],
              ]
                  .map((e) => ElevatedButton(
                        onPressed: () {
                          setState(() {
                            this._convertedText = (e[1] as Function)(_base64TextController.value.text);
                          });
                        },
                        child: Text(e[0] as String),
                      ))
                  .toList(),
            ),
            SizedBox(height: 10),
            Divider(),
            SelectableText(
              this._convertedText,
              textAlign: TextAlign.left,
              onTap: () {
                Clipboard.setData(new ClipboardData(text: this._convertedText));
              },
            ),
          ],
        ),
      ),
    );
  }
}
