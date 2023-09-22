import 'package:asd/components/shadow_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:asd/components/top_story.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopStory(
              title: 'The unlimited courage of Abdullah',
              readTime: '3 min read',
              bgImage: 'assets/images/child1.png',
            )
                .animate()
                .fadeIn(duration: 500.ms)
                .slideY(
                  duration: 500.ms,
                  begin: 0.2,
                )
                .shimmer(duration: 2000.ms),
            SizedBox(
              height: 25,
            ),
            ShadowItemCard(
              cardImage: 'assets/images/hand5.png',
              title: 'Geniuses With Autism',
              subTitle:
                  'These geniuses have either been diagnosed with or are thought to have autism.',
              cornerImage: 'assets/images/card_bg2.png',
            ).animate(delay: 500.ms).fadeIn(duration: 500.ms).slideY(
                  duration: 500.ms,
                  begin: 0.3,
                ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'We deal with',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
