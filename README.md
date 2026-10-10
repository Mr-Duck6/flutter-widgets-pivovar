### Практична робота 5: Розробка віджетів у Flutter

# Бібліотека віджетів та компонентів Flutter
Сучасний мобільний додаток на Flutter, створений на основі компоненти-орієнтованого підходу. Проєкт демонструє надійне управління станом, кастомні повторно використовувані віджети (AnimatedCounter, ProductCard, ProfileWidget, CustomButton) та чисті архітектурні патерни.

## Архітектура додатку
Проєкт побудований за принципами Feature-First / Layered Hybrid Architecture, що забезпечує чіткий розподіл відповідальності та реактивний потік даних:

\*Presentation Layer - lib/screens/, lib/widgets/: Відповідає за рендеринг інтерфейсу, анімації та обробку взаємодії з користувачем. Складається з stateless та stateful віджетів із використанням адаптивних версток (Expanded, Column, Row).

- State Management Layer - lib/utils/app_state.dart: Базується на патерні ChangeNotifier у ролі Єдиного джерела правди (Single Source of Truth). Забезпечує незмінні оновлення стану та миттєву розсилку сповіщень слухачам через notifyListeners().

- Data & Models Layer - lib/models/: Інкапсулює основні сутності (Product, User), гарантуючи безпеку типів та нуль-безпеку.

- lib/utils/themes.dart, lib/utils/constants.dart: Централізовані дизайн-токени для підтримки світлої/темної тем та консистентного стилю.

## Схеми потоків стану
### Потік стану лічильника та анімацій

```
[Дія користувача: Натискання '+' / '-']
                   │
                   ▼
[Перевірка лімітів: _currentValue < maxValue] ──(Ні)──> [Ігнорування натискання]
                   │ (Так)
                   ▼
[setState(): Оновлення _currentValue]
                   │
                   ▼
[_controller.forward().then(reverse())] ──> Запуск анімації (Scale & Color Tween)
                   │
                   ▼
[Перебудова UI через AnimatedBuilder] ──> Відображення нового масштабу та кольору
```

### Потік стану кошика та обраного

```
[Натискання користувача: Додати в кошик / Змінити обране]
                   │
                   ▼
[Виклик методу в AppState (напр., addToCart / toggleFavorite)]
                   │
                   ▼
[Зміна приватного списку/лічильника (Immutable оновлення)]
                   │
                   ▼
[Виклик notifyListeners()]
                   │
                   ▼
[UI-віджети, що слухають AppState, автоматично оновлюються]
```

## Документація дерева віджетів

Нижче наведено ієрархічну структуру ключових дерев компонентів та їх взаємозв'язки:

```
MyApp (MaterialApp)
 └── HomeScreen (Scaffold)
      ├── AppBar ("Демо анімацій")
      └── SingleChildScrollView
           └── Column
                ├── AnimatedCounter
                │    ├── AnimatedBuilder
                │    │    └── Transform.scale
                │    │         └── Text (Поточне значення з інтерполяцією кольору)
                │    ├── LinearProgressIndicator (Динамічний показник прогресу)
                │    └── Row (Кнопки керування: '-' та '+')
                ├── ProductCard (Споживає модель Product)
                │    └── Card
                │         └── Padding
                │              └── Column
                │                   ├── Container (Заглушка зображення / Network Image)
                │                   ├── Text (Назва товару, maxLines: 1, ellipsis)
                │                   └── Row (Ціна зеленим кольором та IconButton кошика)
                └── ProfileWidget (Варіанти компактного або розгорнутого вигляду)
                     └── Card
                          └── Padding
                               └── [Якщо компактний] _buildCompactView()
                               │    ├── CircleAvatar (NetworkImage або текст ініціалу)
                               │    ├── Expanded -> Column (Ім'я та Email з ellipsis)
                               │    └── IconButton (Опціональна кнопка редагування)
                               └── [Якщо розгорнутий] _buildExpandedView()
                                    ├── Row (Великий CircleAvatar + Column для імені/пошти)
                                    └── [Якщо onEditPressed != null] ElevatedButton.icon
```

## Контракт API
Оскільки додаток працює з локальними структурами даних, ці контракти повністю відповідають стандартним схемам RESTful API для сучасних e-commerce систем та профілів.

### Схема моделі продукту

```json
{
  "id": "prod_001",
  "name": "Смартфон",
  "price": 499.99,
  "imageUrl": "https://example.com/images/smartphone.png"
}
```

- Реалізація у Dart\* Клас Product у lib/models/product.dart із обов'язковими параметрами конструктора та незмінними полями.

### Схема моделі користувача (/api/v1/user/profile)

```json
{
  "name": "Олександр",
  "email": "alexander@example.com",
  "avatarUrl": null
}
```

- Реалізація у Dart: Клас User у lib/models/user.dart.

### Контракт сховища стану

| Метод / Геттер            | Тип повернення  | Опис                                                     |
| :------------------------ | :-------------- | :------------------------------------------------------- |
| `currentUser`             | `User?`         | Поточний авторизований профіль користувача.              |
| `favoriteProducts`        | `List<Product>` | Незмінний список улюблених товарів користувача.          |
| `cartItemsCount`          | `int`           | Загальна кількість товарів, доданих до кошика.           |
| `toggleFavorite(Product)` | `void`          | Додає або видаляє товар з обраного та сповіщає слухачів. |
| `addToCart(Product)`      | `void`          | Збільшує лічильник кошика та сповіщає слухачів.          |

## Інструкція з запуску

Запуск застосунку

- У VS Code обрати з No Device на Start Menium Phone API 35 mobile emulator(cold boot)
- Після запуску у консолі виконати futter run

Перевірка тестів

- У VS Code обрати з No Device на Start Menium Phone API 35 mobile emulator(cold boot)
- Після запуску у консолі виконати flutter test
- flutter test integration_test/app_flow_test.dart

## Використання ШІ

У рамках практичної ШІ був використаний для закріплення знать у використанні Futter віджетів. Також під час виконання роботи було зроблено декілька помилок у коді які було знайти важко тривалий час, для прискорення знаходження був використаний ШІ (виправлялося власноруч).
