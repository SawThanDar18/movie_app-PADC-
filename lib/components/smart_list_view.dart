import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/resources/dimens.dart';

class SmartHorizontalListView extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsets padding;
  final Function onListEndReached;

  SmartHorizontalListView({
    required this.itemCount,
    required this.itemBuilder,
    required this.padding,
    required this.onListEndReached,
  });

  @override
  _SmartHorizontalListViewState createState() =>
      _SmartHorizontalListViewState();
}

class _SmartHorizontalListViewState extends State<SmartHorizontalListView> {
  var _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          print('Start of the list reached');
        } else {
          print("End of the list reached");
          widget.onListEndReached();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == 0) {
      return Container(
        child: Center(
          child: Text(
            "No Data!!!",
            style: TextStyle(
              color: Colors.white,
              fontSize: MARGIN_MEDIUM_2,
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: MOVIE_LIST_HEIGHT,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: this.widget.padding,
          itemCount: this.widget.itemCount,
          itemBuilder: this.widget.itemBuilder,
        ),
      );
    }
  }
}

/*
@override
Widget build(BuildContext context) {
  if (widget.itemCount == 0) {
    widget.emptyViewVisibility = true;
    widget.listViewVisibility = false;
  } else {
    widget.emptyViewVisibility = false;
    widget.listViewVisibility = true;
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Visibility(
        visible: widget.listViewVisibility,
        child: Container(
          height: MOVIE_LIST_HEIGHT,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: this.widget.padding,
            itemCount: this.widget.itemCount,
            itemBuilder: this.widget.itemBuilder,
          ),
        ),
      ),
      Visibility(
        visible: widget.emptyViewVisibility,
        child: Container(),),
    ],
  );
}*/
