import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/movie_detail/movie_detail.dart';
import 'package:movie_app/services/api_services.dart';

class SimilarMoviesScreen extends StatelessWidget {
  final int movieId;

  const SimilarMoviesScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmes Similares'),
      ),
      body: FutureBuilder<Result>(
        future: ApiServices().getSimilarMovies(movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar filmes similares'));
          } else if (snapshot.hasData && snapshot.data != null) {
            final similarMovies = snapshot.data!.movies;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
              ),
              itemCount: similarMovies.length,
              itemBuilder: (context, index) {
                final movie = similarMovies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MovieDetailPage(
                              movieId: movie.id,
                            )));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            movie.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Nenhum filme similar encontrado.'));
        },
      ),
    );
  }
}
