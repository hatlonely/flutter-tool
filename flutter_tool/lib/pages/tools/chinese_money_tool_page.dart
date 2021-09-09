import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

const String kChineseMoneyToolReadMe = '''
## 简介

将人民币的数值转成大写形式

## 样例

输出结果：
转换前数字： 45.12
转换后的中文大写： 肆拾伍元壹角贰分

转换前数字： 97953164651665.123
转换后的中文大写： 玖拾柒万玖仟伍佰叁拾壹亿陆仟肆佰陆拾伍万壹仟陆佰陆拾伍元壹角贰分叁厘

转换前数字： 25000
转换后的中文大写： 贰万伍仟元

转换前数字： 363,5
转换后的中文大写： 叁仟陆佰叁拾伍元
```
''';

class ChineseMoneyToolPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('人命币转大写')),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 800,
            child: Column(
              children: [
                ChineseMoneyTool(),
                Card(
                  elevation: 5,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: MarkdownBody(
                      selectable: true,
                      data: kChineseMoneyToolReadMe,
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

class ChineseMoneyTool extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChineseMoneyToolState();
}

class _ChineseMoneyToolState extends State<ChineseMoneyTool> {
  late TextEditingController _chineseMoneyTextController;
  String _convertedText = '';

  @override
  void initState() {
    super.initState();
    _chineseMoneyTextController = TextEditingController();
  }

  @override
  void dispose() {
    _chineseMoneyTextController.dispose();
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
              controller: _chineseMoneyTextController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '转换文字',
                hintText: '请输入要转换的文字',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  splashRadius: 20,
                  onPressed: () {
                    _chineseMoneyTextController.clear();
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 30,
              runSpacing: 10,
              children: [
                ["转换", ConvertNumberToChineseMoneyWords.toChinese],
              ]
                  .map((e) => ElevatedButton(
                        onPressed: () {
                          setState(() {
                            this._convertedText = (e[1] as Function)(_chineseMoneyTextController.value.text);
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

class ConvertNumberToChineseMoneyWords {
  // 大写数字
  static const List<String> kNumbers = ["零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖"];

  // 整数部分的单位
  static const List<String> kIUnit = ["元", "拾", "佰", "仟", "万", "拾", "佰", "仟", "亿", "拾", "佰", "仟", "万", "拾", "佰", "仟"];

  // 小数部分的单位
  static const List<String> kDUnit = ["角", "分", "厘"];

  //转成中文的大写金额
  static String toChinese(String str) {
    if (str == "0" || str == "0.00") {
      return "零元";
    }
    // 去掉","
    str = str.replaceAll(",", "");
    // 整数部分数字
    String integerStr;
    // 小数部分数字
    String decimalStr;

    // 初始化：分离整数部分和小数部分
    if (str.indexOf(".") > 0) {
      integerStr = str.substring(0, str.indexOf("."));
      decimalStr = str.substring(str.indexOf(".") + 1);
    } else if (str.indexOf(".") == 0) {
      integerStr = "";
      decimalStr = str.substring(1);
    } else {
      integerStr = str;
      decimalStr = "";
    }

    // 超出计算能力，直接返回
    if (integerStr.length > kIUnit.length) {
      print(str + "：超出计算能力");
      return str;
    }

    // 整数部分数字
    var integers = toIntArray(integerStr);
    // 设置万单位
    bool isWan = isWanYuan(integerStr);
    // 小数部分数字
    var decimals = toIntArray(decimalStr);
    // 返回最终的大写金额
    return getChineseInteger(integers, isWan) + getChineseDecimal(decimals);
  }

  // 将字符串转为int数组
  static List<int> toIntArray(String number) {
    List<int> array = [];
    if (array.length > number.length) {
      throw new Exception("数组越界异常");
    } else {
      for (int i = 0; i < number.length; i++) {
        array.insert(i, int.parse(number.substring(i, i + 1)));
      }
      return array;
    }
  }

  // 判断当前整数部分是否已经是达到【万】
  static bool isWanYuan(String integerStr) {
    int length = integerStr.length;
    if (length > 4) {
      String subInteger = "";
      if (length > 8) {
        subInteger = integerStr.substring(length - 8, length - 4);
      } else {
        subInteger = integerStr.substring(0, length - 4);
      }
      return int.parse(subInteger) > 0;
    } else {
      return false;
    }
  }

  // 将整数部分转为大写的金额
  static String getChineseInteger(var integers, bool isWan) {
    StringBuffer chineseInteger = new StringBuffer("");
    int length = integers.length;
    for (int i = 0; i < length; i++) {
      String key = "";
      if (integers[i] == 0) {
        // 万（亿）
        if ((length - i) == 13)
          key = kIUnit[4];
        else if ((length - i) == 9) {
          // 亿
          key = kIUnit[8];
        } else if ((length - i) == 5 && isWan) {
          // 万
          key = kIUnit[4];
        } else if ((length - i) == 1) {
          // 元
          key = kIUnit[0];
        }
        if ((length - i) > 1 && integers[i + 1] != 0) {
          key += kNumbers[0];
        }
      }
      chineseInteger.write(integers[i] == 0 ? key : (kNumbers[integers[i]] + kIUnit[length - i - 1]));
    }
    return chineseInteger.toString();
  }

  // 将小数部分转为大写的金额
  static String getChineseDecimal(var decimals) {
    StringBuffer chineseDecimal = new StringBuffer("");
    for (int i = 0; i < decimals.length; i++) {
      if (i == 3) {
        break;
      }
      chineseDecimal.write(decimals[i] == 0 ? "" : (kNumbers[decimals[i]] + kDUnit[i]));
    }
    return chineseDecimal.toString();
  }
}
