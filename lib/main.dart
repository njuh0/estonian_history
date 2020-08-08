import 'package:estonian_history/constants.dart';
import 'package:estonian_history/screens/home.dart';
import 'package:estonian_history/widgets/my_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder,
          'assets/illustrations/rocket_boy_no_stars.svg'),
      null);
  runApp(EstonianHistory());
}

class EstonianHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'Eesti Ajalugu',
      theme: ThemeData(
        primaryIconTheme: IconThemeData(color: kText1Color),
        textTheme: TextTheme(
          caption: GoogleFonts.gabriela(fontSize: 30, color: kText2Color),
          headline5: GoogleFonts.gabriela(fontSize: 25, color: kText2Color),
          headline6: GoogleFonts.gabriela(fontSize: 20, color: kText2Color),
          subtitle1: GoogleFonts.gabriela(fontSize: 17, color: kText2Color),
          subtitle2: GoogleFonts.gabriela(fontSize: 15, color: kText2Color),
          bodyText1: GoogleFonts.gabriela(fontSize: 14, color: kText2Color),
          bodyText2: GoogleFonts.gabriela(fontSize: 10, color: kText2Color),
        ),
        scaffoldBackgroundColor: kPrimaryColor,
      ),
      home: Home(),
    );
  }
}
