import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit copy/cubit.dart';
import 'cubit copy/states.dart';

class NewsLayout extends StatelessWidget {
  var searchController = TextEditingController();
  var searchController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  onChanged: (value) => cubit.getSearch(searchController.text),
                ),
                TextField(
                  controller: searchController2,
                  onChanged: (value) => cubit.getSearch(searchController2.text),
                ),
                ListView.builder(
                  shrinkWrap: true, // Added this line to ensure proper height
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling
                  itemCount: cubit.search.length,
                  itemBuilder: (context, index) {
                    var item = cubit.search[index]['title'];
                    return ListTile(
                      title: Text(item),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
