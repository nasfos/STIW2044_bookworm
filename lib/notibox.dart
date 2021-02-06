import 'package:flutter/material.dart';
import 'package:stiw2044_bookworm/book.dart';
import 'package:stiw2044_bookworm/user.dart';

class NotiBox extends StatefulWidget {
  final User user;
  final Book book;

  const NotiBox({Key key, this.user, this.book}) : super(key: key);

  @override
  _NotiBoxState createState() => _NotiBoxState();
}

class _NotiBoxState extends State<NotiBox> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: Colors.orange,

        appBar: AppBar(
          backgroundColor: Colors.orange,
          iconTheme: IconThemeData(color: Colors.white),
          // actions: [
          //   IconButton(
          //     icon: Icon(
          //       Icons.arrow_back,
          //       color: Colors.white,
          //     ),
              
          //     iconSize: 25,
          //     onPressed: () {
          //       print('change password');
          //       Navigator.pop(context);
          //     },
          //   ),
          // ],
          title: Text('Notification'),
        ),
        body: Column(
          children: [
            // Center(
            widget.book.useremail == widget.user.email
                // ? Text('')
                ? Card(
                    child: Text('IMPORTANT!! ' +
                        widget.user.name +
                        ' is requesting on changing book titled ' +
                        widget.book.booktitle),
                  )
                : Text('Your request is not yet responded by other user')
            // :Card(
            //   child: Text('IMPORTANT!! '+ widget.user.name + ' is requesting on changing book titled '+widget.book.booktitle),
            // ),
            // ),
          ],
        ),
      ),
    );
  }
}
