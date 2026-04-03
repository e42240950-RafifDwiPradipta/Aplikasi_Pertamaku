import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'logout_screen.dart';
import 'home_page.dart';
import 'cart_page.dart';
import 'produk_page.dart';
import 'models/produk.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;
  String selectedBrand = "Semua";
  String searchQuery = "";
  List<Map<String, dynamic>> cartItems = [];

  // List untuk menampung data dari hasil CRUD [cite: 21, 207]
  List<Map<String, dynamic>> crudProducts = [];

  // Data Statis Bawaan Terrace Culture
  final List<Map<String, dynamic>> allProducts = [
    {
      "name": "Stone Island Jacket",
      "brand": "Stone Island",
      "category": "JAKET",
      "price": 7500000,
      "image":
          "https://stoneisland-cdn.thron.com/delivery/public/image/stoneisland/L1S154100036S0F33V0064_R/ppk73x/std/0x0/L1S154100036S0F33V0064_R.jpg",
    },
    {
      "name": "C.P. Company Goggle",
      "brand": "C.P. Company",
      "category": "JAKET",
      "price": 8900000,
      "image":
          "https://images.unsplash.com/photo-1544022613-e87ca75a784a?w=400",
    },
    {
      "name": "Adidas Spezial Birmingham",
      "brand": "Adidas",
      "category": "SEPATU",
      "price": 20000000,
      "image":
          "https://filebroker-cdn.lazada.co.id/kf/S806d6999072843dd8b33953c750db14fn.jpg",
    },
    {
      "name": "Weekend Offender Naz Jacket",
      "brand": "Weekend Offender",
      "category": "JAKET",
      "price": 1850000,
      "image":
          "https://rd1clothing.co.uk/cdn/shop/files/JKAW2437-NAZ-APPLE-11918.webp?v=1755854572",
    },
  ];

  @override
  void initState() {
    super.initState();
    loadCrudData(); // Load data CRUD saat pertama kali buka
  }

  // --- FUNGSI SAKTI: Ambil data CRUD agar tampil di HOME ---
  Future<void> loadCrudData() async {
    final prefs = await SharedPreferences.getInstance(); // [cite: 222]
    List<String>? data = prefs.getStringList('produk'); // [cite: 223]

    if (data != null) {
      setState(() {
        crudProducts = data.map((e) {
          final p = Produk.fromJson(jsonDecode(e)); // [cite: 227]
          return {
            "name": p.nama,
            "brand": "Custom",
            "category": "JAKET",
            "price": p.harga,
            "image": p
                .gambar, // <-- GANTI JADI INI (Sesuaikan dengan field di model Produk kamu)
          };
        }).toList();
      });
    }
  }

  void addToCart(Map<String, dynamic> p) {
    setState(() {
      int index = cartItems.indexWhere((e) => e['name'] == p['name']);
      if (index != -1) {
        cartItems[index]['qty'] = (cartItems[index]['qty'] ?? 1) + 1;
      } else {
        var newItem = Map<String, dynamic>.from(p);
        newItem['qty'] = 1;
        cartItems.add(newItem);
      }
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("🛒 ${p['name']} masuk keranjang!")));
  }

  @override
  Widget build(BuildContext context) {
    // GABUNGKAN DATA STATIS + DATA CRUD
    final List<Map<String, dynamic>> combinedProducts = [
      ...allProducts,
      ...crudProducts,
    ];

    final List<Widget> pages = [
      HomePage(
        products: combinedProducts,
        selectedBrand: selectedBrand,
        searchQuery: searchQuery,
        onBrandSelected: (val) => setState(() => selectedBrand = val),
        onSearchChanged: (val) => setState(() => searchQuery = val),
        onAddToCart: addToCart,
        drawer: _buildMyDrawer(),
      ),
      CartPage(
        cartItems: cartItems,
        onUpdateQuantity: (item, delta) {
          setState(() {
            int index = cartItems.indexOf(item);
            if (index != -1) {
              if (delta == -1 && cartItems[index]['qty'] <= 1) {
                cartItems.removeAt(index);
              } else {
                cartItems[index]['qty'] += delta;
              }
            }
          });
        },
        onCheckout: () {
          setState(() => cartItems.clear());
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("✅ Checkout Berhasil!")));
        },
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 0) loadCrudData(); // Refresh data saat balik ke Home
          setState(() => _selectedIndex = index);
        },
        selectedItemColor: Colors.orange,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
        ],
      ),
    );
  }

  Widget _buildMyDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Rafif Lads"),
            accountEmail: const Text("terrace.culture@lads.com"),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.orange),
            ),
            decoration: const BoxDecoration(color: Colors.black),
          ),
          // MENU CRUD
          ListTile(
            leading: const Icon(Icons.inventory_2, color: Colors.orange),
            title: const Text(
              "Kelola Produk (CRUD)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProdukPage()),
              );
              loadCrudData(); // Sinkronkan data setelah kembali
            },
          ),
          const Divider(),
          // DAFTAR BRAND (FILTER)
          ListTile(
            leading: const Icon(Icons.all_inclusive, color: Colors.orange),
            title: const Text("Semua Brand"),
            onTap: () {
              setState(() => selectedBrand = "Semua");
              Navigator.pop(context);
            },
          ),
          ...[
            "Stone Island",
            "C.P. Company",
            "Adidas",
            "Pretty Green",
            "Weekend Offender",
            "Napapijri",
          ].map(
            (brand) => ListTile(
              leading: const Icon(Icons.label_outline, color: Colors.orange),
              title: Text(brand),
              onTap: () {
                setState(() => selectedBrand = brand);
                Navigator.pop(context);
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LogoutScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
