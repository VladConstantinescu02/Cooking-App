import 'package:flutter/material.dart';
import 'package:msa_cooking_app_client/shared/models/navigation_item.dart';

final List<NavigationItem> navigationItems = [
  const NavigationItem(icon: Icons.home_filled, label: 'Home', route: '/home'),
  const NavigationItem(icon: Icons.set_meal, label: 'Meals', route: '/meals'),
  const NavigationItem(icon: Icons.fastfood_rounded, label: 'fridge', route: '/fridge'),
  const NavigationItem(icon: Icons.account_circle_rounded, label: 'profile', route: '/profile')
];