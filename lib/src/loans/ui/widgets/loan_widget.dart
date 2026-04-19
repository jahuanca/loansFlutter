
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class LoanWidget extends StatelessWidget {

  final void Function()? onTap;
  final int id;
  final String loanName;
  final String customerName;
  final String? date;
  final bool isCompleted;
  

  const LoanWidget({super.key,
    this.onTap,
    required this.id,
    required this.loanName,
    required this.customerName,
    required this.date,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Text('$id'),
      title: _titleItem(),
      subtitle: Text(customerName),
      trailing: Text(date.orEmpty()),
    );
  }

  Widget _titleItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(loanName),
        if (isCompleted) _iconComplete()
      ],
    );
  }

  Widget _iconComplete() => IconWidget(
      padding: const EdgeInsets.only(left: 8.0),
      color: successColor(),
      iconData: Icons.check);

}