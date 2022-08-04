import 'package:flutter/material.dart';
import 'package:flutter_application_1/book_page.dart';
import 'package:flutter_application_1/main.dart';

class BookTile extends StatelessWidget {
  final Book book;
  const BookTile({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
                      title: Text(book.title),
                      subtitle: Text(book.authors.join(", ")),
                      leading: Image.network(book.coverImage, width: 100, height: 100,),
                      onTap: () => handleOnTap(context),
                     );
  } 
}

void handleOnTap(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => BookPage()));
  // Go to page
}