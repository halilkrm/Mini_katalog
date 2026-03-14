import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';
import '../models/fake_data.dart';
import '../models/cart_provider.dart';
import 'detail_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  String searchText = '';
  String selectedCategory = 'Tümü';
  bool isLoading = true;

  List<String> categories = ['Tümü', 'smartphones', 'laptops', 'tablets'];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  // DummyJSON API'dan ürünleri çek
  Future<void> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products?limit=16'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List products = data['products'];

        setState(() {
          allProducts = products.map((json) {
            return Product(
              id: json['id'],
              name: json['title'],
              description: json['description'],
              price: (json['price'] as num).toDouble(),
              imageUrl: json['thumbnail'],
              category: json['category'],
            );
          }).toList();

          filteredProducts = allProducts;
          isLoading = false;

          // Kategorileri API'dan gelen veriye göre güncelle
          final cats = allProducts.map((p) => p.category).toSet().toList();
          categories = ['Tümü', ...cats];
        });
      } else {
        // API çalışmazsa fake data kullan
        _loadFakeData();
      }
    } catch (e) {
      // Hata olursa fake data kullan
      _loadFakeData();
    }
  }

  void _loadFakeData() {
    setState(() {
      allProducts = getFakeProducts();
      filteredProducts = allProducts;
      isLoading = false;
    });
  }

  void filterProducts(String query) {
    setState(() {
      searchText = query;
      _applyFilter();
    });
  }

  void filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
      _applyFilter();
    });
  }

  void _applyFilter() {
    filteredProducts = allProducts.where((product) {
      bool matchesSearch = product.name
          .toLowerCase()
          .contains(searchText.toLowerCase());
      bool matchesCategory =
          selectedCategory == 'Tümü' || product.category == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartProvider.instance;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          'Mini Katalog',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  ).then((_) => setState(() {}));
                },
              ),
              if (cart.itemCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cart.itemCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.indigo),
            )
          : Column(
              children: [
                // Arama kutusu
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    onChanged: filterProducts,
                    decoration: InputDecoration(
                      hintText: 'Ürün ara...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),

                // Kategori butonları
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      final isSelected = selectedCategory == cat;
                      return GestureDetector(
                        onTap: () => filterByCategory(cat),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.indigo : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.indigo),
                          ),
                          child: Text(
                            cat,
                            style: TextStyle(
                              color:
                                  isSelected ? Colors.white : Colors.indigo,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 8),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Text(
                        '${filteredProducts.length} ürün bulundu',
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 6),

                // GridView
                Expanded(
                  child: filteredProducts.isEmpty
                      ? const Center(
                          child: Text(
                            'Ürün bulunamadı 😕',
                            style:
                                TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(12),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.72,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            return _ProductCard(
                                product: filteredProducts[index]);
                          },
                        ),
                ),
              ],
            ),
    );
  }
}

class _ProductCard extends StatefulWidget {
  final Product product;
  const _ProductCard({required this.product});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  @override
  Widget build(BuildContext context) {
    final cart = CartProvider.instance;
    final inCart = cart.isInCart(widget.product);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(product: widget.product),
          ),
        ).then((_) => setState(() {}));
      },
      child: Card(
        elevation: 2,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: SizedBox(
                height: 130,
                width: double.infinity,
                child: Image.network(
                  widget.product.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported, size: 40),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.indigo.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      widget.product.category,
                      style:
                          const TextStyle(fontSize: 10, color: Colors.indigo),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (inCart) {
                              cart.removeItem(widget.product);
                            } else {
                              cart.addItem(widget.product);
                            }
                          });
                        },
                        child: Icon(
                          inCart
                              ? Icons.shopping_cart
                              : Icons.shopping_cart_outlined,
                          color: inCart ? Colors.indigo : Colors.grey,
                          size: 22,
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