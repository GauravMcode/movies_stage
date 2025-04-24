import 'package:flutter/material.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies STAGE"),
        centerTitle: false,
        actions: [
          Transform.scale(scale: 0.7, child: Switch(value: true, padding: EdgeInsets.zero ,onChanged: (value){}, thumbColor: WidgetStatePropertyAll(Colors.white), trackColor: WidgetStatePropertyAll(const Color.fromARGB(255, 255, 180, 174)),)),
          Icon(Icons.favorite_border, size: 20,),
          SizedBox(width: 10,)
        ],
        leading: Icon(Icons.sort),
      ),
      body: SizedBox(
        width: w,
        height: h,
        
      ),
    );
  }
}
