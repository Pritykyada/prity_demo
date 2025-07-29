import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_browser/utils/text_style.dart';
import 'package:provider/provider.dart';
import '../../providers/home_provider.dart';
import '../../models/product.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Products'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          if (provider.favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64.sp, color: Colors.grey),
                  SizedBox(height: 16.h),
                  Text('No favorite products yet', style: CommonTextStyle.f18px600w,),
                  SizedBox(height: 8.h),
                   Text('Add some products to favorites!', style: CommonTextStyle.f18px600w,),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              final product = provider.favorites[index];
              return FavoriteItemWidget(product: product);
            },
          );
        },
      ),
    );
  }
}

class FavoriteItemWidget extends StatelessWidget {
  final Product product;

  const FavoriteItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:  EdgeInsets.only(bottom: 12.w),
      child: Padding(
        padding:  EdgeInsets.all(12.w),
        child: Row(
          children: [
            SizedBox(
              width: 90.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  scale: 10.w,
                  imageUrl: product.image,
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error, color: Colors.red),
                  placeholder: (context, url) =>
                  const Center(child: CupertinoActivityIndicator()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style:  TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: CommonTextStyle.f18pxBoldG
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red),
                        onPressed: () {
                          // Remove from favorites
                          context.read<HomeProvider>().toggleFavorite(product);
                        },
                      ),
                    ],
                  ),
                   SizedBox(height: 8.h),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}