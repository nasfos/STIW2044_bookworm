import 'package:flutter/material.dart';
import 'package:stiw2044_bookworm/book.dart';
import 'package:stiw2044_bookworm/user.dart';
 
class ProfileScreen extends StatefulWidget {
  final User user;
  final Book book;

  const ProfileScreen({Key key, this.user, this.book}) : super(key: key);
  
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}