import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

showToast(String msg) {
  Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_LONG);
}

Future<String> fetchImageFromUrlAndConvertToBase64(String imageUrl) async {
  final finalUrl = "https://image.tmdb.org/t/p/original$imageUrl";
  final response = await http.get(Uri.parse(finalUrl));
  if (response.statusCode == 200) {
    Uint8List bytes = response.bodyBytes;
    String base64String = base64Encode(bytes);
    return base64String;
  } else {
    throw Exception('Failed to load image');
  }
}

Shimmer getLoader(
    {double? w, double? h, double? borderRadius, ShimmerDirection? direction}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.withOpacity(0.15),
    highlightColor: Color.fromARGB(255, 187, 187, 187),
    direction: direction ?? ShimmerDirection.ltr,
    period: const Duration(milliseconds: 2000),
    child: Column(
      children: [
        SizedBox(
          width: w,
          height: h,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 20)),
          ),
        ),
      ],
    ),
  );
}

getGenre(int id) {
  final Map<int, String> genresMap = {
    28: "Action",
    12: "Adventure",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    10751: "Family",
    14: "Fantasy",
    36: "History",
    27: "Horror",
    10402: "Music",
    9648: "Mystery",
    10749: "Romance",
    878: "Science Fiction",
    10770: "TV Movie",
    53: "Thriller",
    10752: "War",
    37: "Western",
  };

  return genresMap[id];
}
