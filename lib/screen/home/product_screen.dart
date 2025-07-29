import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:product_browser/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../providers/home_provider.dart';
import '../../utils/text_style.dart';
import '../../widget/product_card.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Browser'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return MasonryGridView.count(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              itemCount: 6, // Number of shimmer placeholders
              itemBuilder: (context, index) {
                return Shimmer.fromColors(

                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: (index.isEven ? 500.h : 200.h), // Vary height like Masonry
                    decoration: BoxDecoration(
                      color: AllColours.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                );
              },
            );
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
                   SizedBox(height: 16.h),
                  Text(
                    'Error loading products',
                    style: CommonTextStyle.f11px500,
                  ),
                   SizedBox(height: 8.h),
                  Text(
                    provider.error!,
                    style: CommonTextStyle.f11px500,
                    textAlign: TextAlign.center,
                  ),
                   SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () => provider.loadProducts(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.products.isEmpty) {
            return const Center(child: Text('No products available'));
          }

        return  MasonryGridView.count(
          padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          itemCount: provider.products.length,
          itemBuilder: (context, index) {
            final product = provider.products[index];
            return ProductCard(product: product);
          },
        );

        },
      ),
    );
  }
}