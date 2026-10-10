import 'package:flutter/material.dart';
import 'package:flutter_widgets_pivovar/models/product.dart';
import 'package:flutter_widgets_pivovar/widgets/animated_counter.dart';
import 'package:flutter_widgets_pivovar/widgets/product_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Демо анімацій')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const AnimatedCounter(),
              const SizedBox(height: 24),
              SizedBox(
                width: 250,
                child: ProductCard(
                  product: const Product(
                    id: '1',
                    name: 'Смартфон',
                    price: 499.99,
                    imageUrl: '',
                  ),
                  onAddToCart: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
