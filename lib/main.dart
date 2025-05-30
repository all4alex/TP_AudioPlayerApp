// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:thepause_audio_player_app/core/db_helper/db_helper.dart';
import 'package:thepause_audio_player_app/core/res/app_colors.dart';
import 'package:thepause_audio_player_app/presentation/bloc/album_bloc/album_bloc.dart';
import 'package:thepause_audio_player_app/presentation/bloc/boarding_bloc/boarding_bloc.dart';
import 'package:thepause_audio_player_app/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:thepause_audio_player_app/presentation/bloc/player_bloc/player_bloc.dart';
import 'package:thepause_audio_player_app/presentation/screens/intro/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BoardingBLoc(pageController: PageController()),
        ),
        BlocProvider(
          create: (_) => HomeBloc(dbHelper: DbHelper()),
        ),
        BlocProvider(
          create: (_) => PlayerBloc(player: AudioPlayer()),
        ),
        BlocProvider(
          create: (_) => AlbumBloc(pageController: PageController()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
