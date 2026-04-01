import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final String selectedBrand;
  final String searchQuery;
  final Function(String) onBrandSelected;
  final Function(String) onSearchChanged;
  final Function(Map<String, dynamic>) onAddToCart;
  final Widget drawer; // Parameter baru untuk menerima drawer

  const HomePage({
    super.key,
    required this.products,
    required this.selectedBrand,
    required this.searchQuery,
    required this.onBrandSelected,
    required this.onSearchChanged,
    required this.onAddToCart,
    required this.drawer, // Tambahkan di sini
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        drawer: drawer, // PASANG DRAWER DI SINI
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Color(0xFF333333)],
              ),
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ), // Ini agar icon burger warna putih
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
      ),
    );
  }

  Widget _buildFilteredGrid(String category) {
    List<Map<String, dynamic>> filtered = products.where((p) {
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
                onDeleted: () => onBrandSelected("Semua"),
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
                  itemBuilder: (context, index) =>
                      _buildProductItem(filtered[index]),
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
                    onPressed: () => onAddToCart(p),
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

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: onSearchChanged,
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

  Widget _buildHorizontalBrandList() {
    final brands = [
      {
        "name": "Stone Island",
        "logo":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRsghD_18nQdOayC43k3gl3e8aKlvOJ-s-2w&s",
      },
      {
        "name": "C.P. Company",
        "logo":
            "https://1000logos.net/wp-content/uploads/2020/01/C.P.-Company-Logo-1978.png",
      },
      {
        "name": "Adidas",
        "logo":
            "https://logodownload.org/wp-content/uploads/2014/07/adidas-logo-0.png",
      },
      {
        "name": "Pretty Green",
        "logo": "https://cdn.lovesavingsgroup.com/logos/pretty-green.png",
      },
      {
        "name": "Ellesse",
        "logo":
            "https://logoeps.com/wp-content/uploads/2025/02/Ellesse-logo.png",
      },
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: brands.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onBrandSelected(brands[index]['name']!),
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
                      child: Image.network(
                        brands[index]['logo']!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  brands[index]['name']!,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
