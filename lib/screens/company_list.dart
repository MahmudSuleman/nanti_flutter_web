import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/services/company_service.dart';
import 'package:nanti_flutter_web/widgets/main_container.dart';

class CompanyList extends StatelessWidget {
  static const routeName = '/company-list';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company List'),
      ),
      body: MainContainer(
        child: FutureBuilder(
          future: CompanyService.allCompanies(),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.done) {}
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
