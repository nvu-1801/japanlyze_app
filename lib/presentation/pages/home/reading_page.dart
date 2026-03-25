import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import '../../../core/constants/app_colors.dart';
import '../../../domain/entities/reading_article.dart';
import '../../../data/datasources/remote/exam_remote_datasource.dart';
import '../../../injection_container.dart';

/// Colors per JLPT level (shared with exam_tab)
const Map<String, Color> _levelColors = {
  'beginner': Color(0xFF22c55e),
  'n5': Color(0xFF22c55e),
  'n4': Color(0xFFa855f7),
  'n3': Color(0xFF3b82f6),
  'n2': Color(0xFFf97316),
  'n1': Color(0xFFef4444),
};

Color _levelColor(String level) =>
    _levelColors[level.toLowerCase()] ?? AppColors.primary;

class ReadingTitle {
  final String japanese;
  final String? vietnamese;

  ReadingTitle({required this.japanese, this.vietnamese});

  static ReadingTitle parse(String title) {
    if (title.contains(' – ')) {
      final parts = title.split(' – ');
      return ReadingTitle(
        japanese: parts[0].trim(),
        vietnamese: parts[1].trim(),
      );
    }
    return ReadingTitle(japanese: title);
  }
}

// ---------------------------------------------------------------------------
//  ReadingPage – article list
// ---------------------------------------------------------------------------
class ReadingPage extends StatefulWidget {
  const ReadingPage({super.key});

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  final _ds = sl<ExamRemoteDataSource>();
  List<ReadingArticle> _articles = [];
  bool _loading = true;
  String? _error;
  String _selectedLevel = 'all';
  static const _levels = [
    {'id': 'all', 'label': 'Tất cả'},
    {'id': 'beginner', 'label': 'Beginner'},
    {'id': 'n5', 'label': 'N5'},
    {'id': 'n4', 'label': 'N4'},
    {'id': 'n3', 'label': 'N3'},
    {'id': 'n2', 'label': 'N2'},
    {'id': 'n1', 'label': 'N1'},
  ];

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    try {
      final data = await _ds.getReadingArticles();
      if (mounted) {
        setState(() {
          _articles = data;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  List<ReadingArticle> get _filtered {
    return _articles.where((a) {
      final matchLevel =
          _selectedLevel == 'all' || a.level.toLowerCase() == _selectedLevel;
      return matchLevel;
    }).toList();
  }

  final Map<String, Color> _levelColors = {
    'Beginner': const Color(0xFF10B981),
    'N5': const Color(0xFF22C55E),
    'N4': const Color(0xFFA855F7),
    'N3': const Color(0xFF3B82F6),
    'N2': const Color(0xFFF97316),
    'N1': const Color(0xFFEF4444),
  };

  void _showLevelSelection() {
    Set<String> localSelected = {};

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Container(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chọn trình độ',
                    style: GoogleFonts.lexend(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setSheetState(() {
                        if (localSelected.length == _levelColors.length) {
                          localSelected.clear();
                        } else {
                          localSelected = _levelColors.keys.toSet();
                        }
                      });
                    },
                    child: Text(
                      localSelected.length == _levelColors.length
                          ? 'Bỏ chọn tất cả'
                          : 'Chọn tất cả',
                      style: GoogleFonts.lexend(fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Chọn một hoặc nhiều trình độ để bắt đầu thử thách.',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _levelColors.entries.map((entry) {
                  final isSelected = localSelected.contains(entry.key);
                  return GestureDetector(
                    onTap: () {
                      setSheetState(() {
                        if (isSelected) {
                          localSelected.remove(entry.key);
                        } else {
                          localSelected.add(entry.key);
                        }
                      });
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 48 - 24) / 3,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? entry.value.withValues(alpha: 0.2)
                            : entry.value.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? entry.value
                              : entry.value.withValues(alpha: 0.2),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: entry.value,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            entry.key,
                            style: GoogleFonts.lexend(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: entry.value,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: localSelected.isEmpty
                      ? null
                      : () {
                          Navigator.pop(context);
                          _startChallenge(localSelected.toList());
                        },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Bắt đầu ôn luyện',
                    style: GoogleFonts.lexend(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startChallenge(List<String> selectedLevels) async {
    setState(() => _loading = true);
    try {
      List<ReadingArticle> randoms = await _ds.getRandomReadingArticles();

      if (selectedLevels.isNotEmpty) {
        final levelsSet = selectedLevels
            .map((l) => l.toUpperCase().trim())
            .toSet();
        randoms = randoms.where((a) {
          final l = a.level.toUpperCase().trim();
          return levelsSet.contains(l);
        }).toList();
      }

      if (!mounted) return;
      if (randoms.isNotEmpty) {
        final firstArticle = randoms[math.Random().nextInt(randoms.length)];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ReadingDetailPage(
              article: firstArticle,
              isChallenge: true,
              selectedLevels: selectedLevels,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Không tìm thấy bài đọc phù hợp cho các trình độ đã chọn',
              style: GoogleFonts.lexend(),
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Challenge error: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0F172A)
          : const Color(0xFFF8FAFC),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
            elevation: 0,
            expandedHeight: 70,
            title: Text(
              'Luyện đọc',
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColors.textPrimary,
                fontSize: 22,
              ),
            ),
            actions: [
              PopupMenuButton<String>(
                initialValue: _selectedLevel,
                onSelected: (level) => setState(() => _selectedLevel = level),
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white10
                        : Colors.black.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.filter_list_rounded,
                        size: 20,
                        color: isDark ? Colors.white : AppColors.textPrimary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _levels.firstWhere(
                              (l) => l['id'] == _selectedLevel,
                            )['label'] ??
                            '',
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                padding: EdgeInsets.zero,
                offset: const Offset(0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                itemBuilder: (context) => _levels.map((lvl) {
                  final id = lvl['id']!;
                  final color = id == 'all'
                      ? AppColors.primary
                      : _levelColor(id);
                  return PopupMenuItem<String>(
                    value: id,
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          lvl['label']!,
                          style: GoogleFonts.lexend(
                            fontWeight: _selectedLevel == id
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(width: 16),
            ],
          ),

          // Challenge Mode Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildChallengeHeader(),
            ),
          ),

          // Content
          if (_loading)
            const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            )
          else if (_error != null)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 48,
                      color: Colors.red[300],
                    ),
                    const SizedBox(height: 12),
                    Text('Không thể tải bài đọc', style: GoogleFonts.lexend()),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        setState(() {
                          _loading = true;
                          _error = null;
                        });
                        _fetch();
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: const Text('Thử lại'),
                    ),
                  ],
                ),
              ),
            )
          else if (_filtered.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Text(
                  'Không có bài đọc phù hợp.',
                  style: GoogleFonts.lexend(color: Colors.grey),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => _ArticleCard(
                    article: _filtered[i],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ReadingDetailPage(article: _filtered[i]),
                      ),
                    ),
                  ),
                  childCount: _filtered.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildChallengeHeader() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _showLevelSelection,
        icon: const Icon(Icons.bolt_rounded),
        label: Text(
          'Luyện đọc nhanh',
          style: GoogleFonts.lexend(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final ReadingArticle article;
  final VoidCallback onTap;
  const _ArticleCard({required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = _levelColor(article.level);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark
                ? Colors.white10
                : Colors.black.withValues(alpha: 0.05),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              article.image != null && article.image!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        article.image!,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            _buildIconPlaceholder(color),
                      ),
                    )
                  : _buildIconPlaceholder(color),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            article.level.toUpperCase(),
                            style: TextStyle(
                              color: color,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (article.topic != null) ...[
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              article.topic!.split(' – ').first,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 10,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    Builder(
                      builder: (context) {
                        final parsed = ReadingTitle.parse(article.title);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              parsed.japanese,
                              style: GoogleFonts.notoSansJp(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (parsed.vietnamese != null)
                              Text(
                                parsed.vietnamese!,
                                style: GoogleFonts.lexend(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconPlaceholder(Color color) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(Icons.book_rounded, color: color, size: 28),
    );
  }
}

// ---------------------------------------------------------------------------
//  ReadingDetailPage – full article reader
// ---------------------------------------------------------------------------
class ReadingDetailPage extends StatefulWidget {
  final ReadingArticle article;
  final bool isChallenge;
  final List<String>? selectedLevels;
  const ReadingDetailPage({
    super.key,
    required this.article,
    this.isChallenge = false,
    this.selectedLevels,
  });

  @override
  State<ReadingDetailPage> createState() => _ReadingDetailPageState();
}

class _ReadingDetailPageState extends State<ReadingDetailPage> {
  final _ds = sl<ExamRemoteDataSource>();
  ReadingArticle? _currentArticle;
  ReadingArticle? _full;
  List<ReadingSegment> _challengeSegments = [];
  bool _loading = true;
  bool _fetchingNext = false;
  bool _showFurigana = true;
  bool _showRomaji = false;
  bool _showTranslation = false;
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  List<List<ReadingSegment>> _pages = [];

  // TTS
  final FlutterTts _tts = FlutterTts();
  bool _speaking = false;
  double _ttsRate = 0.5;

  // STT (Speech to Text)
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = false;
  bool _isEvaluating = false;
  String _lastWords = '';
  int? _score;
  String? _aiFeedback;
  String? _aiDetails;
  DateTime? _startTime;
  bool _isHolding = false; // Tracks if the user is holding the mic button

  // Visualizer simulation
  List<double> _audioBars = List.generate(20, (_) => 10.0);
  math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _currentArticle = widget.article;
    if (widget.isChallenge) {
      _fetchTrulyRandomSnippet();
    } else {
      _loadFull();
    }
    _initTTS();
    _initSTT();
  }

  void _initTTS() {
    _tts.setLanguage('ja-JP');
    _tts.setCompletionHandler(() {
      if (mounted) setState(() => _speaking = false);
    });
  }

  Future<void> _initSTT() async {
    try {
      _speechEnabled = await _speechToText.initialize(
        onStatus: (status) {
          debugPrint('STT Status: $status, isHolding: $_isHolding');

          // FIX 1 & Auto-Restart:
          if (status == 'done' || status == 'notListening') {
            if (_isHolding) {
              // Platform stopped prematurely but user still holding -> RESTART
              debugPrint('STT platform auto-stop detected, restarting...');
              _startListening(isAutoRestart: true);
            } else if (_isListening) {
              // Normal stop or timeout when not holding (e.g. initial timeout fix)
              _stopListening();
            } else {
              if (mounted) {
                setState(() => _isListening = false);
              }
            }
          }
        },
        onError: (e) => debugPrint('STT Error: $e'),
      );
      if (mounted) setState(() {});
    } catch (e) {
      debugPrint('STT Init Error: $e');
    }
  }

  @override
  void dispose() {
    _tts.stop();
    // FIX 2: Huỷ STT khi navigate ra ngoài để tránh chạy ngầm
    _speechToText.cancel();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadFull() async {
    if (_currentArticle == null) return;
    try {
      final data = await _ds.getReadingArticleDetail(_currentArticle!.id);
      if (mounted) {
        setState(() {
          _full = data;
          _loading = false;
          _preparePages();
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _full = _currentArticle;
          _loading = false;
          _preparePages();
        });
      }
    }
  }

  Future<void> _fetchTrulyRandomSnippet() async {
    setState(() => _loading = true);
    try {
      List<ReadingArticle> pool = await _ds.getRandomReadingArticles();
      if (widget.selectedLevels != null && widget.selectedLevels!.isNotEmpty) {
        final levels = widget.selectedLevels!
            .map((l) => l.trim().toUpperCase())
            .toSet();
        pool = pool.where((a) {
          final l = a.level.trim().toUpperCase();
          return levels.contains(l);
        }).toList();
      }

      if (!mounted) return;
      if (pool.isNotEmpty) {
        // Pick a truly random article from the pool
        final randomArticle = pool[_random.nextInt(pool.length)];
        final detail = await _ds.getReadingArticleDetail(randomArticle.id);
        final allSegments = _extractSegments(detail);

        // Take a random contiguous snippet of exactly 2 sentences
        List<ReadingSegment> snippet = [];
        if (allSegments.length > 2) {
          const snippetLen = 2;
          final maxStart = math.max(0, allSegments.length - snippetLen);
          final start = _random.nextInt(maxStart + 1);
          snippet = allSegments.sublist(
            start,
            math.min(start + snippetLen, allSegments.length),
          );
        } else {
          snippet = allSegments;
        }

        if (mounted) {
          setState(() {
            _currentArticle = detail;
            _challengeSegments = snippet;
            _loading = false;
            _preparePages();
          });
        }
      }
    } catch (e) {
      debugPrint('Error fetching random snippet: $e');
      if (mounted) {
        setState(() {
          _loading = false;
          _preparePages();
        });
      }
    }
  }

  List<ReadingSegment> _extractSegments(ReadingArticle article) {
    final content = article.content ?? '';
    final romajiContent = article.contentRomaji ?? '';
    final meaningContent = article.contentMeaning ?? '';

    if (content.isEmpty) return [];

    final sentencePattern = RegExp(r'[^。！？.!?]+[。！？.!?]*');
    final jpSentences = sentencePattern
        .allMatches(content)
        .map((m) => m.group(0)!.trim())
        .toList();
    final romajiSentences = sentencePattern
        .allMatches(romajiContent)
        .map((m) => m.group(0)!.trim())
        .toList();
    final meaningSentences = sentencePattern
        .allMatches(meaningContent)
        .map((m) => m.group(0)!.trim())
        .toList();

    List<ReadingSegment> segments = [];
    for (int i = 0; i < jpSentences.length; i++) {
      segments.add(
        ReadingSegment(
          japanese: jpSentences[i],
          romaji: i < romajiSentences.length ? romajiSentences[i] : null,
          meaning: i < meaningSentences.length ? meaningSentences[i] : null,
        ),
      );
    }
    return segments;
  }

  Future<void> _fetchNextRandomArticle() async {
    if (_fetchingNext) return;
    setState(() => _fetchingNext = true);
    try {
      if (widget.isChallenge) {
        // FIX 3: Reset _isEvaluating khi chuyển bài để tránh UI lock
        if (mounted) {
          setState(() {
            _isEvaluating = false;
            _isListening = false;
            _score = null;
            _aiFeedback = null;
            _aiDetails = null;
            _lastWords = '';
          });
        }
        await _fetchTrulyRandomSnippet();
      } else {
        final randoms = await _ds.getRandomReadingArticles();
        if (!mounted) return;
        if (randoms.isNotEmpty) {
          // Try to find a different article than the current one
          ReadingArticle next = randoms.first;
          if (next.id == _currentArticle?.id && randoms.length > 1) {
            next = randoms[1];
          }

          setState(() {
            _currentArticle = next;
            _loading = true;
            _full = null;
            _score = null;
            _aiFeedback = null;
            _aiDetails = null;
            _lastWords = '';
            // FIX 3: Reset evaluating state khi sang bài mới
            _isEvaluating = false;
            _isListening = false;
          });
          if (_pageController.hasClients) {
            _pageController.jumpToPage(0);
          }
          await _loadFull();
        }
      }
    } catch (e) {
      debugPrint('Error fetching next article: $e');
    } finally {
      if (mounted) setState(() => _fetchingNext = false);
    }
  }

  void _preparePages() {
    List<ReadingSegment> allSegments = [];

    if (widget.isChallenge) {
      allSegments = _challengeSegments;
    } else {
      final articleToUse = _full ?? _currentArticle;
      allSegments = _extractSegments(articleToUse ?? widget.article);
    }

    if (allSegments.isEmpty) {
      _pages = [];
      return;
    }

    // Paginate segments
    _pages = [];
    List<ReadingSegment> currentBatch = [];
    int currentCharCount = 0;
    const int maxCharsPerPage = 400;

    for (var segment in allSegments) {
      if ((currentCharCount + segment.japanese.length) > maxCharsPerPage &&
          currentBatch.isNotEmpty) {
        _pages.add(currentBatch);
        currentBatch = [];
        currentCharCount = 0;
      }
      currentBatch.add(segment);
      currentCharCount += segment.japanese.length;
    }

    if (currentBatch.isNotEmpty) {
      _pages.add(currentBatch);
    }
  }

  ReadingTitle _parseTitle(String title) => ReadingTitle.parse(title);

  String _stripFurigana(String text) => text.replaceAll(RegExp(r'\[.*?\]'), '');

  Future<void> _toggleTTS() async {
    if (_speaking) {
      await _tts.stop();
      setState(() => _speaking = false);
    } else {
      final segments = _pages[_pageController.page?.round() ?? 0];
      final text = segments
          .map((s) => _showFurigana ? s.japanese : _stripFurigana(s.japanese))
          .join(" ");

      await _tts.setSpeechRate(_ttsRate);
      await _tts.speak(text);
      setState(() => _speaking = true);
    }
  }

  void _startListening({bool isAutoRestart = false}) async {
    if (!_speechEnabled) return;
    if (!isAutoRestart) {
      setResult(null);
      setState(() {
        _lastWords = "";
        _isListening = true;
        _isHolding = true; // User started holding
        _startTime = DateTime.now();
      });
    } else {
      // On auto-restart, we just ensure _isListening is true but keep existing transcribed text
      if (mounted) {
        setState(() => _isListening = true);
      }
    }

    await _speechToText.listen(
      onResult: _onSpeechResult,
      localeId: 'ja-JP',
      listenFor: const Duration(hours: 1), // không giới hạn thực tế
      pauseFor: const Duration(hours: 1), // không tự dừng khi im lặng
    );
    _animateBars();
  }

  void setResult(dynamic r) {
    setState(() {
      _score = null;
      _aiFeedback = null;
      _aiDetails = null;
    });
  }

  void _stopListening() async {
    if (_isHolding) {
      setState(() => _isHolding = false); // User released the button
    }
    await _speechToText.stop();
    final durationMs = _startTime != null
        ? DateTime.now().difference(_startTime!).inMilliseconds
        : 0;

    setState(() {
      _isListening = false;
      _isEvaluating = true;
    });

    try {
      final segments = _pages[_pageController.page?.round() ?? 0];
      final target = segments.map((s) => _stripFurigana(s.japanese)).join(" ");

      final result = await _ds.evaluateReadingSpeech(
        transcribedText: _lastWords,
        originalText: target,
        durationMs: durationMs,
      );

      if (mounted) {
        setState(() {
          _score = result['score'] as int?;
          _aiFeedback = result['feedback'] as String?;
          _aiDetails = result['details'] as String?;
          _isEvaluating = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isEvaluating = false);
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      if (result.finalResult) {
        // _calculateScore(_lastWords); // Removed as evaluation is now done by AI
      }
    });
  }

  // Removed _calculateScore as we now use Gemini-powered evaluateReadingSpeech API

  void _animateBars() {
    if (!_isListening && !_speaking) {
      setState(() => _audioBars = List.generate(20, (_) => 10.0));
      return;
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted && (_isListening || _speaking)) {
        setState(() {
          _audioBars = List.generate(20, (_) => _random.nextDouble() * 30 + 10);
        });
        _animateBars();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final article = _full ?? _currentArticle ?? widget.article;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0F172A)
          : const Color(0xFFF8FAFC),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: isDark
                ? const Color(0xFF1E293B)
                : AppColors.primary,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [
                            const Color(0xFF1E293B).withValues(alpha: 0.8),
                            const Color(0xFF0F172A).withValues(alpha: 0.8),
                          ]
                        : [
                            AppColors.primary.withValues(alpha: 0.8),
                            AppColors.primaryDark.withValues(alpha: 0.8),
                          ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  image:
                      article.image != null &&
                          article.image!.isNotEmpty &&
                          !widget.isChallenge
                      ? DecorationImage(
                          image: NetworkImage(article.image!),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withValues(alpha: 0.4),
                            BlendMode.darken,
                          ),
                        )
                      : null,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 48),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.isChallenge
                              ? 'CHALLENGE'
                              : article.level.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Builder(
                        builder: (context) {
                          final parsed = _parseTitle(
                            widget.isChallenge
                                ? 'Thử thách ngẫu nhiên'
                                : article.title,
                          );
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              children: [
                                Text(
                                  parsed.japanese,
                                  style: GoogleFonts.notoSansJp(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (parsed.vietnamese != null)
                                  Text(
                                    parsed.vietnamese!,
                                    style: GoogleFonts.lexend(
                                      color: Colors.white.withValues(
                                        alpha: 0.9,
                                      ),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: _fetchingNext
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.shuffle_rounded, color: Colors.white),
                tooltip: 'Bài ngẫu nhiên khác',
                onPressed: _fetchNextRandomArticle,
              ),
              IconButton(
                icon: Icon(
                  _showFurigana
                      ? Icons.subtitles_rounded
                      : Icons.subtitles_off_rounded,
                  color: Colors.white,
                ),
                tooltip: 'Furigana',
                onPressed: () => setState(() => _showFurigana = !_showFurigana),
              ),
              IconButton(
                icon: Icon(
                  _showRomaji ? Icons.abc_rounded : Icons.abc_outlined,
                  color: Colors.white,
                ),
                tooltip: 'Romaji',
                onPressed: () => setState(() => _showRomaji = !_showRomaji),
              ),
              IconButton(
                icon: Icon(
                  _showTranslation
                      ? Icons.translate_rounded
                      : Icons.translate_outlined,
                  color: Colors.white,
                ),
                tooltip: 'Bản dịch',
                onPressed: () =>
                    setState(() => _showTranslation = !_showTranslation),
              ),
            ],
          ),
          SliverFillRemaining(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: _pages.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _buildReaderPage(index);
                        },
                      ),
                      // Top dynamic overlay for AI status (removed transcript)
                      if (_isEvaluating)
                        Positioned(
                          top: 0,
                          left: 20,
                          right: 20,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'AI đang chấm điểm...',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: _buildPageIndicator(),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomAction(),
    );
  }

  Widget _buildReaderPage(int index) {
    final segments = _pages[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...segments.map(
                    (segment) => Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Japanese sentence
                          Text(
                            _showFurigana
                                ? segment.japanese
                                : _stripFurigana(segment.japanese),
                            style: GoogleFonts.notoSansJp(
                              fontSize: 18,
                              height: 1.8,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                          // Interleaved Romaji
                          if (_showRomaji && segment.romaji != null) ...[
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(
                                  alpha: 0.05,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                ),
                              ),
                              child: Text(
                                segment.romaji!,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.blue[700],
                                  height: 1.4,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                          // Interleaved Translation
                          if (_showTranslation && segment.meaning != null) ...[
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.orange.withValues(alpha: 0.1),
                                ),
                              ),
                              child: Text(
                                segment.meaning!,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.orange[800],
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_score != null) ...[
              const SizedBox(height: 24),
              _buildScoreCard(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_pages.length, (index) {
        return ListenableBuilder(
          listenable: _pageController,
          builder: (context, _) {
            double page = 0;
            if (_pageController.hasClients) {
              page = _pageController.page ?? 0;
            }
            final isCurrent = page.round() == index;
            return Container(
              width: isCurrent ? 12 : 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isCurrent ? AppColors.primary : Colors.grey[300],
                borderRadius: BorderRadius.circular(3),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildScoreCard() {
    final color = _score! >= 80
        ? Colors.green
        : _score! >= 50
        ? Colors.orange
        : Colors.red;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: _score! / 100,
                  color: color,
                  backgroundColor: color.withValues(alpha: 0.1),
                  strokeWidth: 6,
                  strokeCap: StrokeCap.round,
                ),
              ),
              Text(
                '$_score%',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _score! >= 80
                      ? 'Tuyệt vời!'
                      : _score! >= 50
                      ? 'Khá tốt!'
                      : 'Cố gắng lên!',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                if (_aiFeedback != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    _aiFeedback!,
                    style: TextStyle(
                      color: color.withValues(alpha: 0.9),
                      fontSize: 13,
                    ),
                  ),
                ],
                if (_aiDetails != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _aiDetails!,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Inline Transcript
          if (_isListening || _lastWords.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                _lastWords.isEmpty ? 'Đang nghe...' : _lastWords,
                style: GoogleFonts.notoSansJp(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          Row(
            children: [
              // Speed toggle
              _CompactActionBtn(
                icon: Icons.speed_rounded,
                label: '${_ttsRate}x',
                onTap: () {
                  setState(() {
                    if (_ttsRate == 0.5)
                      _ttsRate = 0.8;
                    else if (_ttsRate == 0.8)
                      _ttsRate = 1.0;
                    else
                      _ttsRate = 0.5;
                  });
                  if (_speaking) {
                    _tts.stop();
                    _toggleTTS();
                  }
                },
              ),
              const SizedBox(width: 12),
              // Listen Sample
              _CompactActionBtn(
                icon: _speaking ? Icons.stop_rounded : Icons.play_arrow_rounded,
                label: 'Mẫu',
                onTap: _toggleTTS,
              ),
              const SizedBox(width: 12),
              // Mic Button (Primary)
              // FIX 4: Disabled state khi !_speechEnabled
              Expanded(
                child: !_speechEnabled
                    ? Tooltip(
                        message:
                            'Microphone không khả dụng. Kiểm tra quyền truy cập mic.',
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.mic_off_rounded,
                                color: Colors.grey[500],
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'MIC KHÔNG KHẢ DỤNG',
                                style: GoogleFonts.lexend(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : GestureDetector(
                        onLongPressStart: (_) => _startListening(),
                        onLongPressEnd: (_) => _stopListening(),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6366f1), Color(0xFFa855f7)],
                            ),
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF6366f1,
                                ).withValues(alpha: 0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              if (_isListening)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: _audioBars
                                      .map(
                                        (h) => Container(
                                          width: 3,
                                          height: h,
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 1.5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withValues(
                                              alpha: 0.5,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              1.5,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _isListening
                                        ? Icons.stop_rounded
                                        : Icons.mic_rounded,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  if (!_isListening) ...[
                                    const SizedBox(width: 8),
                                    Text(
                                      'NHẤN GIỮ',
                                      style: GoogleFonts.lexend(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CompactActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _CompactActionBtn({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: AppColors.primary),
              const SizedBox(height: 2),
              Text(
                label,
                style: GoogleFonts.lexend(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
