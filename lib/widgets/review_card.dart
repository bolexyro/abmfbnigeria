import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.nameAndRole,
    required this.whatTheySaid,
  });

  final String nameAndRole;
  final String whatTheySaid;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 600,
      child: Card(
        elevation: 20,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                      height: 30,
                      width: 30,
                      decoration: const ShapeDecoration(
                        color: Colors.yellow,
                        shape: StarBorder(points: 5),
                      ),
                    ),
                ],
              ),
              const Gap(10),
              Text(whatTheySaid),
            ],
          ),
        ),
      ),
    );
  }
}
