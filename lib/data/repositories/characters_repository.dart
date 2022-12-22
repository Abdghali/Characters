import 'package:crac_app/data/models/characters.dart';
import 'package:crac_app/data/services/characters_services.dart';

import '../models/episode.dart';

class CharactersRepository {
  final CharacterServices characterServices;

  CharactersRepository(this.characterServices);

  Future<List<Character>?> getAllCharacters() async {
    final charactersDataMap = await characterServices.getAllCharacters();
    final charactersData = CharacterData.fromJson(charactersDataMap);
    return charactersData.characters;
  }

  Future<Episode> getCharacterEpisode(String episodeUrl) async {
    final episode = await characterServices.getCharacterEpisode(episodeUrl);
    return Episode.fromJson(episode);
  }
}
