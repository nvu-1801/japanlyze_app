import 'package:flutter/material.dart';
import '../../../domain/entities/roadmap_models.dart';

final List<RoadmapWeek> n5Weeks = [
  const RoadmapWeek(
    week: 1,
    title: "Tuần 1: Chinh phục Hiragana",
    description: "Làm quen, ghi nhớ và luyện tập 46 ký tự Hiragana cơ bản.",
    color: Color(0xFFE8F5E9), // bg-green-100
    iconColor: Color(0xFF2E7D32), // text-green-600
    badgeColor: Color(0xFF4CAF50), // bg-green-500
    quests: [
      RoadmapQuest(
        id: 'w1_1',
        title: "Hiragana: Cơ bản",
        description: "Làm quen và ghi nhớ 46 ký tự Hiragana cơ bản.",
        type: "learn",
        icon: Icons.book_outlined,
        link: "/exercises/hiragana",
        xp: 100,
      ),
      RoadmapQuest(
        id: 'w1_2',
        title: "Hiragana: Biến âm",
        description: "Học âm đục (Dakuten) và âm bán đục của Hiragana.",
        type: "reading",
        icon: Icons.visibility_outlined,
        link: "/exercises/hiragana",
        xp: 150,
      ),
      RoadmapQuest(
        id: 'w1_3',
        title: "Hiragana: Luyện tập",
        description: "Bài tập trắc nghiệm tổng hợp về Hiragana.",
        type: "test",
        icon: Icons.edit_outlined,
        link: "/exercises/hiragana",
        xp: 200,
      ),
      RoadmapQuest(
        id: 'w1_4',
        title: "Kiểm tra Tuần 1",
        description: "Tổng ôn toàn bộ kiến thức Hiragana.",
        type: "test",
        icon: Icons.emoji_events_outlined,
        link: "/exercises/hiragana",
        xp: 300,
      ),
    ],
  ),
  const RoadmapWeek(
    week: 2,
    title: "Tuần 2: Chinh phục Katakana",
    description: "Làm quen, ghi nhớ và luyện tập 46 ký tự Katakana cơ bản.",
    color: Color(0xFFE0F2F1), // bg-teal-100
    iconColor: Color(0xFF00796B), // text-teal-600
    badgeColor: Color(0xFF009688), // bg-teal-500
    quests: [
      RoadmapQuest(
        id: 'w2_1',
        title: "Katakana: Cơ bản",
        description: "Làm quen và ghi nhớ 46 ký tự Katakana cơ bản.",
        type: "learn",
        icon: Icons.book_outlined,
        link: "/exercises/katakana",
        xp: 100,
      ),
      RoadmapQuest(
        id: 'w2_2',
        title: "Katakana: Biến âm",
        description: "Học âm đục (Dakuten) và âm bán đục của Katakana.",
        type: "reading",
        icon: Icons.visibility_outlined,
        link: "/exercises/katakana",
        xp: 150,
      ),
      RoadmapQuest(
        id: 'w2_3',
        title: "Katakana: Luyện tập",
        description: "Bài tập trắc nghiệm tổng hợp về Katakana.",
        type: "test",
        icon: Icons.edit_outlined,
        link: "/exercises/katakana",
        xp: 200,
      ),
      RoadmapQuest(
        id: 'w2_4',
        title: "Kiểm tra Tuần 2",
        description: "Tổng ôn toàn bộ kiến thức Katakana.",
        type: "test",
        icon: Icons.emoji_events_outlined,
        link: "/exercises/katakana",
        xp: 350,
      ),
    ],
  ),
  const RoadmapWeek(
    week: 3,
    title: "Tuần 3: Bài 1, 2 & 3 - Khởi đầu",
    description:
        "Học từ vựng, chữ Hán bài 1, 2, 3 và làm quen với ngữ pháp cơ bản.",
    color: Color(0xFFE3F2FD), // bg-blue-100
    iconColor: Color(0xFF1976D2), // text-blue-600
    badgeColor: Color(0xFF2196F3), // bg-blue-500
    quests: [
      RoadmapQuest(
        id: 'w3_1',
        title: "Bài 1: Từ vựng & Chữ Hán",
        description: "Luyện đọc và làm bài tập từ vựng, Kanji Bài 1.",
        type: "flashcard",
        icon: Icons.bolt,
        link: "/exercises/conv_1_intro",
        xp: 150,
      ),
      RoadmapQuest(
        id: 'w3_2',
        title: "Bài 1: Ngữ pháp & Giao tiếp",
        description: "Học mẫu câu cơ bản (wa, mo, no) và Roleplay.",
        type: "roleplay",
        icon: Icons.mic_none,
        link: "/exercises/conv_1_intro",
        xp: 200,
      ),
      RoadmapQuest(
        id: 'w3_7',
        title: "Kiểm tra Tuần 3",
        description: "Tổng ôn kiến thức Bài 1, 2 và 3.",
        type: "test",
        icon: Icons.emoji_events_outlined,
        link: "/exercises/conv_1_intro",
        xp: 400,
      ),
    ],
  ),
  const RoadmapWeek(
    week: 4,
    title: "Tuần 4: Bài 4 & 5 - Thời gian & Di chuyển",
    description: "Mở rộng vốn từ vựng về thời gian, địa điểm và hành động.",
    color: Color(0xFFE8EAF6), // bg-indigo-100
    iconColor: Color(0xFF303F9F), // text-indigo-600
    badgeColor: Color(0xFF3F51B5), // bg-indigo-500
    quests: [
      RoadmapQuest(
        id: 'w4_1',
        title: "Bài 4: Từ vựng",
        description: "Luyện đọc và làm bài tập từ vựng Bài 4.",
        type: "flashcard",
        icon: Icons.bolt,
        link: "/exercises/numbers",
        xp: 200,
      ),
      RoadmapQuest(
        id: 'w4_5',
        title: "Kiểm tra Tuần 4",
        description: "Đánh giá kiến thức Bài 4 và Bài 5.",
        type: "test",
        icon: Icons.emoji_events_outlined,
        link: "/exercises/numbers",
        xp: 400,
      ),
    ],
  ),
  // Add more weeks as needed, following the pattern
];

