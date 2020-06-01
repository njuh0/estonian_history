import 'package:estonian_history/timeline_list/src/timeline_item.dart';
import 'package:flutter/material.dart';
import 'package:estonian_history/timeline_list/timeline.dart';
import 'package:estonian_history/timeline_list/timeline_model.dart';
import 'package:estonian_history/data.dart';
import 'package:estonian_history/constants.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Timeline Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.reemKufiTextTheme(Theme.of(context).textTheme),
        scaffoldBackgroundColor: kPrimaryColor,
      ),
      home: TimelinePage(title: 'empty'),
    );
  }
}

class TimelinePage extends StatefulWidget {
  TimelinePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  final PageController pageController =
      PageController(initialPage: 1, keepPage: true);
  int pageIx = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eesti ajalugu',
          style: TextStyle(color: kText2Color),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: timelineModel(TimelinePosition.Left),
    );
  }

////////////////////////////////////////////////////////////////////////// physics
  timelineModel(TimelinePosition position) => Timeline.builder(
      itemBuilder: centerTimelineBuilder,
      itemCount: events.length,
      physics: BouncingScrollPhysics(),
      position: position);

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final event = events[i];
    final textTheme = Theme.of(context).textTheme;
    return TimelineModel(
      Card(
        margin: EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network(event.image),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                event.name,
                style: textTheme.headline6,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                event.content,
                style: textTheme.subtitle2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
      ),
      position:
          i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
      isFirst: i == 0,
      isLast: i == events.length,
      iconBackground: event.iconBackground,
      year: event.year,
    );
  }
}
