// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables



import 'package:boardgamesmsf/util/init-images.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';

import '../../bloc/movies/movies_bloc.dart';
import '../../components/generic/load.dart';
import '../../components/movies/arrow-up.dart';
import '../../components/movies/prologue-description.dart';
import '../../domain/movie/movies.dart';
import '../../util/colors.dart';
import '../../util/styles.dart';

class DetailMovieOld extends StatefulWidget {
  DetailMovieOld();

  @override
  State<DetailMovieOld> createState() => _DetailMovieOldState();
}

class _DetailMovieOldState extends State<DetailMovieOld> {
  MoviesBloc _moviesBloc = Injector.appInstance.get<MoviesBloc>();
  double imageHeight = 250.0;
  String imageUrl = "";
  List<String> galleriaUrls = [];
  int maxLinesPro = 3;
  int maxLinesDesc = 3;
  bool visible = true;
  late Movie movie;

  _onTapPro(){
    _moviesBloc.add (GetChangeLinesProEvent(maxLinesPro == 3 ? 100 : 3));
  }
  _onTapDesc(){
    _moviesBloc.add (GetChangeLinesDescEvent(maxLinesDesc == 3 ? 100 : 3));
  }


  @override
  void initState() {

    // imageUrl = widget.game.portada ?? "";
    // _moviesBloc.add(GetGalleryByGameEvent(widget.game.id!));
    super.initState();
    _getImageSize();
  }

  void _getImageSize() {
    Image.network(imageUrl)
        .image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((info, _) {
      if (mounted) {
        setState(() {
          double screenWidth = MediaQuery.of(context).size.width;
          double aspectRatio = info.image.width / info.image.height;
          imageHeight = screenWidth / aspectRatio; // Mantiene la proporción
        });
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: context.select<MoviesBloc, Widget>((bloc){
        if (bloc.state is SelectedMovieState) {
          movie = (bloc.state as SelectedMovieState).movie;
        }
        galleriaUrls.add(movie.backdropPath != null ? movie.backdropPath!.completeUrl() : "");
        return BlocProvider(
          create: (context) => _moviesBloc,
          child: BlocListener<MoviesBloc, MoviesState>(
              listener: (context, state) {
                if (state is GetChangeLinesProState ){
                  setState(() {
                    maxLinesPro = state.lines;
                  });
                }
              },
              child:  Stack(
                children: [
                  SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(movie.posterPath?.completeUrl() ?? "",),
                            SizedBox(height: 16,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(movie.title ?? "", style: Styles().getStyleTittle(),),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Colores.getColorPrincipal(),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row (
                                        children: [
                                          Text(movie.voteAverage.toString() ?? "", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                                          Icon(Icons.star, color: Colors.yellow,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8,),
                            movie.originalTitle != "" ? Text("Título original: ${movie.originalTitle ?? ""}" , style: Styles().getStyleTittle().copyWith(fontSize: 18), overflow: TextOverflow.ellipsis,) : Container(),
                            SizedBox(height: 16,),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     IconNombre().GetIconNombre('assets/icon/jugadores.png', Formatjugadores().GetFormatJugadores(widget.game.jugadores ?? "")),
                            //     IconNombre().GetIconNombre('assets/icon/reloj.png', Formatduracion().GetFormatDuracion(widget.game.duracion ?? "")),
                            //     IconNombre().GetIconNombre('assets/icon/edad.png', Formatjugadores().GetFormatJugadores(widget.game.edad ?? "")),
                            //   ],
                            // ),
                            SizedBox(height: 16,),
                            PrologoDescripcion().GetPrologoDescripcion(_onTapPro, movie.overview ?? "", maxLinesPro, true),
                            Arrowup().GetArrowUp(_onTapPro, maxLinesPro == 3 ? false : true),
                            SizedBox(height: 16,),
                            galleriaUrls.isNotEmpty ? FanCarouselImageSlider.sliderType1(
                                imagesLink: galleriaUrls,
                                isAssets: false,
                                autoPlay: false,
                                sliderHeight: 400,
                                showIndicator: false  ,
                                showArrowNav: true
                            ) : Container()
                          ],
                        ),
                      )
                  ),
                  Load().GetLoad('Obteniendo imágenes', visible, size)
                ],
              )
          ),
        );
      })
    );
  }
}
