import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

const String kTimeToolReadMe = '''
## 简介

UNIX 时间戳返回 1970-01-01 到当前时间的秒数，不考虑闰秒。UNIX 时间戳不分时区，在任何时区都是一样的。在大多数的 UNIX 系统中 UNIX 时间戳存储为 32 位，这样会引发 2038 年问题或 Y2038。

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
      appBar: AppBar(title: const Text('UNIX 时间戳')),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 800,
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
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _timeTextController;
  DateTime _time = DateTime.now();

  static final kTimestampRegexp = RegExp(r'^\d{1,10}$');

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
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _timeTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '时间',
                  hintText: '请输入要转换的时间或时间戳',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    splashRadius: 20,
                    onPressed: () {
                      _timeTextController.clear();
                    },
                  ),
                ),
                validator: (String? text) {
                  if (text == null || text == '') {
                    return null;
                  }
                  if (kTimestampRegexp.hasMatch(text)) {
                    return null;
                  }
                  var t = DateTime.tryParse(text);
                  if (t == null) {
                    return "无效的时间格式";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    setState(() {
                      var text = _timeTextController.value.text;
                      if (text == '') {
                        this._time = DateTime.now();
                        return;
                      }
                      if (kTimestampRegexp.hasMatch(text)) {
                        this._time = DateTime.fromMillisecondsSinceEpoch(int.parse(text) * 1000);
                        return;
                      }
                      var t = DateTime.tryParse(text);
                      if (t != null) {
                        this._time = t;
                      }
                    });
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
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      this._time =
                          DateTime.fromMillisecondsSinceEpoch(this._time.millisecondsSinceEpoch ~/ 3600000 * 3600000);
                    });
                  },
                  child: Text('整点'),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            ListView(
              shrinkWrap: true,
              children: [
                ["时间戳（秒）", (this._time.millisecondsSinceEpoch ~/ 1000).toString()],
                ["时间戳（毫秒）", (this._time.millisecondsSinceEpoch).toString()],
                ["时间", this._time.toString()],
                ["ISO8601", this._time.toIso8601String()],
                ["ISO8601 UTC", this._time.toUtc().toIso8601String()],
              ]
                  .map((e) => ListTile(
                        title: Text(e[0]),
                        trailing: SelectableText(
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
