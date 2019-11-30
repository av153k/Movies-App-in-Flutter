import 'package:flutter/material.dart';
import 'package:yify_movies/services/most_popular.dart';
import 'package:yify_movies/services/most_recent.dart';
import "package:yify_movies/models/movies_model.dart";
import "dart:async";

import 'package:yify_movies/services/most_popular.dart' as mpm;

void main() => runApp(MyApp());

final MostPopularMovies _mostPopularMovies = new mpm.MostPopularMovies();
final MostRecentMovies _mostRecentMovies = new MostRecentMovies();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.green,
        ),
        home: GetData());
  }
}

class GetData extends StatefulWidget {
  GetData({Key key}) : super(key: key);

  @override
  _GetDataState createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  Future<YifyMovies> mpmYifyMovies = _mostPopularMovies.getMostPopularMovies();
  Future<YifyMovies> mrmYifyMovies = _mostRecentMovies.getMostRecentMovies();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.grey[900],
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff0f2027),
                      Color(0xff203a43),
                      Color(0xff205364),
                    ],
                  ),
                ),
              ),
              title: Text("YIFY TORRENT"),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "Latest",
                  ),
                  Tab(
                    text: "Popular",
                  )
                ],
              ),
            ),
            body: TabBarView(children: [
              FutureBuilder(
                  future: mrmYifyMovies,
                  builder: (BuildContext context,
                      AsyncSnapshot<YifyMovies> mrmSnapshot) {
                    if (mrmSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GridView.builder(
                      scrollDirection: Axis.vertical,
                      controller: ScrollController(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        childAspectRatio: 0.53,
                      ),
                      padding: EdgeInsets.all(8.0),
                      itemCount: mrmSnapshot.data.data.movies.length,
                      itemBuilder: (context, index) {
                        Movies movie = mrmSnapshot.data.data.movies[index];
                        return GestureDetector(
                          child: Container(
                              alignment: Alignment.topCenter,
                              child: Card(
                                semanticContainer: false,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 10.0,
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.topCenter,
                                      margin: EdgeInsets.all(5),
                                      child:
                                          Image.network(movie.largeCoverImage),
                                    ),
                                    Container(
                                        alignment: Alignment.bottomLeft,
                                        margin: EdgeInsets.all(30),
                                        child: Text(movie.titleLong,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)))
                                  ],
                                ),
                              )),
                        );
                      },
                    );
                  }),
              FutureBuilder(
                  future: mpmYifyMovies,
                  builder: (BuildContext context,
                      AsyncSnapshot<YifyMovies> mpmSnapshot) {
                    if (mpmSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GridView.builder(
                      scrollDirection: Axis.vertical,
                      controller: ScrollController(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        childAspectRatio: 0.53,
                      ),
                      padding: EdgeInsets.all(8.0),
                      itemCount: mpmSnapshot.data.data.movies.length,
                      itemBuilder: (context, index) {
                        Movies movie = mpmSnapshot.data.data.movies[index];
                        return GestureDetector(
                            child: Container(
                                alignment: Alignment.topCenter,
                                child: Card(
                                  semanticContainer: false,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 10.0,
                                  child: Stack(
                                    children: [
                                      Container(
                                        alignment: Alignment.topCenter,
                                        margin: EdgeInsets.all(5),
                                        child: Image.network(
                                            movie.largeCoverImage),
                                      ),
                                      Container(
                                          alignment: Alignment.bottomLeft,
                                          margin: EdgeInsets.all(30),
                                          child: Text(movie.titleLong,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)))
                                    ],
                                  ),
                                )));
                      },
                    );
                  }),
            ])));
  }
}
