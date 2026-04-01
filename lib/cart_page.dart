import 'package:flutter/material.dart';
import 'payment_page.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final Function(Map<String, dynamic>, int) onUpdateQuantity;
  final VoidCallback onCheckout;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.onUpdateQuantity,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    int total = cartItems.fold(
      0,
      (sum, item) =>
          sum + ((item['price'] as int) * (item['qty'] as int? ?? 1)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang Saya"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
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
                          subtitle: Text(
                            "Rp ${item['price']} x ${item['qty']}",
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.orange,
                                ),
                                onPressed: () => onUpdateQuantity(item, -1),
                              ),
                              Text("${item['qty']}"),
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.orange,
                                ),
                                onPressed: () => onUpdateQuantity(item, 1),
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (cartItems.isNotEmpty) {
                            // MENGUNCI DATA AGAR TIDAK HILANG SAAT CLEAR
                            final List<Map<String, dynamic>> dataBarang =
                                List.from(cartItems);
                            final int totalFinal = total;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentPage(
                                  totalAmount: totalFinal,
                                  items: dataBarang,
                                ),
                              ),
                            );
                            onCheckout(); // Kosongkan keranjang setelah data dikirim
                          }
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
}
