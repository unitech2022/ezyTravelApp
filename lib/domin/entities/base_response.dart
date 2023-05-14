import 'package:equatable/equatable.dart';

class BaseResponse extends Equatable {
  final int currentPage;
  final int totalPages;
  final List<Object> items;
  const BaseResponse({required this.currentPage, required this.totalPages,required this.items});

  @override
  List<Object?> get props => [currentPage, totalPages,items];
}
