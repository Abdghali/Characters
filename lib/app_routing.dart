import 'package:crac_app/business_logic/cubit/characters_cubit.dart';
import 'package:crac_app/data/models/characters.dart';
import 'package:crac_app/data/repositories/characters_repository.dart';
import 'package:crac_app/data/services/characters_services.dart';
import 'package:crac_app/presentation/screens/characters_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constance/routes_names.dart';
import 'presentation/screens/characters_page.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(CharacterServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersPageRout:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: CharactersPage(),
          ),
        );
      case charactersDetailsPageRout:
        final selectedCharacter = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                CharactersCubit(charactersRepository),
            child: CharactersDetailsPage(
              character: selectedCharacter,
            ),
          ),
        );

      case charactersDetailsPageRout:
        final selectedCharacter = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            // create: (BuildContext context) =>
            //     CharactersCubit(charactersRepository),
            value: charactersCubit,
            child: CharactersDetailsPage(
              character: selectedCharacter,
            ),
          ),
        );
    }
  }
}