final List<RoadmapPhase> n5Phases = [
  const RoadmapPhase(
    id: 1,
    title: "Giai đoạn 1: Khởi động (The Awakening)",
    description: "Xóa mù chữ Hiragana/Katakana & Bài tập cơ bản.",
    colorClass: "green",
    iconColor: Color(0xFF4CAF50),
    quests: [
      RoadmapQuest(
        id: 'q1_1',
        title: "1. Nạp kiến thức",
        description: "Xem bảng chữ cái Hiragana & Katakana.",
        type: "learn",
        icon: Icons.book_outlined,
        link: "/exercises/hiragana",
        xp: 100,
      ),
      RoadmapQuest(
        id: 'q1_4',
        title: "4. Kiểm tra tổng hợp",
        description: "Bài thi trắc nghiệm Hiragana + Katakana (Đạt >80%).",
        type: "test",
        icon: Icons.check_circle_outline,
        link: "/exercises/hiragana",
        xp: 300,
      ),
    ],
  ),
  const RoadmapPhase(
    id: 2,
    title: "Giai đoạn 2: Xây nền móng (Foundation)",
    description: "Bài 1 - 12: Số đếm, Gia đình, Mua sắm.",
    colorClass: "blue",
    iconColor: Color(0xFF2196F3),
    quests: [
      RoadmapQuest(
        id: 'q2_1',
        title: "Nạp từ vựng",
        description: "Học Flashcard: Số đếm, Tiền tệ, Gia đình.",
        type: "flashcard",
        icon: Icons.bolt,
        link: "/exercises/numbers",
        xp: 150,
      ),
    ],
  ),
];

