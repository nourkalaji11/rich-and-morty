import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:rick_and_morty/business/character_cubit.dart';
import 'package:rick_and_morty/constant/colors.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/presintation/widget/character_item.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  //search filter
  late List<Result> allCharacter;
  late List<Result> searchForCharacter = []; // Initialized to avoid errors
  bool _isSearched = false;
  final _searchedTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<CharacterCubit>(context).getAllCharacter();
    });
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchedTextController,
      cursorColor: MyColors.grey,
      decoration: const InputDecoration(
          hintText: 'Find a character',
          border: InputBorder.none,
          hintStyle: TextStyle(color: MyColors.grey, fontSize: 18)),
      style: const TextStyle(color: MyColors.grey, fontSize: 18),
      onChanged: (searchCharacter) {
        addSearchedForItemToSearchedList(searchCharacter);
      },
    );
  }

  void addSearchedForItemToSearchedList(String searchCharacter) {
    searchForCharacter = allCharacter
        .where((character) =>
            character.name.toLowerCase().startsWith(searchCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearched) {
      return [
        IconButton(
            onPressed: () {
              _stopSearch();
            },
            icon: const Icon(
              Icons.clear,
              color: MyColors.grey,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: const Icon(
              Icons.search,
              color: MyColors.grey,
            )),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      _isSearched = true;
    });
  }

  void _stopSearch() {
    _cleanSearch();
    setState(() {
      _isSearched = false;
    });
  }

  void _cleanSearch() {
    setState(() {
      _searchedTextController.clear();
    });
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(color: MyColors.grey, fontWeight: FontWeight.bold),
    );
  }

  Widget buildNoInternet() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // To center the content
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'can\'t connect ... check internet',
              style: TextStyle(
                fontSize: 22,
                color: MyColors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),SizedBox(height: 40,),
            Image.asset('assets/images/no-wifi.png',) // Corrected image path
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearched ? const BackButton(color: MyColors.grey) : Container(),
        backgroundColor: MyColors.yellow,
        title: _isSearched ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      backgroundColor: MyColors.grey,
      body:OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            List<ConnectivityResult> connectivity,
            Widget child,
            ) {
          final bool connected =! connectivity.contains(ConnectivityResult.none) ;
          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternet();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        if (state is CharacterLoaded) {
          allCharacter = state.characters;
          return buildLoadedListWidget();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.yellow,
      ),
    );
  }

  Widget buildLoadedListWidget() {
    if (allCharacter.isEmpty) {
      return const Center(
        child: Text(
          'No characters found to display.',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      );
    } else {
      return buildCharactersGrid();
    }
  }

  Widget buildCharactersGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0, // Each item will have a maximum width of 200
        childAspectRatio: 2 / 3, // The ratio of width to height
        crossAxisSpacing: 8, // Spacing between columns
        mainAxisSpacing: 8, // Spacing between rows
      ),
      itemCount: _searchedTextController.text.isEmpty
          ? allCharacter.length
          : searchForCharacter.length,
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        final character = _searchedTextController.text.isEmpty
            ? allCharacter[index]
            : searchForCharacter[index];
        return CharacterItem(
          character: character,
        );
      },
    );
  }
}
