import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

const String kCryptoToolReadMe = '''
## 简介

消息摘要将任意长度的字节流按照特定的算法计算成一个固定长度的摘要，相同的输入会得到相同的输出，常用来验证数据是否被篡改。

## 算法

常见的消息摘要算法包括 MD5/SHA1/SHA256 等

HMAC 是在消息摘要基础上增加一个密码，相同的消息，不同的密码会得到不同的摘要

''';

class CryptoToolPage extends StatelessWidget {
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
                CryptoTool(),
                Card(
                  elevation: 5,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: MarkdownBody(
                      selectable: true,
                      data: kCryptoToolReadMe,
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

class CryptoTool extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CryptoToolState();
}

class _CryptoToolState extends State<CryptoTool> {
  late TextEditingController _messageTextController;
  late TextEditingController _passwordTextController;
  String _convertedText = '';
  bool _enableHmac = false;

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
              ),
            ),
            _enableHmac ? SizedBox(height: 10) : Container(),
            _enableHmac
                ? TextField(
                    controller: _passwordTextController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '密码',
                      hintText: '请输入密码',
                    ),
                  )
                : Container(),
            SizedBox(height: 10),
            SwitchListTile(
              title: Text("HMAC"),
              value: _enableHmac,
              onChanged: (bool value) {
                setState(() {
                  this._enableHmac = value;
                });
              },
            ),
            SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 30,
              runSpacing: 10,
              children: [
                ["MD5", md5],
                ["SHA1", sha1],
                ["SHA224", sha224],
                ["SHA256", sha256],
                ["SHA384", sha384],
                ["SHA512", sha512],
              ]
                  .map((e) => ElevatedButton(
                        onPressed: () {
                          setState(() {
                            var hash = e[1] as Hash;
                            if (_enableHmac) {
                              var hmac = Hmac(hash, utf8.encode(_passwordTextController.value.text));
                              this._convertedText =
                                  hmac.convert(utf8.encode(_messageTextController.value.text)).toString();
                            } else {
                              this._convertedText =
                                  hash.convert(utf8.encode(_messageTextController.value.text)).toString();
                            }
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
