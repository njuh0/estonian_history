import 'package:auto_size_text/auto_size_text.dart';
import 'package:Eesti_Ajalugu/components/backgroundIllustration.dart';
import 'package:Eesti_Ajalugu/constants.dart';
import 'package:Eesti_Ajalugu/models/event.dart';
import 'package:Eesti_Ajalugu/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';

import 'package:marquee/marquee.dart';

class HistoryInfo extends StatefulWidget {
  final Event event;
  HistoryInfo(this.event);

  @override
  _HistoryInfoState createState() => _HistoryInfoState(event);
}

class _HistoryInfoState extends State<HistoryInfo> {
  Event event;
  _HistoryInfoState(this.event);

  final ScrollController infoBackground1ScrollController = ScrollController();
  final ScrollController infoBackground2ScrollController = ScrollController();
  final ScrollController infoBackground3ScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      infoBackground1ScrollController
          .jumpTo(background1ScrollController.position.pixels);
      infoBackground2ScrollController
          .jumpTo(background2ScrollController.position.pixels);
      infoBackground3ScrollController
          .jumpTo(background3ScrollController.position.pixels);
    });
  }

  @override
  Widget build(BuildContext context) {
    contextHistoryInfo = context;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Stack(
              children: backgroundIllustration([
            infoBackground1ScrollController,
            infoBackground2ScrollController,
            infoBackground3ScrollController
          ])),
          Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 8.0,
                  sigmaY: 8.0,
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: double.infinity,
                  child: Text(' '), //without Text(Widget), blur doesn't work
                ),
              ),
            ),
          ),
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                brightness: Brightness.light,
                iconTheme: IconThemeData(
                  color: kText2Color,
                ),
                elevation: 0,
                title: AutoSizeText(
                  event.subDate + " " + event.date,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headline5,
                  minFontSize: Theme.of(context).textTheme.headline5.fontSize,
                  overflowReplacement: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Marquee(
                      text: event.subDate + " " + event.date,
                      style: Theme.of(context).textTheme.headline5,
                      blankSpace: 20.0,
                      velocity: 100.0,
                      pauseAfterRound: Duration(seconds: 1),
                      accelerationDuration: Duration(seconds: 1),
                      accelerationCurve: Curves.linear,
                      decelerationDuration: Duration(milliseconds: 500),
                      decelerationCurve: Curves.easeOut,
                    ),
                  ),
                ),
                backgroundColor: kPrimaryColor.withOpacity(0.0),
                flexibleSpace: Container(
                  margin: EdgeInsets.only(top: 80),
                  child: Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Container(),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (c, i) {
                    return Column(
                      children: <Widget>[
                        Container(
                          child: Card(
                            margin: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(16.0)),
                            elevation: 0,
                            color: Colors.white60,
                            child: Opacity(
                              opacity: 1,
                              child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: event.text),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  childCount: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
