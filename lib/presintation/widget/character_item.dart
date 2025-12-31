import 'package:flutter/material.dart';
import 'package:rick_and_morty/constant/colors.dart';
import 'package:rick_and_morty/constant/strings.dart';
import 'package:rick_and_morty/data/models/character_model.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({super.key, required this.character});
  final Result character;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, characterDetailsScreen, arguments: character);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: GridTile(
            footer: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                character.name,
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColors.white,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            child: Hero(
              tag: character.id,
              child: Container(
                color: MyColors.grey,
                child: character.image.isNotEmpty?
                // const Center(
                //     child: CircularProgressIndicator(
                //       backgroundColor:MyColors.grey ,
                //       color: MyColors.yellow,
                //     ),)
                     FadeInImage.assetNetwork(
                        // Corrected the placeholder image path
                        placeholder: 'assets/images/Spinner@1x-1.0s-200px-200px (2).gif',
                        image: character.image,
                        fit: BoxFit.cover,
                      )

                    : Image.asset('assets/images/download.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
