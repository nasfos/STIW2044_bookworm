import 'package:flutter/material.dart';
import 'package:stiw2044_bookworm/book.dart';
import 'package:stiw2044_bookworm/exchangebook.dart';
import 'package:stiw2044_bookworm/user.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:numberpicker/numberpicker.dart';

class AddExchangeBookDetails extends StatefulWidget {
  final User user;
  final Book book;

  const AddExchangeBookDetails({Key key, this.user, this.book})
      : super(key: key);
  @override
  _AddExchangeBookDetailsState createState() => _AddExchangeBookDetailsState();
}

class _AddExchangeBookDetailsState extends State<AddExchangeBookDetails> {
  final TextEditingController _sizecontroller = TextEditingController();
  final TextEditingController _originalitycontroller = TextEditingController();
  int selectedQty = 1, selectedVal = 1;
  String _quantity, _bookvalue, _size,  _originality;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BOOKWORM',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.orange,
        // fontFamily: 'Gill Sans Ultra Bold',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Exchange Book Details',
            style: TextStyle(
                color: Colors.white, fontFamily: 'Gill Sans Ultra Bold'),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Text("Bookid" + widget.book.bookid),
                // Text("user email" + widget.book.useremail),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text("Select Quantity"),
                    SizedBox(width: 10),
                    NumberPicker.horizontal(
                      decoration: BoxDecoration(
                        border: new Border(
                          top: new BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black26,
                          ),
                          bottom: new BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                      initialValue: selectedQty,
                      minValue: 1,
                      maxValue: 100,
                      step: 1,
                      zeroPad: false,
                      onChanged: (value) =>
                          setState(() => selectedQty = value),
                    ),
                  ],
                ),
                // Text("Bookid" + selectedQty.toString()),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text("Give value for your book: "),
                    SizedBox(width: 10),
                    NumberPicker.horizontal(
                      decoration: BoxDecoration(
                        border: new Border(
                          top: new BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black26,
                          ),
                          bottom: new BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                      initialValue: selectedVal,
                      minValue: 1,
                      maxValue: 10,
                      step: 1,
                      zeroPad: false,
                      onChanged: (value) =>
                          setState(() => selectedVal = value),
                    ),
                  ],
                ),
                // Text("Bookid" + selectedVal.toString()),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: _sizecontroller,
                    // keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText:
                          'Size of book (Eg: A4 / B5 / Textbook / 2in1 / dll)',
                    )),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: _originalitycontroller,
                    // keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText:
                          'Originality of book (Eg: Original Textbook / Original Photocopy / Used Book)',
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      minWidth: MediaQuery.of(context).size.width / 3,
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
                      minWidth: MediaQuery.of(context).size.width / 3,
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
                SizedBox(
                  height: 10,
                ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addbook() {
    // print('bookid: ' + widget.book.bookid);
    _size = _sizecontroller.text;
    // print(_size);
    _originality = _originalitycontroller.text;
    // print(_originality);
    _quantity = selectedQty.toString();
    // print(_quantity);
    _bookvalue = selectedVal.toString();
    // print(_bookvalue);

    http.post(
        "http://middleton.000webhostapp.com/stiw2044/php/exchange_book_detail.php",
        body: {
          "bookid": widget.book.bookid,
          "quantity": _quantity,
          "value": _bookvalue,
          "size": _size,
          "status": "Available",
          "originality": _originality,
        }).then((res) {
      print(res.body+" test");
      if (res.body == "success") {
        Toast.show(
          "Success",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
        Navigator.pop(context);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => ExchangeBook(
        //               user: widget.user,
                    // )));
      } else {
        // print(res.body+"fail");
        Toast.show(
          "Failed",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
        Navigator.pop(context);
      }
    }).catchError((err) {
      print(err);
    });
  }
}
