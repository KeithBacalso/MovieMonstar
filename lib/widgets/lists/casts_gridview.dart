import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movie_monstar/models/movie_casts.dart';
import 'package:movie_monstar/utilities/constants.dart';

class CastsGridview extends StatelessWidget {
  const CastsGridview({
    Key key,
    @required this.castList,
  }) : super(key: key);

  final List<MovieCasts> castList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: castList.length,
      itemBuilder: (context, index) {
        final cast = castList[index];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                  ImageUrls.movieImageUrl(cast.profilePath),
                ),
              ),
              Text(
                cast.originalName,
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
              AutoSizeText(
                cast.character,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 10.0),
              )
            ],
          ),
        );
      },
    );
  }
}
