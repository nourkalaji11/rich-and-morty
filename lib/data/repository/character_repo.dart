import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/data/web_services/character_web_services.dart';

class CharacterRepo {
  final CharacterWebServices characterWebServices;

  CharacterRepo(this.characterWebServices);

  Future<List<Result>> getAllCharacter() async {
    try {
      final response = await characterWebServices.getAllCharacter();
      if (response != null) {
        final characterModel = CharacterModel.fromJson(response);
        return characterModel.results;
      } else {
        return [];
      }
    } catch (e) {
      print('Error in repository: $e');
      return [];
    }
  }
}
