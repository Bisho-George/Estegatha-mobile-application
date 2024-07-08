import 'package:estegatha/features/catalog/data/models/blog.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:flutter/material.dart';

class BlogDetailScreen extends StatelessWidget {
  final Blog blog;

  const BlogDetailScreen({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title ?? 'Blog Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              bottom: getProportionateScreenHeight(
                  ConstantSizes.bottomNavBarHeight)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (blog.image != null)
                Image.network(
                  blog.image!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: getProportionateScreenHeight(250),
                ),
              Padding(
                padding: EdgeInsets.all(getProportionateScreenHeight(16.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (blog.title != null)
                      Text(
                        blog.title!,
                        style: Theme.of(context).textTheme.headlineMedium,
                        textDirection: TextDirection.rtl,
                      ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    if (blog.content != null)
                      Text(
                        textDirection: TextDirection.rtl,
                        blog.content!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
