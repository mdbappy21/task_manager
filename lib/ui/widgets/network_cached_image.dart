import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkCachedImage extends StatelessWidget {
  const NetworkCachedImage(
      {super.key,
        required this.imageUrl,
        this.width,
        this.height,
        required this.fit});

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width??50,
      height: height??50,

      // placeholder: (_,__)=>Center(
      //   child: CircularProgressIndicator(),
      // ),

      progressIndicatorBuilder: (_, __, ___) {
        return CircularProgressIndicator();
      },
      errorWidget: (_,__,___){
        return Icon(Icons.error_outline);
      },
    );
  }
}
