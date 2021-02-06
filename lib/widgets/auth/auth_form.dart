import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String username,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  AuthForm(this.submitFn, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  bool _showPassword = false;

  void _trySubmit() {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: ValueKey('email'),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email Address",
                      ),
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        bool isValid = EmailValidator.validate(value.trim());
                        if (!isValid)
                          return "Please provide a valid email address.";
                        return null;
                      },
                      onSaved: (newValue) {
                        _userEmail = newValue;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return "Please enter at least 4 characters.";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _userName = newValue;
                        },
                        decoration: InputDecoration(
                          labelText: "Username",
                        ),
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return "Password must be at least 7 characters long.";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _userPassword = newValue;
                      },
                      obscureText: !_showPassword,
                      decoration: InputDecoration(
                          labelText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: _showPassword
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() => _showPassword = !_showPassword);
                            },
                          )),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      onPressed: _trySubmit,
                      child: widget.isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(_isLogin ? "Login" : "Signup"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                          _isLogin ? "Create new account!" : "Already a user?"),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
