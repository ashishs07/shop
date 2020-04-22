import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import './auth_screen/auth_screen.dart';
import '../screens/home_screen/home_screen.dart';

class ScreenDecider extends StatefulWidget {
  @override
  _ScreenDeciderState createState() => _ScreenDeciderState();
}

class _ScreenDeciderState extends State<ScreenDecider> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).currentUser();
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    if (authData.user == null) return AuthScreen();
    return HomeScreen();
  }
}
