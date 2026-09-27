import 'package:flutter/material.dart';
import 'package:math_bus/shared/presentation/wigets/top_title_bar.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String? _version;

  @override
  void initState() {
    super.initState();

    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();

    if (!mounted) return;

    setState(() {
      _version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const TopTitleBar(title: 'Sobre')),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Sobre
              _buildSection(
                context,
                title: 'Sobre o MathBus',
                icon: Icons.calculate_outlined,
                children: [
                  const Text(
                    'O MathBus é uma aplicação desenvolvida para tornar '
                    'a prática de matemática básica simples, acessível e '
                    'interativa.',
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'A aplicação permite praticar as quatro operações '
                    'matemáticas básicas por meio de exercícios configuráveis, '
                    'com geração de questões e feedback imediato.',
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // História
              _buildSection(
                context,
                title: 'Como surgiu',
                icon: Icons.directions_bus_outlined,
                children: [
                  const Text(
                    'A ideia do MathBus surgiu a partir de uma situação '
                    'cotidiana: o tempo gasto em deslocamentos por transporte '
                    'público.',
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Em vez de considerar esse período apenas como tempo '
                    'ocioso, surgiu a ideia de aproveitá-lo para realizar '
                    'uma atividade produtiva e praticar matemática.',
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Essa ideia deu origem ao projeto e também ao seu nome. '
                    'O transporte público representa a inspiração inicial '
                    'do MathBus, não uma limitação de uso da aplicação.',
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Funcionalidades
              _buildSection(
                context,
                title: 'O que você pode fazer',
                icon: Icons.extension_outlined,
                children: [
                  _buildFeature(context, icon: Icons.add, title: 'Adição'),
                  _buildFeature(
                    context,
                    icon: Icons.remove,
                    title: 'Subtração',
                  ),
                  _buildFeature(
                    context,
                    icon: Icons.close,
                    title: 'Multiplicação',
                  ),
                  _buildFeature(context, icon: Icons.percent, title: 'Divisão'),
                  _buildFeature(
                    context,
                    icon: Icons.tune,
                    title: 'Configurar exercícios',
                    description:
                        'Defina a quantidade de questões, os limites dos '
                        'operandos e a quantidade de operandos.',
                  ),
                  _buildFeature(
                    context,
                    icon: Icons.check_circle_outline,
                    title: 'Receber feedback',
                    description:
                        'Confira imediatamente se sua resposta está correta.',
                  ),
                  _buildFeature(
                    context,
                    icon: Icons.draw_outlined,
                    title: 'Utilizar o rascunho',
                    description:
                        'Faça cálculos manualmente utilizando o espaço de '
                        'rascunho durante os exercícios.',
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Objetivo
              _buildSection(
                context,
                title: 'Objetivo',
                icon: Icons.flag_outlined,
                children: [
                  const Text(
                    'O objetivo do MathBus é oferecer uma maneira prática '
                    'de exercitar a matemática básica em diferentes momentos '
                    'do dia.',
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Seja durante um deslocamento, em uma pausa, nos estudos '
                    'ou simplesmente por vontade de praticar, a proposta é '
                    'transformar alguns minutos disponíveis em uma '
                    'oportunidade de aprendizado.',
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Versão
              _buildSection(
                context,
                title: 'Versão',
                icon: Icons.info_outline,
                children: [
                  Text(
                    _version != null ? 'MathBus $_version' : 'MathBus',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'A versão atual conta com exercícios de adição, '
                    'subtração, multiplicação e divisão.',
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Rodapé
              Center(
                child: Column(
                  children: [
                    Text(
                      'MathBus',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Aprimore sua matemática básica.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildFeature(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? description,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (description != null) ...[
                  const SizedBox(height: 4),
                  Text(description),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
