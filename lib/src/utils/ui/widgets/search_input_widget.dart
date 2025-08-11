import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class SearchInputWidget extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final bool isSearching;
  final void Function()? onClear;
  final String? textOfResults;
  final String hintText;

  const SearchInputWidget({
    super.key,
    required this.hintText,
    this.onChanged,
    this.controller,
    this.isSearching = false,
    this.onClear,
    this.textOfResults,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
              onChanged: onChanged,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius())),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: ChildOrElseWidget(
                  condition: isSearching,
                  child: IconWidget(onTap: onClear, iconData: Icons.close),
                ),
              )),
          if (textOfResults != null)
            Text(
              textOfResults.orEmpty(),
              textAlign: TextAlign.start,
            ),
        ],
      ),
    );
  }
}
