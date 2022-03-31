

import 'package:med_g/models/pagination/iresult.dart';

class BasePagination {
  BasePagination({
    this.next,
    this.results,
    this.total,
  });

  final String? next;
  final List<IResult>? results;
  final int? total;

  BasePagination copyWith({
    String? next,
    List<IResult>? results,
  }) =>
      BasePagination(
        next: next ?? this.next,
        results: results ?? this.results,
      );

  factory BasePagination.fromJson(
          Map<String, dynamic> json, IResult serizlizer) =>
      BasePagination(
          next: json['next'] as String?,
          total: json['count'] as int? ?? 0,
          results: (json['results'] as List)
              .map<IResult>((e) =>
                  IResult.fromJson(e as Map<String, dynamic>, serizlizer))
              .toList());
}