// Data mẫu cho N4
final List<RoadmapWeek> n4Weeks = [
  const RoadmapWeek(
    week: 1,
    title: "Tuần 1: Ôn tập N5 + Từ vựng N4 cơ bản",
    description: "Ôn lại kiến thức N5 và làm quen với từ vựng N4.",
    color: Color(0xFFE3F2FD), // bg-blue-100
    iconColor: Color(0xFF1565C0), // text-blue-600
    badgeColor: Color(0xFF2196F3), // bg-blue-500
    quests: [
      RoadmapQuest(
        id: 'n4_w1_1',
        title: "Ôn tập Hiragana/Katakana",
        description: "Ôn lại bảng chữ cái cơ bản.",
        type: "learn",
        icon: Icons.book_outlined,
        link: "/exercises/hiragana",
        xp: 100,
      ),
      RoadmapQuest(
        id: 'n4_w1_2',
        title: "Từ vựng N4: Thiên nhiên",
        description: "Học từ vựng về thiên nhiên và môi trường.",
        type: "flashcard",
        icon: Icons.eco_outlined,
        link: "/exercises/nature",
        xp: 150,
      ),
      RoadmapQuest(
        id: 'n4_w1_3',
        title: "Ngữ pháp N4: Thể điều kiện",
        description: "Làm quen với thể điều kiện ば, と, たら, なら.",
        type: "learn",
        icon: Icons.account_tree_outlined,
        link: "/exercises/grammar-n4-1",
        xp: 200,
      ),
    ],
  ),
  const RoadmapWeek(
    week: 2,
    title: "Tuần 2: Từ vựng N4 & Giao tiếp xã hội",
    description: "Học từ vựng về xã hội, công việc và cuộc sống hàng ngày.",
    color: Color(0xFFE3F2FD),
    iconColor: Color(0xFF1565C0),
    badgeColor: Color(0xFF2196F3),
    quests: [
      RoadmapQuest(
        id: 'n4_w2_1',
        title: "Từ vựng N4: Xã hội",
        description: "Học từ vựng về xã hội và cộng đồng.",
        type: "flashcard",
        icon: Icons.groups_outlined,
        link: "/exercises/society",
        xp: 150,
      ),
      RoadmapQuest(
        id: 'n4_w2_2',
        title: "Ngữ pháp N4: Kính ngữ cơ bản",
        description: "Làm quen với Tôn kính ngữ và Khiêm nhường ngữ.",
        type: "learn",
        icon: Icons.work_outline,
        link: "/exercises/keigo-basic",
        xp: 200,
      ),
      RoadmapQuest(
        id: 'n4_w2_3',
        title: "Giao tiếp: Tại nơi làm việc",
        description: "Đóng vai hội thoại trong môi trường công sở.",
        type: "roleplay",
        icon: Icons.mic_none,
        link: "/exercises/roleplay-work",
        xp: 250,
      ),
    ],
  ),
  const RoadmapWeek(
    week: 3,
    title: "Tuần 3: Kanji N4 & Đọc hiểu",
    description: "Mở rộng vốn Kanji và làm quen với các đoạn văn ngắn.",
    color: Color(0xFFE3F2FD),
    iconColor: Color(0xFF1565C0),
    badgeColor: Color(0xFF2196F3),
    quests: [
      RoadmapQuest(
        id: 'n4_w3_1',
        title: "Kanji N4: Phần 1",
        description: "Học 50 Kanji N4 thường gặp nhất.",
        type: "learn",
        icon: Icons.draw_outlined,
        link: "/exercises/kanji-n4-1",
        xp: 200,
      ),
      RoadmapQuest(
        id: 'n4_w3_2',
        title: "Đọc hiểu: Thông báo & Biển báo",
        description: "Đọc và dịch các biển báo thực tế tại Nhật.",
        type: "reading",
        icon: Icons.signpost_outlined,
        link: "/exercises/reading-signs",
        xp: 250,
      ),
    ],
  ),
  const RoadmapWeek(
    week: 4,
    title: "Tuần 4: Tổng ôn & Thi thử N4",
    description: "Ôn tập toàn bộ và chuẩn bị cho bài thi thực tế.",
    color: Color(0xFFE3F2FD),
    iconColor: Color(0xFF1565C0),
    badgeColor: Color(0xFF2196F3),
    quests: [
      RoadmapQuest(
        id: 'n4_w4_1',
        title: "Luyện nghe N4",
        description: "Nghe hiểu các đoạn hội thoại thường nhật.",
        type: "test",
        icon: Icons.headphones_outlined,
        link: "/exercises/listening-n4",
        xp: 250,
      ),
      RoadmapQuest(
        id: 'n4_w4_2',
        title: "Thi thử N4 (Mock Test)",
        description: "Làm bài thi thử N4 theo cấu trúc chuẩn JLPT.",
        type: "test",
        icon: Icons.workspace_premium_outlined,
        link: "/exercises/mock-test-n4",
        xp: 500,
      ),
    ],
  ),
];

