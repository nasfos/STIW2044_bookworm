import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stiw2044_bookworm/book.dart';
import 'package:stiw2044_bookworm/bookdetails1.dart';
import 'package:stiw2044_bookworm/bookdetailscreen.dart';
import 'package:stiw2044_bookworm/newbook.dart';
import 'package:stiw2044_bookworm/profilescreen.dart';
import 'package:stiw2044_bookworm/user.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BOOKWORM',
      home: ExchangeBook(),
    );
  }
}

class ExchangeBook extends StatefulWidget {
  final User user;
  final Book book;
  final BookDetails1 bookdets;
  const ExchangeBook({Key key, this.user, this.book, this.bookdets}) : super(key: key);

  @override
  _ExchangeBookState createState() => _ExchangeBookState();
}

class _ExchangeBookState extends State<ExchangeBook> {
  String titlecenter = "No book found";
  List bookList,bookdetList;
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text('For Exchange',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Gill Sans Ultra Bold',
                  color: Colors.white)),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.perm_identity,
                color: Colors.white,
              ),
              onPressed: () {
                _loadprofile();
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addbookform();
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.orange,
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
                    childAspectRatio: (screenWidth / screenHeight) / 1,
                    children: List.generate(
                      bookList.length,
                      (index) {
                        return Padding(
                            padding: EdgeInsets.all(1),
                            child: Card(
                              child: InkWell(
                                onTap: () => _loadBookDetail(index),
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

  void _loadBook() {
    print('_loadBook()');
    http.post("http://middleton.000webhostapp.com/stiw2044/php/load_book.php",
        body: {
          // "category": "for exchange",
        }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        bookList = null;
        setState(() {
          titlecenter = "No book found";
        });
      } else {
        setState(() {
          // print('got data');
          var jsondata = json.decode(res.body);
          // print(jsondata);
          bookList = jsondata["exchange_book"];
          print(bookList);
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _addbookform() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => NewBook(
                  user: widget.user,
                )));
  }

  _loadBookDetail(int index) {
    Book book = new Book(
      bookid: bookList[index]['bookid'],
      booktitle: bookList[index]['title'],
      author: bookList[index]['author'],
      publisher: bookList[index]['publisher'],
      year: bookList[index]['years'],
      edition: bookList[index]['edition'],
      category: bookList[index]['category'],
      isbn: bookList[index]['isbn'],
      cover: bookList[index]['cover'],
      dateadd: bookList[index]['dateadd'],
      useremail: bookList[index]['useremail'],
    );

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BookDetails(
                  user: widget.user,
                  book: book,
                  // bookdets1: bookdets1,
                )));
  }

  void _loadprofile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ProfileScreen(
                  book: widget.book,
                  user: widget.user,
                )));
  }
}
