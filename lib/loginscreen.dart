import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stiw2044_bookworm/changepassword.dart';
import 'package:stiw2044_bookworm/user.dart';
import 'package:toast/toast.dart';
import 'main.dart';
import 'registerscreen.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  final User user;

  const LoginPage({Key key, this.user}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  String _email = "", _password = "";
  SharedPreferences prefs;
  bool _rememberMe = false;
  // List userList;

  @override
  void initState() {
    loadpref();
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
                    height: 250,
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
                      child: Text('Login',
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
                          controller: _emcontroller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: 'Email', icon: Icon(Icons.email))),
                      TextField(
                        controller: _passcontroller,
                        decoration: InputDecoration(
                            labelText: 'Password', icon: Icon(Icons.lock)),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (bool value) {
                              _onChange(value);
                            },
                          ),
                          Text('Remember Me', style: TextStyle(fontSize: 16))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        minWidth: 300,
                        height: 50,
                        child: Text('Login'),
                        color: Color.fromRGBO(255, 148, 48, 1),
                        textColor: Colors.white,
                        elevation: 15,
                        onPressed: _onLogin,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: _onRegister,
                    child: Text('Register New Account',
                        style: TextStyle(fontSize: 16, color: Colors.black54))),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: _onForgot,
                    child: Text('Forgot Account',
                        style: TextStyle(fontSize: 16, color: Colors.black54))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onLogin() async {
    _email = _emcontroller.text;
    _password = _passcontroller.text;

    print(_email+','+ _password);

    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Login...");
    await pr.show();
    http.post("http://middleton.000webhostapp.com/stiw2044/php/login_user.php", body: {
      "email": _email,
      "password": _password,
    }).then((res) {
      print(res.body);
      List userList = res.body.split(",");
      if (userList[0] == "success") {
        Toast.show(
          "Login Success",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );

        User user = new User(
          name: userList[1],
          email: _email,
          phone: userList[2],
          password: _password,
          datereg: userList[3]
        );

        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => MainScreen(user: user,)));
      } else {
        Toast.show(
          "Login failed",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  void _onChange(bool value) {
    setState(() {
      _rememberMe = value;
      savepref(value);
    });
  }

  void _onRegister() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => RegisterPage()));
  }

  void _onForgot() {
    // widget.user.email = _emcontroller.text;
    print("Forgot");
  }

  Future<void> loadpref() async {
    prefs = await SharedPreferences.getInstance();
    _email = (prefs.getString('email')) ?? '';
    _password = (prefs.getString('password')) ?? '';
    _rememberMe = (prefs.getBool('rememberme')) ?? false;
    if (_email.isNotEmpty) {
      setState(() {
        _emcontroller.text = _email;
        _passcontroller.text = _password;
        _rememberMe = _rememberMe;
      });
    }
  }

  Future<void> savepref(bool value) async {
    prefs = await SharedPreferences.getInstance();
    _email = _emcontroller.text;
    _password = _passcontroller.text;

    if (value) {
      if (_email.length < 5 && _password.length < 3) {
        print("EMAIL/PASSWORD EMPTY");
        _rememberMe = false;
        Toast.show(
          "Email/password empty!!!",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
        );
        return;
      } else {
        await prefs.setString('email', _email);
        await prefs.setString('password', _password);
        await prefs.setBool('rememberme', value);
        Toast.show(
          "Preferences saved",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
        );
        print("SUCCESS");
      }
    } else {
      await prefs.setString('email', '');
      await prefs.setString('password', '');
      await prefs.setBool('rememberme', false);
      setState(() {
        _emcontroller.text = "";
        _passcontroller.text = "";
        _rememberMe = false;
      });
      Toast.show(
        "Preferences removed",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
      );
    }
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
