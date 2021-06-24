import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';

class UserList extends StatelessWidget {
  static String routeName = '/user-list';

  @override
  Widget build(BuildContext context) {
    AuthService.autoLogout(context);

    return Container();
  }
}
