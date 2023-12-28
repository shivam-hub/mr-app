import 'package:flutter/material.dart';

class ProductSelectionWidget extends StatefulWidget {
  @override
  _ProductSelectionWidgetState createState() => _ProductSelectionWidgetState();
}

class _ProductSelectionWidgetState extends State<ProductSelectionWidget> {
  List<String> products = [];
  List<String> allProducts = [
    'Product 1',
    'Product 2',
    'Product 3',
    'Product 4',
    'Product 5',
    'Product 6',
    'Product 7',
    'Product 8',
    'Product 9',
    'Product 10',
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Color(0xFF7882A4)), // Change the underline color
              ),
            ),
            child: DropdownButton<String>(
              underline: SizedBox(), // Hide the default underline
              icon: Icon(Icons.arrow_drop_down),
              hint: Text('Select Products'),
              value: null,
              items: allProducts.map((String product) {
                return DropdownMenuItem<String>(
                  value: product,
                  child: Text(product),
                );
              }).toList(),
              onChanged: (String? selectedProduct) {
                if (selectedProduct != null) {
                  setState(() {
                    products.add(selectedProduct);
                    allProducts.remove(selectedProduct);
                  });
                }
              },
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(products.length, (index) {
              return Material(
                borderRadius: BorderRadius.circular(15),
                child: Chip(
                  label: Text(products[index]),
                  backgroundColor:
                      Color(0xFF7882A4), // Change the chip background color
                  deleteIcon: Icon(Icons.cancel, color: Colors.white),
                  onDeleted: () {
                    setState(() {
                      allProducts.add(products[index]);
                      products.removeAt(index);
                    });
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
