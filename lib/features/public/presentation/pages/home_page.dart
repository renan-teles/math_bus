import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:math_bus/features/exercise/domain/exercise/basic/operation.dart';
import 'package:math_bus/shared/presentation/wigets/top_title_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TopTitleBar(title: 'Início')),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Cabeçalho
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.lightbulb_rounded,
                      color: Colors.amber,
                      size: 48,
                      shadows: [
                        Shadow(color: Colors.amberAccent, blurRadius: 15),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Aprimore Sua Matemática Básica',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 32),

              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calculate_outlined),
                          const SizedBox(width: 8),
                          Text(
                            '4 Operações',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      _OperationCard(
                        icon: Icons.add,
                        operation: Operation.addition,
                      ),

                      const SizedBox(height: 16),

                      _OperationCard(
                        icon: Icons.remove,
                        operation: Operation.subtraction,
                      ),

                      const SizedBox(height: 16),

                      _OperationCard(
                        icon: Icons.close,
                        operation: Operation.multiplication,
                      ),

                      const SizedBox(height: 16),

                      _OperationCard(
                        icon: Icons.percent,
                        operation: Operation.division,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OperationCard extends StatelessWidget {
  final IconData icon;
  final Operation operation;

  const _OperationCard({required this.icon, required this.operation});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            context.push('/exercises/config', extra: operation);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48),
              const SizedBox(height: 12),

              Text(
                operation.name,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
