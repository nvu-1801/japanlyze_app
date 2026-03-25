import 'package:japalyze/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../domain/entities/flashcard_models.dart';
import '../../../../data/repositories/flashcard_repository.dart';
import '../../../../data/services/isar_service.dart';
import '../../../pages/lesson/srs_flashcard_page.dart';

class SRSDashboardWidget extends StatefulWidget {
  const SRSDashboardWidget({super.key});

  @override
  State<SRSDashboardWidget> createState() => _SRSDashboardWidgetState();
}

class _SRSDashboardWidgetState extends State<SRSDashboardWidget> {
  late FlashcardRepository _repository;
  Map<FlashcardRating, int> _counts = {
    FlashcardRating.hard: 0,
    FlashcardRating.good: 0,
    FlashcardRating.easy: 0,
  };
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _repository = FlashcardRepository(IsarService.instance.isar);
    _loadCounts();
  }

  Future<void> _loadCounts() async {
    final counts = await _repository.getSRSBucketCounts();
    if (mounted) {
      setState(() {
        _counts = counts;
        _isLoading = false;
      });
    }
  }

  void _onBucketTap(FlashcardRating rating) async {
    final cards = await _repository.getFlashcardsByRating(rating);
    if (cards.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không có thẻ nào trong mục này!')),
      );
      return;
    }

    if (!mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SRSFlashcardPage(
          title: rating == FlashcardRating.hard
              ? 'Thẻ Khó'
              : rating == FlashcardRating.good
              ? 'Thẻ Tốt'
              : 'Thẻ Dễ',
          initialCards: cards,
          onProgressUpdated: _loadCounts,
        ),
      ),
    );
    _loadCounts();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? const Color(0xFF1a2632) : Colors.white;
    final outline = isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Học Tập SRS',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: outline.withValues(alpha: 0.5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  _buildCompactBucket(
                    label: 'Khó',
                    count: _counts[FlashcardRating.hard] ?? 0,
                    color: Colors.red,
                    isDark: isDark,
                    onTap: () => _onBucketTap(FlashcardRating.hard),
                    isFirst: true,
                  ),
                  _buildDivider(outline),
                  _buildCompactBucket(
                    label: 'Tốt',
                    count: _counts[FlashcardRating.good] ?? 0,
                    color: AppColors.primary,
                    isDark: isDark,
                    onTap: () => _onBucketTap(FlashcardRating.good),
                  ),
                  _buildDivider(outline),
                  _buildCompactBucket(
                    label: 'Dễ',
                    count: _counts[FlashcardRating.easy] ?? 0,
                    color: Colors.green,
                    isDark: isDark,
                    onTap: () => _onBucketTap(FlashcardRating.easy),
                    isLast: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(Color color) {
    return Container(width: 1, height: 32, color: color.withValues(alpha: 0.2));
  }

  Widget _buildCompactBucket({
    required String label,
    required int count,
    required Color color,
    required bool isDark,
    required VoidCallback onTap,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            onTap();
          },
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(isFirst ? 16 : 0),
            right: Radius.circular(isLast ? 16 : 0),
          ),
          splashColor: color.withValues(alpha: 0.1),
          highlightColor: color.withValues(alpha: 0.05),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: color.withValues(alpha: 0.8),
                  width: 3,
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$count',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: isDark ? Colors.white60 : Colors.black45,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
