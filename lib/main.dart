import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const AnimatedWidgetExample(),
    );
  }
}

class AnimatedWidgetExample extends StatefulWidget {
  const AnimatedWidgetExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedWidgetExampleState createState() => _AnimatedWidgetExampleState();
}

class _AnimatedWidgetExampleState extends State<AnimatedWidgetExample>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _scaleAnimation;

  // Nova animação de rotação
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // Inicializa o AnimationController para a animação existente
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // Configura a animação de Offset para criar uma animação infinita
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-2.0, 0.0),
      end: const Offset(3.0, 0.0),
    ).animate(_controller);

    // Configura o AnimationController para repetir continuamente
    _controller.repeat();

    // Configura a animação de escala para o botão
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 2.0,
    ).animate(_controller);

    // Inicializa o AnimationController para a nova animação de rotação
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    // Configura a animação de rotação
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 6.28,
    ).animate(_rotationController);

    // Configura o AnimationController para repetir continuamente
    _rotationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 37, 39),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 117, 142),
        title: const Text('Animação Flutter'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/imagen_fundo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            height: MediaQuery.of(context).size.height / 4,
          ),
          Positioned(
            top: 80,
            left: 0,
            child: SlideTransition(
              position: _offsetAnimation,
              child: Image.asset(
                'assets/images/bike.gif', // Substitua pelo caminho correto para sua imagem
                width: 150,
                height: 120,
              ),
            ),
          ),
          Positioned(
            top: 500,
            left: 0,
            child: SlideTransition(
              position: _offsetAnimation, // Aplica Animacao inifinita
              child: Image.asset(
                'assets/images/human.svg.png', // Substitua pelo caminho correto para sua imagem
                width: 110,
                height: 120,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RotationTransition(
              turns: _rotationAnimation, // Aplicando a animação de rotação
              child: Image.asset(
                'assets/images/planet3.webp', // Substitua pelo caminho correto para sua imagem
                width: 250,
                height: 400,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.status == AnimationStatus.completed) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
        child: ScaleTransition(
          scale: _scaleAnimation, // Aplicando a animação de escala ao botão
          child: const Icon(Icons.electric_bike),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _rotationController.dispose();
    super.dispose();
  }
}
