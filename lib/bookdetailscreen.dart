import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stiw2044_bookworm/book.dart';

class BookDetails extends StatefulWidget {
  final Book book;

  const BookDetails({Key key, this.book}) : super(key: key);

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  double screenHeight = 0.00, screenWidth = 0.00;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.booktitle),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: SingleChildScrollView(
            child: Column(
              children:[
                Container(
                    height: screenHeight / 2.5,
                    width: screenWidth / 0.5,
                    child: SingleChildScrollView(
                      child: CachedNetworkImage(
                        imageUrl:
                            "http://middleton.000webhostapp.com/stiw2044/images/bookimages/${widget.book.cover}.jpg",
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        errorWidget: (context, url, error) => new Icon(
                          Icons.broken_image,
                          size: screenWidth / 2,
                        ),
                      ),
                    )),
                Divider(color: Colors.grey),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 5.0, 20.0, 5.0),
                      child:Text("Book Title",style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ))
                    ),
                    Container(
                      child:Text(widget.book.booktitle)
                    ),
                  ],
                ),
                Divider(color: Colors.grey),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 5.0, 42.0, 5.0),
                      child:Text("Author",style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ))
                    ),
                    Container(
                      child:Text(widget.book.author)
                    ),
                  ],
                ),
                Divider(color: Colors.grey),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 5.0, 54.0, 5.0),
                      child:Text("ISBN",style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ))
                    ),
                    Container(
                      child:Text(widget.book.isbn)
                    ),
                  ],
                ),
                Divider(color: Colors.grey),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 5.0, 25.0, 5.0),
                      child:Text("Publisher",style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ))
                    ),
                    Container(
                      child:Text(widget.book.publisher)
                    ),
                  ],
                ),
                Divider(color: Colors.grey),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 5.0, 25.0, 5.0),
                      child:Text("Category",style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ))
                    ),
                    Container(
                      child:Text(widget.book.category)
                    ),
                  ],
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
