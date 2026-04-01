import 'package:flutter/material.dart';
import 'success_page.dart';

class PaymentPage extends StatefulWidget {
  final int totalAmount;
  final List<Map<String, dynamic>> items;

  const PaymentPage({
    super.key,
    required this.totalAmount,
    required this.items,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedMethod = "Pilih Metode";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Metode Pembayaran"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Detail Pesanan:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            ...widget.items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${item['name']} (x${item['qty']})"),
                    Text("Rp ${item['price'] * item['qty']}"),
                  ],
                ),
              ),
            ),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Tagihan",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rp ${widget.totalAmount}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Pilih Metode:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Card(
              child: ExpansionTile(
                leading: const Icon(Icons.account_balance, color: Colors.blue),
                title: Text(
                  selectedMethod.contains("Bank")
                      ? selectedMethod
                      : "Transfer Bank",
                ),
                children: ["Bank BCA", "Bank Mandiri", "Bank BNI"]
                    .map(
                      (bank) => ListTile(
                        title: Text(bank),
                        onTap: () => setState(() => selectedMethod = bank),
                      ),
                    )
                    .toList(),
              ),
            ),

            Card(
              child: ExpansionTile(
                leading: const Icon(Icons.wallet, color: Colors.purple),
                title: Text(
                  selectedMethod.contains("Dana") ||
                          selectedMethod.contains("OVO") ||
                          selectedMethod.contains("GoPay")
                      ? selectedMethod
                      : "E-Wallet",
                ),
                children: ["Dana", "OVO", "GoPay"]
                    .map(
                      (wallet) => ListTile(
                        title: Text(wallet),
                        onTap: () => setState(() => selectedMethod = wallet),
                      ),
                    )
                    .toList(),
              ),
            ),

            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: selectedMethod == "Pilih Metode"
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SuccessPage(
                              method: selectedMethod,
                              total: widget.totalAmount,
                              items: widget.items,
                            ),
                          ),
                        );
                      },
                child: const Text(
                  "Bayar Sekarang",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