// Data mẫu cho N3
final List<RoadmapWeek> n3Weeks = [
  const RoadmapWeek(
    week: 1,
    title: "Tuần 1: Ôn tập N4 + Ngữ pháp N3",
    description: "Ôn lại N4 và học ngữ pháp N3 nâng cao.",
    color: Color(0xFFF3E5F5), // bg-purple-100
    iconColor: Color(0xFF6A1B9A), // text-purple-600
    badgeColor: Color(0xFF9C27B0), // bg-purple-500
    quests: [
      RoadmapQuest(
        id: 'n3_w1_1',
        title: "Ôn tập ngữ pháp N4",
        description: "Ôn lại các cấu trúc ngữ pháp N4.",
        type: "learn",
        icon: Icons.book_outlined,
        link: "/exercises/grammar",
        xp: 100,
      ),
      RoadmapQuest(
        id: 'n3_w1_2',
        title: "Ngữ pháp N3: Mệnh đề phức",
        description: "Học cách sử dụng mệnh đề phức trong N3.",
        type: "reading",
        icon: Icons.article_outlined,
        link: "/exercises/complex-sentences",
        xp: 200,
      ),
    ],
  ),
  const RoadmapWeek(
    week: 2,
    title: "Tuần 2: Từ vựng N3 & Cụm từ",
    description: "Học từ vựng N3 theo chủ đề và các cụm từ cố định.",
    color: Color(0xFFF3E5F5),
    iconColor: Color(0xFF6A1B9A),
    badgeColor: Color(0xFF9C27B0),
    quests: [
      RoadmapQuest(
        id: 'n3_w2_1',
        title: "Từ vựng N3: Cảm xúc & Tính cách",
        description: "Từ vựng miêu tả trạng thái và tâm lý.",
        type: "flashcard",
        icon: Icons.mood_outlined,
        link: "/exercises/vocab-n3-emotions",
        xp: 150,
      ),
      RoadmapQuest(
        id: 'n3_w2_2',
        title: "Ngữ pháp N3: Sự cho nhận",
        description: "Học sâu hơn về V-te morau/kureru/ageru.",
        type: "learn",
        icon: Icons.sync_alt_outlined,
        link: "/exercises/grammar-n3-giving",
        xp: 200,
      ),
    ],
  ),
  const RoadmapWeek(
    week: 3,
    title: "Tuần 3: Kanji N3 & Đọc hiểu trung cấp",
    description: "Chinh phục Kanji N3 và luyện dịch đoạn văn.",
    color: Color(0xFFF3E5F5),
    iconColor: Color(0xFF6A1B9A),
    badgeColor: Color(0xFF9C27B0),
    quests: [
      RoadmapQuest(
        id: 'n3_w3_1',
        title: "Kanji N3: Ký tự ghép",
        description: "Học các Jukugo (Từ ghép Kanji) thường thi.",
        type: "flashcard",
        icon: Icons.font_download_outlined,
        link: "/exercises/kanji-n3-jukugo",
        xp: 200,
      ),
      RoadmapQuest(
        id: 'n3_w3_2',
        title: "Đọc hiểu: Bài báo ngắn",
        description: "Đọc và trả lời câu hỏi từ các tin tức Nhật Bản.",
        type: "reading",
        icon: Icons.newspaper_outlined,
        link: "/exercises/reading-n3-news",
        xp: 250,
      ),
    ],
  ),
  const RoadmapWeek(
    week: 4,
    title: "Tuần 4: Tổng ôn & Thi thử N3",
    description: "Khẳng định trình độ với bài thi N3 toàn diện.",
    color: Color(0xFFF3E5F5),
    iconColor: Color(0xFF6A1B9A),
    badgeColor: Color(0xFF9C27B0),
    quests: [
      RoadmapQuest(
        id: 'n3_w4_1',
        title: "Luyện nghe N3: Bắt từ khóa",
        description: "Kỹ năng nghe có chủ đích trong bài thi.",
        type: "test",
        icon: Icons.hearing_outlined,
        link: "/exercises/listening-n3-keywords",
        xp: 300,
      ),
      RoadmapQuest(
        id: 'n3_w4_2',
        title: "Thi thử N3 (Mock Test)",
        description: "Đánh giá toàn diện kiến thức N3.",
        type: "test",
        icon: Icons.emoji_events_outlined,
        link: "/exercises/mock-test-n3",
        xp: 600,
      ),
    ],
  ),
];

