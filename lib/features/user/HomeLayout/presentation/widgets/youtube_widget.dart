import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/assets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

final List<String> videoIds = [
  'iOaMLRNVXyA',
  '6vD_bsJOLa0',
  'T8MCCgc7O9w',
  'XN5bN5Y1L7E',
];

class YouTubeThumbnailLink extends StatelessWidget {
  final String videoId; // YouTube video ID

  YouTubeThumbnailLink({required this.videoId});

  // Get the YouTube video thumbnail URL
  String getThumbnailUrl() {
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  // Function to launch the YouTube video URL
  Future<void> _launchURL() async {
    final url = 'https://www.youtube.com/watch?v=$videoId';
    if (await canLaunchUrl((Uri.parse(url)))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchURL,
      child: Stack(alignment: AlignmentDirectional.center, children: [
        CachedNetworkImage(
          imageUrl: getThumbnailUrl(),
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
        ),
        Image.asset(
          Assets.youtubeIcon,
          height: 30.h,
          width: 34.w,
          fit: BoxFit.fill,
        )
      ]),
    );
  }
}
