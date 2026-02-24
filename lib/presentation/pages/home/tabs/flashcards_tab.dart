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
    
    // Sort sets: incomplete (< 100%) first, completed (100%) last
    sets.sort((a, b) {
      final aProgress = a.cards.isEmpty ? 0.0 : a.studiedCount / a.cards.length;
      final bProgress = b.cards.isEmpty ? 0.0 : b.studiedCount / b.cards.length;
      
      final aCompleted = aProgress >= 1.0;
      final bCompleted = bProgress >= 1.0;
      
      // If one is completed and the other isn't, incomplete comes first
      if (aCompleted != bCompleted) {
        return aCompleted ? 1 : -1;
      }
      
      // If both have same completion status, sort by progress (ascending for incomplete, descending for complete)
      return aProgress.compareTo(bProgress);
    });
    
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

  Future<void> _generateDefaultFlashcards() async {
    setState(() => _isLoading = true);
    try {
      await FlashcardRepository().initializeDefaultFlashcards();
      await _loadSets();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Đã tạo flashcards mặc định từ vocab data!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            toolbarHeight: 70,
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary.withOpacity(0.8), AppColors.secondary.withOpacity(0.8)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.style_rounded, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Flashcards',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    fontSize: 22,
                  ),
                ),
              ],
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
                IconButton(
                  icon: const Icon(Icons.add_rounded, color: Colors.green),
                  onPressed: _createSet,
                  tooltip: 'Tạo Set mới',
                ),
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
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primary.withOpacity(0.1), AppColors.secondary.withOpacity(0.1)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.style_outlined, size: 56, color: AppColors.primary),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Chưa có Flashcard nào',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Bắt đầu học ngay với flashcards có sẵn\nhoặc tự tạo bộ flashcard của riêng bạn',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.secondary],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: _generateDefaultFlashcards,
                        icon: const Icon(Icons.auto_awesome, size: 22),
                        label: const Text(
                          'Tạo Flashcards mặc định',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton.icon(
                      onPressed: _createSet,
                      icon: const Icon(Icons.add, size: 20),
                      label: const Text(
                        'Hoặc tạo Set mới',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
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
                    final isCompleted = set.cards.isNotEmpty && (set.studiedCount / set.cards.length) >= 1.0;
                    
                    // Show "Completed" section header
                    final showCompletedHeader = index > 0 && 
                        !(_flashcardSets[index - 1].cards.isNotEmpty && 
                          (_flashcardSets[index - 1].studiedCount / _flashcardSets[index - 1].cards.length) >= 1.0) &&
                        isCompleted;
                    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (showCompletedHeader) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.green.withOpacity(0.05),
                                    Colors.blue.withOpacity(0.05),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.green.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Đã hoàn thành',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        _DeckCard(
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
                        ),
                      ],
                    );
                  },
                  childCount: _flashcardSets.length,
                ),
              ),
            ),
             const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: _flashcardSets.isNotEmpty && !_isSelectionMode
          ? FloatingActionButton(
              onPressed: _createSet,
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add_rounded, color: Colors.white),
            )
          : null,
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
                ? Border.all(color: AppColors.primary, width: 2.5)
                : Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
            boxShadow: [
              BoxShadow(
                color: widget.isSelected 
                    ? AppColors.primary.withOpacity(0.15)
                    : Colors.black.withOpacity(0.03),
                blurRadius: widget.isSelected ? 16 : 12,
                offset: const Offset(0, 4),
                spreadRadius: widget.isSelected ? 1 : 0,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
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
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          color.withOpacity(0.15),
                          color.withOpacity(0.08),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: color.withOpacity(0.2),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(Icons.style_rounded, color: color, size: 32),
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
                            fontSize: 17,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.layers, size: 14, color: Colors.grey[500]),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.set.cards.length} cards',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (!widget.isSelectionMode)
                   Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: color,
                      size: 16,
                    ),
                  ),
                ],
              ),
              if (widget.set.cards.isNotEmpty) ...[
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.school, size: 14, color: Colors.grey[500]),
                        const SizedBox(width: 6),
                        Text(
                          'Learning Progress',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withOpacity(0.15),
                            color.withOpacity(0.08),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${(widget.set.studiedCount / widget.set.cards.length * 100).toInt()}%',
                        style: TextStyle(
                          color: color,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Stack(
                    children: [
                      Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: widget.set.studiedCount / widget.set.cards.length,
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [color, color.withOpacity(0.7)],
                            ),
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: color.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
