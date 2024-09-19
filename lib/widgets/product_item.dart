import 'package:flutter/material.dart';
import 'package:first_project/models/product.dart';
import 'package:first_project/screens/update_product_screen.dart';
import 'package:http/http.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key, required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: Colors.white,
      title: Text(product.productName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Code: ${product.productCode}'),
          Text('Price: \$${product.unitPrice}'),
          Text('Quantity: ${product.quantity}'),
          Text('Total Price: \$${product.totalPrice}'),
          const Divider(),
          ButtonBar(
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return  UpdateProductScreen(productId: product.id);
                    }),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
              ),
              TextButton.icon(
                onPressed: () => _deleteProduct(context),
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                label: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  Future<void> _deleteProduct(BuildContext context) async {
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/DeleteProduct/' + product.id);
    Response response = await get(uri);
    ScaffoldMessenger.of(context)
        .showSnackBar( SnackBar(content: Text('Product deleted successfully')));
  }
}
