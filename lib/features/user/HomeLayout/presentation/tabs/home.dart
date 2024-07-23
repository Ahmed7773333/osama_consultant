import 'package:flutter/material.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/assets.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(150, 80),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          child: AppBar(
            title: Text(
              'Hi Handwerker!',
              style: AppStyles.welcomeSytle,
            ),
            backgroundColor: const Color(0XFF07D9AD),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Live',
                style: AppStyles.smallLableStyle,
              ),
              SizedBox(
                height: 168,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Image.asset(Assets.logo);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 1,
                      );
                    },
                    itemCount: 6),
              ),
              SizedBox(
                height: 100,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Image.asset(Assets.logo);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 5,
                      );
                    },
                    itemCount: 6),
              ),
              Text(
                'Popular',
                style: AppStyles.smallLableStyle,
              ),
              SizedBox(
                height: 264,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Image.asset(Assets.logo);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 0,
                      );
                    },
                    itemCount: 6),
              ),
              Text(
                'Feature',
                style: AppStyles.smallLableStyle,
              ),
              SizedBox(
                height: 130,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Image.asset(Assets.logo);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 0,
                      );
                    },
                    itemCount: 6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
