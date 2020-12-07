import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'loginscreen.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  final TextEditingController _phcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();

  String _email = "", _password = "", _name = "", _phone = "";
  bool _rememberMe = false;
  bool _validate = false;
  bool _termcondition = false;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
  }

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
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromRGBO(252, 127, 3, 1),
                            Color.fromRGBO(255, 148, 48, 1),
                          ]),
                    ),
                    child: Center(
                      child: Text('Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 38,
                              fontFamily: 'Gill Sans Ultra Bold')),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Color.fromRGBO(237, 231, 223, 1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _namecontroller,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          icon: Icon(Icons.person),
                          hintText: 'e.g: nasfos84',
                          errorText:
                              _validate ? 'This field is compulsory' : null,
                        ),
                        textInputAction: TextInputAction.next,
                        // validator: (){}
                      ),
                      TextField(
                        controller: _emcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          icon: Icon(Icons.email),
                          hintText: 'e.g: nasfos84@gmail.com',
                          errorText:
                              _validate ? 'This field is compulsory' : null,
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      TextField(
                        controller: _phcontroller,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Mobile',
                          icon: Icon(Icons.phone),
                          hintText: 'e.g: 0xxxxxxxxx',
                          errorText:
                              _validate ? 'This field is compulsory' : null,
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      TextField(
                        controller: _passcontroller,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          icon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          errorText:
                              _validate ? 'This field is compulsory' : null,
                        ),
                        obscureText: _passwordVisible,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: _termcondition,
                            onChanged: (bool value) {
                              _onChange1(value);
                            },
                          ),
                          Expanded(
                            child: Text(
                                'I accept Term & Condition of this application',
                                style: TextStyle(fontSize: 15)),
                          )
                        ],
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      _termcondition
                          ? Column(
                              children: [
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                      value: _rememberMe,
                                      onChanged: (bool value) {
                                        _onChange(value);
                                      },
                                    ),
                                    Text('Remember Me',
                                        style: TextStyle(fontSize: 15))
                                  ],
                                ),
                                //   ],
                                // ):
                                SizedBox(
                                  height: 10,
                                ),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  minWidth: 300,
                                  height: 50,
                                  child: Text('Register'),
                                  color: Color.fromRGBO(255, 148, 48, 1),
                                  textColor: Colors.white,
                                  elevation: 15,
                                  onPressed: () {
                                    setState(() {
                                      // _emcontroller.text.isEmpty
                                      //     ? _validate = true
                                      //     : _validate = false;
                                      // _passcontroller.text.isEmpty
                                      //     ? _validate = true
                                      //     : _validate = false;
                                      // _phcontroller.text.isEmpty
                                      //     ? _validate = true
                                      //     : _validate = false;
                                      // _namecontroller.text.isEmpty
                                      //     ? _validate = true
                                      //     : _validate = false;

                                      if (_emcontroller.text.isNotEmpty &&
                                          _passcontroller.text.isNotEmpty &&
                                          _phcontroller.text.isNotEmpty &&
                                          _namecontroller.text.isNotEmpty) {
                                        _showMaterialDialog();
                                      } else {
                                        Toast.show(
                                          "Check your details",
                                          context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.TOP,
                                        );
                                      }
                                    });
                                  },
                                ),
                              ],
                            )
                          : MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              minWidth: 300,
                              height: 50,
                              child: Text('Register'),
                              color: Colors.grey,
                              textColor: Colors.white,
                              elevation: 15,
                              onPressed: _onRegister,
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: _onLogin,
                    child: Text('Already Register',
                        style: TextStyle(fontSize: 16, color: Colors.black54))),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onLogin() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }

  void _onChange(bool value) {
    setState(() {
      _rememberMe = value;
    });
  }

  void _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Confirm Registration"),
              content: new Text("Are you sure you want to register?"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    _onRegister();
                  },
                )
              ],
            ));
  }

  void _onRegister() async {
    _name = _namecontroller.text;
    _email = _emcontroller.text;
    _password = _passcontroller.text;
    _phone = _phcontroller.text;

    if (!validateEmail(_email) && !validatePassword(_password)) {
        print('success validate email');
        // print(validateEmail);
        Toast.show(
          "Check your email/password",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
        return;
      }
    if (_termcondition) {
      
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Registration...");
      await pr.show();
      http.post(
          "http://middleton.000webhostapp.com/stiw2044/php/register_user.php",
          body: {
            "name": _name,
            "email": _email,
            "phone": _phone,
            "password": _password,
          }).then((res) {
        print(res.body);
        if (res.body == "success") {
          Toast.show(
            "Registration success.",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
          );
          if (_rememberMe) {
            savepref();
          }
          _onLogin();
        } else {
          Toast.show(
            "Registration failed",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
          );
        }
      }).catchError((err) {
        print(err);
      });
      await pr.hide();
    } else {
      print('not register');
      Toast.show(
        "Please agree with our T&C",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.TOP,
      );
    }
  }

  void savepref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = _emcontroller.text;
    _password = _passcontroller.text;
    await prefs.setString('email', _email);
    await prefs.setString('password', _password);
    await prefs.setBool('rememberme', true);
  }

  bool validateEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(email)) ? false : true;
  }

  bool validatePassword(String password) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(password);
  }

  void _onChange1(bool value) {
    setState(() {
      _termcondition = value;
    });
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
