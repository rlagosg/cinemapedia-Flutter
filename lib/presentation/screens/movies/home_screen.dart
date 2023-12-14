import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';


class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();
    
    ref.read( nowPlayingMoviesProvider.notifier ).loadNextPage();
    ref.read( popularMoviesProvider.notifier ).loadNextPage();
    ref.read( topRatedMoviesProvider.notifier ).loadNextPage();
    ref.read( upComingMoviesProvider.notifier ).loadNextPage();
  }


  @override
  Widget build(BuildContext context) {

    final initiialLoading = ref.watch(initialLoadingProvider);
    if ( initiialLoading ) return const FullScreenLoader();

    final slideShowMovie = ref.watch( moviesSlideshowProvider );   

    final nowPlayingMovies = ref.watch( nowPlayingMoviesProvider );    
    final popularMovies = ref.watch( popularMoviesProvider );    
    final topRatedMovies = ref.watch( topRatedMoviesProvider );    
    final upComingMovies = ref.watch( upComingMoviesProvider );    

    return CustomScrollView(
      slivers: [

        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(5),
            title: CustomAppbar(),
          ),
        ),

        SliverList(delegate: SliverChildBuilderDelegate(
          (context, index){
            return Column(
              children: [
                //const CustomAppbar(),
                MoviesSlideShow(movies: slideShowMovie),
            
                MovieHorizontalListview(
                  movies: nowPlayingMovies, 
                  title: 'En cines',
                  subTitle: 'Enero 20',
                  loadNextPage: ()=> ref.read(nowPlayingMoviesProvider.notifier).loadNextPage() ,
                ),
            
                MovieHorizontalListview(
                  movies: upComingMovies, 
                  title: 'Proximamente',
                  subTitle: 'En este mes',
                  loadNextPage: ()=> ref.read(upComingMoviesProvider.notifier).loadNextPage() ,
                ),

                MovieHorizontalListview(
                  movies: popularMovies, 
                  title: 'Populares',
                  subTitle: 'Con mas vistas',
                  loadNextPage: ()=> ref.read(popularMoviesProvider.notifier).loadNextPage() ,
                ),

                MovieHorizontalListview(
                  movies: topRatedMovies, 
                  title: 'Mejor Calificadas',
                  subTitle: 'Desde siempre',
                  loadNextPage: ()=> ref.read(topRatedMoviesProvider.notifier).loadNextPage() ,
                ),

                const SizedBox(
                  height: 10,
                ),
            
              ],
            );
          },
          childCount: 1
        ))
      ]
    );
  }
} 