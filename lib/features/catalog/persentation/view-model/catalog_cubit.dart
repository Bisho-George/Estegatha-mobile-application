import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:estegatha/features/catalog/data/api/catalog_http_client.dart';
import 'package:estegatha/features/catalog/data/models/blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'catalog_state.dart';

class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit() : super(CatalogInitial());

  // Future<List<Blog>>? getCatalogBlogs() async {
  //   emit(CatalogLoading());

  //   try {
  //     final response = await CatalogHttpClient.getCatalogBlogs();

  //     if (response.statusCode == 200) {
  //       final responseBody = jsonDecode(response.body);
  //       final List<Blog> blogs =
  //           (responseBody as List).map((blog) => Blog.fromJson(blog)).toList();

  //       // save the blogs to shared preferences to be used later if connection is lost
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       prefs.setString('blogs', jsonEncode(blogs));

  //       emit(CatalogLoaded(blogs));
  //       return blogs;
  //     } else {
  //       print('Status code: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //       emit(const CatalogFailure(errMessage: "Failed to get user details!"));
  //     }
  //   } catch (e) {
  //     print('Exception: $e');
  //     emit(const CatalogFailure(errMessage: "Failed to get user details!"));
  //   }
  //   return [];
  // }
  Future<List<Blog>>? getCatalogBlogs() async {
    emit(CatalogLoading());

    try {
      final response = await CatalogHttpClient.getCatalogBlogs();
      print("End point called for get catalog blogs");

      print("Respons body: ${response.body}");
      if (response.statusCode == 200) {
        // final responseBody = jsonDecode(response.body);
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        print("DEcoded response body: $responseBody");
        final List<Blog> newBlogs =
            (responseBody as List).map((blog) => Blog.fromJson(blog)).toList();

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? storedBlogsJson = prefs.getString('blogs');
        List<Blog> storedBlogs = storedBlogsJson != null
            ? (jsonDecode(storedBlogsJson) as List)
                .map((blog) => Blog.fromJson(blog))
                .toList()
            : [];

        // Check if there are new blogs not present in the stored blogs
        var newBlogsToAdd = newBlogs.where((newBlog) =>
            !storedBlogs.any((storedBlog) => storedBlog.id == newBlog.id));

        if (newBlogsToAdd.isNotEmpty) {
          // If there are new blogs, add them to the stored blogs and save
          storedBlogs.addAll(newBlogsToAdd);
          prefs.setString('blogs', jsonEncode(storedBlogs));
        }

        emit(CatalogLoaded(newBlogs));
        return newBlogs;
      } else {
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        emit(const CatalogFailure(errMessage: "Failed to get user details!"));
      }
    } catch (e) {
      print('Exception: $e');
      emit(const CatalogFailure(errMessage: "Failed to get user details!"));
    }
    return [];
  }
}
