import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/route/routes.dart';
import 'package:flutter/material.dart';

import 'package:core/common/constants.dart';
import '../../domain/entities/season.dart';
import '../pages/season_detail_page.dart';

class SeasonCard extends StatelessWidget {
  final Season season;
  final String posterPath;
  final int id;

  SeasonCard(this.season, this.posterPath, this.id);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            seasonDetailPage,
            arguments: ScreenArguments(id, season.seasonNumber, posterPath),
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => SeasonDetailPage(id: id, seasonNumber: season.seasonNumber, posterPath: posterPath)),
          // );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      season.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    SizedBox(height: 16),
                    Text(
                      season.episodeCount.toString() + ' episodes.',
                    ),
                    SizedBox(height: 16),
                    Text(
                      season.overview,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${season.posterPath ?? posterPath}',
                  width: 80,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
