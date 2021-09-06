import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

const String kURLEncodeToolReadMe = '''
## 简介

只有字母和数字 `[0-9a-zA-Z]` 和一些特殊符号 `\$-_.+!*'(),`，以及某些保留字，才可以不经过编码直接用于 URL。
其他字符，比如中文，空格等都需经过编码才可用于 URL。
''';

class URLEncodeToolPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('URL 编解码')),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 800,
            child: Column(
              children: [
                URLEncodeTool(),
                Card(
                  elevation: 5,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: MarkdownBody(
                      selectable: true,
                      data: kURLEncodeToolReadMe,
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

class URLEncodeTool extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _URLEncodeToolState();
}

class _URLEncodeToolState extends State<URLEncodeTool> {
  late TextEditingController _urlEncodeTextController;
  String _convertedText = '';

  @override
  void initState() {
    super.initState();
    _urlEncodeTextController = TextEditingController();
  }

  @override
  void dispose() {
    _urlEncodeTextController.dispose();
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
              controller: _urlEncodeTextController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '转换文字',
                hintText: '请输入要转换的文字',
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      this._convertedText = Uri.encodeComponent(this._urlEncodeTextController.value.text);
                    });
                  },
                  child: Text('URL 编码'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      this._convertedText = Uri.decodeComponent(this._urlEncodeTextController.value.text);
                    });
                  },
                  child: Text('URL 解码'),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            SelectableText(
              this._convertedText,
              textAlign: TextAlign.left,
              onSelectionChanged: (TextSelection selection, SelectionChangedCause? cause) {
                Clipboard.setData(new ClipboardData(text: this._convertedText));
              },
            ),
          ],
        ),
      ),
    );
  }
}
