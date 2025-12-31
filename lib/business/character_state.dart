part of 'character_cubit.dart';

@immutable
sealed class CharacterState {}

final class CharacterInitial extends CharacterState {}

class CharacterLoaded extends CharacterState {
  List <Result> characters;
  CharacterLoaded(this.characters);

}
