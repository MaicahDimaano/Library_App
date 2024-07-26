import 'package:flutter/material.dart';
import 'package:library_app/themes.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

//display how the recent books will be displayed
class RecentBook extends StatelessWidget {
  const RecentBook({
    Key? key,
     required this.image,
    required this.title,
    required this.completionPercentage,
  }) : super(key: key);

  final String image;
  final String title;
  final double completionPercentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: borderColorRecentBook),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Image.network(
            image,
            width: 90,
          ),
          const SizedBox(width: 18),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: semiBoldText14.copyWith(color: blackColor2),
              ),
              CircularPercentIndicator(
                reverse: true,
                radius: 30,
                lineWidth: 7,
                animation: true,
                percent: completionPercentage,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: greenColor,
                backgroundColor: greyColorRecentBook,
              ),
              Text(
                '${(completionPercentage * 100).toInt()}% Completed',
                style: mediumText12.copyWith(
                  color: greyColorRecentBook,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
