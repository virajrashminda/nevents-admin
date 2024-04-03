import 'package:flutter/material.dart';
import 'package:nevents_admin/models/admin.dart' as models;
import 'package:nevents_admin/resoureces/auth_methods.dart';

class userprovider with ChangeNotifier {
  models.admin? _user;
  final authmethods _authmetods = authmethods();

  models.admin? get getUser => _user;

  Future<void> refreshUser() async {
    models.admin? user = await _authmetods.getuserdetails();
    _user = user;

    notifyListeners();
  }
}
