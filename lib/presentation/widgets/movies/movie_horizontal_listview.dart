//import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

//import '../../../config/helpers/human_formats.dart';
import '../../../domain/entities/movie.dart';

class MovieHorizontalListview extends StatelessWidget {

  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key, 
    this.title, 
    this.subTitle,
    this.loadNextPage, 
    required this.movies, 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
           if ( title != null || subTitle != null )
            _Title(title: title, subTitle: subTitle ),

            // ListView.builder(
            //   itemCount: movies.length,
            //   scrollDirection: Axis.horizontal,
            //   physics: const BouncingScrollPhysics(),
            //   itemBuilder: (context, index) => _Slide(movie: movies[index])
            // )
        ],
      ),
    );
  }
}

// class _Slide extends StatelessWidget {

//   final Movie movie;

//   const _Slide({ required this.movie });

//   @override
//   Widget build(BuildContext context) {

//     //final textStyles = Theme.of(context).textTheme;

//     return Container(
//       margin: const EdgeInsets.symmetric( horizontal: 8),
//       child: const Placeholder()
//     );
//   }
// }

class _Title extends StatelessWidget {

  final String? title;
  final String? subTitle;

  const _Title({ this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only( top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          
          if ( title != null )
            Text(title!, style: titleStyle ),
          
          const Spacer(),

          if ( subTitle != null )
            FilledButton.tonal(
              style: const ButtonStyle( visualDensity: VisualDensity.compact ),
              onPressed: (){}, 
              child: Text( subTitle! )
          )

        ],
      ),
    );
  }
}