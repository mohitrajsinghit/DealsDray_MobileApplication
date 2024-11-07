part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState{}

class HomeLoadedState extends HomeState {
  final List<BannerModel> banners;
  final List<CategoryModel> categories;
  final List<ProductModel> products;

  HomeLoadedState({required this.banners, required this.categories, required this.products});

}

class HomeLoadedErrorState extends HomeState {
   final String message;

  HomeLoadedErrorState({required this.message});


}
