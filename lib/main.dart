import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/providers/client_type_provider.dart';
import 'package:nanti_flutter_web/providers/device_provider.dart';
import 'package:nanti_flutter_web/providers/manufacturer_provider.dart';
import 'package:nanti_flutter_web/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DeviceProvider()),
        ChangeNotifierProvider(create: (_) => ManufacturerProvider()),
        ChangeNotifierProvider(create: (_) => ClientTypeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Devices Hub',
        theme: myThemeData(context),
        initialRoute: '/',
        routes: routes,
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
