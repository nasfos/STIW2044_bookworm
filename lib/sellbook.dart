import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BOOKWORM',
      home: SellBook(),
    );
  }
}

class SellBook extends StatefulWidget {
  @override
  _SellBookState createState() => _SellBookState();
}

class _SellBookState extends State<SellBook> {
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _authorcontroller = TextEditingController();
  final TextEditingController _publishercontroller = TextEditingController();
  final TextEditingController _editioncontroller = TextEditingController();
  final TextEditingController _yearcontroller = TextEditingController();
  final TextEditingController _isbncontroller = TextEditingController();

  String _title, _author, _publisher, _edition, _year, _isbn;
  String titlecenter = "No book found";
  List bookList;
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text('For Sale',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Gill Sans Ultra Bold',
                  color: Colors.white)),
          // leading: Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
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
                    child: Center(
                      child: Container(
                        child: Text(titlecenter,
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _loadBook() {
    print('_loadBook()');
  }

  void _addbookform() {
    print('new book form');
    showDialog(
        context: context,
        builder: (BuildContext context) => new Dialog(
              // title: new Text("Add New Book"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 10,
                child: SingleChildScrollView(
                  child: new Column(children: [
                    Text("Add New Book",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    TextField(
                        controller: _titlecontroller,
                        // keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Title',
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        controller: _authorcontroller,
                        // keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Author',
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        controller: _publishercontroller,
                        // keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Publisher',
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        controller: _editioncontroller,
                        // keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Edition',
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        controller: _yearcontroller,
                        // keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Year',
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        controller: _isbncontroller,
                        // keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'ISBN',
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          minWidth: 150,
                          height: 50,
                          child: Text('Cancel'),
                          color: Colors.grey,
                          textColor: Colors.white,
                          elevation: 15,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          // onPressed: _addbook,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          minWidth: 150,
                          height: 50,
                          child: Text('Add'),
                          color: Color.fromRGBO(255, 148, 48, 1),
                          textColor: Colors.white,
                          elevation: 15,
                          onPressed: _addbook,
                          // onPressed: () {
                          //   Navigator.of(context).pop();
                          // },
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ));
  }

  void _addbook() {
    print('add book');
    _title = _titlecontroller.text;
    _author = _authorcontroller.text;
    _publisher = _publishercontroller.text;
    _edition = _editioncontroller.text;
    _year = _yearcontroller.text;
    _isbn = _isbncontroller.text;
  }
}
