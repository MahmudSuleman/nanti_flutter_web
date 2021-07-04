import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/providers/device_provider.dart';
import 'package:nanti_flutter_web/routes.dart';
import 'package:nanti_flutter_web/screens/admin/admin_dashboard.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';
import 'package:nanti_flutter_web/widgets/app_drawer.dart';
import 'package:nanti_flutter_web/widgets/main_container.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DeviceProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Devices Hub',
        theme: myThemeData(context),
        home: MyHomePage(),
        routes: routes,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  var isAdmin = false;

  @override
  Widget build(BuildContext context) {
    AuthService.autoLogout(context);
    AuthService.isAdmin().then((value) {
      if (value) isAdmin = true;
    });
    return Scaffold(
      // backgroundColor: Colors.black12,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.dehaze),
            onPressed: () {
              if (_scaffoldKey.currentState!.isDrawerOpen == false) {
                _scaffoldKey.currentState!.openDrawer();
              } else {
                _scaffoldKey.currentState!.openEndDrawer();
              }
            }),
        title: Text('Device Hub'),
      ),
      body: Scaffold(
        key: _scaffoldKey,
        body: MainContainer(
          // child: MyHomePage(),
          child: AdminDashBoard(),
        ),
        drawer: AppDrawer(),
      ),
    );
  }
}

ThemeData myThemeData(context) => ThemeData(
      primarySwatch: Colors.blue,
      // scaffoldBackgroundColor: Colors.black38,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).errorColor),
        ),
      ),
    );