// Data mẫu cho N2
final List<RoadmapWeek> n2Weeks = [
  const RoadmapWeek(
    week: 1,
    title: "Tuần 1: Ôn tập N3 + Kanji N2",
    description: "Ôn lại N3 và học Kanji N2 nâng cao.",
    color: Color(0xFFFFF3E0), // bg-orange-100
    iconColor: Color(0xFFE65100), // text-orange-600
    badgeColor: Color(0xFFFF9800), // bg-orange-500
    quests: [
      RoadmapQuest(
        id: 'n2_w1_1',
        title: "Ôn tập Kanji N3",
        description: "Ôn lại các Kanji N3 quan trọng.",
        type: "learn",
        icon: Icons.book_outlined,
        link: "/exercises/kanji",
        xp: 100,
      ),
      RoadmapQuest(
        id: 'n2_w1_2',
        title: "Kanji N2: Từ ghép",
        description: "Học các từ ghép phức tạp trong N2.",
        type: "flashcard",
        icon: Icons.style_outlined,
        link: "/exercises/compound-kanji",
        xp: 250,
      ),
    ],
  ),
  const RoadmapWeek(
    week: 2,
    title: "Tuần 2: Ngữ pháp N2 & Biểu đạt",
    description: "Học các cấu trúc ngữ pháp dùng trong văn bản trang trọng.",
    color: Color(0xFFFFF3E0),
    iconColor: Color(0xFFE65100),
    badgeColor: Color(0xFFFF9800),
    quests: [
      RoadmapQuest(
        id: 'n2_w2_1',
        title: "Ngữ pháp N2: Văn viết",
        description: "Các mẫu ngữ pháp thường dùng trong báo chí.",
        type: "learn",
        icon: Icons.menu_book_outlined,
        link: "/exercises/grammar-n2-formal",
        xp: 200,
      ),
      RoadmapQuest(
        id: 'n2_w2_2',
        title: "Đọc hiểu: Quan điểm tác giả",
        description: "Luyện kỹ năng nắm bắt ý chính của tác giả.",
        type: "reading",
        icon: Icons.lightbulb_outline,
        link: "/exercises/reading-n2-opinions",
        xp: 300,
      ),
    ],
  ),
  const RoadmapWeek(
    week: 3,
    title: "Tuần 3: Từ vựng chuyên ngành N2",
    description: "Mở rộng từ vựng về kinh tế, chính trị và kinh doanh.",
    color: Color(0xFFFFF3E0),
    iconColor: Color(0xFFE65100),
    badgeColor: Color(0xFFFF9800),
    quests: [
      RoadmapQuest(
        id: 'n2_w3_1',
        title: "Từ vựng N2: Kinh doanh",
        description: "Từ vựng sử dụng trong công ty Nhật Bản.",
        type: "flashcard",
        icon: Icons.business_center_outlined,
        link: "/exercises/vocab-n2-business",
        xp: 250,
      ),
      RoadmapQuest(
        id: 'n2_w3_2',
        title: "Kính ngữ N2",
        description: "Nâng cao kỹ năng sử dụng Keigo.",
        type: "roleplay",
        icon: Icons.record_voice_over_outlined,
        link: "/exercises/keigo-advanced",
        xp: 250,
      ),
    ],
  ),
  const RoadmapWeek(
    week: 4,
    title: "Tuần 4: Luyện đề N2 chuyên sâu",
    description: "Áp lực thời gian và kỹ năng làm bài thi N2.",
    color: Color(0xFFFFF3E0),
    iconColor: Color(0xFFE65100),
    badgeColor: Color(0xFFFF9800),
    quests: [
      RoadmapQuest(
        id: 'n2_w4_1',
        title: "Luyện nghe N2: Tin tức",
        description: "Nghe hiểu các bản tin thời sự tiếng Nhật.",
        type: "test",
        icon: Icons.radio_outlined,
        link: "/exercises/listening-n2-news",
        xp: 300,
      ),
      RoadmapQuest(
        id: 'n2_w4_2',
        title: "Thi thử N2 (Mock Test)",
        description: "Thử sức với đề thi N2 chuẩn hóa.",
        type: "test",
        icon: Icons.stars_outlined,
        link: "/exercises/mock-test-n2",
        xp: 700,
      ),
    ],
  ),
];

