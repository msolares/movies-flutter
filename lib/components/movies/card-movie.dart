import 'package:boardgamesmsf/util/init-images.dart';
import 'package:flutter/material.dart';
import '../../domain/movie/movies.dart';

class CardMovie {
  Widget getCardMovie(Movie movie) {
    return AspectRatio(
      aspectRatio: 1, // Hace que el contenedor sea cuadrado
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200], // Color de fondo en caso de imagen nula
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            movie.posterPath?.completeUrl() ?? "",
            fit: BoxFit.cover, // Cubre todo el espacio sin deformarse
            errorBuilder: (context, error, stackTrace) =>
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(movie.originalTitle ?? ""),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}