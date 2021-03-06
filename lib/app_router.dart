import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_breaking/constants/strings.dart';
import 'package:flutter_breaking/data/repositories/characters_repository.dart';
import 'package:flutter_breaking/data/web_services/characters_web_services.dart';

import 'data/models/character.dart';
import 'presentation/screens/characters_screen.dart';
import 'presentation/screens/character_details_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider(
                  create: (context) => charactersCubit,
                  child: const CharactersScreen(),
                ));
      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider(
                  create: (context) => CharactersCubit(charactersRepository),
                  child: CharacterDetailsScreen(character: character),
                ));
    }
  }
}
