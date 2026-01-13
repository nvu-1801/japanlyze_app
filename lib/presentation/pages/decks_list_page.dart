import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../domain/entities/deck.dart';
import '../widgets/widgets.dart';

/// Page displaying list of flashcard decks
class DecksListPage extends StatelessWidget {
  const DecksListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with BlocBuilder
    final mockDecks = [
      Deck(
        id: 1,
        title: 'Hiragana',
        description: 'Basic Japanese characters',
        userId: 1,
        cardCount: 46,
        dueCount: 12,
        createdAt: DateTime.now(),
      ),
      Deck(
        id: 2,
        title: 'Katakana',
        description: 'Japanese syllabary for foreign words',
        userId: 1,
        cardCount: 46,
        dueCount: 8,
        createdAt: DateTime.now(),
      ),
      Deck(
        id: 3,
        title: 'JLPT N5 Vocabulary',
        description: 'Essential words for JLPT N5',
        userId: 1,
        cardCount: 800,
        dueCount: 45,
        createdAt: DateTime.now(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Decks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Search decks
            },
          ),
        ],
      ),
      body: mockDecks.isEmpty
          ? EmptyState(
              icon: Icons.style_outlined,
              title: 'No Decks Yet',
              subtitle: 'Create your first flashcard deck to start learning!',
              buttonText: 'Create Deck',
              onButtonPressed: () => _showCreateDeckDialog(context),
            )
          : RefreshIndicator(
              onRefresh: () async {
                // TODO: Refresh decks
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mockDecks.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _DeckCard(deck: mockDecks[index]),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDeckDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateDeckDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create New Deck',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Deck Title',
                  hintText: 'e.g., JLPT N5 Vocabulary',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  hintText: 'Add a description...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Create deck
                        Navigator.of(context).pop();
                      },
                      child: const Text('Create'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DeckCard extends StatelessWidget {
  final Deck deck;

  const _DeckCard({required this.deck});

  @override
  Widget build(BuildContext context) {
    final hasDueCards = deck.dueCount > 0;

    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to deck detail
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: hasDueCards
                ? Border.all(color: AppColors.primary.withValues(alpha: 0.3))
                : null,
          ),
          child: Row(
            children: [
              // Deck icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.style,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              // Deck info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deck.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (deck.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        deck.description!,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _InfoChip(
                          icon: Icons.credit_card,
                          label: '${deck.cardCount} cards',
                        ),
                        if (hasDueCards) ...[
                          const SizedBox(width: 12),
                          _InfoChip(
                            icon: Icons.schedule,
                            label: '${deck.dueCount} due',
                            color: AppColors.warning,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              // Study button
              if (hasDueCards)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Study',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const _InfoChip({required this.icon, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final chipColor = color ?? Colors.grey[600]!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: chipColor),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12, color: chipColor)),
      ],
    );
  }
}
