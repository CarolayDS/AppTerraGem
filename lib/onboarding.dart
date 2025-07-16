import 'package:flutter/material.dart';
import 'package:gemini_gpt/myHomePage.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      '¡Bienvenido!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(228, 136, 100, 1),
                      ),
                    ),
                    const SizedBox(
                        height: 16), // Espacio entre el texto y la imagen
                    // Coloca el texto y la imagen al costado (en un Row)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'TerraGem ',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(135, 76, 59, 1.0),
                          ),
                        ),
                        // Asegúrate de tener la imagen en los assets
                        Image.asset(
                          'assets/terragem.png', // Cambia este nombre al correcto
                          width: 40, // Ajusta el tamaño de la imagen
                          height: 40,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'App para interpretar análisis de suelo 🌱📊, optimiza cultivos con inteligencia artificial 🤖💡',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 77, 74, 74),
                      ),
                    )
                  ],
                ),
                // Imagen con un tamaño mayor
                Image.asset(
                  'assets/imagen1.png',
                  width: 300, // Ajusta el valor para cambiar el ancho
                  height: 300, // Ajusta el valor para cambiar la altura
                  fit:
                      BoxFit.contain, // Opcional: ajusta el ajuste de la imagen
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage()),
                        (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                    backgroundColor: const Color.fromRGBO(
                        135, 76, 59, 1.0), // Botón de color neutro
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Continuar',
                        style: TextStyle(
                          color: Colors
                              .white, // Cambiar el color del texto a blanco
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color:
                            Colors.white, // Cambiar el color del ícono a blanco
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
