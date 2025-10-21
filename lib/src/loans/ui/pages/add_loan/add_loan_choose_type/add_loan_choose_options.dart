import 'package:flutter/material.dart';

enum AddLoanChooseOptions {
  normal(
    iconData: Icons.calendar_month,
    title: 'Un mes',
    description: 'Préstamo a 28 dias: con formas de pago diaria, semanal o mensual',
  ),
  special(
    iconData: Icons.star_rate_outlined,
    title: 'Especial',
    description: 'Elija el tiempo y la cantidad de cuotas como desee.',
  ),
  renewal(
    iconData: Icons.refresh,
    title: 'Renovación',
    description: 'Vincular renovación entre préstamos.',
  );

  const AddLoanChooseOptions({
    required this.iconData,
    required this.title,
    required this.description,
  });

  final IconData iconData;
  final String title;
  final String description;
}

const chooseOptions = AddLoanChooseOptions.values;