import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/home_provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:  BorderRadius.vertical(
                    top: Radius.circular(12.r),
                  ),
                  color: Colors.grey[100],
                ),
                child: ClipRRect(
                  borderRadius:  BorderRadius.vertical(
                    top: Radius.circular(12.r),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: Colors.red),
                    placeholder: (context, url) =>
                    const Center(child: CupertinoActivityIndicator()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                top: 8.h,
                right: 8.w,
                child: Consumer<HomeProvider>(
                  builder: (context, provider, child) {
                    final isFavorite = provider.isFavorite(product);
                    return GestureDetector(
                      onTap: () => provider.toggleFavorite(product),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.8),
                          shape: BoxShape.circle,
                        ),
                        padding:  EdgeInsets.all(6.w),
                        child: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                          size: 22.sp,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  product.title,
                  style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                 SizedBox(height: 4.h),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style:  TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                // const Spacer(),

                // Add to Cart Button
                Consumer<HomeProvider>(
                  builder: (context, provider, child) {
                    int quantity = provider.getProductQuantity(product);

                    return quantity == 0
                        ? ElevatedButton.icon(
                      onPressed: () {
                        provider.addToCart(product);

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding:  EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      icon:  Icon(Icons.shopping_cart, size: 16.sp),
                      label: const Text("Add"),
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Minus Button
                        IconButton(
                          icon: const Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () {
                            int newQuantity = quantity - 1;
                            provider.updateCartItemQuantity(product, newQuantity);
                          },
                        ),
                        // Quantity
                        Text(
                          '$quantity',
                          style:  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        // Plus Button
                        IconButton(
                          icon:  Icon(Icons.add_circle, color: Colors.green),
                          onPressed: () {
                            int newQuantity = quantity + 1;
                            provider.updateCartItemQuantity(product, newQuantity);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}