import 'package:flutter/material.dart';
import 'logout_screen.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  // --- 1. DATABASE PRODUK ---
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
          "https://images-cdn.ubuy.co.id/693a117b15dcc6f79c0a9dd8-napapijri-jacket-rainforest-summer.jpg",
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

  // --- STATE UNTUK FILTER & KERANJANG ---
  String selectedBrand = "Semua";
  String searchQuery = "";
  List<Map<String, dynamic>> cartItems = [];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  // --- FUNGSI UPDATE QUANTITY KERANJANG ---
  void updateQuantity(Map<String, dynamic> item, int delta) {
    setState(() {
      int index = cartItems.indexWhere(
        (element) => element['name'] == item['name'],
      );
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        drawer: _buildMyDrawer(),
        body: IndexedStack(
          index: _selectedIndex,
          children: [_buildHomePage(), _buildCartPage()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
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
      ),
    );
  }

  // --- DRAWER ---
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
          _buildBrandTile("Stone Island"),
          _buildBrandTile("C.P. Company"),
          _buildBrandTile("Adidas"),
          _buildBrandTile("Pretty Green"),
          _buildBrandTile("Ellesse"),
          _buildBrandTile("Fred Perry"),
          _buildBrandTile("Weekend Offender"),
          _buildBrandTile("Lyle & Scott"),
          _buildBrandTile("Napapijri"),
          _buildBrandTile("Peaceful Hooligan"),
          _buildBrandTile("Lacoste"),
          _buildBrandTile("Marshall Artist"),
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

  Widget _buildBrandTile(String brandName) {
    return ListTile(
      leading: const Icon(Icons.label_important_outline, color: Colors.orange),
      title: Text(brandName),
      onTap: () {
        setState(() => selectedBrand = brandName);
        Navigator.pop(context);
      },
    );
  }

  // --- HOME PAGE ---
  Widget _buildHomePage() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      drawer: _buildMyDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.black, Color(0xFF333333)]),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "TERRACE CULTURE",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.orange,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: "SEMUA"),
            Tab(text: "JAKET"),
            Tab(text: "KAOS"),
            Tab(text: "SEPATU"),
            Tab(text: "TOPI"),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          _buildFilteredGrid("SEMUA"),
          _buildFilteredGrid("JAKET"),
          _buildFilteredGrid("KAOS"),
          _buildFilteredGrid("SEPATU"),
          _buildFilteredGrid("TOPI"),
        ],
      ),
    );
  }

  // --- GRID PRODUK DENGAN FILTER ---
  Widget _buildFilteredGrid(String category) {
    List<Map<String, dynamic>> filtered = allProducts.where((p) {
      bool matchCategory = category == "SEMUA" || p['category'] == category;
      bool matchBrand = selectedBrand == "Semua" || p['brand'] == selectedBrand;
      bool matchSearch = p['name'].toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      return matchCategory && matchBrand && matchSearch;
    }).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          _buildPremiumBanner(),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
            child: Text(
              "Top Brands",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          _buildHorizontalBrandList(),

          if (selectedBrand != "Semua")
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: InputChip(
                label: Text("Brand: $selectedBrand"),
                onDeleted: () => setState(() => selectedBrand = "Semua"),
                backgroundColor: Colors.orange.withAlpha(25),
                deleteIconColor: Colors.orange,
              ),
            ),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Rekomendasi Produk",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          filtered.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(50),
                    child: Text("Barang tidak ditemukan, lads! ❌"),
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final p = filtered[index];
                    return _buildProductItem(p);
                  },
                ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildProductItem(Map<String, dynamic> p) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: Image.network(
                p['image'],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                ),
                Text(
                  "Rp ${p['price']}",
                  style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        int index = cartItems.indexWhere(
                          (element) => element['name'] == p['name'],
                        );
                        if (index != -1) {
                          cartItems[index]['qty'] =
                              (cartItems[index]['qty'] ?? 1) + 1;
                        } else {
                          var newItem = Map<String, dynamic>.from(p);
                          newItem['qty'] = 1;
                          cartItems.add(newItem);
                        }
                      });
                      _showSnackBar("🛒 ${p['name']} masuk keranjang!");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Beli", style: TextStyle(fontSize: 10)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- KERANJANG DENGAN FITUR QUANTITY ---
  Widget _buildCartPage() {
    int total = cartItems.fold(
      0,
      (sum, item) =>
          sum + ((item['price'] as int) * (item['qty'] as int? ?? 1)),
    );
    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang Saya"), elevation: 0.5),
      body: cartItems.isEmpty
          ? const Center(child: Text("Keranjang kosong, borong dulu lads!"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      int qty = item['qty'] ?? 1;
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Image.network(
                            item['image'],
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            item['name'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("Rp ${item['price']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.orange,
                                ),
                                onPressed: () => updateQuantity(item, -1),
                              ),
                              Text("$qty"),
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.orange,
                                ),
                                onPressed: () => updateQuantity(item, 1),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total: Rp $total",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() => cartItems.clear());
                          _showSnackBar("✅ Checkout Berhasil!");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text(
                          "Checkout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // --- WIDGET PENDUKUNG ---
  Widget _buildHorizontalBrandList() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildTopBrandCircle(
            "Stone Island",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRsghD_18nQdOayC43k3gl3e8aKlvOJ-s-2w&s",
          ),
          _buildTopBrandCircle(
            "C.P. Company",
            "https://1000logos.net/wp-content/uploads/2020/01/C.P.-Company-Logo-1978.png",
          ),
          _buildTopBrandCircle(
            "Adidas",
            "https://logodownload.org/wp-content/uploads/2014/07/adidas-logo-0.png",
          ),
          _buildTopBrandCircle(
            "Pretty Green",
            "https://cdn.lovesavingsgroup.com/logos/pretty-green.png",
          ),
          _buildTopBrandCircle(
            "Ellesse",
            "https://logoeps.com/wp-content/uploads/2025/02/Ellesse-logo.png",
          ),
        ],
      ),
    );
  }

  Widget _buildTopBrandCircle(String name, String logoUrl) {
    return GestureDetector(
      onTap: () => setState(() => selectedBrand = name),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            width: 65,
            height: 65,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(logoUrl, fit: BoxFit.contain),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: (value) => setState(() => searchQuery = value),
        decoration: InputDecoration(
          hintText: "Cari brand atau jenis barang...",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPremiumBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          'https://i.pinimg.com/736x/af/de/57/afde57be5dd9c447bfe5d3135ae61520.jpg',
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 1)),
    );
  }
}
