import 'package:firestore_demo/core/presentation/providers/providers.dart';
import 'package:firestore_demo/features/auth/presentation/widgets/login_form.dart';
import 'package:firestore_demo/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _emailField = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailField = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0xff161d27),
      ),
      body: Consumer(builder: (context, watch, _) {
        return Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Image.asset('images/forgotten_login.png'),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: S.of(context).resetPasswordTitleText,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 38,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: S.of(context).resetPasswordSubtitleText,
                                  style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 18.0),
                          LoginField(
                            key: Key('email-field'),
                            controller: _emailField,
                            validator: (value) => (value.isEmpty)
                                ? S.of(context).emailValidationError
                                : null,
                            hintText: S.of(context).emailFieldlabel,
                            isPassword: false,
                          ),
                          SizedBox(height: 18.0),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: FlatButton(
                    color: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () {
                      _resetPassword();
                    },
                    child: Text(
                      S.of(context).sendPasswordButtonText,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  _resetPassword() async {
    print(_emailField.text);
    if (_formKey.currentState.validate()) {
      await context
          .read(userRepoProvider)
          .resetPassword(_emailField.text)
          .then((value) => _showResetPasswordDialog(context));
    }
  }

  _showResetPasswordDialog(BuildContext context) async {
    if (!await context.read(userRepoProvider).resetPassword(_emailField.text)) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Color(0xff161d27),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              content: Container(
                height: 250.0,
                child: Column(
                  children: [
                    Image.asset(
                      'images/incorrect.png',
                      width: 65.0,
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      'ERROR',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      S.of(context).emailValidationError,
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 16),
                    ),
                    SizedBox(height: 12.0),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(S.of(context).tryAgainErrorText),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    } else {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Color(0xff161d27),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              content: Container(
                height: 260.0,
                child: Column(
                  children: [
                    Image.asset(
                      'images/verificated.png',
                      width: 65.0,
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      'Success',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      S.of(context).successMessageText,
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 16),
                    ),
                    SizedBox(height: 12.0),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(S.of(context).continuoToSignInText),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    }
  }

  @override
  void dispose() {
    _emailField.dispose();
    super.dispose();
  }
}
