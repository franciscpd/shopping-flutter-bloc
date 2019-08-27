import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_bloc/blocs/user.bloc.dart';
import 'package:shopping_bloc/models/authenticate-user.model.dart';
import 'package:shopping_bloc/models/user.model.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Usuário",
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe o usuário';
                  }

                  return null;
                },
                onSaved: (value) {
                  username = value;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe a senha';
                  }

                  return null;
                },
                onSaved: (value) {
                  password = value;
                },
              ),
              FlatButton(
                child: Text("Entrar"),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    authenticate(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  authenticate(BuildContext context) async {
    UserBloc bloc = Provider.of<UserBloc>(context);

    UserModel user = await bloc.authenticate(
      new AuthenticateModel(
        username: username,
        password: password,
      )
    );

    if (user != null) {
      Navigator.pop(context);
      return;
    }

    final SnackBar snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        "Usuário ou senha inválidos",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
