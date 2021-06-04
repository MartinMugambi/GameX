import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_store_app/constants.dart';
import 'package:game_store_app/screens/register_screen.dart';
import 'package:game_store_app/widgets/custom_button.dart';
import 'package:game_store_app/widgets/custom_input.dart';

class LoginScreen extends StatefulWidget {
  static final String id = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form input fields
  String _loginEmail = "";
  String _loginPassword = "";

  // show dialog
  Future<void> _alerDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Error Message'),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(' close Dialog'),
              ),
            ],
          );
        });
  }

  // create new user account
  Future<String> _loginAccount() async {
    try {
      UserCredential result =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _loginEmail,
        password: _loginPassword,
      );
      User user = result.user;
      print(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'the password provided is to weak';
      } else if (e.code == 'email-arleady in use') {
        return 'account arleady exists for that email';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // submit form method
  void _submitForm() async {
    // form loading state
    setState(() {
      _isLoadingFormLoading = true;
    });
    //create Account Method
    String _loginAccountFeedback = await _loginAccount();
    if (_loginAccountFeedback != null) {
      _alerDialogBuilder(_loginAccountFeedback);
      setState(() {
        _isLoadingFormLoading = false;
      });
    } else {}
  }

  bool _isLoadingFormLoading = false;
  //focusnode for input textfields
  FocusNode _passwordFocusNode;
  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 26.0,
                  ),
                  child: Text(
                    'Welcome User,\n Login into Account',
                    textAlign: TextAlign.center,
                    style: Constants.boldHeading,
                  ),
                ),
                Column(
                  children: [
                    CustomInput(
                      hintText: 'Email',
                      onChnaged: (value) {
                        _loginEmail = value;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    CustomInput(
                      hintText: 'Password',
                      isPasswordField: true,
                      onChnaged: (value) {
                        _loginPassword = value;
                      },
                      onSubmitted: (value) {
                        _passwordFocusNode.requestFocus();
                      },
                    ),
                    CustomBtn(
                      text: "Login",
                      onPressed: () {
                        _submitForm();
                      },
                      isLoading: _isLoadingFormLoading,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CustomBtn(
                    text: "Create New Account",
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, RegisterScreen.id);
                    },
                    outlineBtn: true,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
