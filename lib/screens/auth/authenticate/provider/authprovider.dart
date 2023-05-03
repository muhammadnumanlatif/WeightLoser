import 'package:flutter/cupertino.dart';
import 'package:weight_loser/screens/auth/authenticate/model/authmodel.dart';

class authModeprovider extends ChangeNotifier {
  authModel _auth = authModel();
  setData(bool noti) {
    _auth.isGoogleOrFB = noti;
    //notifyListeners();
  }

  getData() {
    return _auth.isGoogleOrFB;
  }
}
