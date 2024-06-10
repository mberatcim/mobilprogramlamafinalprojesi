import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

enum ThemeEvent { toggle }

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(_lightTheme) {
    on<ThemeEvent>((event, emit) {
      if (event == ThemeEvent.toggle) {
        if (state == _lightTheme) {
          emit(_darkTheme);
        } else {
          emit(_lightTheme);
        }
      }
    });
  }

  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
  );

  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
  );
}
