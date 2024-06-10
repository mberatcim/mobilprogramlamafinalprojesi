import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

enum LanguageEvent { toggle }

class LanguageBloc extends Bloc<LanguageEvent, Locale> {
  LanguageBloc() : super(Locale('en')) {
    on<LanguageEvent>((event, emit) {
      if (event == LanguageEvent.toggle) {
        if (state.languageCode == 'en') {
          emit(Locale('tr'));
        } else {
          emit(Locale('en'));
        }
      }
    });
  }
}
