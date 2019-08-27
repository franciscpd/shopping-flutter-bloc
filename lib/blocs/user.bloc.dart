import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_bloc/settings.dart';
import 'package:shopping_bloc/models/user.model.dart';
import 'package:shopping_bloc/models/create-user.model.dart';
import 'package:shopping_bloc/models/authenticate-user.model.dart';
import 'package:shopping_bloc/repositories/account.repository.dart';

class UserBloc extends ChangeNotifier {
  UserModel user = new UserModel();

  UserBloc() {
    user = null;
    loadUser();
  }

  Future<UserModel> authenticate(AuthenticateModel model) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      AccountRepository repository = new AccountRepository();

      user = await repository.authenticate(model);
      await prefs.setString('user', jsonEncode(user));
    } catch (error) {
      user = null;
    }

    return user;
  }

  Future<UserModel> create(CreateUserModel model) async {
    try {
      AccountRepository repository = new AccountRepository();
      user = await repository.create(model);
    } catch (error) {
      print(error);
      user = null;
    }

    return user;
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', null);
    user = null;
    notifyListeners();
  }

  Future loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userData = prefs.getString('user');

    if (userData != null) {
      user = UserModel.fromJson(jsonDecode(userData));
      Settings.user = user;
    }
  }
}
