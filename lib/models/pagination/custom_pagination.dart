

import 'package:med_g/models/pagination/iresult.dart';

class CustomPagination {
  final int currentPage;
  final int totalPages;
  final List<IResult>? results;

  CustomPagination({
    required this.currentPage,
    required this.results,
    required this.totalPages,
  });

  factory CustomPagination.fromJson(
          Map<String, dynamic> json, IResult serializer) =>
      CustomPagination(
          currentPage: json['current_page'] as int? ?? 0,
          results: (json['results'] as List)
              .map<IResult>((e) =>
                  IResult.fromJson(e as Map<String, dynamic>, serializer))
              .toList(),
          totalPages: json['total_pages'] as int? ?? 0);
}
