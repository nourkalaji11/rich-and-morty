import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/data/repository/character_repo.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit(this.characterRepo) : super(CharacterInitial());
  final CharacterRepo characterRepo;
  List<Result> result=[];
  List<Result> getAllCharacter(){
    characterRepo.getAllCharacter().then((Result) {
      emit(CharacterLoaded(Result));
      this.result=Result;
    });
    return result;
  }

}
