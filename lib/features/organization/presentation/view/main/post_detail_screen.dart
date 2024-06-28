import 'package:estegatha/features/organization/domain/models/post.dart';
import 'package:estegatha/utils/common/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostDetailScreen extends StatelessWidget {
  Post post;
  PostDetailScreen({super.key, required this.post});

  String formatDate(String dateString) {
    print("Original Date String: $dateString");

    // Remove the AM/PM part
    if (dateString.contains('AM') || dateString.contains('PM')) {
      dateString = dateString.substring(0, dateString.length - 3);
    }

    DateTime dateTime = DateTime.parse(dateString);

    DateFormat outputFormat = DateFormat('d MMM, y h:mm a');
    return outputFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: Icons.arrow_back,
        leadingOnPressed: () {
          Navigator.pop(context, true);
        },
        title: Text(
          post.title!,
          style: TextStyle(
            fontSize: SizeConfig.font20,
            color: ConstantColors.primary,
          ),
        ),
        showBackArrow: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title!,
              style: TextStyle(
                fontSize: SizeConfig.font24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'By ${post.author}',
              style: TextStyle(
                fontSize: SizeConfig.font18,
                color: ConstantColors.darkGrey,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Published on ${formatDate(post.publishedAt!)}',
              style: TextStyle(
                fontSize: SizeConfig.font16,
                color: ConstantColors.darkGrey,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  post.content!,
                  style: TextStyle(
                    fontSize: SizeConfig.font18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
