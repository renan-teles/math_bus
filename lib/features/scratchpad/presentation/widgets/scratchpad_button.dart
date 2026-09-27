import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class ScratchpadButton extends StatelessWidget {
  const ScratchpadButton({super.key});

  void _openScratchpad(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const _ScratchpadSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => _openScratchpad(context),
      icon: const Icon(Icons.draw_outlined),
      label: const Text('Rascunho'),
    );
  }
}

class _ScratchpadSheet extends StatefulWidget {
  const _ScratchpadSheet();

  @override
  State<_ScratchpadSheet> createState() => _ScratchpadSheetState();
}

class _ScratchpadSheetState extends State<_ScratchpadSheet> {
  late final SignatureController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SignatureController(penStrokeWidth: 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.50,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: Column(
              children: [
                _buildTitle(context),
                const SizedBox(height: 20),
                _buildCanvas(),
                const SizedBox(height: 8),
                _buildClearButton(),
                const SizedBox(height: 16),
                _buildCloseButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Rascunho',
      style: Theme.of(
        context,
      ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCanvas() {
    return SizedBox(
      height: 430,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Signature(
            controller: _controller,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: _controller.clear,
        icon: const Icon(Icons.delete_outline),
        label: const Text('Limpar'),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Fechar'),
      ),
    );
  }
}
