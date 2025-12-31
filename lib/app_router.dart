import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/business/character_cubit.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/data/repository/character_repo.dart';
import 'package:rick_and_morty/data/web_services/character_web_services.dart';
import 'package:rick_and_morty/presintation/screen/character_detailes_screen.dart';
import 'package:rick_and_morty/presintation/screen/character_screen.dart';
import 'package:bloc/bloc.dart';
import 'constant/strings.dart';

class AppRouter{
  late CharacterRepo characterRepo;
  late CharacterCubit characterCubit;

  AppRouter(){
    characterRepo=CharacterRepo(CharacterWebServices());
    characterCubit=CharacterCubit(characterRepo);
  }


  Route? generateRoute(RouteSettings settings){
     switch(settings.name){
       case  characterScreen: // Corrected from charactersceen
         return MaterialPageRoute(builder: (_)=> BlocProvider(
           create: (context) => characterCubit,
           child: const CharacterScreen(),
         ),
         );


       case  characterDetailsScreen:
         final character=settings.arguments as Result;
         return MaterialPageRoute(builder: (_)=> CharacterDetailesScreen(character: character,));
     }
     return null;
  }
}