import 'package:flutter/material.dart';

enum DirectAccessEnum {
  analytics(icon: Icons.analytics_outlined, title: 'Analíticas'),
  currentWeek(icon: Icons.calendar_month_outlined, title: 'Semana actual'),
  createLoan(icon: Icons.post_add_outlined, title: 'Nuevo préstamo'),
  paymentSummary(icon: Icons.summarize_outlined, title: 'Resumen pagos'),
  defeated(icon: Icons.calendar_month_outlined, title: 'Vencidos'),
  createCustomer(icon: Icons.person_add_alt_1_outlined, title: 'Nuevo cliente');

  const DirectAccessEnum({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;
}
