import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thepause_audio_player_app/core/utils/utils.dart';
import 'package:thepause_audio_player_app/presentation/bloc/boarding_bloc/boarding_event.dart';
import 'package:thepause_audio_player_app/presentation/bloc/boarding_bloc/boarding_state.dart';
import 'package:thepause_audio_player_app/presentation/screens/home/home_view.dart';

class BoardingBLoc extends Bloc<BoardingEvent, BoardingState> {
  final PageController pageController;
  BoardingBLoc({required this.pageController}) : super(const BoardingState()) {
    on<OnPageChangeEvent>(_onPageChangeEvent);
    on<OnSkipTapEvent>(_onSkipTapEvent);
    on<LetsGoTapEvent>(_letsGoTapEvent);
  }

  void _onPageChangeEvent(
      OnPageChangeEvent event, Emitter<BoardingState> emit) {
    pageController.animateToPage(event.index,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    emit(state.copyWith(index: event.index));
  }

  Future<void> _onSkipTapEvent(
      OnSkipTapEvent event, Emitter<BoardingState> emit) async {
    var pref = await SharedPreferences.getInstance();
    final isPermissionGranted = await Utils.requestPermission();
    if (isPermissionGranted) {
      Utils.go(context: event.context!, screen: const HomeView());
      pref.setBool('OPENED', true);
    } else {
      await Utils.requestPermission();
    }
  }

  Future<void> _letsGoTapEvent(
      LetsGoTapEvent event, Emitter<BoardingState> emit) async {
    var pref = await SharedPreferences.getInstance();
    final isPermissionGranted = await Utils.requestPermission();
    if (isPermissionGranted) {
      await Utils.go(context: event.context!, screen: const HomeView());
      pref.setBool('OPENED', true);
    } else {
      await Utils.requestPermission();
    }
  }
}
