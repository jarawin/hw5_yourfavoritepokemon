import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(
    items: List<String>.generate(
        150,
        (i) =>
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${i + 1}.png'), // generate a list of 150 Pokemon
  ));
}

class MyApp extends StatelessWidget {
  final List<String> items;

  const MyApp({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    String title = "Pokemon List";

    return MaterialApp(
      title: title,
      home: HomePage(
        items: items,
        title: title,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final List<String> items;
  final String title;

  const HomePage({super.key, required this.items, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 0;

  void incrementCounter(int count) {
    setState(() {
      counter += count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(counter < 1 ? widget.title : '${widget.title} ($counter)'),
      ),
      body: ListView.builder(
        itemCount: widget.items.length ~/
            3, // 3 items per row so we divide the number of items by 3
        itemBuilder: (context, index) {
          return Row(
            children: [
              Expanded(
                  child: Stack(
                children: [
                  Image.network(widget.items[index * 3]),
                  FavoriteBTN(incrementCounter),
                ],
              )),
              Expanded(
                  child: Stack(
                children: [
                  Image.network(widget.items[index * 3 + 1]),
                  FavoriteBTN(incrementCounter),
                ],
              )),
              Expanded(
                  child: Stack(
                children: [
                  Image.network(widget.items[index * 3 + 2]),
                  FavoriteBTN(incrementCounter),
                ],
              )),
            ],
          );
        },
      ),
    );
  }
}

class FavoriteBTN extends StatefulWidget {
  final CountCallback incrementCounter;
  const FavoriteBTN(this.incrementCounter, {super.key});

  @override
  State<FavoriteBTN> createState() => _FavoriteBTNState();
}

class _FavoriteBTNState extends State<FavoriteBTN> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        size: 50,
        color: isFavorite ? Colors.red : Colors.black,
      ),
      onPressed: () {
        setState(() {
          if (isFavorite) {
            // decrement counter
            widget.incrementCounter(-1);
          } else {
            // increment counter
            widget.incrementCounter(1);
          }
          isFavorite = !isFavorite;
        });
      },
    );
  }
}

typedef CountCallback = void Function(int count);
