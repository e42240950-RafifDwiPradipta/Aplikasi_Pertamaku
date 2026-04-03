import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'models/produk.dart';
import 'form_produk_page.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  List<Produk> produkList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList('produk');
    if (data != null) {
      setState(() {
        produkList = data.map((e) => Produk.fromJson(jsonDecode(e))).toList();
      });
    }
  }

  Future<void> simpanData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> data = produkList.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('produk', data);
  }

  void bukaForm({Produk? produk, int? index}) async {
    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormProdukPage(produk: produk)),
    );

    if (hasil != null && hasil is Produk) {
      setState(() {
        if (index == null) {
          produkList.add(hasil);
        } else {
          produkList[index] = hasil;
        }
        simpanData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kelola Katalog"),
        backgroundColor: Colors.orange,
      ),
      body: produkList.isEmpty
          ? const Center(child: Text("Belum ada koleksi baru, Lads!"))
          : ListView.builder(
              itemCount: produkList.length,
              itemBuilder: (context, index) {
                final p = produkList[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      p.gambar,
                      width: 50,
                      errorBuilder: (c, e, s) => const Icon(Icons.broken_image),
                    ),
                    title: Text(p.nama),
                    subtitle: Text("Rp ${p.harga} - ${p.kategori}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => bukaForm(produk: p, index: index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              produkList.removeAt(index);
                              simpanData();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bukaForm(),
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
