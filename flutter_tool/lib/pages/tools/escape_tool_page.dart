import 'dart:convert' show HtmlEscape;
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:html_unescape/html_unescape.dart';

const String kEscapeToolReadMe = '''
## 简介

各种字符串转义

### 单双引号转义

大多数语言中字符串一般使用单引号或者双引号，如果字符串中本身包含引号，就将引号转义才能表示

### HTML 转义

在 HTML 中的有特殊字符有特殊含义，比如 `<` 就是标签的开始，如果元素中包含这些字符，就需要成特殊的符号，常见的字符转义

| 符号 | 名称   | 转义名称 | 转义编号 |
| ---- | ------ | -------- | -------- |
|      | 空格   | &nbsp;   | &#160;   |
| <    | 小于号 | &lt;     | &#60;    |
| >    | 大于号 | &gt;     | &#62;    |
| &    | 和号   | &amp;    | &#38;    |
| "    | 引号   | &quot;   | &#34;    |
| '    | 撇号   | &apos;   | &#39;    |

### URL 编解码

只有字母和数字 `[0-9a-zA-Z]` 和一些特殊符号 `\$-_.+!*'(),`，以及某些保留字，才可以不经过编码直接用于 URL。
其他字符，比如中文，空格等都需经过编码才可用于 URL
''';

class EscapeToolPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('字符串转义')),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 800,
            child: Column(
              children: [
                EscapeTool(),
                Card(
                  elevation: 5,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: MarkdownBody(
                      selectable: true,
                      data: kEscapeToolReadMe,
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

class EscapeTool extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EscapeToolState();
}

class _EscapeToolState extends State<EscapeTool> {
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
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 30,
              runSpacing: 10,
              children: [
                ["URL 编码", Uri.encodeComponent],
                ["URL 解码", Uri.decodeComponent],
                ["HTML 转义", HtmlEscape().convert],
                ["HTML 反转义", HtmlUnescape().convert],
                ["双引号转义", (String text) => text.replaceAll('\\', '\\\\').replaceAll('"', '\\"')],
                ["双引号反转义", (String text) => text.replaceAll('\\"', '"').replaceAll('\\\\', '\\')],
                ["单引号转义", (String text) => text.replaceAll('\\', '\\\\').replaceAll("'", "\\'")],
                ["单引号反转义", (String text) => text.replaceAll("\\'", "'").replaceAll('\\\\', '\\')],
              ]
                  .map((e) => ElevatedButton(
                        onPressed: () {
                          setState(() {
                            this._convertedText = (e[1] as Function)(this._urlEncodeTextController.value.text);
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
