import 'package:flutter/material.dart';
import 'result.dart'; // Importa la página de resultados

class ParametersPage extends StatefulWidget {
  final String cultivo; // Recibe el cultivo desde la página anterior

  const ParametersPage({Key? key, required this.cultivo}) : super(key: key);

  @override
  _ParametersPageState createState() => _ParametersPageState();
}

class _ParametersPageState extends State<ParametersPage> {
  final TextEditingController _phController = TextEditingController();
  final TextEditingController _ceController = TextEditingController();
  final TextEditingController _ciceController = TextEditingController();
  final TextEditingController _psiController = TextEditingController();
  final TextEditingController _pController = TextEditingController();

  // Verifica si todos los campos están completos
  bool get _isFormValid {
    return _phController.text.trim().isNotEmpty &&
        _ceController.text.trim().isNotEmpty &&
        _ciceController.text.trim().isNotEmpty &&
        _psiController.text.trim().isNotEmpty &&
        _pController.text.trim().isNotEmpty;
  }

  // Función para redirigir a ResultPage con los parámetros
  void navigateToResultPage() {
    if (!_isFormValid) {
      // Si algún campo está vacío, muestra una alerta
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Campos incompletos'),
          content: const Text(
              'Por favor, completa todos los campos antes de continuar.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // Obtén los valores ingresados
    String ph = _phController.text.trim();
    String ce = _ceController.text.trim();
    String cice = _ciceController.text.trim();
    String psi = _psiController.text.trim();
    String p = _pController.text.trim();

    // Navega a ResultPage y pasa los datos como argumentos
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          cultivo: widget.cultivo, // Pasa el cultivo desde la página anterior
          parametros: {
            'pH': ph,
            'CE': ce,
            'CICE': cice,
            'PSI': psi,
            'P': p,
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/terragem_p.png', // Asegúrate de que la ruta de la imagen sea correcta
              height: 30, // Ajusta el tamaño de la imagen según sea necesario
            ),
            SizedBox(width: 10),
            Text(
              'TerraGem',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold, // Texto en negrita
                color: const Color.fromRGBO(135, 76, 59,
                    1.0), // Color del texto (puedes ajustarlo a tu preferencia)
              ),
            )
          ],
        ),
        backgroundColor: Color.fromRGBO(232, 214, 191, 1.0), // Fondo de color
      ),
      body: SingleChildScrollView(
        // Permitir que el contenido sea desplazable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Texto de bienvenida
              Text(
                '🌱 Ingresa los parámetros fundamentales para la interpretación de tu cultivo 🌾',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Color.fromRGBO(135, 76, 59, 1.0),
                ),
              ),
              const SizedBox(height: 20),

              // Campos de texto para ingresar los parámetros con texto arriba
              _buildTextFieldWithLabel(
                  'pH', '🌟 Nivel de acidez del suelo (pH) ', _phController),
              _buildTextFieldWithLabel(
                  'Conductividad',
                  '🌟 Medición de la salinidad del suelo DSm⁻¹ ',
                  _ceController),
              _buildTextFieldWithLabel(
                  'CICE',
                  '🌟 Capacidad de intercambio catiónico efectivo cmol(c)/kg',
                  _ciceController),
              _buildTextFieldWithLabel('PSI',
                  '🌟 Porcentaje de sodio intercambiable  (%)', _psiController),
              _buildTextFieldWithLabel(
                  'P', '🌟 Nivel de fósforo disponible mg/kg', _pController),

              const SizedBox(height: 20),

              // Botón para guardar los parámetros y redirigir
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormValid
                        ? Color.fromRGBO(135, 76, 59, 1.0)
                        : Colors.grey, // Cambiar color del botón según validez
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isFormValid ? navigateToResultPage : null,
                  child: const Text(
                    'Continuar',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Función para crear el campo de texto para cada parámetro con un texto arriba
  Widget _buildTextFieldWithLabel(
      String label, String description, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título o etiqueta encima del campo de texto
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(135, 76, 59, 1.0),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // Campo de texto con un ancho fijo y uniforme
          Container(
            width: double
                .infinity, // Asegura que el campo ocupe todo el ancho disponible
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200], // Fondo de los campos de texto
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: const Color.fromRGBO(135, 76, 59, 1.0)),
                ),
                hintText: 'Ingresa $label',
                hintStyle: TextStyle(color: Color.fromRGBO(142, 127, 116, 1)),
              ),
              keyboardType: TextInputType.number, // Tipo de teclado numérico
              onChanged: (_) =>
                  setState(() {}), // Actualiza el estado para validar
            ),
          ),
        ],
      ),
    );
  }
}
