import 'package:flutter/material.dart';

void showExerciseFeedback({
  required BuildContext context,
  required String message,
  required bool isCorrect,
}) {
  final messenger = ScaffoldMessenger.of(context);

  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        content: Row(
          children: [
            Icon(
              isCorrect ? Icons.check_circle_outline : Icons.error_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: messenger.hideCurrentSnackBar,
              icon: const Icon(Icons.close, color: Colors.white),
              tooltip: 'Fechar',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
}
