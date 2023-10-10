import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/config/configs.dart';


import '../../../../../config/app.dart';
import '../../../domain/entities/exercise.dart';
import '../../bloc/exercise/remote/remote_exercise_bloc.dart';
import '../../widgets/exercise_tile.dart';

class ExercisesPage extends StatelessWidget {
  const ExercisesPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody() ,
    );
  }
  
  _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
          'Exercises',
        ),
        actions: [
          GestureDetector(
            onTap: () => _onShowBookmarksViewTapped(context),
            child:  Padding(
              padding: Space.h1!,
              child: Icon(Icons.bookmark),
            ),
          ),
        ],
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteExerciseBloc,RemoteExerciseState> (
      builder: (_,state) {
        if (state is RemoteExerciseLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteExerciseError) {
          return const Center(child: Icon(Icons.refresh,color: Colors.blue,));
        }
        if (state is RemoteExerciseLoaded) {
          return ListView.builder(
           itemBuilder: (context,index){
            return ExerciseWidget(
              exercise: state.exercises![index] ,
              onExercisePressed: (article) => _onArticlePressed(context,article),
            );
           },
           itemCount: state.exercises!.length,
         );
        }
        return const SizedBox();
      },
    );
  }

  void _onArticlePressed(BuildContext context, ExerciseEntity article) {
    Navigator.pushNamed(context, '/ExerciseDetails', arguments: article);
  }

  void _onShowBookmarksViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/Bookmarks');
  }
  
}
