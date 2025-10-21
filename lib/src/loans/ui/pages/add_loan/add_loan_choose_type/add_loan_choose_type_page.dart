import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_choose_type/add_loan_choose_type_controller.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_choose_type/add_loan_choose_options.dart';
import 'package:utils/utils.dart';

class AddLoanChooseTypePage extends StatelessWidget {
  
  final AddLoanChooseTypeController controller = AddLoanChooseTypeController();
  
  AddLoanChooseTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return GetBuilder<AddLoanChooseTypeController>(
      init: controller,
      builder: (controller) => Scaffold(
        appBar: appBarWidget(text: 'Elija el tipo', hasArrowBack: true),
        body: _content(size),
      ),
    );
  }

  Widget _content(Size size) {
    return ListView.separated(
      itemCount: AddLoanChooseOptions.values.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) => _cardType(
          onTap: ()=> controller.goSelectedType(AddLoanChooseOptions.values[index]),
          iconData: AddLoanChooseOptions.values[index].iconData,
          title: AddLoanChooseOptions.values[index].title,
          description: AddLoanChooseOptions.values[index].description,
          size: size,
      ),
    );
  }

  Widget _cardType({
    required IconData iconData,
    required String title,
    required String description,
    required Size size,
    required void Function()? onTap,
  }) {
    const TextStyle titleStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

    const TextStyle descriptionStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );

    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: titleStyle,
      ),
      subtitle: Text(
        description,
        style: descriptionStyle,
      ),
      leading: Icon(
        iconData,
        color: infoColor(),
      ),
    );
  }
}
