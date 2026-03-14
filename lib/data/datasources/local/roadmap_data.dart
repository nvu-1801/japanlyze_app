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
