import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:math_bus/features/exercise/domain/exercise/answer_validator.dart';
import 'package:math_bus/features/exercise/domain/exercise/basic/basic_exercise_service.dart';
import 'package:math_bus/features/exercise/domain/exercise/basic/basic_expression_formatter.dart';
import 'package:math_bus/features/exercise/domain/exercise/basic/basic_operation_exercise.dart';
import 'package:math_bus/features/exercise/domain/exercise/exercise_config.dart';
import 'package:math_bus/features/exercise/domain/exercise/basic/operation_calculator.dart';
import 'package:math_bus/features/exercise/domain/exercise/random_operand_generator.dart';
import 'package:math_bus/features/scratchpad/presentation/widgets/scratchpad_button.dart';
import 'package:math_bus/shared/presentation/feedback/exercise_feedback_service.dart';

class BasicExercisePage extends StatefulWidget {
  final ExerciseConfig config;

  const BasicExercisePage({super.key, required this.config});

  @override
  State<BasicExercisePage> createState() => _BasicExercisePageState();
}

class _BasicExercisePageState extends State<BasicExercisePage> {
  late final BasicExerciseService _service;
  final _answerController = TextEditingController();

  int _currentQuestion = 1;
  bool _isGeneratingExercise = false;
  bool _isFinished = false;
  String? _generationError;

  @override
  void initState() {
    super.initState();

    _service = _createService();
    _service.setConfig(widget.config);

    _generateExercise();
  }

  @override
  void dispose() {
    _answerController.dispose();

    super.dispose();
  }

  BasicExerciseService _createService() {
    final exercise = BasicOperationExercise(
      calculator: OperationCalculator(),
      generator: RandomOperandGenerator(random: Random()),
      operation: widget.config.operation,
    );

    return BasicExerciseService(
      exercise: exercise,
      answerValidator: AnswerValidator(),
      expressionFormatter: BasicExpressionFormatter(),
    );
  }

  void _generateExercise() {
    setState(() {
      _isGeneratingExercise = true;
      _generationError = null;
    });

    final generated = _service.next();
    if (!mounted) return;

    setState(() {
      _isGeneratingExercise = false;
      if (!generated) {
        _generationError = 'Não foi possível gerar a questão. Tente novamente.';
      }
    });
  }

  void _checkAnswer() {
    if (_isGeneratingExercise || _isFinished || _generationError != null) {
      return;
    }

    final answer = double.tryParse(_answerController.text.replaceAll(',', '.'));
    if (answer == null) {
      showExerciseFeedback(
        context: context,
        message: 'Digite uma resposta válida.',
        isCorrect: false,
      );
      return;
    }

    final correct = _service.checkAnswer(answer);
    if (correct) {
      showExerciseFeedback(
        context: context,
        message: 'Resposta correta!',
        isCorrect: true,
      );
      _goToNextQuestion();
      return;
    }

    showExerciseFeedback(
      context: context,
      message: 'Resposta incorreta!',
      isCorrect: false,
    );
  }

  void _goToNextQuestion() {
    if (_currentQuestion >= widget.config.questionsQuantity) {
      _finishExercise();
      return;
    }

    _answerController.clear();
    final generated = _service.next();
    if (!generated) {
      setState(() {
        _generationError =
            'Não foi possível gerar a próxima questão. Tente novamente.';
      });
      return;
    }

    setState(() {
      _currentQuestion++;
      _generationError = null;
    });
  }

  void _finishExercise() {
    setState(() {
      _isFinished = true;
    });
  }

  void _restartExercise() {
    _answerController.clear();

    setState(() {
      _currentQuestion = 1;
      _isFinished = false;
      _isGeneratingExercise = true;
      _generationError = null;
    });

    final generated = _service.next();
    if (!mounted) return;

    setState(() {
      _isGeneratingExercise = false;
      if (!generated) {
        _generationError = 'Não foi possível gerar a questão. Tente novamente.';
      }
    });

    ScaffoldMessenger.of(context).clearSnackBars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercício')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isFinished) return _buildFinished();
    if (_isGeneratingExercise) return _buildLoading();
    if (_generationError != null) return _buildGenerationError();
    return _buildExercise();
  }

  Widget _buildLoading() {
    return SizedBox(
      height: 500,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 24),
            Text(
              'Gerando questão...',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenerationError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64),
          const SizedBox(height: 24),

          Text(
            'Não foi possível gerar a questão.',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          Text(_generationError!, textAlign: TextAlign.center),
          const SizedBox(height: 24),

          ElevatedButton(
            onPressed: _generateExercise,
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }

  Widget _buildExercise() {
    return Column(
      children: [
        _buildHeader(),
        const SizedBox(height: 16),

        _buildProgress(),
        const SizedBox(height: 40),

        _buildOperation(),
        const SizedBox(height: 24),

        _buildExpression(),
        const SizedBox(height: 32),

        _buildAnswerInput(),
        const SizedBox(height: 16),

        _buildVerifyButton(),
        const SizedBox(height: 12),

        _buildClearAnswerButton(),
        const SizedBox(height: 24),

        const ScratchpadButton(),
      ],
    );
  }

  Widget _buildFinished() {
    return SizedBox(
      height: 500,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, size: 80),
            const SizedBox(height: 24),

            Text(
              'Exercício concluído!',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            const Text(
              'Você respondeu todas as questões.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _restartExercise,
                icon: const Icon(Icons.refresh),
                label: const Text('Refazer exercício'),
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  context.go('/');
                },
                icon: const Icon(Icons.home_outlined),
                label: const Text('Voltar ao início'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Questão: $_currentQuestion',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          'Total: ${widget.config.questionsQuantity}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  Widget _buildProgress() {
    final progress = (_currentQuestion - 1) / widget.config.questionsQuantity;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 10,
        backgroundColor: Colors.grey.shade200,
        valueColor: const AlwaysStoppedAnimation(Colors.green),
      ),
    );
  }

  Widget _buildOperation() {
    return Text(
      widget.config.operation.name,
      style: Theme.of(
        context,
      ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildExpression() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.sizeOf(context).width - 48,
        ),
        child: Text(
          _service.getFormattedExpression(),
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildAnswerInput() {
    return TextField(
      controller: _answerController,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: true,
      ),
      textAlign: TextAlign.center,
      decoration: const InputDecoration(
        hintText: 'Digite o resultado...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      onSubmitted: (_) => _checkAnswer(),
    );
  }

  Widget _buildVerifyButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(foregroundColor: Colors.green),
        onPressed: _checkAnswer,
        label: const Text('Verificar'),
        icon: const Icon(Icons.check_circle_outline),
      ),
    );
  }

  Widget _buildClearAnswerButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        label: const Text('Limpar'),
        style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
        onPressed: () {
          _answerController.clear();
        },
        icon: const Icon(Icons.delete_outlined),
      ),
    );
  }
}
