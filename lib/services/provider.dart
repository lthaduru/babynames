import 'package:flutter/material.dart';
import 'package:baby_names/services/authentication.dart';

class Provider extends InheritedWidget {
  final BaseAuth auth;

  Provider({
    Key key,
    Widget child,
    this.auth,
  }) : super(
    key: key,
    child: child,
  );

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(Provider) as Provider);
}