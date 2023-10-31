import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/shared/dio_helper.dart';

import 'bloc_observer.dart';
import 'layout/cubit copy/cubit.dart';
import 'layout/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  get isDark => null;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NewsCubit()),
        ],
        child: MaterialApp(
          home: NewsLayout(),
        ));
  }
}
