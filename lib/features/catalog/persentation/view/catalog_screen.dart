import 'dart:convert';
import 'package:estegatha/features/catalog/data/models/blog.dart';
import 'package:estegatha/features/catalog/persentation/view-model/catalog_cubit.dart';
import 'package:estegatha/features/catalog/persentation/view/blog_detail_screen.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:estegatha/utils/common/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  Future<List<Blog>> _loadBlogsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String? blogsJson = prefs.getString('blogs');
    if (blogsJson != null) {
      final List<dynamic> blogList = jsonDecode(blogsJson);
      return blogList.map((blog) => Blog.fromJson(blog)).toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<CatalogCubit>(context).getCatalogBlogs();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text(
            'Catalog',
            style: TextStyle(
              fontSize: SizeConfig.font20,
              color: ConstantColors.primary,
            ),
          ),
          showBackArrow: false,
        ),
        body: Column(
          children: [
            const SectionHeading(title: "Catalog Blogs"),
            SizedBox(height: getProportionateScreenHeight(ConstantSizes.sm)),
            Expanded(
              child: FutureBuilder<List<Blog>>(
                future: _loadBlogsFromPrefs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final blogs = snapshot.data!;
                    return ListView.builder(
                      itemCount: blogs.length,
                      itemBuilder: (context, index) {
                        final blog = blogs[index];
                        return Container(
                          padding: EdgeInsets.only(
                              left: getProportionateScreenHeight(
                                  ConstantSizes.md),
                              top: getProportionateScreenHeight(
                                  ConstantSizes.sm),
                              bottom: getProportionateScreenHeight(
                                  ConstantSizes.sm)),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: ConstantColors.grey,
                                width: 1,
                              ),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              blog.title!,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: SizeConfig.font20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: blog.image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        getProportionateScreenHeight(4)),
                                    child: Image.network(
                                      blog.image!,
                                      width: getProportionateScreenWidth(50),
                                      height: getProportionateScreenHeight(50),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : null,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BlogDetailScreen(blog: blog),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: Text('No blogs available'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