// Data mẫu cho N1
final List<RoadmapWeek> n1Weeks = [
  const RoadmapWeek(
    week: 1,
    title: "Tuần 1: Ôn tập N2 + Ngữ pháp N1",
    description: "Ôn lại N2 và học ngữ pháp N1 cao cấp.",
    color: Color(0xFFFFEBEE), // bg-red-100
    iconColor: Color(0xFFB71C1C), // text-red-600
    badgeColor: Color(0xFFF44336), // bg-red-500
    quests: [
      RoadmapQuest(
        id: 'n1_w1_1',
        title: "Ôn tập ngữ pháp N2",
        description: "Ôn lại các cấu trúc ngữ pháp N2 nâng cao.",
        type: "learn",
        icon: Icons.book_outlined,
        link: "/exercises/advanced-grammar",
        xp: 100,
      ),
      RoadmapQuest(
        id: 'n1_w1_2',
        title: "Ngữ pháp N1: Biểu đạt tinh tế",
        description: "Học các cách biểu đạt tinh tế trong N1.",
        type: "reading",
        icon: Icons.psychology_outlined,
        link: "/exercises/nuanced-expressions",
        xp: 300,
      ),
    ],
  ),
  const RoadmapWeek(
    week: 2,
    title: "Tuần 2: Hán tự N1 & Từ vựng hàn lâm",
    description: "Chinh phục những Kanji khó và từ vựng mang tính học thuật.",
    color: Color(0xFFFFEBEE),
    iconColor: Color(0xFFB71C1C),
    badgeColor: Color(0xFFF44336),
    quests: [
      RoadmapQuest(
        id: 'n1_w2_1',
        title: "Kanji N1: Nghĩa bóng",
        description: "Hiểu sâu nghĩa bóng của các cụm Kanji.",
        type: "flashcard",
        icon: Icons.translate_outlined,
        link: "/exercises/kanji-n1-metaphors",
        xp: 300,
      ),
      RoadmapQuest(
        id: 'n1_w2_2',
        title: "Đọc hiểu: Luận văn & Triết học",
        description: "Luyện đọc các chủ đề trừu tượng.",
        type: "reading",
        icon: Icons.auto_stories_outlined,
        link: "/exercises/reading-n1-essays",
        xp: 400,
      ),
    ],
  ),
  const RoadmapWeek(
    week: 3,
    title: "Tuần 3: Nghe hiểu N1 tốc độ cao",
    description: "Luyện nghe tiếng Nhật với tốc độ người bản xứ.",
    color: Color(0xFFFFEBEE),
    iconColor: Color(0xFFB71C1C),
    badgeColor: Color(0xFFF44336),
    quests: [
      RoadmapQuest(
        id: 'n1_w3_1',
        title: "Nghe hiểu: Phỏng vấn & Thuyết trình",
        description: "Bắt ý chính trong các bài phát biểu dài.",
        type: "test",
        icon: Icons.co_present_outlined,
        link: "/exercises/listening-n1-speech",
        xp: 350,
      ),
      RoadmapQuest(
        id: 'n1_w3_2',
        title: "Ngữ pháp N1: Quán dụng ngữ",
        description: "Các cụm từ cố định (Idioms) người Nhật hay dùng.",
        type: "learn",
        icon: Icons.forum_outlined,
        link: "/exercises/grammar-n1-idioms",
        xp: 300,
      ),
    ],
  ),
  const RoadmapWeek(
    week: 4,
    title: "Tuần 4: Chinh phục đỉnh cao N1",
    description: "Sẵn sàng cho bài thi đánh giá năng lực cao nhất.",
    color: Color(0xFFFFEBEE),
    iconColor: Color(0xFFB71C1C),
    badgeColor: Color(0xFFF44336),
    quests: [
      RoadmapQuest(
        id: 'n1_w4_1',
        title: "Thực hành: Đọc nhanh (Skimming)",
        description: "Kỹ năng tìm kiếm thông tin nhanh trong bài đọc dài.",
        type: "reading",
        icon: Icons.timer_outlined,
        link: "/exercises/reading-n1-skimming",
        xp: 400,
      ),
      RoadmapQuest(
        id: 'n1_w4_2',
        title: "Thi thử N1 (Mock Test)",
        description: "Bài thi thử N1 với độ khó thực tế.",
        type: "test",
        icon: Icons.military_tech_outlined,
        link: "/exercises/mock-test-n1",
        xp: 1000,
      ),
    ],
  ),
];
