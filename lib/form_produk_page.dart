import 'package:flutter/material.dart';
import 'models/produk.dart';

class FormProdukPage extends StatefulWidget {
  final Produk? produk;
  const FormProdukPage({super.key, this.produk});

  @override
  State<FormProdukPage> createState() => _FormProdukPageState();
}

class _FormProdukPageState extends State<FormProdukPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController gambarController = TextEditingController();

  String selectedKategori = "JAKET";
  final List<String> categories = ["JAKET", "SEPATU", "KAOS", "TOPI"];

  @override
  void initState() {
    super.initState();
    if (widget.produk != null) {
      namaController.text = widget.produk!.nama;
      hargaController.text = widget.produk!.harga.toString();
      gambarController.text = widget.produk!.gambar;
      selectedKategori = widget.produk!.kategori;
    }
  }

  void simpan() {
    if (namaController.text.isEmpty ||
        hargaController.text.isEmpty ||
        gambarController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lengkapi semua data, Lads!")),
      );
      return;
    }

    final dataBaru = Produk(
      nama: namaController.text,
      harga: int.parse(hargaController.text),
      kategori: selectedKategori,
      gambar: gambarController.text,
    );
    Navigator.pop(context, dataBaru);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Input Produk Terrace"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: "Nama Produk",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: hargaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Harga",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: gambarController,
              decoration: const InputDecoration(
                labelText: "Link Gambar (URL)",
                border: OutlineInputBorder(),
                hintText: "https://...",
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField(
              value: selectedKategori,
              decoration: const InputDecoration(
                labelText: "Kategori",
                border: OutlineInputBorder(),
              ),
              items: categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (val) =>
                  setState(() => selectedKategori = val.toString()),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: simpan,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Simpan Ke Katalog",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
