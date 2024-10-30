import 'package:flutter/material.dart';
import 'package:perpus_aqeel/Homescreen/favorit.dart';
import 'package:perpus_aqeel/Homescreen/profil.dart';
import 'package:perpus_aqeel/models/model.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  final List<Book> books = [
    Book(
      title: 'Story Of My Life',
      author: 'John Doe',
      publisher: 'Story Books',
      stock: 28,
      imageUrl: 'assets/SOMY.jpeg',
    ),
    Book(
      title: 'Be a Profesional Programmer',
      author: 'Jane Smith',
      publisher: 'Programmer Publishers',
      stock: 53,
      imageUrl: 'assets/Programmer.jpeg',
    ),
    Book(
      title: 'In the Out of Nowhere',
      author: 'Alice Johnson',
      publisher: 'Fiction Books',
      stock: 41,
      imageUrl: 'assets/IOON.jpeg',
    ),
    Book(
      title: 'A Journey',
      author: 'Bob Brown',
      publisher: 'Story Books',
      stock: 36,
      imageUrl: 'assets/Journey.jpeg',
    ),
    Book(
      title: 'Negeri 5 Menara',
      author: 'Ahmad Fuadi',
      publisher: 'Story Books',
      stock: 100,
      imageUrl: 'assets/5Menara.jpeg',
    ),
    Book(
      title: 'Teka Teki Rumah Aneh',
      author: 'Bob Brown',
      publisher: 'Horror Books',
      stock: 78,
      imageUrl: 'assets/RumahAneh.jpeg',
    ),
    Book(
      title: 'Laskar Pelangi',
      author: 'Andrea Hirata',
      publisher: 'Story Books',
      stock: 63,
      imageUrl: 'assets/LaskarPelangi.jpeg',
    ),
  ];

  List<Book> filteredBooks = [];
  List<Book> favoriteBooks = [];
  String searchQuery = '';
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    filteredBooks = books;
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredBooks = books.where((book) {
        return book.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void addToFavorites(Book book) {
    setState(() {
      if (!favoriteBooks.contains(book)) {
        favoriteBooks.add(book);
      }
    });
  }

  void removeFromFavorites(Book book) {
    setState(() {
      favoriteBooks.remove(book);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      buildHomePage(),
      FavoritScreen(
        favoriteBooks: favoriteBooks,
        onRemove: removeFromFavorites,
      ),
      const ProfilScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('MYPERPUS'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        color: Colors.lightBlue[50],
        child: pages[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Profil',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  Widget buildHomePage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: updateSearchQuery,
            decoration: const InputDecoration(
              labelText: 'Cari Buku',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
            ),
            itemCount: filteredBooks.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (favoriteBooks.contains(filteredBooks[index])) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '${filteredBooks[index].title} sudah ada di favorit!'),
                      ),
                    );
                  } else {
                    addToFavorites(filteredBooks[index]);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '${filteredBooks[index].title} ditambahkan ke favorit!'),
                      ),
                    );
                  }
                },
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Image.asset(
                          filteredBooks[index].imageUrl,
                          height: 150,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          filteredBooks[index].title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                      Text('Penulis: ${filteredBooks[index].author}'),
                      Text('Penerbit: ${filteredBooks[index].publisher}'),
                      Text('Stok: ${filteredBooks[index].stock}'),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
