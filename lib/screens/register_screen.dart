import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_store_app/constants.dart';
import 'package:game_store_app/screens/home_screen.dart';
import 'package:game_store_app/screens/login_screen.dart';
import 'package:game_store_app/widgets/custom_button.dart';
import 'package:game_store_app/widgets/custom_input.dart';

class RegisterScreen extends StatefulWidget {
  static final String id = "register_screen";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // form input values
  String _registerName = "";
  String _regiterEmail = "";
  String _regiterPassword = "";

  User _user = FirebaseAuth.instance.currentUser;

  //Dialog to display error messages
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

  //

  // create new user account
  Future<String> _createAccount() async {
    try {
      UserCredential result =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _regiterEmail,
        password: _regiterPassword,
      );
      User user = result.user;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('/users')
            .doc(user.uid)
            .set({
          'fullname': _registerName,
          'email': _regiterEmail,
        });
      }
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
      _isregisterFormLoading = true;
    });
    //create Account Method
    String _createAccountFeedback = await _createAccount();
    if (_createAccountFeedback != null) {
      _alerDialogBuilder(_createAccountFeedback);
      setState(() {
        _isregisterFormLoading = false;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  bool _isregisterFormLoading = false;
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
                    'Create New Account',
                    textAlign: TextAlign.center,
                    style: Constants.boldHeading,
                  ),
                ),
                Column(
                  children: [
                    CustomInput(
                      hintText: 'Full Names',
                      onChnaged: (value) {
                        _registerName = value;
                      },
                      onSubmitted: (value) {
                        _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    CustomInput(
                      hintText: 'Email',
                      onChnaged: (value) {
                        _regiterEmail = value;
                      },
                      onSubmitted: (value) {
                        _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    CustomInput(
                      hintText: 'Password',
                      onChnaged: (value) {
                        _regiterPassword = value;
                      },
                      focusNode: _passwordFocusNode,
                      isPasswordField: true,
                      onSubmitted: (value) {
                        _submitForm();
                      },
                    ),
                    CustomBtn(
                      text: "Create New Account",
                      onPressed: () {
                        //opens alert DialogBuilder
                        _submitForm();
                      },
                      isLoading: _isregisterFormLoading,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CustomBtn(
                    text: "Back To Login",
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, LoginScreen.id);
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
