import 'package:flutter/cupertino.dart';
import 'package:nanti_flutter_web/models/client_type.dart';
import 'package:nanti_flutter_web/services/client_type_service.dart';

class ClientTypeProvider extends ChangeNotifier {
  List<ClientType> _clientTypes = [];

  List<ClientType> get allClientTypes {
    ClientTypeService.allClientTypes().then((data) {
      _clientTypes = data;
    });
    return [..._clientTypes];
  }
}
