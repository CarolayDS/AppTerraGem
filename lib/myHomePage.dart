import 'package:flutter/material.dart';
import 'parameters.dart'; // Importa la página de parámetros

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  // Función para navegar a ParametersPage con el nombre del cultivo
  void navigateToParametersPage() {
    String cultivo = _controller.text.trim();
    if (cultivo.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParametersPage(cultivo: cultivo),
        ),
      );
    } else {
      // Mostrar un mensaje si el cultivo no está especificado
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Por favor ingresa el nombre del cultivo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center, // Centrado vertical
          children: [
            // Título y emoji
            Text(
              '¿Qué tipo de cultivo estás trabajando?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(135, 76, 59, 1.0),
              ),
            ),
            SizedBox(height: 12),
            Text(
              '🌱 Es importante conocer tu tipo de cultivo para obtener mejores resultados en tu cosecha 🌾',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                color: Color.fromRGBO(
                    168, 138, 126, 1), // Puedes elegir el color que prefieras
              ),
            ),

            SizedBox(height: 12), // Espacio entre el texto y la imagen

            // Imagen centrada
            Image.asset(
              'assets/imagen2.png', // Asegúrate de que esta imagen exista
              width: 200, // Ajusta el valor para cambiar el ancho
              height: 200, // Ajusta el valor para cambiar la altura
              fit: BoxFit.contain, // Opcional: ajusta el ajuste de la imagen
            ),
            SizedBox(height: 32), // Espacio entre la imagen y el campo de texto

            // Campo de texto para ingresar el nombre del cultivo
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Ingresa tu cultivo',
                labelStyle: TextStyle(color: Color.fromRGBO(157, 154, 154, 1)),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(135, 76, 59, 1.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(135, 76, 59, 1.0)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Botón de continuar
            ElevatedButton(
              onPressed: navigateToParametersPage,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                backgroundColor: Color.fromRGBO(135, 76, 59, 1.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Continuar',
                    style: TextStyle(
                      color:
                          Colors.white, // Cambiar el color del texto a blanco
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white, // Cambiar el color del ícono a blanco
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
