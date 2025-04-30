import 'package:flutter/material.dart';
import '../widgets/app_bar_momo.dart';
import '../widgets/menu_momo.dart';
import '../theme/app_colors.dart';
import '../services/cart_service.dart';

class CheckoutMomo extends StatefulWidget {
  const CheckoutMomo({super.key});

  @override
  State<CheckoutMomo> createState() => _CheckoutMomoState();
}

class _CheckoutMomoState extends State<CheckoutMomo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CartService _cartService = CartService();
  
  // Controladores para los campos de entrada
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();
  
  // Estado del método de pago seleccionado
  String _selectedPaymentMethod = 'tarjeta';
  
  // Estado de los pasos del checkout
  int _currentStep = 0;
  
  @override
  void dispose() {
    // Limpiar controladores al cerrar
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarMomo(),
      endDrawer: MenuMomo(),
      backgroundColor: AppColors.background,
      body: _buildCheckoutContent(),
      persistentFooterButtons: [
        _buildConfirmButton(),
      ],
    );
  }
  
  // Contenido principal del checkout
  Widget _buildCheckoutContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de la página
            Text(
              'Completar Compra',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 24),
            
            // Stepper para el proceso de checkout
            _buildCheckoutStepper(),
          ],
        ),
      ),
    );
  }
  
  // Construir el stepper del checkout
  Widget _buildCheckoutStepper() {
    return Stepper(
      currentStep: _currentStep,
      onStepContinue: () {
        if (_currentStep < 2) {
          setState(() {
            _currentStep++;
          });
        }
      },
      onStepCancel: () {
        if (_currentStep > 0) {
          setState(() {
            _currentStep--;
          });
        } else {
          Navigator.pop(context);
        }
      },
      steps: [
        // Paso 1: Información de contacto
        Step(
          title: Text('Información de contacto'),
          content: _buildContactInfoForm(),
          isActive: _currentStep >= 0,
        ),
        // Paso 2: Dirección de envío
        Step(
          title: Text('Dirección de envío'),
          content: _buildShippingAddressForm(),
          isActive: _currentStep >= 1,
        ),
        // Paso 3: Método de pago
        Step(
          title: Text('Método de pago'),
          content: _buildPaymentMethodForm(),
          isActive: _currentStep >= 2,
        ),
      ],
      controlsBuilder: (context, details) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: details.onStepContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: Text(
                  _currentStep < 2 ? 'Continuar' : 'Completar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(width: 12),
              TextButton(
                onPressed: details.onStepCancel,
                child: Text(
                  _currentStep > 0 ? 'Regresar' : 'Cancelar',
                  style: TextStyle(color: AppColors.secondary),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  // Formulario de información de contacto
  Widget _buildContactInfoForm() {
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Nombre completo',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Correo electrónico',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: _phoneController,
          decoration: InputDecoration(
            labelText: 'Teléfono',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
  
  // Formulario de dirección de envío
  Widget _buildShippingAddressForm() {
    return Column(
      children: [
        TextFormField(
          controller: _addressController,
          decoration: InputDecoration(
            labelText: 'Dirección',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'Ciudad',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: _stateController,
                decoration: InputDecoration(
                  labelText: 'Estado',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: _zipController,
          decoration: InputDecoration(
            labelText: 'Código postal',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
  
  // Formulario de método de pago
  Widget _buildPaymentMethodForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selecciona un método de pago:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        
        // Tarjeta de crédito/débito
        RadioListTile<String>(
          title: Row(
            children: [
              Icon(Icons.credit_card, color: AppColors.primary),
              SizedBox(width: 8),
              Text('Tarjeta de crédito/débito'),
            ],
          ),
          value: 'tarjeta',
          groupValue: _selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              _selectedPaymentMethod = value!;
            });
          },
        ),
        
        // PayPal
        RadioListTile<String>(
          title: Row(
            children: [
              Icon(Icons.account_balance_wallet, color: AppColors.primary),
              SizedBox(width: 8),
              Text('PayPal'),
            ],
          ),
          value: 'paypal',
          groupValue: _selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              _selectedPaymentMethod = value!;
            });
          },
        ),
        
        // Pago en efectivo
        RadioListTile<String>(
          title: Row(
            children: [
              Icon(Icons.money, color: AppColors.primary),
              SizedBox(width: 8),
              Text('Pago en efectivo al recibir'),
            ],
          ),
          value: 'efectivo',
          groupValue: _selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              _selectedPaymentMethod = value!;
            });
          },
        ),
        
        SizedBox(height: 16),
        
        // Mostrar campos de tarjeta si seleccionó tarjeta
        if (_selectedPaymentMethod == 'tarjeta')
          Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Número de tarjeta',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Fecha de expiración',
                        hintText: 'MM/AA',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'CVV',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        
        // Mostrar campos de PayPal si seleccionó PayPal
        if (_selectedPaymentMethod == 'paypal')
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Correo electrónico de PayPal',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
      ],
    );
  }
  
  // Botón de confirmar pedido
  Widget _buildConfirmButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _showConfirmationDialog();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Confirmar pedido: \$${_cartService.total.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Mostrar diálogo de confirmación de pedido
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar Pedido'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tu pedido ha sido recibido. Detalles:'),
            SizedBox(height: 8),
            Text('Productos: ${_cartService.itemCount}'),
            Text('Total: \$${_cartService.total.toStringAsFixed(2)}'),
            SizedBox(height: 16),
            Text(
              'Gracias por tu compra. Recibirás un correo de confirmación pronto.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Limpiar carrito
              _cartService.clearCart();
              
              // Navegar a la página principal
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).pushReplacementNamed('/home');
            },
            child: Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
