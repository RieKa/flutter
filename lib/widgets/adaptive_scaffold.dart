import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveScaffold extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final Widget body;
  final Function centerButtonAction;

  AdaptiveScaffold(
      {@required this.title,
      @required this.body,
      this.actions,
      this.centerButtonAction});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              title,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          )
        : AppBar(
            title: Text(
              title,
            ),
            actions: actions,
          );

    final pageBody = SafeArea(
      child: Container(
        child: body,
        height: mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top,
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => centerButtonAction(),
                  ),
          );
  }
}