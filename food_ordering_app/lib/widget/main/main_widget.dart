import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantImageWidget extends StatelessWidget {
  final String imageUrl;
  const RestaurantImageWidget({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          errorWidget: (context, url, err) => Center(
            child: Icon(Icons.image),
          ),
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class RestaurantInfoWidget extends StatelessWidget {
  final String name;
  final String address;
  const RestaurantInfoWidget({this.name, this.address});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              name,
              style: GoogleFonts.jetBrainsMono(
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              address,
              style: GoogleFonts.jetBrainsMono(
                  fontWeight: FontWeight.w400, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
