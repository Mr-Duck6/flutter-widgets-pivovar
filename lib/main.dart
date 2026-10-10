import 'package:flutter/material.dart';
import 'package:flutter_widgets_pivovar/models/product.dart';
import 'package:flutter_widgets_pivovar/widgets/animated_counter.dart';
import 'package:flutter_widgets_pivovar/widgets/product_card.dart';

void main() => runApp(const MyApp());

/// Головний віджет додатку
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Головна сторінка додатку з базовою структурою Scaffold
      home: Scaffold(
        appBar: AppBar(title: const Text('Демо анімацій')),
        // Основне тіло екрана з відступами по краях
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Віджет анімованого лічильника
              const AnimatedCounter(),

              // Вертикальний відступ між віджетами
              const SizedBox(height: 24),

              SizedBox(
                width: 250,
                child: ProductCard(
                  // Передаємо екземпляр класу Product із початковими даними
                  product: const Product(
                    id: '1',
                    name: 'Смартфон',
                    price: 499.99,
                    imageUrl: '',
                  ),
                  // Зворотний виклик при натисканні кнопки додавання в кошик
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
