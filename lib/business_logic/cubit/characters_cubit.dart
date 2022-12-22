import 'package:bloc/bloc.dart';
import 'package:crac_app/data/models/characters.dart';
import 'package:flutter/material.dart';

import '../../data/models/episode.dart';
import '../../data/repositories/characters_repository.dart';
part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Character> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      print("characters.length : ${characters!.length}");
      emit(CharactersLoaded(characters));
    });
    return characters;
  }

  void getEpisode(String episodeUrl) {
    charactersRepository
        .getCharacterEpisode(episodeUrl)
        .then((Episode episode) {
      print("episode.name : ${episode.name}");
      emit(EpisodeLoaded(episode));
    });
  }
}
