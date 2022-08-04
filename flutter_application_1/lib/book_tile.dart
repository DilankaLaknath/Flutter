import 'package:flutter/material.dart';
import 'main.dart';

class BookTile extends StatelessWidget {
  final Book book;
  const BookTile({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
                      title: Text(book.title),
                      subtitle: Text(book.authors.join(", ")),
                      leading: Image.network(book.coverImage, width: 100, height: 100,),
                     );
    
  }
}