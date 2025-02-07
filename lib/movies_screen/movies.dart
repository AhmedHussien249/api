import 'package:api/core/designs/app_images.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  bool isLoading = true;
  List<MovieModel> list = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    final response = await Dio().get(
        "https://api.themoviedb.org/3/discover/movie?api_key=2001486a0f63e9e4ef9c4da157ef37cd&page=9");
    // await Future.delayed(Duration(seconds: 3));
    final movies = response.data["results"] as List;
    movies.forEach((element) {
      print("********");
      print(element["backdrop_path"]);
      print(element["original_title"]);
      MovieModel movie = MovieModel(
          image: element["backdrop_path"], title: element["original_title"]);
      list.add(movie);
    });
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Movies",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.red,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 189 / 189),
              itemBuilder: (context, index) => Stack(
                fit: StackFit.expand,
                children: [
                  AppImages(
                    list[index].image,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Container(
                      height: 47,
                      width: double.infinity,
                      color: Colors.black.withOpacity(.46),
                      child: Center(
                        child: Text(
                          list[index].title,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              itemCount: list.length,
            ),
    );
  }
}

class MovieModel {
  final String title;
  late String image;

  MovieModel({required this.image, required this.title}) {
    image = image.isEmpty
        ? "https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png?20210521171500"
        : "http://image.tmdb.org/t/p/original$image";
  }
}
