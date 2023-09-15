import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../gen/assets.gen.dart';
import '../../gen/colors.gen.dart';
import '../imc_form/imc_form_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final _pages = <Map<String, dynamic>>[
    {
      'image': Assets.images.logo,
      'text':
          'Seja bem-vindo ao nosso aplicativo de Cálculo de Índice de Massa Corporal (IMC). Estamos aqui para ajudá-lo a monitorar sua saúde e alcançar seus objetivos de bem-estar.'
    },
    {
      'image': Assets.images.scalesMeasuringTape,
      'text':
          'O Índice de Massa Corporal (IMC) é uma medida que avalia a relação entre seu peso e altura. Ele é amplamente utilizado para identificar se você está com peso abaixo do ideal, peso saudável, sobrepeso ou obesidade. O IMC fornece uma visão geral da sua saúde e pode ser um guia valioso para a gestão do peso'
    },
    {
      'image': Assets.images.womanEating,
      'text':
          'Seu IMC está dentro da faixa saudável? Ou há espaço para melhorias? Nossa próxima etapa é fornecer informações úteis sobre qual o seu IMC atual e como mantê-lo ou melhorá-lo. Vamos ajudá-lo a trabalhar em direção a um estilo de vida mais saudável. Toque em "Começar" para começar a usar o aplicativo e descobrir mais sobre seu IMC.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: _pages.length,
        itemBuilder: (_, index) {
          final {
            'image': AssetGenImage image,
            'text': String text,
          } = _pages[index];

          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                image.image(
                  height: 300.0,
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                ),
                const SizedBox(height: 32.0),
                Text(
                  text,
                  style: const TextStyle(color: ColorName.textOpaque),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          final currentPage = _controller.page?.round() ?? 0;
          final pagesCount = _pages.length;
          final isLastPage = currentPage == pagesCount - 1;

          Widget footer = switch (isLastPage) {
            true => _LastPageIndicator(controller: _controller),
            false => _OnBoardingIndicators(
                currentPage: currentPage,
                pagesCount: pagesCount,
                controller: _controller,
              ),
          };

          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: footer,
          );
        },
      ),
    );
  }
}

class _LastPageIndicator extends StatelessWidget {
  final PageController controller;
  const _LastPageIndicator({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleButton.surface(
          child: const Icon(Icons.chevron_left, size: 32.0),
          onPressed: () => controller.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          ),
        ),
        Expanded(
          child: ElevatedButton(
            child: const Text('Começar'),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (_) => const IMCFormPage(),
              ));
            },
          ),
        ),
      ],
    );
  }
}

class _OnBoardingIndicators extends StatelessWidget {
  final int currentPage;
  final int pagesCount;
  final PageController controller;

  const _OnBoardingIndicators({
    required this.currentPage,
    required this.pagesCount,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        PageIndicatorsBar(
          currentPage: currentPage,
          pages: pagesCount,
        ),
        CircleButton.primary(
          child: const Icon(Icons.chevron_right, size: 32.0),
          onPressed: () => controller.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          ),
        )
      ],
    );
  }
}
