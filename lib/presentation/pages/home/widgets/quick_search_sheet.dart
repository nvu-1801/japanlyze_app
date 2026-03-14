import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../injection_container.dart';
import '../../../../domain/entities/conversation_models.dart';

// --- Analysis Models ---
class AnalysisToken {
  final String text;
  final String romaji;
  final String role;
  final String meaning;
  final String explanation;

  const AnalysisToken({
    required this.text,
    required this.romaji,
    required this.role,
    required this.meaning,
    required this.explanation,
  });
}

class GrammarPoint {
  final String point;
  final String explanation;

  const GrammarPoint({required this.point, required this.explanation});
}

class AnalysisResult {
  final List<AnalysisToken> tokens;
  final List<GrammarPoint> grammarPoints;
  final String nuance;

  const AnalysisResult({
    required this.tokens,
    required this.grammarPoints,
    required this.nuance,
  });
}

void showQuickSearch(BuildContext context, {String? initialCategory}) {
  showGeneralDialog(
    context: context,
    barrierLabel: 'QuickSearch',
    barrierDismissible: true,
    barrierColor: Colors.black26,
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (context, animation, secondaryAnimation) =>
        QuickSearchSheet(initialCategory: initialCategory),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
            .animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
        child: FadeTransition(opacity: animation, child: child),
      );
    },
  );
}

class QuickSearchSheet extends StatefulWidget {
  final String? initialCategory;
  const QuickSearchSheet({super.key, this.initialCategory});

  @override
  State<QuickSearchSheet> createState() => _QuickSearchSheetState();
}

