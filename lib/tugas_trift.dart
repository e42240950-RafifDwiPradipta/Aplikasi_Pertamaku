import 'package:flutter/material.dart';
import 'logout_screen.dart';
import 'home_page.dart';
import 'cart_page.dart';

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
      "name": "Pretty Green Jacket",
      "brand": "Pretty Green",
      "category": "JAKET",
      "price": 2200000,
      "image":
          "https://down-id.img.susercontent.com/file/41b855e6e37d8d318f5d0cbb40498d40",
    },
    {
      "name": "Ellesse SL Prado",
      "brand": "Ellesse",
      "category": "KAOS",
      "price": 650000,
      "image":
          "https://moesportsnyc.com/cdn/shop/products/614203-ELLESSE-HERITAGE-SS20Q1-MENS-SHE07405-SL-PRADO-TSHIRT-LIGHT-BLUE-ECOMM-C_1200x1200.jpg?v=1617309777",
    },
    {
      "name": "Fred Perry Twin Tipped Polo",
      "brand": "Fred Perry",
      "category": "KAOS",
      "price": 1500000,
      "image":
          "https://www.707.co.id/cdn/shop/products/M12_120_3_800x.jpg?v=1650599447",
    },
    {
      "name": "Weekend Offender Clay Cap",
      "brand": "Weekend Offender",
      "category": "TOPI",
      "price": 550000,
      "image":
          "https://dz3aw12iizk17.cloudfront.net/cache/catalog/Weekend_Offender/weekend_offender_clay_cap_mid_house_check_1-870x1110.jpg",
    },
    {
      "name": "Lyle & Scott Golden Eagle Polo",
      "brand": "Lyle & Scott",
      "category": "KAOS",
      "price": 1250000,
      "image": "https://images.brownthomas.com/bta/2001240827_01.jpg?",
    },
    {
      "name": "Weekend Offender Naz Jacket",
      "brand": "Weekend Offender",
      "category": "JAKET",
      "price": 1850000,
      "image":
          "https://rd1clothing.co.uk/cdn/shop/files/JKAW2437-NAZ-APPLE-11918.webp?v=1755854572",
    },
    {
      "name": "Napapijri Rainforest Summer",
      "brand": "Napapijri",
      "category": "JAKET",
      "price": 3200000,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSK52ziab7lggg9VeXrbkqIkNEHBVLrnu9BCQ&s",
    },
    {
      "name": "Marshall Artist Siren Tee",
      "brand": "Marshall Artist",
      "category": "KAOS",
      "price": 850000,
      "image":
          "https://www.eqvvs.co.uk/cdn/shop/files/5056746249390_1.jpg?v=1755877172",
    },
    {
      "name": "Peaceful Hooligan Outline Jacket",
      "brand": "Peaceful Hooligan",
      "category": "JAKET",
      "price": 2100000,
      "image": "https://casuallads.com/cdn/shop/products/77.jpg?v=1741798136",
    },
    {
      "name": "Peaceful Hooligan Dove Tee",
      "brand": "Peaceful Hooligan",
      "category": "KAOS",
      "price": 750000,
      "image":
          "https://cdn.webshopapp.com/shops/278898/files/406227157/image.jpg",
    },
    {
      "name": "Lacoste Classic Polo Shirt",
      "brand": "Lacoste",
      "category": "KAOS",
      "price": 1900000,
      "image":
          "https://www.thesportinglodge.com/cdn/shop/files/LacosteClassicFitL.12.12MarlPoloShirtBlueChine_1_1320x.jpg?v=1725361516",
    },
    {
      "name": "Lacoste Gabardine Cap",
      "brand": "Lacoste",
      "category": "TOPI",
      "price": 850000,
      "image": "https://m.media-amazon.com/images/I/41k8WQNUTaL._SL500_.jpg",
    },
  ];

  void updateQuantity(Map<String, dynamic> item, int delta) {
    setState(() {
      int index = cartItems.indexWhere((e) => e['name'] == item['name']);
      if (index != -1) {
        int currentQty = cartItems[index]['qty'] ?? 1;
        if (delta == -1 && currentQty <= 1) {
          cartItems.removeAt(index);
        } else {
          cartItems[index]['qty'] = currentQty + delta;
        }
      }
    });
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("🛒 ${p['name']} masuk keranjang!"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // List halaman dengan pengiriman Drawer ke HomePage
    final List<Widget> pages = [
      HomePage(
        products: allProducts,
        selectedBrand: selectedBrand,
        searchQuery: searchQuery,
        onBrandSelected: (val) => setState(() => selectedBrand = val),
        onSearchChanged: (val) => setState(() => searchQuery = val),
        onAddToCart: addToCart,
        drawer: _buildMyDrawer(), // KIRIM DRAWER KE SINI
      ),
      CartPage(
        cartItems: cartItems,
        onUpdateQuantity: updateQuantity,
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
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Colors.orange,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text("${cartItems.length}"),
              isLabelVisible: cartItems.isNotEmpty,
              child: const Icon(Icons.shopping_cart),
            ),
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
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.orange, size: 40),
            ),
            accountName: const Text(
              "Rafif Lads",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: const Text("terrace.culture@lads.com"),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Color(0xFF333333)],
              ),
            ),
          ),
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
            "Ellesse",
            "Fred Perry",
            "Weekend Offender",
            "Lyle & Scott",
            "Napapijri",
            "Peaceful Hooligan",
            "Lacoste",
            "Marshall Artist",
          ].map(
            (brand) => ListTile(
              leading: const Icon(
                Icons.label_important_outline,
                color: Colors.orange,
              ),
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
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
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
