import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'recomen_fertilizante.dart'; // Asegúrate de tener este archivo creado

class ResultPage extends StatelessWidget {
  final String cultivo;
  final Map<String, String> parametros;

  const ResultPage({
    Key? key,
    required this.cultivo,
    required this.parametros,
  }) : super(key: key);

  // Función para obtener las recomendaciones detalladas del modelo Gemini
  Future<List<String>> analyzeSoilWithGemini() async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: dotenv.env['GOOGLE_API_KEY']!,
      );

      final prompt = '''
      Analiza los siguientes datos para el cultivo "$cultivo":
      - pH: ${parametros['pH']}
      - Conductividad Eléctrica (CE): ${parametros['CE']}
      - Capacidad de Intercambio Catiónico Efectivo (CICE): ${parametros['CICE']}
      - Porcentaje de Sodio Intercambiable (PSI): ${parametros['PSI']}
      - Fósforo Disponible (P): ${parametros['P']}

      Proporciona un análisis detallado de cada parámetro, y proporciona recomendaciones específicas sobre cómo mejorar cada uno de los aspectos para optimizar las condiciones del suelo y el cultivo, hazlo que sea estético y fácil de leer.
      Asegúrate de no poner en negrita las palabras, no utilices ***, no arrojes ningún resumen al final, no realices ninguna tabla.
      ''';

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      return response.text!
          .split('\n')
          .where((line) => line.trim().isNotEmpty && !line.contains('*****'))
          .map((line) => line.trim())
          .toList();
    } catch (e) {
      print('Error al analizar los datos: $e');
      return ['Error al analizar los datos. Intenta nuevamente.'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/terragem_p.png',
              height: 30,
            ),
            const SizedBox(width: 10),
            const Text(
              'TerraGem',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(135, 76, 59, 1.0),
              ),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(232, 214, 191, 1.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              '📊 Aquí tienes tus resultados 📋',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(135, 76, 59, 1.0),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '🌟 Lee atentamente los resultados y recomendaciones para que tu cultivo 🌱 esté en óptimas condiciones 🌿',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Color.fromRGBO(135, 76, 59, 1.0),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder<List<String>>(
                      future: analyzeSoilWithGemini(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError || !snapshot.hasData) {
                          return const Center(
                            child: Text(
                              'Error al generar resultados. Intenta nuevamente.',
                              style: TextStyle(fontSize: 16, color: Colors.red),
                            ),
                          );
                        }

                        final results = snapshot.data!;
                        return ListView.builder(
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.lightbulb,
                                      color: Color.fromRGBO(135, 76, 59, 1.0),
                                      size: 30,
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        results[index],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                          height: 1.5,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecomenFertilizante(
                            cultivo: cultivo,
                            parametros: parametros,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(135, 76, 59, 1.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Siguiente',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
