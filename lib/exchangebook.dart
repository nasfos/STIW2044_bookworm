
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stiw2044_bookworm/newbook.dart';
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

  const ExchangeBook({Key key, this.user}) : super(key: key);

  @override
  _ExchangeBookState createState() => _ExchangeBookState();
}

class _ExchangeBookState extends State<ExchangeBook> {
  
  String titlecenter = "No book found";
  List bookList;
  double screenHeight = 0.00, screenWidth = 0.00;

  final flex1 = new Container(
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
          // leading: Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addbookform();
            // NewBook();
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
                    crossAxisCount: 1,
                    childAspectRatio: (screenWidth / screenHeight) / 0.3,
                    children: List.generate(bookList.length, (index) {
                      return Padding(
                          padding: EdgeInsets.all(1),
                          child: Card(
                            child: InkWell(
                              onTap: () => _loadBookDetail(index),
                              child: Row(
                                children: [
                                  Container(
                                      height: screenHeight / 0.5,
                                      width: screenWidth / 3,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "http://middleton.000webhostapp.com/stiw2044/images/${bookList[index]['cover']}.jpg",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            bookList[index]['booktitle'],
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        // Column(
                                        //   mainAxisAlignment: MainAxisAlignment.start,
                                        //   children: [

                                        // StarRating(
                                        //   // alignment:left,
                                        //   size: 15.5,
                                        //   rating: double.parse(
                                        //       bookList[index]['rating']),
                                        //   color: Colors.orange,
                                        //   borderColor: Colors.grey,
                                        //   starCount: starCount,
                                        //   onRatingChanged: (rating) => setState(
                                        //     () {
                                        //       this.rating = rating;
                                        //     },
                                        //   ),
                                        // ),
                                        //   ],
                                        // ),
                                        // SizedBox(height: 5),
                                        // Text(
                                        //   "Rating: " +
                                        //       bookList[index]['rating'],
                                        //   style: TextStyle(
                                        //     fontSize: 16,
                                        //     // fontWeight: FontWeight.bold,
                                        //   ),
                                        // ),
                                        SizedBox(height: 5),
                                        Text(
                                          bookList[index]['author'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // SizedBox(height: 5),
                                        // Text(
                                        //   "RM " + bookList[index]['price'],
                                        //   style: TextStyle(
                                        //     fontSize: 16,
                                        //     // fontWeight: FontWeight.bold,
                                        //   ),
                                        // ),

                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    }),
                  )),
          ],
        ),
      ),
    );
  }

  void _loadBook() {
    print('_loadBook()');
  }

  void _addbookform() {

    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => NewBook(user: widget.user,)));
  }

  _loadBookDetail(int index) {}
}
