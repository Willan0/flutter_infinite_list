import 'package:flutter/material.dart';
import 'package:infinite_list_bloc/posts/pages/post_page.dart';

class App extends MaterialApp {
  App({super.key})
      : super(
            title: 'Flutter Infinite List',
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
                appBarTheme: AppBarTheme(
                  backgroundColor: Colors.deepPurpleAccent.withOpacity(0.3),
                  centerTitle: true,
                  titleTextStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 20,)
                )),
            home: const PostPage(),
            debugShowCheckedModeBanner: false);
}
