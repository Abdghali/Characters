part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;
  CharactersLoaded(this.characters);
}

class EpisodeLoaded extends CharactersState {
  final Episode episode;

  EpisodeLoaded(this.episode);
}

class CharactersError extends CharactersState {}
