
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../../domain/entities/flashcard_models.dart';
import '../../../../infrastructure/repositories/flashcard_repository.dart';

class CreateFlashcardSetPage extends StatefulWidget {
  const CreateFlashcardSetPage({super.key});

  @override
  State<CreateFlashcardSetPage> createState() => _CreateFlashcardSetPageState();
}

class _CreateFlashcardSetPageState extends State<CreateFlashcardSetPage> {
  final _titleController = TextEditingController();
  final List<TextEditingController> _frontControllers = [];
  final List<TextEditingController> _backControllers = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _addCardField(); // Start with one card
  }

  void _addCardField() {
    setState(() {
      _frontControllers.add(TextEditingController());
      _backControllers.add(TextEditingController());
    });
  }

  void _removeCardField(int index) {
    setState(() {
      _frontControllers.removeAt(index);
      _backControllers.removeAt(index);
    });
  }

  Future<void> _saveSet() async {
    if (!_formKey.currentState!.validate()) return;
    if (_frontControllers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one card')),
      );
      return;
    }

    final cards = <Flashcard>[];
    for (int i = 0; i < _frontControllers.length; i++) {
        cards.add(Flashcard(
          id: const Uuid().v4(),
          front: _frontControllers[i].text,
          back: _backControllers[i].text,
        ));
    }

    final newSet = FlashcardSet(
      id: const Uuid().v4(),
      title: _titleController.text,
      cards: cards,
    );

    await FlashcardRepository().saveFlashcardSet(newSet);

    if (mounted) {
      Navigator.pop(context, true); // Return true to refresh list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Set'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveSet,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Set Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter a title' : null,
            ),
            const SizedBox(height: 20),
            ...List.generate(_frontControllers.length, (index) {
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Card ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeCardField(index),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _frontControllers[index],
                        decoration: const InputDecoration(labelText: 'Front (Term)'),
                        validator: (value) => value!.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _backControllers[index],
                        decoration: const InputDecoration(labelText: 'Back (Definition)'),
                        validator: (value) => value!.isEmpty ? 'Required' : null,
                      ),
                    ],
                  ),
                ),
              );
            }),
            ElevatedButton.icon(
              onPressed: _addCardField,
              icon: const Icon(Icons.add),
              label: const Text('Add Card'),
            ),
             const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
