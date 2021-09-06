import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

const String kBinaryConversionToolReadMe = '''
## 简介

无
''';

class BinaryConversionToolPage extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