class _QuickSearchSheetState extends State<QuickSearchSheet>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final SpeechToText _speech = SpeechToText();
  final FlutterTts _tts = FlutterTts();
  bool _speechAvailable = false;
  bool _isListening = false;
  final List<VocabItem> _searchResults = [];
  String _translationResult = '';
  bool _isSearchMode = true; // true = Search, false = Translate
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _isAnalyzing = false;
  AnalysisResult? _analysisResult;
  String _selectedCategory = ''; // Empty means no specific filter selected

  // Pagination & Scroll tracking
  final ScrollController _scrollController = ScrollController();
  int _page = 0;
  final int _pageSize = 25;
  bool _hasMore = true;
  bool _showHeader = true;
  double _lastScrollOffset = 0;
  late AnimationController _headerController;

  final List<String> _categories = [
    'Danh từ',
    'Động từ',
    'Tính từ',
    'Phó từ',
    'Khác',
  ];

  final SupabaseClient _supabase = sl<SupabaseClient>();

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..value = 1.0;

    _initSpeech();
    _initTts();
    if (widget.initialCategory != null &&
        _categories.contains(widget.initialCategory)) {
      _selectedCategory = widget.initialCategory!;
    }
    _scrollController.addListener(_onScroll);
    // Trigger initial search for suggestions
    _searchVocabulary(_controller.text);
  }

  void _onScroll() {
    final double currentOffset = _scrollController.offset;
    final bool scrollingDown = currentOffset > _lastScrollOffset;

    // Detect direction for Smart Header
    if (currentOffset <= 50) {
      // Always show at the top
      if (!_showHeader) {
        _showHeader = true;
        _headerController.forward();
      }
    } else if (scrollingDown &&
        currentOffset > _lastScrollOffset + 40 &&
        _showHeader) {
      // Scrolling down significantly -> hide
      _showHeader = false;
      _headerController.reverse();
    } else if (!scrollingDown &&
        currentOffset < _lastScrollOffset - 5 &&
        !_showHeader) {
      // Scrolling up even a bit -> show
      _showHeader = true;
      _headerController.forward();
    }

    _lastScrollOffset = currentOffset;

    // Load more logic
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        !_isLoadingMore &&
        _hasMore &&
        _isSearchMode) {
      _loadMore();
    }
  }

  Future<void> _initTts() async {
    await _tts.setLanguage('ja-JP');
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
  }

  Future<void> _speak(String text, {bool isJapanese = true}) async {
    if (text.isEmpty) return;
    await _tts.setLanguage(isJapanese ? 'ja-JP' : 'vi-VN');
    await _tts.speak(text);
  }

  Future<void> _initSpeech() async {
    try {
      final available = await _speech.initialize(
        onStatus: (status) {
          if (mounted) setState(() => _isListening = status == 'listening');
        },
        onError: (error) {
          if (mounted) setState(() => _isListening = false);
        },
      );
      if (mounted) setState(() => _speechAvailable = available);
    } catch (e) {
      debugPrint('Speech init error: $e');
    }
  }

  Future<void> _toggleListening() async {
    if (_isListening) {
      await _speech.stop();
      setState(() => _isListening = false);
    } else {
      setState(() => _isListening = true);
      await _speech.listen(
        onResult: (result) {
          setState(() {
            _controller.text = result.recognizedWords;
            _controller.selection = TextSelection.fromPosition(
              TextPosition(offset: _controller.text.length),
            );
          });
        },
        localeId: 'ja_JP',
        listenOptions: SpeechListenOptions(
          cancelOnError: true,
          partialResults: true,
        ),
      );
    }
  }

  @override
  void dispose() {
    _headerController.dispose();
    _scrollController.dispose();
    _speech.stop();
    _controller.dispose();
    super.dispose();
  }

  void _runAction() {
    final query = _controller.text.trim();
    if (query.isEmpty) return;

    if (_isSearchMode) {
      _searchVocabulary(query);
    } else {
      _translateSentence(query);
    }
    setState(() {
      _analysisResult = null;
    });
  }

  Future<void> _runDeepAnalysis() async {
    final query = _controller.text.trim();
    if (query.isEmpty || _translationResult.isEmpty) return;

    setState(() {
      _isAnalyzing = true;
      _analysisResult = null;
    });

    // Simulate AI thinking
    await Future.delayed(const Duration(milliseconds: 1500));

    // Mock Deep Analysis (In reality, this would call web/api/analyze)
    final mockResult = AnalysisResult(
      tokens: [
        const AnalysisToken(
          text: '日本',
          romaji: 'ni-hon',
          role: 'Danh từ',
          meaning: 'Nhật Bản',
          explanation: 'Chủ thể chính của câu.',
        ),
        const AnalysisToken(
          text: '語',
          romaji: 'go',
          role: 'Hậu tố',
          meaning: 'Ngôn ngữ',
          explanation: 'Chỉ ngôn ngữ của quốc gia đó.',
        ),
        const AnalysisToken(
          text: 'を',
          romaji: 'o',
          role: 'Trợ từ',
          meaning: '(Tác động)',
          explanation: 'Xác định đối tượng chịu sự tác động.',
        ),
        const AnalysisToken(
          text: '勉強',
          romaji: 'ben-kyou',
          role: 'Danh động từ',
          meaning: 'Học tập',
          explanation: 'Hành động chính trong câu.',
        ),
        const AnalysisToken(
          text: 'しています',
          romaji: 'shi-te-i-masu',
          role: 'Đuôi động từ',
          meaning: 'Đang làm',
          explanation: 'Thế tiếp diễn, chỉ trạng thái kéo dài.',
        ),
      ],
      grammarPoints: [
        const GrammarPoint(
          point: 'V-ています',
          explanation:
              'Diễn tả hành động đang tiếp diễn hoặc trạng thái hiện tại.',
        ),
        const GrammarPoint(
          point: 'N + を + V',
          explanation: 'Cấu trúc cơ bản xác định tân ngữ của câu.',
        ),
      ],
      nuance:
          'Câu này mang sắc thái trang trọng, lịch sự (Polite), phù hợp dùng trong môi trường công sở hoặc khi nói với người mới gặp.',
    );

    if (mounted) {
      setState(() {
        _analysisResult = mockResult;
        _isAnalyzing = false;
      });
    }
  }

  Future<void> _searchVocabulary(String query) async {
    final q = query.trim().toLowerCase();

    setState(() {
      _isLoading = true;
      _searchResults.clear();
      _translationResult = '';
      _page = 0;
      _hasMore = true;
    });

    try {
      // ✅ Supabase Remote Search
      // We look for matches in lemma, reading, romaji, and meaningVi
      var supabaseQuery = _supabase.from('DictionaryEntry').select();

      // Construction of OR filter for multiple fields
      if (q.isNotEmpty) {
        // We use prefix match for lemma, reading, romaji (better performance with indexes)
        // and contains match for meaningVi
        supabaseQuery = supabaseQuery.or(
          'lemma.ilike.$q%,reading.ilike.$q%,romaji.ilike.$q%,meaningVi.ilike.%$q%',
        );
      }

      if (_selectedCategory.isNotEmpty) {
        final posFilter = _mapCategoryToPos(_selectedCategory);
        if (posFilter != null) {
          supabaseQuery = supabaseQuery.ilike('posTag', '%$posFilter%');
        }
      }

      // Add pagination range
      final int from = _page * _pageSize;
      final int to = from + _pageSize - 1;
      final List<dynamic> response = await supabaseQuery.range(from, to);

      final results = response.map((item) {
        return VocabItem(
          kanji: item['lemma'] ?? '',
          kana: item['reading'] ?? item['lemma'] ?? '',
          romaji: item['romaji'] ?? '',
          meaning: item['meaningVi'] ?? '',
        );
      }).toList();

      if (mounted) {
        setState(() {
          _searchResults.addAll(results);
          _isLoading = false;
          _hasMore = results.length >= _pageSize;
        });
      }
    } catch (e) {
      debugPrint('Supabase search error: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi kết nối: ${e.toString()}')));
      }
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() {
      _isLoadingMore = true;
      _page++;
    });

    final q = _controller.text.trim().toLowerCase();

    try {
      var supabaseQuery = _supabase.from('DictionaryEntry').select();

      if (q.isNotEmpty) {
        supabaseQuery = supabaseQuery.or(
          'lemma.ilike.$q%,reading.ilike.$q%,romaji.ilike.$q%,meaningVi.ilike.%$q%',
        );
      }

      if (_selectedCategory.isNotEmpty) {
        final posFilter = _mapCategoryToPos(_selectedCategory);
        if (posFilter != null) {
          supabaseQuery = supabaseQuery.ilike('posTag', '%$posFilter%');
        }
      }

      final int from = _page * _pageSize;
      final int to = from + _pageSize - 1;
      final List<dynamic> response = await supabaseQuery.range(from, to);

      final results = response.map((item) {
        return VocabItem(
          kanji: item['lemma'] ?? '',
          kana: item['reading'] ?? item['lemma'] ?? '',
          romaji: item['romaji'] ?? '',
          meaning: item['meaningVi'] ?? '',
        );
      }).toList();

      if (mounted) {
        setState(() {
          _searchResults.addAll(results);
          _isLoadingMore = false;
          _hasMore = results.length >= _pageSize;
        });
      }
    } catch (e) {
      debugPrint('Supabase load more error: $e');
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  String? _mapCategoryToPos(String cat) {
    switch (cat) {
      case 'Danh từ':
        return 'n';
      case 'Động từ':
        return 'v';
      case 'Tính từ':
        return 'adj';
      case 'Phó từ':
        return 'adv';
      case 'Khác':
        return 'other';
      default:
        return null;
    }
  }

  Future<void> _translateSentence(String query) async {
    setState(() {
      _isLoading = true;
      _translationResult = '';
      _searchResults.clear();
    });

    try {
      final hasJapanese = RegExp(
        r'[\u3040-\u30ff\u3400-\u4dbf\u4e00-\u9fff]',
      ).hasMatch(query);
      final pair = hasJapanese ? 'ja|vi' : 'vi|ja';

      final response = await http.get(
        Uri.parse(
          'https://api.mymemory.translated.net/get?q=${Uri.encodeComponent(query)}&langpair=$pair',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _translationResult =
              data['responseData']['translatedText'] ?? 'Lỗi dịch thuật';
        });
      }
    } catch (e) {
      setState(() {
        _translationResult = 'Lỗi kết nối: ${e.toString()}';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.of(context).padding.top;

    return Material(
      type: MaterialType.transparency,
      child: Align(
        alignment: Alignment.topCenter,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20, topPadding + 12, 20, 28),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.backgroundDark.withValues(alpha: 0.95)
                  : Colors.white.withValues(alpha: 0.97),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                // === SMART HEADER AREA (FIXED TOP) ===
                SizeTransition(
                  sizeFactor: CurvedAnimation(
                    parent: _headerController,
                    curve: Curves.fastOutSlowIn,
                  ),
                  child: FadeTransition(
                    opacity: CurvedAnimation(
                      parent: _headerController,
                      curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              _isSearchMode
                                  ? Icons.book_rounded
                                  : Icons.translate_rounded,
                              color: AppColors.primary,
                              size: 24,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              _isSearchMode ? 'Tra từ điển' : 'Dịch câu AI',
                              style: GoogleFonts.lexend(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? Colors.white
                                    : AppColors.textPrimary,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.white10
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  _SparkleToggle(
                                    isActive: _isSearchMode,
                                    icon: Icons.search,
                                    onTap: () =>
                                        setState(() => _isSearchMode = true),
                                    isDark: isDark,
                                  ),
                                  _SparkleToggle(
                                    isActive: !_isSearchMode,
                                    icon: Icons.auto_awesome,
                                    onTap: () =>
                                        setState(() => _isSearchMode = false),
                                    isDark: isDark,
                                    isTranslate: true,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.close_rounded,
                                color: isDark ? Colors.white54 : Colors.black38,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.07)
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white10
                                  : Colors.black.withValues(alpha: 0.06),
                            ),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 16),
                              Icon(
                                Icons.search_rounded,
                                color: isDark
                                    ? Colors.white38
                                    : Colors.grey[400],
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: _controller,
                                  autofocus: true,
                                  style: GoogleFonts.lexend(
                                    fontSize: 16,
                                    color: isDark
                                        ? Colors.white
                                        : AppColors.textPrimary,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: _isListening
                                        ? 'Đang nghe...'
                                        : (_isSearchMode
                                              ? 'Nhập từ vựng...'
                                              : 'Nhập câu văn...'),
                                    hintStyle: GoogleFonts.lexend(
                                      color: _isListening
                                          ? AppColors.primary.withValues(
                                              alpha: 0.7,
                                            )
                                          : (isDark
                                                ? Colors.white38
                                                : Colors.grey[400]),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                  ),
                                  onChanged: (val) {
                                    if (_isSearchMode) {
                                      _searchVocabulary(val);
                                      setState(() {
                                        _analysisResult = null;
                                      });
                                    }
                                  },
                                  onSubmitted: (_) => _runAction(),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: _isListening
                                      ? Colors.red
                                      : (_speechAvailable
                                            ? AppColors.primary
                                            : Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  onPressed: _speechAvailable
                                      ? _toggleListening
                                      : null,
                                  icon: Icon(
                                    _isListening
                                        ? Icons.stop_rounded
                                        : Icons.mic_none_rounded,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_isListening)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.graphic_eq_rounded,
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Đang lắng nghe...',
                                  style: GoogleFonts.lexend(
                                    fontSize: 13,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (_isSearchMode)
                          Container(
                            height: 40,
                            margin: const EdgeInsets.only(top: 12),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _categories.length,
                              itemBuilder: (context, index) {
                                final cat = _categories[index];
                                final isSelected = _selectedCategory == cat;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: FilterChip(
                                    label: Text(
                                      cat,
                                      style: GoogleFonts.lexend(
                                        fontSize: 12,
                                        color: isSelected
                                            ? Colors.white
                                            : (isDark
                                                  ? Colors.white70
                                                  : Colors.black87),
                                      ),
                                    ),
                                    selected: isSelected,
                                    onSelected: (selected) {
                                      setState(() {
                                        _selectedCategory = selected ? cat : '';
                                      });
                                      _searchVocabulary(_controller.text);
                                    },
                                    selectedColor: AppColors.primary,
                                    backgroundColor: isDark
                                        ? Colors.white10
                                        : Colors.grey[200],
                                    checkmarkColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    side: BorderSide.none,
                                  ),
                                );
                              },
                            ),
                          ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),

                // === RESULTS AREA (SCROLLABLE) ===
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_isLoading)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        else if (_isSearchMode && _searchResults.isNotEmpty)
                          Column(
                            children: [
                              _SearchResultsList(
                                results: _searchResults,
                                isDark: isDark,
                                onSpeak: (text) =>
                                    _speak(text, isJapanese: true),
                              ),
                              if (_isLoadingMore)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                )
                              else if (!_hasMore &&
                                  _searchResults.length >= _pageSize)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Đã hiển thị tất cả kết quả',
                                      style: GoogleFonts.lexend(
                                        fontSize: 12,
                                        color: isDark
                                            ? Colors.white38
                                            : Colors.grey[400],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          )
                        else if (!_isSearchMode &&
                            _translationResult.isNotEmpty)
                          Column(
                            children: [
                              _TranslationCard(
                                result: _translationResult,
                                isDark: isDark,
                                onAnalyze: _isAnalyzing
                                    ? null
                                    : _runDeepAnalysis,
                                isAnalyzing: _isAnalyzing,
                                onSpeak: () {
                                  final hasJapanese = RegExp(
                                    r'[\u3040-\u30ff\u3400-\u4dbf\u4e00-\u9fff]',
                                  ).hasMatch(_translationResult);
                                  _speak(
                                    _translationResult,
                                    isJapanese: hasJapanese,
                                  );
                                },
                              ),
                              if (_analysisResult != null)
                                _DeepAnalysisView(
                                  result: _analysisResult!,
                                  isDark: isDark,
                                ),
                            ],
                          )
                        else if (_controller.text.isEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              _QuickTagStrip(
                                isDark: isDark,
                                controller: _controller,
                                runAction: _runAction,
                              ),
                            ],
                          ),
                      ],
                    ),
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

class _QuickTagStrip extends StatelessWidget {
  final bool isDark;
  final TextEditingController controller;
  final VoidCallback runAction;

  const _QuickTagStrip({
    required this.isDark,
    required this.controller,
    required this.runAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gợi ý',
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white38 : Colors.grey[500],
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _QuickTag(
              label: '🌸 Chào hỏi',
              isDark: isDark,
              onTap: () {
                controller.text = 'Chào hỏi';
                runAction();
              },
            ),
            _QuickTag(
              label: '👨‍👩‍👧 Gia đình',
              isDark: isDark,
              onTap: () {
                controller.text = 'Gia đình';
                runAction();
              },
            ),
            _QuickTag(
              label: '🔢 Số đếm',
              isDark: isDark,
              onTap: () {
                controller.text = 'Số đếm';
                runAction();
              },
            ),
            _QuickTag(
              label: '⏰ Thời gian',
              isDark: isDark,
              onTap: () {
                controller.text = 'Thời gian';
                runAction();
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickTag extends StatelessWidget {
  final String label;
  final bool isDark;
  final VoidCallback onTap;
  const _QuickTag({
    required this.label,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? Colors.white10 : Colors.grey.withValues(alpha: 0.2),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.lexend(
            fontSize: 13,
            color: isDark ? Colors.white70 : Colors.grey[700],
          ),
        ),
      ),
    );
  }
}

class _SearchResultsList extends StatelessWidget {
  final List<VocabItem> results;
  final bool isDark;
  final Function(String) onSpeak;

  const _SearchResultsList({
    required this.results,
    required this.isDark,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: results.length,
        itemBuilder: (context, index) {
          final item = results[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.03)
                  : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? Colors.white10 : Colors.grey[200]!,
              ),
            ),
            child: ListTile(
              title: Text(
                item.kanji.isNotEmpty ? item.kanji : item.kana,
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDark ? Colors.white : AppColors.textPrimary,
                ),
              ),
              subtitle: Text(
                item.meaning,
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  color: isDark ? Colors.white70 : Colors.grey[600],
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.volume_up_rounded, size: 20),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  onSpeak(item.kana);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TranslationCard extends StatelessWidget {
  final String result;
  final bool isDark;
  final VoidCallback? onAnalyze;
  final bool isAnalyzing;
  final VoidCallback onSpeak;

  const _TranslationCard({
    required this.result,
    required this.isDark,
    this.onAnalyze,
    required this.isAnalyzing,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white10
              : AppColors.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, size: 16, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Bản dịch AI',
                style: GoogleFonts.lexend(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              _TranslationAction(
                icon: Icons.copy_rounded,
                onTap: () {
                  Clipboard.setData(ClipboardData(text: result));
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Đã sao chép!')));
                },
              ),
              const SizedBox(width: 8),
              _TranslationAction(icon: Icons.volume_up_rounded, onTap: onSpeak),
              const SizedBox(width: 8),
              _TranslationAction(
                icon: Icons.analytics_outlined,
                onTap: onAnalyze != null ? onAnalyze! : () {},
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            result,
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : AppColors.textPrimary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: onAnalyze,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: isAnalyzing
                    ? null
                    : LinearGradient(
                        colors: [AppColors.primary, AppColors.secondary],
                      ),
                color: isAnalyzing ? Colors.grey[300] : null,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isAnalyzing) ...[
                    const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white70,
                      ),
                    ),
                  ] else ...[
                    const Icon(
                      Icons.auto_fix_high_rounded,
                      size: 14,
                      color: Colors.white,
                    ),
                  ],
                  const SizedBox(width: 8),
                  Text(
                    isAnalyzing ? 'Đang phân tích...' : 'Phân tích chuyên sâu',
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeepAnalysisView extends StatelessWidget {
  final AnalysisResult result;
  final bool isDark;
  const _DeepAnalysisView({required this.result, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(title: 'Cấu trúc câu', isDark: isDark),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: result.tokens
                  .map((t) => _TokenCard(token: t, isDark: isDark))
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          _SectionTitle(title: 'Điểm ngữ pháp', isDark: isDark),
          const SizedBox(height: 8),
          ...result.grammarPoints.map(
            (g) => _GrammarCard(point: g, isDark: isDark),
          ),
          const SizedBox(height: 20),
          _SectionTitle(title: 'Sắc thái & Văn phong', isDark: isDark),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.purple[900]!.withValues(alpha: 0.2)
                  : Colors.purple[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              result.nuance,
              style: GoogleFonts.lexend(
                fontSize: 13,
                color: isDark ? Colors.purple[100] : Colors.purple[900],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final bool isDark;
  const _SectionTitle({required this.title, required this.isDark});
  @override
  Widget build(BuildContext context) => Text(
    title.toUpperCase(),
    style: GoogleFonts.lexend(
      fontSize: 11,
      fontWeight: FontWeight.bold,
      color: isDark ? Colors.white38 : Colors.grey[400],
      letterSpacing: 1.2,
    ),
  );
}

class _TokenCard extends StatelessWidget {
  final AnalysisToken token;
  final bool isDark;
  const _TokenCard({required this.token, required this.isDark});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Text(
            token.text,
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
          ),
          Text(
            token.role,
            style: GoogleFonts.lexend(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            token.meaning,
            style: GoogleFonts.lexend(
              fontSize: 12,
              color: isDark ? Colors.white70 : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}

class _GrammarCard extends StatelessWidget {
  final GrammarPoint point;
  final bool isDark;
  const _GrammarCard({required this.point, required this.isDark});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey[200]!),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.bookmark_added_rounded,
            size: 16,
            color: Colors.green,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  point.point,
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
                Text(
                  point.explanation,
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    color: isDark ? Colors.white60 : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SparkleToggle extends StatefulWidget {
  final bool isActive;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;
  final bool isTranslate;

  const _SparkleToggle({
    required this.isActive,
    required this.icon,
    required this.onTap,
    required this.isDark,
    this.isTranslate = false,
  });

  @override
  State<_SparkleToggle> createState() => _SparkleToggleState();
}

class _SparkleToggleState extends State<_SparkleToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    if (widget.isTranslate) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final isPremiumEffect = widget.isTranslate && widget.isActive;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: widget.isActive
                  ? (isPremiumEffect
                        ? null
                        : (widget.isDark ? Colors.white12 : Colors.white))
                  : Colors.transparent,
              gradient: isPremiumEffect
                  ? LinearGradient(
                      colors: [
                        const Color(0xFF6366f1),
                        const Color(0xFFa855f7).withValues(alpha: 0.8),
                        const Color(0xFF6366f1),
                      ],
                      stops: [0.0, _controller.value, 1.0],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              borderRadius: BorderRadius.circular(10),
              boxShadow: isPremiumEffect
                  ? [
                      BoxShadow(
                        color: const Color(
                          0xFF6366f1,
                        ).withValues(alpha: 0.3 * _controller.value),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              widget.icon,
              size: 20,
              color: widget.isActive
                  ? (isPremiumEffect ? Colors.white : AppColors.primary)
                  : (widget.isDark ? Colors.white38 : Colors.grey),
            ),
          );
        },
      ),
    );
  }
}

class _TranslationAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _TranslationAction({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: AppColors.primary),
      ),
    );
  }
}
