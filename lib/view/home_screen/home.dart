import 'package:carousel_slider/carousel_slider.dart';
import 'package:dealsdray/bloc/home_bloc/home_bloc.dart';
import 'package:dealsdray/Repositories/api_repository.dart';
import 'package:dealsdray/view/home_screen/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(ApiRepository())..add(FetchHomeData()),
      child: Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: 800.w,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search here',
                prefix: SizedBox(
                  height: 18.h,
                  width: 40.w,
                  child: const Center(
                      child: Image(
                    image: AssetImage('assets/images/dealdraylogo.png'),
                    fit: BoxFit.cover,
                  )),
                ),
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {},
              iconSize: 30.r,
            ),
          ],
          backgroundColor: Colors.white,
        ),
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          } else if (state is HomeLoadedState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                      height: 180.h,
                      width: 900.w,
                      child: _buildCarouselSlider(state.banners
                          .map((bannerModel) => bannerModel.banner)
                          .toList())),
                  _kycPendingCard(),
                  _categoryRow(state.categories),
                  Padding(
                    padding: EdgeInsets.only(left: 15.r, right: 15.r),
                    child: Container(
                        height: 400.h,
                        width: double.infinity,
                        color: Colors.blue.withOpacity(0.5),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.w, top: 20.h, right: 20.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("EXCLUSIVE FOR YOU",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 30.r,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.w, top: 30.h),
                              child: _exclusiveItemsSection(state.products),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            );
          } else if (state is HomeLoadedErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
          }
        }),
        floatingActionButton: SizedBox(
          width: 120.w,
          height: 50.h,
          child: FloatingActionButton(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chat,
                  size: 25.r,
                  color: Colors.white,
                ),
                SizedBox(width: 10.w),
                const Text(
                  'Chat',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _bottomNavBar(),
      ),
    );
  }

  Widget _buildCarouselSlider(List<String> imageUrls) {
    return CarouselSlider.builder(
      itemCount: imageUrls.length,
      itemBuilder: (context, index, realIndex) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrls[index],
              fit: BoxFit.fill,
              width: 1000.w,
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 400.h,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        onPageChanged: (index, reason) {},
      ),
    );
  }

  Widget _kycPendingCard() {
    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "KYC Pending",
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          SizedBox(height: 8.h),
          Text(
            "You need to provide the required documents for your account activation.",
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          TextButton(
            onPressed: () {},
            child: Text(
              "Click Here",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationThickness: 2),
            ),
          )
        ],
      ),
    );
  }

  Widget _categoryRow(List<CategoryModel> categories) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: _categoryIcon(
                  categories[index].icon, categories[index].label),
            );
          }),
    );
  }

  Widget _categoryIcon(String asset, String label) {
    return Column(
      children: [
        Image.network(asset, height: 50.h),
        SizedBox(height: 8.h),
        Text(label),
      ],
    );
  }

  Widget _exclusiveItemsSection(List<ProductModel> products) {
    return SizedBox(
      height: 300.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return _productCard(
            products[index].label,
            products[index].icon,
            products[index].offer,
            products[index].subLabel,
          );
        },
      ),
    );
  }

  Widget _productCard(
      String title, String iconUrl, String offer, String subLabel) {
    return Container(
      height: 300.h,
      width: 150.w,
      margin: EdgeInsets.only(right: 16.w),
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 20.h,
              width: 50.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color:
                      const Color.fromARGB(255, 111, 180, 55).withOpacity(0.7)),
              child: Center(
                child: Text(
                  '$offer off',
                  style: TextStyle(fontSize: 10.sp, color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Center(
            child: SizedBox(
              height: 100.h,
              width: 100.w,
              child: Image.network(
                iconUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 90.h),
            child: Text(
              '$title $subLabel',
              style: TextStyle(fontSize: 10.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.red,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined), label: "Categories"),
        BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_outlined), label: "Deals"),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined), label: "Cart"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: "Profile"),
      ],
      onTap: (index) {},
    );
  }
}
