import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class RecomenFertilizante extends StatelessWidget {
  final String cultivo;
  final Map<String, String> parametros;

  const RecomenFertilizante({
    super.key,
    required this.cultivo,
    required this.parametros,
  });

  // Función para obtener recomendaciones de fertilizantes
  Future<List<String>> getFertilizerRecommendations() async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: dotenv.env['GOOGLE_API_KEY']!,
      );

      final prompt = '''
      Con base en el siguiente análisis de suelo para el cultivo "$cultivo", proporciona únicamente recomendaciones específicas de fertilizantes:

      - pH: ${parametros['pH']}
      - Conductividad Eléctrica (CE): ${parametros['CE']}
      - Capacidad de Intercambio Catiónico Efectivo (CICE): ${parametros['CICE']}
      - Porcentaje de Sodio Intercambiable (PSI): ${parametros['PSI']}
      - Fósforo Disponible (P): ${parametros['P']}

      Indica qué fertilizantes se deben usar, cómo aplicarlos (tipo, cantidad, frecuencia) y por qué, según cada parámetro del suelo.

      No uses negrita, tablas ni resúmenes. Escribe de forma estética, clara y fácil de leer.
      ''';

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      return response.text!
          .split('\n')
          .where((line) => line.trim().isNotEmpty && !line.contains('*****'))
          .map((line) => line.trim())
          .toList();
    } catch (e) {
      print('Error al obtener fertilizantes: $e');
      return ['No se pudieron obtener recomendaciones. Intenta más tarde.'];
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
              '🧪 Recomendaciones de Fertilización 🌾',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(135, 76, 59, 1.0),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '🌟 Basado en el análisis del suelo y el cultivo seleccionado, aquí tienes sugerencias para optimizar tu fertilización.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Color.fromRGBO(135, 76, 59, 1.0),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<String>>(
                future: getFertilizerRecommendations(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(
                      child: Text(
                        'Error al generar recomendaciones.',
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
                                Icons.eco,
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
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context); // Volver a la pantalla anterior
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(135, 76, 59, 1.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              label: const Text(
                'Volver a resultados',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
