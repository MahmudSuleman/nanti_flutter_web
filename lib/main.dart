import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/routes.dart';
import 'package:nanti_flutter_web/widgets/app_drawer.dart';
import 'package:nanti_flutter_web/widgets/main_container.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Devices Hub',
      theme: ThemeData(
          primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.black38),
      home: MyHomePage(),
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
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
          child: Text('hello main app'),
        ),
        drawer: AppDrawer(),
      ),
    );
  }
}
