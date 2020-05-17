import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/http_exception.dart';
import '../../providers/auth_provider.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;

  final _emailTextCont = TextEditingController();
  final _passTextCont = TextEditingController();
  var _isLoading = false;

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Authentication failed!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      FocusScope.of(context).unfocus();
      if (_authMode == AuthMode.Login) {
        await Provider.of<AuthProvider>(context, listen: false)
            .signInWithEmailAndPassword(
                _emailTextCont.text, _passTextCont.text);
      } else {
        await Provider.of<AuthProvider>(context, listen: false)
            .createUserWithEmailAndPassword(
                _emailTextCont.text, _passTextCont.text);
      }
    } on HttpException catch (error) {
      _showDialog(error.message);
    } catch (error) {
      _showDialog(error.toString());
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    _emailTextCont.clear();
    _passTextCont.clear();
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 320 : 260,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildEmailTTF(),
                _buildPasswordTTF(),
                if (_authMode == AuthMode.Signup) _buildConfPassTTF(),
                SizedBox(height: 20),
                _buildSubmitButton(),
                _buildInsteadButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTTF() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'E-Mail'),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextCont,
      validator: (value) {
        if (value.isEmpty || !value.contains('@')) {
          return 'Invalid email!';
        }
        return null;
      },
      onSaved: (value) {
        _emailTextCont.text = value;
      },
    );
  }

  Widget _buildPasswordTTF() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      controller: _passTextCont,
      validator: (value) {
        if (value.isEmpty || value.length < 5) {
          return 'Password is too short!';
        }
        return null;
      },
      onSaved: (value) {
        _passTextCont.text = value;
      },
    );
  }

  Widget _buildConfPassTTF() {
    return TextFormField(
      enabled: _authMode == AuthMode.Signup,
      decoration: InputDecoration(labelText: 'Confirm Password'),
      obscureText: true,
      validator: _authMode == AuthMode.Signup
          ? (value) {
              if (value != _passTextCont.text) {
                return 'Passwords do not match!';
              }
              return null;
            }
          : null,
    );
  }

  Widget _buildSubmitButton() {
    if (_isLoading)
      return CircularProgressIndicator();
    else
      return RaisedButton(
        child: Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
        onPressed: _submit,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
        color: Theme.of(context).primaryColor,
        textColor: Theme.of(context).primaryTextTheme.button.color,
      );
  }

  Widget _buildInsteadButton() {
    return FlatButton(
      child:
          Text('${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
      onPressed: _switchAuthMode,
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textColor: Theme.of(context).primaryColor,
    );
  }
}
