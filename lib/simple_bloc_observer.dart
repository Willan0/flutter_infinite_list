import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class SimpleBlocObserver extends BlocObserver {
  const SimpleBlocObserver();

  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint(
        "Bloc runtime Type : ${bloc.runtimeType} and transition  : ${change.runtimeType}");
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint(
        "Bloc runtime Type : ${bloc.runtimeType} and transition  : ${transition.runtimeType}");
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint(
        "Bloc runtime Type : ${bloc.runtimeType} and transition  : $stackTrace");
    super.onError(bloc, error, stackTrace);
  }
}
