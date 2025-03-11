import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'welcome_view.dart';

class CreateVehiclePage extends StatefulWidget {
  const CreateVehiclePage({super.key});

  @override
  State<CreateVehiclePage> createState() => _CreateVehiclePageState();
}

class _CreateVehiclePageState extends State<CreateVehiclePage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controladores para los campos del formulario
  final _idTypeController = TextEditingController();
  final _idUserController = TextEditingController();
  final _plateController = TextEditingController();
  final _yearController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _displacementController = TextEditingController();
  final _weightController = TextEditingController();
  final _powerController = TextEditingController();
  final _torqueController = TextEditingController();
  
  bool _isLoading = false;

  @override
  void dispose() {
    _idTypeController.dispose();
    _idUserController.dispose();
    _plateController.dispose();
    _yearController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _displacementController.dispose();
    _weightController.dispose();
    _powerController.dispose();
    _torqueController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final vehicleData = {
        'id_type': _idTypeController.text,
        'id_user': _idUserController.text,
        'plate': _plateController.text,
        'year': _yearController.text,
        'brand': _brandController.text,
        'model': _modelController.text,
        'displacement': _displacementController.text,
        'weight': _weightController.text,
        'power': _powerController.text,
        'torque': _torqueController.text,
      };

      try {
        // Simulamos el envío de datos al backend
        await Future.delayed(const Duration(seconds: 2));
        
        setState(() {
          _isLoading = false;
        });

        if (!mounted) return;
        
        // Navegar a la página principal después del registro exitoso
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeView(userName: _idUserController.text),
          ),
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        
        if (!mounted) return;
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de conexión: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header con color de fondo #5BB1AF
            Container(
              height: 150,
              color: const Color(0xFF5BB1AF),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IconButton(
                      icon: const Icon(Icons.notifications, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                  const Center(
                    child: Text(
                      'create vehicle',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Avatar que sobresale del header
            Transform.translate(
              offset: const Offset(0, -40),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            
            Transform.translate(
              offset: const Offset(0, -20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Crear vehículo',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      
                      // Campos del formulario
                      _buildTextField('ID de la moto', _idTypeController),
                      _buildTextField('ID del usuario', _idUserController),
                      _buildTextField('Placa', _plateController),
                      _buildTextField('Año', _yearController, keyboardType: TextInputType.number),
                      _buildTextField('Marca', _brandController),
                      _buildTextField('Modelo', _modelController),
                      _buildTextField('Cilindraje (cc)', _displacementController, keyboardType: TextInputType.number),
                      _buildTextField('Peso (kg)', _weightController, keyboardType: TextInputType.number),
                      _buildTextField('Potencia (HP)', _powerController),
                      _buildTextField('Torque (Nm)', _torqueController),
                      
                      const SizedBox(height: 20),
                      
                      // Botón de registro
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5BB1AF),
                          ),
                          child: _isLoading 
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('Registrar', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Botón de volver
                      SizedBox(
                        width: 120,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5BB1AF),
                          ),
                          child: const Text('Volver'),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Barra inferior verde
      bottomNavigationBar: Container(
        height: 10,
        color: const Color(0xFF5BB1AF),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

