import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/data/cart_data.dart';
import 'package:loja_virtual/data/product_data.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/pages/cart_page.dart';
import 'package:loja_virtual/pages/login_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    super.key,
    required this.product,
  });

  final ProductData product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int currentCarousel = 0;
  String selectedSize = "";
  final CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name!),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CarouselSlider(
                carouselController: carouselController,
                items: widget.product.images!
                    .map((url) => Image.network(
                          url,
                          fit: BoxFit.fitHeight,
                        ))
                    .toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  disableCenter: true,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentCarousel = index;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.product.images!.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => carouselController.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (currentCarousel != entry.key ? Colors.white : Theme.of(context).primaryColor)
                            .withOpacity(currentCarousel == entry.key ? 0.9 : 0.6),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.product.name!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Text(
                  "R\$ ${widget.product.price!.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.product.description!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Tamanho:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: widget.product.sizes!
                      .map(
                        (size) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: size == selectedSize ? Theme.of(context).primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(),
                            ),
                            child: Text(
                              size,
                              style: TextStyle(
                                color: size == selectedSize ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 0, padding: const EdgeInsets.all(16)),
                  onPressed: selectedSize.isNotEmpty
                      ? () {
                          if (UserModel.of(context).isLoggedIn()) {
                            CartData cartData = CartData();
                            cartData.size = selectedSize;
                            cartData.quantity = 1;
                            cartData.productId = widget.product.id;
                            cartData.category = widget.product.category;
                            cartData.productData = widget.product;

                            CartModel.of(context).addCartItem(cartData);

                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CartPage()));
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
                          }
                        }
                      : null,
                  child: Text(
                    UserModel.of(context).isLoggedIn() ? "Adicionar ao carrinho" : "Fazer login",
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
