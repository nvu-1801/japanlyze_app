import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entities/flashcard_models.dart';
import '../../../../infrastructure/repositories/flashcard_repository.dart';
import '../../flashcards/create_flashcard_set_page.dart';
import '../../flashcards/study_flashcard_page.dart';

/// Flashcards tab with local storage support
class FlashcardsTab extends StatefulWidget {
  const FlashcardsTab({super.key});

  @override
  State<FlashcardsTab> createState() => _FlashcardsTabState();
}

class _FlashcardsTabState extends State<FlashcardsTab> {
  List<FlashcardSet> _flashcardSets = [];
  bool _isLoading = true;
  bool _isSelectionMode = false;
  final Set<String> _selectedSetIds = {};

  @override
  void initState() {
    super.initState();
    _loadSets();
  }

  Future<void> _loadSets() async {
    setState(() => _isLoading = true);
    final sets = await FlashcardRepository().getFlashcardSets();
    setState(() {
      _flashcardSets = sets;
      _isLoading = false;
    });
  }

  Future<void> _createSet() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateFlashcardSetPage()),
    );
    if (result == true) {
      _loadSets();
    }
  }

  void _toggleSelectionMode() {
    setState(() {
      _isSelectionMode = !_isSelectionMode;
      _selectedSetIds.clear();
    });
  }

  void _toggleSetSelection(String id) {
    setState(() {
      if (_selectedSetIds.contains(id)) {
        _selectedSetIds.remove(id);
      } else {
        _selectedSetIds.add(id);
      }
    });
  }

  Future<void> _deleteSelectedSets() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Selected Sets?'),
        content: Text('Delete ${_selectedSetIds.length} sets? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      for (final id in _selectedSetIds) {
        await FlashcardRepository().deleteFlashcardSet(id);
      }
      _toggleSelectionMode(); // Exit selection mode
      _loadSets();
    }
  }

  Future<void> _deleteSet(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Set?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm == true) {
      await FlashcardRepository().deleteFlashcardSet(id);
      _loadSets();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            floating: true,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: const Text(
              'Flashcards',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            actions: [
              if (_isSelectionMode) ...[
                TextButton(
                  onPressed: _toggleSelectionMode,
                  child: const Text('Cancel', style: TextStyle(fontSize: 16)),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: _selectedSetIds.isEmpty ? null : _deleteSelectedSets,
                ),
              ] else ...[
                 TextButton(
                  onPressed: _toggleSelectionMode,
                  child: const Text('Select', style: TextStyle(fontSize: 16)),
                ),
                IconButton(icon: const Icon(Icons.add_rounded), onPressed: _createSet),
              ],
            ],
          ),
          if (_isLoading)
            const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
          else if (_flashcardSets.isEmpty)
             SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.style_outlined, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text('No flashcard sets yet', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _createSet,
                      icon: const Icon(Icons.add),
                      label: const Text('Create Set'),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final set = _flashcardSets[index];
                    final isSelected = _selectedSetIds.contains(set.id);
                    return _DeckCard(
                      set: set,
                      isSelectionMode: _isSelectionMode,
                      isSelected: isSelected,
                      onSelectionChanged: (value) => _toggleSetSelection(set.id),
                      onTap: () {
                        if (_isSelectionMode) {
                           _toggleSetSelection(set.id);
                        } else {
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => StudyFlashcardPage(flashcardSet: set)),
                          ).then((result) {
                             if (result == true) _loadSets();
                          });
                        }
                      },
                      onLongPress: () {
                         if (!_isSelectionMode) {
                            _toggleSelectionMode();
                            _toggleSetSelection(set.id);
                         }
                      },
                    );
                  },
                  childCount: _flashcardSets.length,
                ),
              ),
            ),
             const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class _DeckCard extends StatefulWidget {
  final FlashcardSet set;
  final bool isSelectionMode;
  final bool isSelected;
  final ValueChanged<bool?>? onSelectionChanged;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _DeckCard({
    required this.set,
    required this.isSelectionMode,
    required this.isSelected,
    this.onSelectionChanged,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  State<_DeckCard> createState() => _DeckCardState();
}

class _DeckCardState extends State<_DeckCard> {
  bool _isPressed = false;

  Color _getRandomColor(String id) {
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.info,
      Colors.orange,
      Colors.purple,
      Colors.teal,
    ];
    return colors[id.hashCode % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final color = _getRandomColor(widget.set.id);
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        HapticFeedback.lightImpact();
        widget.onTap();
      },
      onLongPress: () {
        HapticFeedback.mediumImpact();
        widget.onLongPress();
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            border: widget.isSelected
                ? Border.all(color: AppColors.primary, width: 2)
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                   if (widget.isSelectionMode) ...[
                      Checkbox(
                        value: widget.isSelected,
                        onChanged: widget.onSelectionChanged,
                        activeColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                      const SizedBox(width: 8),
                   ],
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(Icons.style_rounded, color: color, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.set.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${widget.set.cards.length} cards',
                          style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (!widget.isSelectionMode)
                   Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey[400],
                    size: 16,
                  ),
                ],
              ),
              if (widget.set.cards.isNotEmpty) ...[
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Learning Progress',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${(widget.set.studiedCount / widget.set.cards.length * 100).toInt()}%',
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: widget.set.studiedCount / widget.set.cards.length,
                    backgroundColor: color.withOpacity(0.1),
                    valueColor: AlwaysStoppedAnimation(color),
                    minHeight: 6,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
