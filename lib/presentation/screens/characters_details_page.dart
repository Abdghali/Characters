// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:crac_app/constance/my_app_colors.dart';
import 'package:crac_app/data/models/episode.dart';
import 'package:flutter/material.dart';

import 'package:crac_app/data/models/characters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/characters_cubit.dart';

class CharactersDetailsPage extends StatelessWidget {
  const CharactersDetailsPage({
    Key? key,
    required this.character,
  }) : super(key: key);
  final Character character;

  /// SliverAppBar Widget
  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyAppColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name!,
          style: const TextStyle(color: MyAppColors.myWhite),
        ),
        background: Hero(
          tag: character.id!,
          child: Image.network(
            character.image!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

// characterInfo
  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyAppColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: MyAppColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

// custom divider
  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyAppColors.myYallow,
      thickness: 2,
    );
  }

  Widget checkIfEpisodeAreLoaded(CharactersState state) {
    if (state is EpisodeLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    Episode episode = (state).episode;
    if (episode != null) {
      int randomepisodeIndex =
          Random().nextInt(episode.name!.characters.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: MyAppColors.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyAppColors.myYallow,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              // FlickerAnimatedText(episode.name!),
              // FlickerAnimatedText(episode.airDate!),
              // FlickerAnimatedText(episode.created!),
              FlickerAnimatedText(episode.characters![randomepisodeIndex]),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyAppColors.myYallow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BlocProvider.of<CharactersCubit>(context)
        .getEpisode(character.episode!.first);
    return Scaffold(
      backgroundColor: MyAppColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Species : ', character.species.toString()),
                      buildDivider(270),
                      characterInfo('Gender : ', character.gender.toString()),
                      buildDivider(280),
                      characterInfo('Status : ', character.status.toString()),
                      buildDivider(290),
                      Visibility(
                        visible: character.type!.isNotEmpty,
                        replacement: Container(),
                        child: characterInfo(
                          'Type : ',
                          character.type.toString(),
                        ),
                      ),
                      Visibility(
                        visible: character.type!.isNotEmpty,
                        replacement: Container(),
                        child: buildDivider(300),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                          return checkIfEpisodeAreLoaded(state);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 500,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
