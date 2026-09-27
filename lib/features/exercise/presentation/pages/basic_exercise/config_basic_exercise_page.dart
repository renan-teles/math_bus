import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:math_bus/features/exercise/domain/exercise/random_operand_generator.dart';

import '../../../domain/exercise/exercise_config.dart';
import '../../../domain/exercise/basic/operation.dart';

class ConfigExercisePage extends StatefulWidget {
  final Operation operation;

  const ConfigExercisePage({super.key, required this.operation});

  @override
  State<ConfigExercisePage> createState() => _ConfigExercisePageState();
}

class _ConfigExercisePageState extends State<ConfigExercisePage> {
  final _formKey = GlobalKey<FormState>();

  final _questionsController = TextEditingController();
  final _minOperandController = TextEditingController();
  final _maxOperandController = TextEditingController();
  final _operandsController = TextEditingController();

  @override
  void dispose() {
    _questionsController.dispose();
    _minOperandController.dispose();
    _maxOperandController.dispose();
    _operandsController.dispose();

    super.dispose();
  }

  void _startExercise() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final config = ExerciseConfig(
      questionsQuantity: int.parse(_questionsController.text),
      minOperand: int.parse(_minOperandController.text),
      maxOperand: int.parse(_maxOperandController.text),
      operandsQuantity: int.parse(_operandsController.text),
      operation: widget.operation,
    );

    context.push('/exercises/basic', extra: config);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configurar ${widget.operation.name}')),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(Icons.settings),
                    const SizedBox(width: 8),
                    Text(
                      'Configurar exercício',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  'Defina como você deseja realizar o exercício.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                const SizedBox(height: 32),

                _buildNumberField(
                  controller: _questionsController,
                  label: 'Quantidade de questões',
                  hint: 'Ex.: 10',
                  validator: _validateQuestionsQuantity,
                ),
                const SizedBox(height: 16),

                _buildNumberField(
                  controller: _operandsController,
                  label: 'Quantidade de operandos',
                  hint: 'Ex.: 2',
                  validator: _validateNumbersQuantity,
                ),
                const SizedBox(height: 16),

                _buildNumberField(
                  controller: _minOperandController,
                  label: 'Menor operando',
                  hint: 'Ex.: 1',
                  validator: _validateOperand,
                ),
                const SizedBox(height: 16),

                _buildNumberField(
                  controller: _maxOperandController,
                  label: 'Maior operando',
                  hint: 'Ex.: 10',
                  validator: _validateOperand,
                ),
                const SizedBox(height: 24),

                FilledButton.icon(
                  icon: Icon(Icons.play_arrow),
                  onPressed: _startExercise,
                  label: const Text('Iniciar Exercício'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNumberField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,

      keyboardType: TextInputType.number,
      autovalidateMode: AutovalidateMode.onUserInteraction,

      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),

      validator: validator,
    );
  }

  String? _validateQuestionsQuantity(String? value) {
    final quantity = _parseInt(value);
    if (quantity == null) {
      return 'Digite um número inteiro válido.';
    }

    if (quantity < 1) {
      return 'O valor não deve ser menor que 1.';
    }
    if (quantity > 30) {
      return 'O valor não deve ser maior que 30.';
    }

    return null;
  }

  String? _validateNumbersQuantity(String? value) {
    final quantity = _parseInt(value);
    if (quantity == null) {
      return 'Digite um número inteiro válido.';
    }

    if (quantity <= 1) {
      return 'O valor deve ser maior que 1.';
    }
    if (quantity > 4) {
      return 'O valor não deve ser maior que 4.';
    }

    return null;
  }

  String? _validateOperand(String? value) {
    final number = _parseInt(value);
    if (number == null) {
      return 'Digite um número inteiro válido.';
    }

    if (number < RandomOperandGenerator.minOperand) {
      return 'O valor não deve ser menor que ${RandomOperandGenerator.minOperand}.';
    }

    if (number > RandomOperandGenerator.maxOperand) {
      return 'O valor não deve ser maior que ${RandomOperandGenerator.maxOperand}.';
    }

    return null;
  }

  int? _parseInt(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final number = int.tryParse(value);
    if (number == null) {
      return null;
    }

    return number;
  }
}
