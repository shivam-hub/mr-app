import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:nurene_app/models/prodcut_model.dart';
import 'package:nurene_app/services/api_services.dart';
import 'package:nurene_app/services/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/const.dart';

class ProductSelectionWidget extends StatefulWidget {
  final void Function(List<ProductModel>)? onOptionSelected;
  const ProductSelectionWidget({super.key, this.onOptionSelected});

  @override
  State<ProductSelectionWidget> createState() => _ProductSelectionWidgetState();
}

class _ProductSelectionWidgetState extends State<ProductSelectionWidget> {
  final baseUrl = Constants.baseurl;
  final pref = locator<SharedPreferences>();
  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown.network(
        onOptionSelected: (options) {
          List<ProductModel> p = [];
          for (var element in options) {
            p.insert(0, ProductModel(name: element.label, code: element.value));
          }
          widget.onOptionSelected!(p);
        },
        networkConfig: NetworkConfig(
            url: '$baseUrl/api/Products/allProducts',
            headers: {'Authorization': 'Bearer ${pref.getString('token')}'},
            method: RequestMethod.get),
        responseParser: (response) {
          final list = (response as List<dynamic>).map((e) {
            final item = ProductModel.fromJson(e);
            return ValueItem(label: item.name ?? '', value: item.code);
          }).toList();
          return Future.value(list);
        },
        responseErrorBuilder: (context, body) {
          return const Padding(
              padding: EdgeInsets.all(8),
              child: Text('Error fetching options'));
        },
        hint: 'Select Products',
        selectionType: SelectionType.multi,
        searchEnabled: true);
  }
}

// class ProductSelectionWidget extends StatefulWidget {
//   const ProductSelectionWidget({super.key});

//   @override
//   ProductSelectionWidgetState createState() => ProductSelectionWidgetState();
// }

// class ProductSelectionWidgetState extends State<ProductSelectionWidget> {
//   List<String> products = [];
//   List<String> allProducts = [];

//   Future<void> fetchAllProducts() async {
//     final apiService = locator<ApiService>();
//     try {
//       final fetchedProducts = await apiService.getProducts();
//       setState(() {
//         for (var element in fetchedProducts) {
//           final dynamic name = element['name'];
//           if (name != null && name is String && name.isNotEmpty) {
//             allProducts.add(name);
//           }
//         }
//       });
//     } catch (e) {
//       allProducts = [];
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchAllProducts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     debugPrint(allProducts.length as String?);
//     return Material(
//       borderRadius: BorderRadius.circular(15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             decoration: const BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                     color: Color(0xFF7882A4)), // Change the underline color
//               ),
//             ),
//             child: DropdownButton<String>(
//               underline: const SizedBox(), // Hide the default underline
//               icon: const Icon(Icons.arrow_drop_down),
//               hint: const Text('Select Products'),
//               value: null,
//               items: allProducts.map((String product) {
//                 return DropdownMenuItem<String>(
//                   value: product,
//                   child: Text(product),
//                 );
//               }).toList(),
//               onChanged: (String? selectedProduct) {
//                 if (selectedProduct != null) {
//                   setState(() {
//                     products.add(selectedProduct);
//                     allProducts.remove(selectedProduct);
//                   });
//                 }
//               },
//             ),
//           ),
//           const SizedBox(height: 10),
//           Wrap(
//             spacing: 8.0,
//             runSpacing: 8.0,
//             children: List.generate(products.length, (index) {
//               return Material(
//                 borderRadius: BorderRadius.circular(15),
//                 child: Chip(
//                   label: Text(products[index]),
//                   backgroundColor: const Color(
//                       0xFF7882A4), // Change the chip background color
//                   deleteIcon: const Icon(Icons.cancel, color: Colors.white),
//                   onDeleted: () {
//                     setState(() {
//                       allProducts.add(products[index]);
//                       products.removeAt(index);
//                     });
//                   },
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
