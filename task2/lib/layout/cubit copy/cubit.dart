import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/layout/cubit%20copy/states.dart';

import '../../shared/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<dynamic> news2 = [];

  void get_news2() {
    emit(NewsGetSportsLoadingState());

    if (news2.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'sports',
          'apiKey': 'ddfab6085e084e05b38e08c343021ca1',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        news2 = value.data['articles'];
        print(news2[0]['title']);

        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  //test
  List<dynamic> news = [];

  void news1() {
    emit(NewsGetScienceLoadingState());

    if (news.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'science',
          'apiKey': 'ddfab6085e084e05b38e08c343021ca1',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        news = value.data['articles'];
        print(news[0]['title']);

        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search1 = [];

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': 'ddfab6085e084e05b38e08c343021ca1',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      search1 = [];
      search1 = value.data['articles'];
      search.addAll(search1);
      search.addAll(search2);

      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  List<dynamic> search2 = [];

  void getSearch2(String value) {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': 'ddfab6085e084e05b38e08c343021ca1',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      search2 = [];
      search2 = value.data['articles'];
      search.addAll(search1);

      search.addAll(search2);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  List<dynamic> searching = [];
  var value11 = "";
  var value22 = '';
  void getSearching(String value, String value2) {
    emit(NewsGetSearchLoadingState());

    if (value != value11) {
      DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': '$value',
          'apiKey': 'ddfab6085e084e05b38e08c343021ca1',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        value11 = value.toString();

        search1 = [];
        search = [];
        search1 = value.data['articles'];

        emit(NewsGetSearchSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });
    }
    if (value2 != value22) {
      DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': '$value2',
          'apiKey': 'ddfab6085e084e05b38e08c343021ca1',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        value22 = value2;

        search = [];
        search2 = [];
        search2 = value.data['articles'];
        search.addAll(search1);
        search.addAll(search2);
        emit(NewsGetSearchSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });
    }
    search.addAll(search1);
    search.addAll(search2);
  }
}
