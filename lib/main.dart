import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:infinite_list_bloc/app.dart';
import 'package:infinite_list_bloc/simple_bloc_observer.dart';

void main() {
  Bloc.observer =  const SimpleBlocObserver();
  runApp(App());
}


