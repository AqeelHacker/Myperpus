import 'package:flutter/material.dart';
import 'package:perpus_aqeel/Homescreen/beranda.dart';
import 'package:perpus_aqeel/Homescreen/favorit.dart';
import 'package:perpus_aqeel/Homescreen/profil.dart';
import 'package:perpus_aqeel/models/model.dart';

void main() {
  runApp(const MyPerpus());
}

class MyPerpus extends StatefulWidget {
  const MyPerpus({super.key});

  @override
  State<MyPerpus> createState() => _MyPerpusState();
}

class _MyPerpusState extends State<MyPerpus> {
  List<Book> favoriteBooks = []; 

  void removeBook(Book book) {
    setState(() {
      favoriteBooks.remove(book); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Perpustakaan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', 
      routes: {
        '/': (context) => const Beranda(),
        '/favorit': (context) => FavoritScreen(
              favoriteBooks: favoriteBooks,
              onRemove: removeBook,
            ), 
        '/profil': (context) => const ProfilScreen(), 
      },
    );
  }
}
