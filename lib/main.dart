import 'package:flutter/material.dart';
import 'package:stiw2044_bookworm/book.dart';
// import 'package:stiw2044_bookworm/bookdetailscreen.dart';
import 'package:stiw2044_bookworm/borrowbook.dart';
import 'package:stiw2044_bookworm/exchangebook.dart';
import 'package:stiw2044_bookworm/profilescreen.dart';
import 'package:stiw2044_bookworm/sellbook.dart';
import 'package:stiw2044_bookworm/user.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BOOKWORM',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  final User user;
  final Book book;
  const MainScreen({Key key, this.user, this.book}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double screenHeight = 0.00, screenWidth = 0.00;

  @override
  void initState() {
    super.initState();
    // _loadBook();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text('Home',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Gill Sans Ultra Bold',
                  color: Colors.white)),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _loadprofile();
            // NewBook();
          },
          child: Icon(
            Icons.perm_identity,
            color: Colors.white,
          ),
          backgroundColor: Colors.orange,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //ExchangeBook
            // SingleChildScrollView(
              Flexible(
                child: Card(
                  child: InkWell(
                    onTap: () => _exchangeBook(),
                    child: Column(children: [
                      Container(
                        height: screenHeight / 6,
                        width: screenWidth / 0.5,
                        child: Image.asset(
                          'assets/images/exchange_book.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Exchange Book',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(
                            ' (**Book is in physical form)',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Text(
                            'An activity that allow user to change a book with other parties. If user has interest on a book, user may send request and wait for other parties to respond.'),
                      ),
                    ]),
                  ),
                ),
                //  ),
              ),
            
            //SellBook
            Flexible(
              child: Card(
                child: InkWell(
                  onTap: () => _sellBook(),
                  child: Column(children: [
                    Container(
                      height: screenHeight / 6,
                      width: screenWidth / 0.5,
                      child: Image.asset(
                        'assets/images/sell_book.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Book for Sale',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(
                          ' (**Book is in physical form)',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    Expanded(
                        child: Text(
                            'An activity that allow user to sell or buy book. A book can be new or used book. ')),
                  ]),
                ),
              ),
              //  ),
            ),
            //BorrowBook
            Flexible(
              child: Card(
                child: InkWell(
                  onTap: () => _borrowBook(),
                  child: Column(children: [
                    Container(
                      height: screenHeight / 6,
                      width: screenWidth / 0.5,
                      child: Image.asset(
                        'assets/images/borrow_book.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Borrow Book',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(
                          ' (**Book is in physical form)',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    Expanded(
                        child: Text(
                            'An activity that allow user to borrow book among UUM students. In this section, user need to select date and time to borrow book.')),
                  ]),
                ),
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }

  _exchangeBook() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                ExchangeBook(user: widget.user)));
  }

  _sellBook() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => SellBook()));
  }

  _borrowBook() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => BorrowBook()));
  }

  void _loadprofile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ProfileScreen(
                  book: widget.book,
                )));
  }
}
