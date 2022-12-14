import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/book_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = false;
  List<Book> books = [];

  @override
  Widget build(BuildContext context) {
return MaterialApp(
  		// title: 'Welcome to Flutter',
  		home: Scaffold(
    			appBar: AppBar(
      				title: const Text('Book List Viewer'),
    			),
    			body: ListView(
      				children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    onSubmitted: handleSearchSubmitted,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                if (isLoading)
                  Center(child: CircularProgressIndicator())
                else
                  for (int i = 0; i <books.length; i++) BookTile(book: books[i]),
                    // ListTile(
                    //   title: Text(books[i].title),
                    //   subtitle: Text(books[i].authors.join(", ")),
                    //   leading: Image.network(books[i].coverImage, width: 100, height: 100,),
                    //  )
              ],
    			),
  		),
); 
  }

  void handleSearchSubmitted(String text) async {
    setState(() {
      isLoading = true;
    });
    
    // await Future.delayed(Duration(seconds: 1));

    Dio dio = Dio();

    final response = await dio.get("http://openlibrary.org/search.json?q=$text&limit=10");
      final docs = response.data["docs"];

    // final loadedBooks = [
    //   Book("Harry Pottor", ["J.K.Rowling"], "https://i.ytimg.com/vi/pIrOAyXIjak/maxresdefault.jpg"),
    //   Book("Load of the Rings", ["Peter Jackson"], "https://www.animationxpress.com/wp-content/uploads/2021/08/intro-1508529851.jpg"),
    //   Book("The Book", ["Dilanka L"], "https://www.adazing.com/wp-content/uploads/2019/02/open-book-clipart-03.png"),
    // ];

    List<Book> loadedBooks = [];
    for (var doc in docs) {
      final bookTitle = doc["title"];
      final bookAuthors = List<String>.from(doc["author_name"]);
      final coverI = doc["cover_i"];
      final coverImage = "https://covers.openlibrary.org/b/id/$coverI-M.jpg" ;

      loadedBooks.add(Book(bookTitle, bookAuthors, coverImage));
    }

    setState(() {
      books = loadedBooks;  
    });
    
    setState(() {
      isLoading = false;
    });
    
    // print(text);
  }
}

// class BookTile extends StatelessWidget {
//   final Book book;
//   const BookTile({Key? key, required this.book}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//                       title: Text(book.title),
//                       subtitle: Text(book.authors.join(", ")),
//                       leading: Image.network(book.coverImage, width: 100, height: 100,),
//                      );
    
//   }
// }

class Book {
  String title;
  List<String> authors;
  String coverImage;
  Book(this.title, this.authors, this.coverImage);
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
