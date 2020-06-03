library timeline;

import 'package:estonian_history/constants.dart';
import 'package:estonian_history/global.dart';
import 'package:flutter/material.dart';
import 'package:estonian_history/timeline_list/src/timeline_item.dart';
import 'package:estonian_history/timeline_list/src/timeline_painter.dart';
import 'package:estonian_history/timeline_list/timeline_model.dart';
import 'package:flutter_parallax/flutter_parallax.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef IndexedTimelineModelBuilder = TimelineModel Function(
    BuildContext context, int index);

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
  final ScrollController controller;
  final IndexedTimelineModelBuilder itemBuilder;
  final int itemCount;
  final TimelinePosition position;
  final TimelineProperties properties;
  final ScrollPhysics physics;
  final bool shrinkWrap;
  final bool primary;
  final bool reverse;

  /// Creates a scrollable timeline of widgets that are created befirehand.
  /// Note: [TimelineModel.icon]'s size is ignored when `position` is not
  /// [TimelinePosition.Center].
  Timeline(
      {List<TimelineModel> children,
      Color lineColor,
      double lineWidth,
      double iconSize,
      this.controller,
      this.position = TimelinePosition.Center,
      this.physics,
      this.shrinkWrap = false,
      this.primary = false,
      this.reverse = false})
      : itemCount = children.length,
        properties = TimelineProperties(
            lineColor: lineColor, lineWidth: lineWidth, iconSize: iconSize),
        itemBuilder = ((BuildContext context, int i) => children[i]);

  /// Creates a scrollable timeline of widgets that are created on demand.
  /// Note: `itemBuilder` position and [TimelineModel.icon]'s size is ignored
  /// when `position` is not [TimelinePosition.Center].
  Timeline.builder(
      {@required this.itemBuilder,
      this.itemCount,
      this.controller,
      Color lineColor,
      double lineWidth,
      double iconSize,
      this.position = TimelinePosition.Center,
      this.physics,
      this.shrinkWrap = true,
      this.primary = false,
      this.reverse = false})
      : properties = TimelineProperties(
            lineColor: lineColor, lineWidth: lineWidth, iconSize: iconSize);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          reverse: reverse,
          physics: physics,
          primary: primary,
          controller: backgroundScrollController,
          child: Column(
            children: <Widget>[
              SizedBox(height: 430),
              Parallax.inside(
                mainAxisExtent: 7000,
                child: SvgPicture.asset(
                  'assets/illustrations/cosmosBG.svg',
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
        CustomScrollView(
          reverse: reverse,
          physics: physics,
          primary: primary,
          // shrinkWrap: shrinkWrap,
          controller: controller,
          slivers: <Widget>[
            SliverAppBar(
              brightness: Brightness.light,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: Icon(
                      Icons.info_outline,
                      color: kText1Color,
                    ),
                    tooltip: 'someIcon',
                    onPressed: () {},
                  ),
                ),
              ],
              backgroundColor: kPrimaryColor,
              floating: false,
              pinned: false,
              expandedHeight: 400,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Eesti Ajalugu',
                    style: Theme.of(context).textTheme.headline5),
                background: SvgPicture.asset(
                    'assets/illustrations/rocket_boy_dark.svg'),
                collapseMode: CollapseMode.pin,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final TimelineModel model = itemBuilder(context, i);
                  model.isFirst = reverse ? i == (itemCount - 1) : i == 0;
                  model.isLast = reverse ? i == 0 : i == (itemCount - 1);
                  switch (position) {
                    default:
                      return TimelineItemLeft(
                          properties: properties, model: model);
                  }
                },
                childCount: itemCount, //why
              ),
            ),
          ],
        ),
      ],
    );
  }
}