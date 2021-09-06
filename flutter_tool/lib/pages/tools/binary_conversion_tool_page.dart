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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [],
              // children: [
              //   ElevatedButton(
              //     onPressed: () {
              //       if (!_formKey.currentState!.validate()) {
              //         return;
              //       }
              //       setState(() {
              //         var text = _textController.value.text;
              //         if (text == '') {
              //           this._time = DateTime.now();
              //           return;
              //         }
              //         if (kTimestampRegexp.hasMatch(text)) {
              //           this._time = DateTime.fromMillisecondsSinceEpoch(int.parse(text) * 1000);
              //           return;
              //         }
              //         var t = DateTime.tryParse(text);
              //         if (t != null) {
              //           this._time = t;
              //         }
              //       });
              //     },
              //     child: Text('转换'),
              //   ),
              //   ElevatedButton(
              //     onPressed: () {
              //       setState(() {
              //         this._time = DateTime.now();
              //       });
              //     },
              //     child: Text('当前时间'),
              //   ),
              //   ElevatedButton(
              //     onPressed: () {
              //       setState(() {
              //         this._time =
              //             DateTime.fromMillisecondsSinceEpoch(this._time.millisecondsSinceEpoch ~/ 3600000 * 3600000);
              //       });
              //     },
              //     child: Text('整点'),
              //   ),
              // ],
            ),
            SizedBox(height: 10),
            Divider(),
            // ListTile(
            //   title: Text("时间戳（秒）"),
            //   trailing: SelectableText((this._time.millisecondsSinceEpoch ~/ 1000).toString()),
            // ),
            // ListTile(
            //   title: Text("时间戳（毫秒）"),
            //   trailing: SelectableText((this._time.millisecondsSinceEpoch).toString()),
            // ),
            // ListTile(
            //   title: Text("时间"),
            //   trailing: SelectableText(this._time.toString()),
            // ),
            // ListTile(
            //   title: Text("ISO8601"),
            //   trailing: SelectableText(this._time.toIso8601String()),
            // ),
            // ListTile(
            //   title: Text("ISO8601 UTC"),
            //   trailing: SelectableText(this._time.toUtc().toIso8601String()),
            // ),
          ],
        ),
      ),
    );
  }
}
