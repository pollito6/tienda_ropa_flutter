import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/app_bar_momo.dart';
import '../widgets/menu_momo.dart';
import '../widgets/app_nav.dart';

class AccountMomo extends StatefulWidget {
  const AccountMomo({super.key});

  @override
  State<AccountMomo> createState() => _AccountMomoState();
}

class _AccountMomoState extends State<AccountMomo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  // Información de usuario simulada (normalmente vendría de una base de datos o servicio)
  final String _userName = 'María López';
  final String _userEmail = 'maria.lopez@example.com';
  final String _userProfileImage = 'assets/images/momo_logo_4x.png';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarMomo(),
      endDrawer: MenuMomo(),
      backgroundColor: AppColors.background,
      bottomNavigationBar: AppNav(
        currentIndex: 3, // Índice 3 corresponde a Cuenta
        onTap: (index) {
          switch (index) {
            case 0: // Home
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1: // Favoritos
              Navigator.pushReplacementNamed(context, '/favorites');
              break;
            case 2: // Historial
              Navigator.pushReplacementNamed(context, '/history');
              break;
            case 3: // Cuenta
              // Ya estamos en cuenta
              break;
          }
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título de la sección
              Text(
                'Mi Cuenta',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 24),
              
              // Perfil del usuario
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Foto de perfil
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                        child: CircleAvatar(
                          radius: 38,
                          backgroundImage: AssetImage(_userProfileImage),
                        ),
                      ),
                      SizedBox(width: 16),
                      // Información del usuario
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _userName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              _userEmail,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.secondary,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextButton(
                              onPressed: () {
                                // Lógica para editar perfil
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Editar perfil (funcionalidad no implementada)'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                foregroundColor: AppColors.primary,
                              ),
                              child: Text('Editar perfil'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              
              // Secciones de la cuenta
              _buildAccountSection(
                'Pedidos',
                Icons.shopping_bag_outlined,
                [
                  _buildMenuItem('Mis pedidos', Icons.shopping_basket, () {
                    _showNotImplementedMessage('Mis pedidos');
                  }),
                  _buildMenuItem('Pedidos en curso', Icons.local_shipping_outlined, () {
                    _showNotImplementedMessage('Pedidos en curso');
                  }),
                  _buildMenuItem('Devoluciones', Icons.assignment_return_outlined, () {
                    _showNotImplementedMessage('Devoluciones');
                  }),
                ],
              ),
              
              _buildAccountSection(
                'Configuración',
                Icons.settings_outlined,
                [
                  _buildMenuItem('Dirección de entrega', Icons.location_on_outlined, () {
                    _showNotImplementedMessage('Dirección de entrega');
                  }),
                  _buildMenuItem('Métodos de pago', Icons.credit_card_outlined, () {
                    _showNotImplementedMessage('Métodos de pago');
                  }),
                  _buildMenuItem('Notificaciones', Icons.notifications_outlined, () {
                    _showNotImplementedMessage('Notificaciones');
                  }),
                ],
              ),
              
              _buildAccountSection(
                'Soporte',
                Icons.help_outline,
                [
                  _buildMenuItem('Ayuda', Icons.question_answer_outlined, () {
                    _showNotImplementedMessage('Ayuda');
                  }),
                  _buildMenuItem('Políticas de privacidad', Icons.privacy_tip_outlined, () {
                    _showNotImplementedMessage('Políticas de privacidad');
                  }),
                  _buildMenuItem('Términos y condiciones', Icons.description_outlined, () {
                    _showNotImplementedMessage('Términos y condiciones');
                  }),
                ],
              ),
              
              SizedBox(height: 24),
              
              // Botón de cerrar sesión
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica para cerrar sesión
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    'Cerrar sesión',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
  
  // Método para mostrar mensaje de funcionalidad no implementada
  void _showNotImplementedMessage(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature (funcionalidad no implementada)'),
        duration: Duration(seconds: 2),
      ),
    );
  }
  
  // Método para construir una sección de la cuenta
  Widget _buildAccountSection(String title, IconData icon, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título de la sección
        Row(
          children: [
            Icon(icon, color: AppColors.primary),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        // Lista de elementos
        Card(
          elevation: 1,
          child: Column(
            children: items,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
  
  // Método para construir un elemento de menú
  Widget _buildMenuItem(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.secondary, size: 20),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, color: AppColors.secondary, size: 16),
          ],
        ),
      ),
    );
  }
}
