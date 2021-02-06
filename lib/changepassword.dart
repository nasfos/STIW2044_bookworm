import 'package:flutter/material.dart';
import 'package:stiw2044_bookworm/user.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class ChangePassword extends StatefulWidget {
  final User user;

  const ChangePassword({Key key, this.user}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _passcontroller = TextEditingController();
  String _password = "";
  bool _validate = false;
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BOOKWORM',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Arial',
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text('Change Password',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Gill Sans Ultra Bold',
                  color: Colors.white)),
        ),
        body: Column(
          children: [
            TextField(
              controller: _passcontroller,
              decoration: InputDecoration(
                labelText: 'Password (min 8 character)',
                hintText: 'Abcde123',
                icon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                errorText: _validate ? 'This field is compulsory' : null,
              ),
              obscureText: _passwordVisible,
              // textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              minWidth: MediaQuery.of(context).size.width / 3,
              height: 50,
              child: Text('Change Password'),
              color: Color.fromRGBO(255, 148, 48, 1),
              textColor: Colors.white,
              elevation: 15,
              onPressed: _changepassword,
              // onPressed: () {
              //   Navigator.of(context).pop();
              // },
            ),
          ],
        ),
      ),
    );
  }

  bool validatePassword(String password) {
    print('validatePassword');
    int minLength=8;
    bool hasUppercase = password.contains(new RegExp(r'^(?=.*?[A-Z])'));
    bool hasDigits = password.contains(new RegExp(r'^(?=.*?[0-9])'));
    bool hasLowercase = password.contains(new RegExp(r'^(?=.*?[a-z])'));
    // String passpattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    bool hasMinLength = password.length >= minLength;
    // Pattern pattern = new Pattern.compile(passpattern);
    // RegExp regExp = new RegExp(passpattern);
    // return regExp.hasMatch(password);
    if(hasDigits == true  && hasUppercase == true  && hasLowercase == true  && hasMinLength == true ){
      print('alltrue');
      return true;
    } else {
      print('not alltrue');
      return false;
    }
    
  }

  void _changepassword() {
    _password = _passcontroller.text;
    print('_changepassword()');

      if (validatePassword(_password)) {
        print('success validate password');
      http.post(
          "http://middleton.000webhostapp.com/stiw2044/php/change_password.php?",
          body: {
            "email": widget.user.email,
            "password": _password,
          }).then((res) {
        print(res.body+"test");
        if (res.body == "success") {
          Toast.show(
            "success.",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
          );
          Navigator.pop(context);
        } else {
          Toast.show(
            "failed",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
          );
        }
      }).catchError((err) {
        print(err);
      });
    } else Toast.show(
        "Please check your password",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.TOP,
      );

  }
}
