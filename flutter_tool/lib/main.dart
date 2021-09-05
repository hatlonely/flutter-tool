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
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/tool/base64'),
          child: Text("text"),
        ),
      ),
    );
  }
}
