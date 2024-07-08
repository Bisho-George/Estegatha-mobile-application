part of 'catalog_cubit.dart';

abstract class CatalogState extends Equatable {
  const CatalogState();

  @override
  List<Object> get props => [];
}

class CatalogInitial extends CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogFailure extends CatalogState {
  final String errMessage;

  const CatalogFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

class CatalogLoaded extends CatalogState {
  final List<Blog> catalogs;

  const CatalogLoaded(this.catalogs);

  @override
  List<Object> get props => [catalogs];
}

// class CatalogLoaded extends CatalogState {
//   const CatalogLoaded() : super();
// }
