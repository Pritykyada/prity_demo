import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../providers/home_provider.dart';
import '../../models/cart_item.dart';
import '../../utils/colors.dart';
import '../../utils/text_style.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          if (provider.cartItems.isEmpty) {
            return  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64.sp,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: CommonTextStyle.f18px600w,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add some products to get started!',
                    style: CommonTextStyle.f18px600w,
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding:  EdgeInsets.all(16.w),
                  itemCount: provider.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = provider.cartItems[index];
                    return CartItemWidget(cartItem: cartItem);
                  },
                ),
              ),
              Container(
                padding:  EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AllColours.white,
                  boxShadow: [
                    BoxShadow(
                      color: AllColours.grey.withValues(alpha: 0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${provider.cartTotal.toStringAsFixed(2)}',

                          style: CommonTextStyle.f18pxBoldG,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SizedBox(
              width: 90.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  scale: 10.w,
                  imageUrl: cartItem.product.image,
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
                    cartItem.product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${cartItem.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<HomeProvider>().updateCartItemQuantity(
                            cartItem.product,
                            cartItem.quantity - 1,
                          );
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                        color: Colors.red,
                      ),
                      Container(
                        padding:  EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),  constraints:  BoxConstraints(minWidth: 20.w, maxWidth: 50.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(
                            '${cartItem.quantity}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,

                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<HomeProvider>().updateCartItemQuantity(
                            cartItem.product,
                            cartItem.quantity + 1,
                          );
                        },
                        icon: const Icon(Icons.add_circle_outline),
                        color: Colors.green,
                      ),
                      // const Spacer(),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            '\$${cartItem.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}