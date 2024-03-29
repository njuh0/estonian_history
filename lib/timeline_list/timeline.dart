library timeline;

import 'package:Eesti_Ajalugu/constants.dart';
import 'package:Eesti_Ajalugu/models/event.dart';
import 'package:Eesti_Ajalugu/screens/history_timeline/history_info.dart';
import 'package:Eesti_Ajalugu/transitions/fade_route.dart';
import 'package:flutter/material.dart';
import 'package:Eesti_Ajalugu/timeline_list/src/timeline_item.dart';
import 'package:Eesti_Ajalugu/timeline_list/src/timeline_painter.dart';
import 'package:Eesti_Ajalugu/timeline_list/timeline_model.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

typedef IndexedTimelineModelBuilder = TimelineModel Function(
    BuildContext context, int indexm, Map<List<Event>, List<Event>> events);

enum TimelinePosition { Left, Center, Right }

class TimelineProperties {
  final Color lineColor;
  final double lineWidth;
  final double iconSize;

  const TimelineProperties({Color lineColor, double lineWidth, double iconSize})
      : lineColor = lineColor ?? const Color(0xFF333333),
        lineWidth = lineWidth ?? 2.5,
        iconSize = iconSize ?? TimelineBoxDecoration.DEFAULT_ICON_SIZE;
}

class Timeline extends StatelessWidget {
  final tKey;
  final ScrollController controller;
  final IndexedTimelineModelBuilder itemBuilder;
  final int itemCount;
  final TimelinePosition position;
  final TimelineProperties properties;
  final ScrollPhysics physics;
  final bool shrinkWrap;
  final bool primary;
  final bool reverse;
  final String periodTitle;
  final Map<List<Event>, List<Event>> events;

  /// Creates a scrollable timeline of widgets that are created befirehand.
  /// Note: [TimelineModel.icon]'s size is ignored when `position` is not
  /// [TimelinePosition.Center].
  Timeline(
      {List<TimelineModel> children,
      Color lineColor,
      double lineWidth,
      double iconSize,
      this.tKey,
      this.controller,
      this.position = TimelinePosition.Center,
      this.physics,
      this.shrinkWrap = false,
      this.primary = false,
      this.reverse = false,
      this.periodTitle,
      this.events})
      : itemCount = children.length,
        properties = TimelineProperties(
            lineColor: lineColor, lineWidth: lineWidth, iconSize: iconSize),
        itemBuilder = ((BuildContext context, int i,
                Map<List<Event>, List<Event>> events) =>
            children[i]);

  /// Creates a scrollable timeline of widgets that are created on demand.
  /// Note: `itemBuilder` position and [TimelineModel.icon]'s size is ignored
  /// when `position` is not [TimelinePosition.Center].
  Timeline.builder(
      {@required this.itemBuilder,
      this.itemCount,
      this.tKey,
      this.controller,
      Color lineColor,
      double lineWidth,
      double iconSize,
      this.position = TimelinePosition.Center,
      this.physics,
      this.shrinkWrap = true,
      this.primary = false,
      this.reverse = false,
      this.periodTitle,
      this.events})
      : properties = TimelineProperties(
            lineColor: lineColor, lineWidth: lineWidth, iconSize: iconSize);

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeaderBuilder(
      builder: (context, state) => Container(
        height: 60.0,
        color: (state.isPinned ? kPrimaryColor : Colors.transparent),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Stack(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(right: 50),
                alignment: Alignment.centerLeft,
                child: Text(periodTitle,
                    style: TextStyle(
                        fontFamily: 'Exo2', fontSize: 15, color: kText2Color))),
            GestureDetector(
              onTap: () {
                Scrollable.ensureVisible(tKey.currentContext,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              child: Container(
                key: tKey,
                width: double.infinity,
                height: 60,
                child: Text(''), // necessary, for onTap
              ),
            ),
            state.isPinned
                ? Container()
                : events.keys.toList()[0][0] == null
                    ? Container()
                    : Container(
                        width: double.infinity,
                        height: 60,
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.more_horiz,
                            color: kText1Color,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                FadeRoute(
                                    page: HistoryInfo(
                                        events.keys.toList()[0][0])));
                          },
                        ),
                      ),
          ],
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) {
            final TimelineModel model = itemBuilder(context, i, events);
            model.isFirst = reverse ? i == (itemCount - 1) : i == 0;
            model.isLast = reverse ? i == 0 : i == (itemCount - 1);
            return TimelineItemLeft(properties: properties, model: model);
          },
          childCount: itemCount,
        ),
      ),
    );
  }
}
