import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tool/pages/tools/base64_tool_page.dart';
import 'package:flutter_tool/pages/tools/binary_conversion_tool_page.dart';
import 'package:flutter_tool/pages/tools/crypto_tool_page.dart';
import 'package:flutter_tool/pages/tools/time_tool_page.dart';
import 'package:flutter_tool/pages/tools/url_encode_tool_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  // GoogleFonts.config.allowRuntimeFetching = false;
  runApp(ToolApp());
}

class ToolApp extends StatelessWidget {
  ToolApp({
    Key? key,
  }) : super(key: key);

  final List<String> fallbackFonts = [GoogleFonts.robotoCondensed().fontFamily!, GoogleFonts.zcoolKuaiLe().fontFamily!];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '程序员工具集',
      theme: FlexColorScheme.light(
        scheme: FlexScheme.bigStone,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        // fontFamily: GoogleFonts.robotoCondensed().fontFamily,
        // fontFamily: GoogleFonts.longCang().fontFamily,
        // fontFamily: 'SourceHanSansSC',
        transparentStatusBar: true,
        appBarElevation: 5,
      ).toTheme,
      themeMode: ThemeMode.system,
      routes: HomePage.routes,
      home: HomePage(title: '程序员工具集'),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;

  HomePage({Key? key, required this.title}) : super(key: key);

  static final routes = {
    '/tool/base64': (context) => Base64ToolPage(),
    '/tool/time': (context) => TimeToolPage(),
    '/tool/urlencode': (context) => URLEncodeToolPage(),
    '/tool/crypto': (context) => CryptoToolPage(),
    '/tool/binaryConversion': (context) => BinaryConversionToolPage(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text(this.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 800,
            child: Column(
              children: [ToolsGrid()],
            ),
          ),
        ),
      ),
    );
  }
}

class _ToolCardItemInfo {
  final String button;
  final String route;

  const _ToolCardItemInfo({
    required this.button,
    required this.route,
  });
}

class ToolsGrid extends StatelessWidget {
  static const List<_ToolCardItemInfo> _toolCards = [
    _ToolCardItemInfo(button: "Base64 编解码", route: "/tool/base64"),
    _ToolCardItemInfo(button: "UNIX 时间戳", route: "/tool/time"),
    _ToolCardItemInfo(button: "URL 编解码", route: "/tool/urlencode"),
    _ToolCardItemInfo(button: "消息摘要", route: "/tool/crypto"),
    _ToolCardItemInfo(button: "进制转换", route: "/tool/binaryConversion"),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.fromLTRB(10, 50, 10, 20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.extent(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          maxCrossAxisExtent: 200.0,
          physics: NeverScrollableScrollPhysics(),
          children: _toolCards
              .map((e) => Card(
                    elevation: 5,
                    color: Theme.of(context).colorScheme.primaryVariant,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: InkWell(
                      child: Center(
                        child: Text(e.button, style: TextStyle(color: Colors.white)),
                      ),
                      onTap: () => Navigator.pushNamed(context, e.route),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
