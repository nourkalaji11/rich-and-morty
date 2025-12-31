import 'package:flutter/material.dart';
import 'package:rick_and_morty/constant/colors.dart';
import 'package:rick_and_morty/data/models/character_model.dart';

class CharacterDetailesScreen extends StatelessWidget {
   CharacterDetailesScreen({super.key, required this.character});
  final Result character;


  Widget buildSliverAppBar() {
    return SliverAppBar(
      iconTheme: IconThemeData(color: MyColors.white),
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.grey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.name,
          style: const TextStyle(color: MyColors.white),
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
            text: title,
            style: const TextStyle(
                color: MyColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        TextSpan(
            text: value,
            style: const TextStyle(
              color: MyColors.white,
              fontSize: 16,
            )),
      ]),
    );
  }

  Widget buildDivider(double endIdent) {
    return Divider(
      height: 30,
      thickness: 3,
      color: MyColors.yellow,
      endIndent: endIdent,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth=MediaQuery.of(context).size.width;
    final screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyColors.grey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo(
                          'status : ', character.status.name.toLowerCase()),
                      buildDivider(290),
                      characterInfo(
                          'species : ', character.species.name.toLowerCase()),
                      buildDivider(278),
                      characterInfo(
                          'gender : ', character.gender.name.toLowerCase()),
                      buildDivider(283),
                      characterInfo('location : ',
                          character.location.name.toLowerCase()),
                      buildDivider(275),
                      characterInfo('origin : ',
                          character.origin.name),
                      buildDivider(293),
                      characterInfo('episodes : ',
                          character.episode.map((url) => url.split('/').last).toList().join(', ')),
                      buildDivider(266),
                    ],
                  ),
                ),
                const SizedBox(height: 400) // For scroll padding
              ],
            ),
          )
        ],
      ),
    );
  }
}
