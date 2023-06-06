import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/season.dart';

class SeasonDetailPage extends StatelessWidget {
  static const ROUTE_NAME = '/season-detail';

  final Season season;
  SeasonDetailPage({required this.season});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Season Detail'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500${season.posterPath}',
                width: screenWidth,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      season.name!,
                      style: kHeading5,
                    ),
                    Text(
                      '${season.episodeCount} episodes',
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Air Date',
                      style: kHeading6,
                    ),
                    Text(
                      season.airDate ?? "No air date available",
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Overview',
                      style: kHeading6,
                    ),
                    Text(
                      season.overview == ""
                          ? "No overview available"
                          : season.overview!,
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
