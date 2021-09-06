import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

const String kBinaryConversionToolReadMe = '''
## 简介

十六进制（简写为 hex 或下标 16）在数学中是一种逢 16 进 1 的进位制。一般用数字 0\-9 和字母 A\-F（或a\-f）表示，其中: A\-F 表示 10\-15，这些称作十六进制数字
''';

class BinaryConversionToolPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('进制转换')),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 800,
            child: Column(
              children: [
                BinaryConversionTool(),
                Card(
                  elevation: 5,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: MarkdownBody(
                      selectable: true,
                      data: kBinaryConversionToolReadMe,
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

class BinaryConversionTool extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BinaryConversionToolState();
}

class _BinaryConversionToolState extends State<BinaryConversionTool> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _textController;
  BigInt _bigInt = BigInt.zero;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
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
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '数字',
                  hintText: '请输入要转换的数字',
                ),
                validator: (String? text) {
                  return null;
                },
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 30,
              runSpacing: 10,
              children: [
                ["2进制", 2],
                ["4进制", 4],
                ["8进制", 8],
                ["10进制", 10],
                ["16进制", 16],
                ["32进制", 32],
              ]
                  .map((e) => ElevatedButton(
                        child: Text(e[0] as String),
                        onPressed: () {
                          setState(() {
                            this._bigInt = BigInt.parse(_textController.value.text, radix: e[1] as int);
                          });
                        },
                      ))
                  .toList(),
            ),
            SizedBox(height: 10),
            Divider(),
            ListView(
              shrinkWrap: true,
              children: [
                ["2进制", 2],
                ["4进制", 4],
                ["8进制", 8],
                ["10进制", 10],
                ["16进制", 16],
                ["32进制", 32],
              ]
                  .map((e) => ListTile(
                        title: Text(e[0] as String),
                        subtitle: Wrap(children: [SelectableText(_bigInt.toRadixString(e[1] as int))]),
                        dense: false,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
