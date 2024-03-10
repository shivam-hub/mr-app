import 'package:flutter/material.dart';
import '../../widgets/appbar_widget.dart';
import 'package:Nurene/themes/app_colors.dart';

class ProductScreen extends StatelessWidget {
  // Define a list of product data including asset paths
  final List<Map<String, String>> products = [
    {
      'productName': 'Nurexime-200',
      'description': 'Cefixime 200 mg Dispersible Tablet',
      'imageAsset': 'asset/products/product1.png', // Example asset path
    },
    {
      'productName': 'Nurapainwin',
      'description':
          'Trypsin 48 mg Bromelain 90 mg + Rutoside Trihydrate 100 mg Diclofenac Sodium 50 mg Tablets',
      'imageAsset': 'asset/products/product2.png', // Example asset path
    },
    {
      'productName': 'Nurowin',
      'description':
          'Nortriptylin 10 mg + Pregabalin 75 mg + Methylcobalamin 1500 mcg Tablets',
      'imageAsset': 'asset/products/product3.png', // Example asset path
    },
    {
      'productName': 'NUROJTWIN Plus',
      'description':
          'Rosehip Ext, Collagen Peptide type 2, Sodium Hyaluronate, Chondroitin Sulphate & Vitamin C Tablets',
      'imageAsset': 'asset/products/product4.png', // Example asset path
    },
    {
      'productName': 'NUROJTWIN',
      'description':
          'Collagen Peptide Type 1 40 mg, Chondroitin sulphate 200 mg, Sodium hyaluronate 30 mg, and Vitamin C 35 mg + L. Arginine 500 mg',
      'imageAsset': 'asset/products/product5.png', // Example asset path
    },
    {
      'productName': 'Nurocal',
      'description':
          'Calcitriol BP 0.25 mg Calcium Carbonate I.P. 500 mg (eq to elemental Calcium 200 mg) Zinc USP 7.5 mg (as Zinc Sulphate Monohydrate)',
      'imageAsset': 'asset/products/product6.png', // Example asset path
    },
    {
      'productName': 'Nurofer XT',
      'description':
          'Ferrous Ascorbate eq to elemental Iron 100 mg + Folic Acid 1.5 mg',
      'imageAsset': 'asset/products/product7.png', // Example asset path
    },
    {
      'productName': 'NuraPan-40',
      'description': 'Pantoprazole 40 mg',
      'imageAsset': 'asset/products/product8.png', // Example asset path
    },
    {
      'productName': 'NuraPan-D',
      'description': 'Pantoprazole 40 mg + Domperidone 10 mg',
      'imageAsset': 'asset/products/product9.png', // Example asset path
    },
    {
      'productName': 'NuraCV',
      'description': 'Amoxicillin 500 mg + Clavulanic acid 125 mg',
      'imageAsset': 'asset/products/product10.png', // Example asset path
    },
    {
      'productName': 'Nurexime Plus',
      'description': 'Cefuroxime 500 mg Tablet',
      'imageAsset': 'asset/products/product11.png', // Example asset path
    },
    {
      'productName': 'Nurodosin D4',
      'description': 'Silodosin 4 mg + Dutasteroid 0.5 mg',
      'imageAsset': 'asset/products/product12.png', // Example asset path
    },
    {
      'productName': 'Nurodosin D8',
      'description': 'Silodosin 8 mg + Dutasteroid 0.5 mg',
      'imageAsset': 'asset/products/product13.png', // Example asset path
    },
    {
      'productName': 'Nurastrone 200',
      'description': 'Natural Micronised Progesterone 200 mg Soft Gel Capsules',
      'imageAsset': 'asset/products/product14.png', // Example asset path
    },
    {
      'productName': 'Nurastrone 300',
      'description': 'Natural Micronised Progesterone 300 mg S R Tablets',
      'imageAsset': 'asset/products/product15.png', // Example asset path
    },
    {
      'productName': 'Nuromont-LC',
      'description': 'Levocetirizine 5 mg. + Montelukast Sodium 10 mg',
      'imageAsset': 'asset/products/product16.png', // Example asset path
    },
    {
      'productName': 'Nuraconazole-200 ',
      'description': 'Itraconazole 200 mg Capsules',
      'imageAsset': 'asset/products/product17.png', // Example asset path
    },
    {
      'productName': 'Nurozit',
      'description': 'flupentixol hydrochloride 0.5 mg + Melitracen 10 mg',
      'imageAsset': 'asset/products/product18.png', // Example asset path
    },
    {
      'productName': 'Pregni Card',
      'description': 'One Step HCG Urine Pregnancy Test',
      'imageAsset': 'asset/products/product19.png', // Example asset path
    },
    {
      'productName': 'VANA IV SET',
      'description': 'Gravity Feed Only |Non Toxic |Non Pyrogenic',
      'imageAsset': 'asset/products/product20.png', // Example asset path
    },
    {
      'productName': 'Nuredexа',
      'description': 'Dexamethasone Phosphate 4 mg per ml',
      'imageAsset': 'asset/products/product21.png', // Example asset path
    },
    {
      'productName': 'Nurofer Syrup',
      'description': 'Iron tonic',
      'imageAsset': 'asset/products/product22.png', // Example asset path
    },
    {
      'productName': 'Nurofenac-SP',
      'description': 'Aceclofenac, Paracetamol and Serratiopeptidase Tablets',
      'imageAsset': 'asset/products/product23.png', // Example asset path
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        appBarTitle: "Products",
        prefixIcon: IconButton(
          icon: const Icon(Icons.arrow_back_outlined,
              color: Colors.black, size: 25),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
        gradient: AppColors.appBarColorGradient,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(products.length, (index) {
          return ProductCard(
            productName: products[index]['productName']!,
            description: products[index]['description']!,
            imageAsset: products[index]['imageAsset']!,
          );
        }),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final String description;
  final String imageAsset;

  ProductCard({
    required this.productName,
    required this.description,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            imageAsset,
            height: 150,
            width: 200,
            //fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  productName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0),
                Text(
                  description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
