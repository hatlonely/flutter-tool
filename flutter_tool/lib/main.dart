import 'package:flutter/material.dart';
import 'package:flutter_tool/pages/tools/base64_tool_page.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.robotoCondensed().fontFamily,
        textTheme: TextTheme(
          headline1: TextStyle(fontFamilyFallback: fallbackFonts),
          headline2: TextStyle(fontFamilyFallback: fallbackFonts),
          headline3: TextStyle(fontFamilyFallback: fallbackFonts),
          headline4: TextStyle(fontFamilyFallback: fallbackFonts),
          headline5: TextStyle(fontFamilyFallback: fallbackFonts),
          headline6: TextStyle(fontFamilyFallback: fallbackFonts),
          bodyText2: TextStyle(fontFamilyFallback: fallbackFonts),
          bodyText1: TextStyle(fontFamilyFallback: fallbackFonts),
          subtitle1: TextStyle(fontFamilyFallback: fallbackFonts),
          subtitle2: TextStyle(fontFamilyFallback: fallbackFonts),
          button: TextStyle(fontFamilyFallback: fallbackFonts),
          caption: TextStyle(fontFamilyFallback: fallbackFonts),
          overline: TextStyle(fontFamilyFallback: fallbackFonts),
        ),
      ),
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
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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

  const _ToolCardItemInfo({required this.button, required this.route});
}

class ToolsGrid extends StatelessWidget {
  static const List<_ToolCardItemInfo> _toolCards = [
    _ToolCardItemInfo(button: "Base64 编解码", route: "/tool/base64"),
    _ToolCardItemInfo(button: "Base64 编解码", route: "/tool/base64"),
    _ToolCardItemInfo(button: "Base64 编解码", route: "/tool/base64"),
    _ToolCardItemInfo(button: "Base64 编解码", route: "/tool/base64"),
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
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: InkWell(
                      child: Text(e.button),
                      onTap: () => Navigator.pushNamed(context, e.route),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
