import 'package:estonian_history/constants.dart';
import 'package:estonian_history/event.dart';
import 'package:estonian_history/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

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
  double textlen;

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
          SingleChildScrollView(
            reverse: false,
            physics: BouncingScrollPhysics(),
            primary: false,
            controller: infoBackground1ScrollController,
            child: Container(
              width: double.infinity,
              child: SvgPicture.asset(
                'assets/illustrations/cosmosBG1.svg',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SingleChildScrollView(
            reverse: false,
            physics: BouncingScrollPhysics(),
            primary: false,
            controller: infoBackground2ScrollController,
            child: Container(
              width: double.infinity,
              child: SvgPicture.asset(
                'assets/illustrations/cosmosBG2.svg',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SingleChildScrollView(
            reverse: false,
            physics: BouncingScrollPhysics(),
            primary: false,
            controller: infoBackground3ScrollController,
            child: Container(
              width: double.infinity,
              child: SvgPicture.asset(
                'assets/illustrations/cosmosBG3.svg',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
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
                  child: Text(' '), //without Text, blur doesn't work
                ),
              ),
            ),
          ),
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverFixedExtentList(
                itemExtent: 35,
                delegate: SliverChildListDelegate([Container(color: Colors.transparent,)]),
              ),
              SliverAppBar(
                brightness: Brightness.light,
                iconTheme: IconThemeData(
                  color: kText2Color,
                ),
                elevation: 0,
                title: Container(
                  child: Text(event.subDate + " " + event.date,
                      style: Theme.of(context).textTheme.headline5),
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
