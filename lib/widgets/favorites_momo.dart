import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
class FavoritesMomo extends StatelessWidget {
  const FavoritesMomo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        backgroundColor: AppColors.primary,
      ),
      body: const Center(
        child: Text('Página de Favoritos'),
      ),
    );
  }
}
