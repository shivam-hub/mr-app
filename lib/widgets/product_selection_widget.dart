import 'package:Nurene/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import '/models/prodcut_model.dart';
import '/services/locator.dart';
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
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.appThemeDarkShade3,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: MultiSelectDropDown.network(
        chipConfig: ChipConfig(
            backgroundColor: Colors.white,
            labelColor: Colors.black,
            wrapType: WrapType.scroll,
            labelStyle: GoogleFonts.montserrat()),
        borderColor: Colors.transparent,
        optionsBackgroundColor: Colors.white,
        selectedOptionBackgroundColor: AppColors.appThemeLightShade3,
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
          method: RequestMethod.get,
        ),
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
            child: Text('Error fetching options'),
          );
        },
        hint: 'Select Products',
        selectionType: SelectionType.multi,
        searchEnabled: true,
      ),
    );
  }
}
