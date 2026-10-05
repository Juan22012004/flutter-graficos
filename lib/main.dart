import 'package:flutter/material.dart';
import 'fl_chart_basicas.dart';

void main() {
  runApp(const GaleriaApp());
}

class GaleriaApp extends StatelessWidget {
  const GaleriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taller gráficos Flutter',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const Galeria(),
    );
  }
}

class Galeria extends StatelessWidget {
  const Galeria({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('fl_chart - 43 Gráficas Básicas'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: basicasFl.length,
        itemBuilder: (context, index) {
          final grafica = basicasFl[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 20),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    grafica.titulo,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    height: 280,
                    width: double.infinity,
                    child: grafica.build(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}