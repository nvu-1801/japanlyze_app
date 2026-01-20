
import 'package:flutter/material.dart';
import '../../../domain/entities/conversation_models.dart';
import 'conversation_data_part1.dart';
import 'conversation_data_part2.dart';
import 'conversation_data_part3.dart';
import 'vocab_data.dart';

// Mapping icons from Web (Lucide) to Flutter (Material or Lucide)
// Web: Type, BookA, Hash, UtensilsCrossed, Trophy, CloudSun, School, Briefcase, PawPrint, Users, Apple, Carrot, Music, Cpu, Armchair, Clapperboard, Palette, Globe, Smile, Plane, AlarmClock, Shirt, MessageCircle, Heart, PartyPopper, UserCheck, MapPin, BookOpen, ShoppingBag, Leaf, Map, Home, Utensils, Stethoscope, HandCoins
// ... (comments kept)

final List<LessonCategory> exerciseCategories = [
  LessonCategory(
    title: "Nhập môn (Trắc nghiệm)",
    lessons: [
      LessonItem(id: 'hiragana', title: 'Hiragana (Chữ mềm)', icon: Icons.text_fields, color: Colors.pink[600], backgroundColor: Colors.pink[50]),
      LessonItem(id: 'katakana', title: 'Katakana (Chữ cứng)', icon: Icons.auto_stories, color: Colors.blue[600], backgroundColor: Colors.blue[50]),
    ],
  ),
  LessonCategory(
    title: "Từ vựng theo chủ đề",
    lessons: [
      LessonItem(id: 'numbers', title: 'Số đếm & Thời gian', icon: Icons.numbers, color: Colors.green[600], backgroundColor: Colors.green[50]),
      LessonItem(id: 'food', title: 'Ẩm thực Nhật Bản', icon: Icons.restaurant, color: Colors.orange[600], backgroundColor: Colors.orange[50]),
      LessonItem(id: 'sports', title: 'Thể thao & Vận động', icon: Icons.emoji_events, color: Colors.cyan[600], backgroundColor: Colors.cyan[50]),
      LessonItem(id: 'weather', title: 'Thời tiết & Mùa', icon: Icons.cloud, color: Colors.lightBlue[600], backgroundColor: Colors.lightBlue[50]),
      LessonItem(id: 'school', title: 'Trường học & Giáo dục', icon: Icons.school, color: Colors.indigo[600], backgroundColor: Colors.indigo[50]),
      LessonItem(id: 'jobs', title: 'Nghề nghiệp', icon: Icons.work, color: Colors.grey[700], backgroundColor: Colors.grey[100]),
      LessonItem(id: 'animals', title: 'Thế giới Động vật', icon: Icons.pets, color: Colors.pink[600], backgroundColor: Colors.pink[50]),
      LessonItem(id: 'family', title: 'Gia đình & Người thân', icon: Icons.people, color: Colors.red[600], backgroundColor: Colors.red[50]),
      LessonItem(id: 'fruits', title: 'Trái cây & Hoa quả', icon: Icons.local_grocery_store, color: Colors.red[500], backgroundColor: Colors.red[50]),
      LessonItem(id: 'vegetables', title: 'Rau củ & Nông sản', icon: Icons.grass, color: Colors.green[600], backgroundColor: Colors.green[50]),
      LessonItem(id: 'music', title: 'Âm nhạc & Nhạc cụ', icon: Icons.music_note, color: Colors.purple[600], backgroundColor: Colors.purple[50]),
      LessonItem(id: 'electronics', title: 'Điện tử & Linh kiện', icon: Icons.memory, color: Colors.blue[700], backgroundColor: Colors.blue[100]),
      LessonItem(id: 'household', title: 'Đồ gia dụng & Nội thất', icon: Icons.chair, color: Colors.amber[700], backgroundColor: Colors.amber[100]),
      LessonItem(id: 'media', title: 'Phim ảnh & Truyền thông', icon: Icons.movie, color: Colors.deepPurple[600], backgroundColor: Colors.deepPurple[50]),
      LessonItem(id: 'hobbies', title: 'Sở thích & Giải trí', icon: Icons.palette, color: Colors.pink[500], backgroundColor: Colors.pink[50]),
    ],
  ),
   LessonCategory(
    title: "Luyện hội thoại (Conversation)",
    lessons: [
      LessonItem(id: 'conv_1_intro', title: '1. Giới thiệu bản thân', icon: Icons.people, color: Colors.pink[600], backgroundColor: Colors.pink[50]),
      LessonItem(id: 'conv_2_hometown', title: '2. Quê quán', icon: Icons.home, color: Colors.blue[600], backgroundColor: Colors.blue[50]),
      LessonItem(id: 'conv_3_friends', title: '3. Bạn thân', icon: Icons.sentiment_satisfied, color: Colors.orange[600], backgroundColor: Colors.orange[50]),
      LessonItem(id: 'conv_4_subject', title: '4. Môn học yêu thích', icon: Icons.school, color: Colors.indigo[600], backgroundColor: Colors.indigo[50]),
      LessonItem(id: 'conv_5_job', title: '5. Công việc', icon: Icons.work, color: Colors.grey[700], backgroundColor: Colors.grey[100]),
      LessonItem(id: 'conv_6_shopping', title: '6. Mua sắm', icon: Icons.shopping_bag, color: Colors.green[600], backgroundColor: Colors.green[50]),
      LessonItem(id: 'conv_7_interview', title: '7. Phỏng vấn', icon: Icons.mic, color: Colors.deepPurple[600], backgroundColor: Colors.deepPurple[50]),
      LessonItem(id: 'conv_8_environment', title: '8. Bảo vệ môi trường', icon: Icons.eco, color: Colors.teal[600], backgroundColor: Colors.teal[50]),
      LessonItem(id: 'conv_9_direction', title: '9. Hỏi đường', icon: Icons.map, color: Colors.red[600], backgroundColor: Colors.red[50]),
      LessonItem(id: 'conv_10_family', title: '10. Gia đình', icon: Icons.family_restroom, color: Colors.brown[600], backgroundColor: Colors.brown[50]),
      LessonItem(id: 'conv_11_travel', title: '11. Du lịch', icon: Icons.flight, color: Colors.lightBlue[600], backgroundColor: Colors.lightBlue[50]),
      LessonItem(id: 'conv_12_hobby', title: '12. Sở thích', icon: Icons.palette, color: Colors.purple[600], backgroundColor: Colors.purple[50]),
      LessonItem(id: 'conv_13_food', title: '13. Đồ ăn', icon: Icons.restaurant, color: Colors.orange[700], backgroundColor: Colors.orange[100]),
      LessonItem(id: 'conv_14_health', title: '14. Sức khỏe', icon: Icons.medical_services, color: Colors.red[400], backgroundColor: Colors.red[50]),
      LessonItem(id: 'conv_15_money', title: '15. Tiền bạc', icon: Icons.monetization_on, color: Colors.amber[600], backgroundColor: Colors.amber[50]),
    ],
  ),
];


final List<ConversationLesson> conversationData = [
  ...conversationDataPart1,
  ...conversationDataPart2,
  ...conversationDataPart3,
  ...vocabLessonData,
];
