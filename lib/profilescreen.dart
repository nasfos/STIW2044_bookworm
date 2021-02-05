import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stiw2044_bookworm/book.dart';
import 'package:stiw2044_bookworm/bookdetailscreen.dart';
import 'package:stiw2044_bookworm/main.dart';
import 'package:stiw2044_bookworm/user.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  final Book book;

  const ProfileScreen({Key key, this.user, this.book}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String titlecenter = "No book found";
  List bookList;
  double screenHeight = 0.00, screenWidth = 0.00;
  var flex1 = new Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Image.asset('assets/images/readbook_washout.png',
                height: 150, width: 150)),
        Center(
          child: Container(
            child: Text("no book found",
                style: TextStyle(fontSize: 16, color: Colors.grey)),
          ),
        ),
      ],
    ),
  );

  @override
  void initState() {
    super.initState();
    _loadBook();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'BOOKWORM',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 200),
          child: Container(
            width: screenWidth,
            height: screenHeight / 0.2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 25, 0, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.lock_outline,
                            color: Colors.white,
                          ),
                          iconSize: 25,
                          onPressed: () {
                            print("change password");
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.phone_enabled_outlined,
                            color: Colors.white,
                          ),
                          iconSize: 25,
                          onPressed: () {
                            print("call");
                          },
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontFamily: 'Gill Sans Ultra Bold'),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.history_outlined,
                            color: Colors.white,
                          ),
                          iconSize: 25,
                          onPressed: () {
                            _loadhome();
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.home_outlined,
                            color: Colors.white,
                          ),
                          
                          iconSize: 25,
                          onPressed: () {
                            _loadhome();
                          },
                        ),
                        
                        // Text("Name",style: TextStyle(fontSize: 20,color: Colors.white),),
                      ],
                    ),
                  ),
                  // SizedBox(width: 50),
                  Container(
                      // margin: EdgeInsets.symmetric(horizontal: 30),
                      width: screenWidth - 20,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
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
                      child: Text(
                        "Name: " + widget.user.name,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                  SizedBox(height: 10),
                  Container(
                      // margin: EdgeInsets.symmetric(horizontal: 30),
                      width: screenWidth - 20,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
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
                      child: Text(
                        "Email: " + widget.user.email,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            bookList == null
                ? Flexible(
                    child: flex1,
                  )
                : Flexible(
                    child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: (screenWidth / screenHeight) / 0.95,
                    children: List.generate(
                      bookList.length,
                      (index) {
                        return Padding(
                            padding: EdgeInsets.all(1),
                            child: Card(
                              child: InkWell(
                                onTap: () => _loadBookDetail(index),
                                // child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                        height: screenHeight / 3.5,
                                        width: screenWidth / 2,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "http://middleton.000webhostapp.com/stiw2044/images/bookimages/${bookList[index]['cover']}.jpg",
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              new CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              new Icon(
                                            Icons.broken_image,
                                            size: screenWidth / 2,
                                          ),
                                        )),
                                    SizedBox(height: 5),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              bookList[index]['title'],
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            bookList[index]['author'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            bookList[index]['category'],
                                            style: TextStyle(
                                                fontSize: 16, color: Colors.grey
                                                // fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // ),
                              ),
                            ));
                      },
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  void _onChat() {
    print("call");
  }

  _loadBookDetail(int index) {
    Book book = new Book(
      bookid: bookList[index]['bookid'],
      booktitle: bookList[index]['title'],
      author: bookList[index]['author'],
      publisher: bookList[index]['publisher'],
      isbn: bookList[index]['isbn'],
      cover: bookList[index]['cover'],
      category: bookList[index]['category'],
      useremail: bookList[index]['useremail'],
    );

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BookDetails(
              user: widget.user,
                  book: book,
                )));
  }

  void _loadBook() {
    print('_loadBook()');
    http.post(
        "http://middleton.000webhostapp.com/stiw2044/php/load_book_profile.php",
        body: {
          "useremail": widget.user.email,
        }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        bookList = null;
        setState(() {
          titlecenter = "No book found";
        });
      } else {
        setState(() {
          print('got data');
          var jsondata = json.decode(res.body);
          // print(jsondata);
          bookList = jsondata["books"];
          print(bookList);
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loadhome() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MainScreen(
              user: widget.user,
                )));
  }
}
