import 'dart:convert';

class Produk {
  String nama;
  int harga;
  String kategori;
  String gambar;

  Produk({
    required this.nama,
    required this.harga,
    required this.kategori,
    required this.gambar,
  });

  // Untuk simpan ke SharedPreferences
  Map<String, dynamic> toJson() => {
    'nama': nama,
    'harga': harga,
    'kategori': kategori,
    'gambar': gambar,
  };

  // Untuk ambil dari SharedPreferences
  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
    nama: json['nama'],
    harga: json['harga'],
    kategori: json['kategori'] ?? "JAKET",
    gambar: json['gambar'] ?? "https://via.placeholder.com/150",
  );
}
