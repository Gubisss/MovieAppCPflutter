import 'package:flutter/material.dart';
import 'package:movie_app/models/review_model.dart';
import 'package:movie_app/services/api_services.dart';

class ReviewsPage extends StatelessWidget {
  final int movieId;

  const ReviewsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    ApiServices apiServices = ApiServices();

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Reviews'),
      ),
      body: FutureBuilder<List<ReviewModel>>(
        future: apiServices.getMovieReviews(movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No reviews available.'));
          }

          final reviews = snapshot.data!;

          return ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  reviews[index].author,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 17, 66, 155),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  reviews[index].content,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
