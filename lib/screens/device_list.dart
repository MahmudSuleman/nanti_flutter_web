import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/screens/add_device.dart';
import 'package:nanti_flutter_web/widgets/main_container.dart';

class DeviceList extends StatefulWidget {
  const DeviceList({Key? key}) : super(key: key);
  static const routeName = '/device-list';

  @override
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Lists'),
      ),
      body: MainContainer(
        child: Column(
          children: [
            Text(
              "Device List",
              style: kPageHeaderTextStyle,
              textAlign: TextAlign.center,
            ),
            Divider(),
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AddDevice.routeName);
                      },
                      child: Text('Add a Device')),
                )),
            Divider(),
            SizedBox(
              height: 20,
            ),
            Table(
              children: [
                TableRow(children: [
                  Text('hello'.toUpperCase()),
                  Text('hello'),
                  Text('hello'),
                  Text('hello'),
                ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
