import 'package:dealsdray/Repositories/api_repository.dart';
import 'package:dealsdray/view/home_screen/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiRepository apiRepository;
  HomeBloc(this.apiRepository) : super(HomeInitial()) {
    on<FetchHomeData>((event, emit) async {
      emit(HomeLoadingState());
      try {
        final data = await apiRepository.fetchHomeData();
        List<BannerModel> banners = (data['banner_one'] as List)
            .map((e) => BannerModel.fromJson(e))
            .toList();
        List<CategoryModel> categories = (data['category'] as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();
        List<ProductModel> products = (data['products'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
        emit(HomeLoadedState(
            banners: banners, categories: categories, products: products));
      } catch (e) {
        emit(HomeLoadedErrorState(message: e.toString()));
      }
    });
  }
}
