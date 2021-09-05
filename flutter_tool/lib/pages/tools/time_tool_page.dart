import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

const String kTimeToolReadMe = '''
## 简介

Unix 时间戳返回 1970-01-01 到当前时间的秒数，Unix 时间戳不分时区，在任何时区都是一样的。

## 常用命令

获取当前时间戳

```
date +%s
```
''';

class TimeToolPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Base64 编解码')),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 600,
            child: Column(
              children: [
                TimeTool(),
                Card(
                  elevation: 5,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: MarkdownBody(
                      selectable: true,
                      data: kTimeToolReadMe,
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

class TimeTool extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TimeToolState();
}

class _TimeToolState extends State<TimeTool> {
  late TextEditingController _timeTextController;
  DateTime _time = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timeTextController = TextEditingController();
  }

  @override
  void dispose() {
    _timeTextController.dispose();
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
              controller: _timeTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '时间',
                hintText: '请输入要转换的时间或时间戳',
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // setState(() {
                    //   this._convertedText = base64.encode(utf8.encode(_base64TextController.value.text));
                    // });
                  },
                  child: Text('转换'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      this._time = DateTime.now();
                    });
                  },
                  child: Text('当前时间'),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("时间戳（秒）"),
                Divider(),
                SelectableText(
                  (this._time.millisecondsSinceEpoch ~/ 1000).toString(),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("时间戳（毫秒）"),
                Divider(),
                SelectableText(
                  (this._time.millisecondsSinceEpoch).toString(),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("ISO8601"),
                Divider(),
                SelectableText(
                  this._time.toIso8601String(),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("ISO8601 UTC"),
                Divider(),
                SelectableText(
                  this._time.toUtc().toIso8601String(),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
