import '../../../domain/entities/roadmap_models.dart';
import '../../../domain/entities/conversation_models.dart';
// Lưu ý: Nhớ import file chứa model ConversationLesson và VocabItem của bạn nhé.

final List<ConversationLesson> allJlptLessons = [
  // ==========================================
  // DỮ LIỆU N4
  // ==========================================
  ConversationLesson(
    id: 'n4_w1_1',
    title: 'Ôn tập Hiragana/Katakana',
    description: 'Ôn lại bảng chữ cái cơ bản.',
    vocabItems: [
      const VocabItem(
        kanji: '挨拶',
        kana: 'あいさつ',
        romaji: 'aisatsu',
        meaning: 'chào hỏi',
      ),
      const VocabItem(
        kanji: '基本',
        kana: 'きほん',
        romaji: 'kihon',
        meaning: 'cơ bản',
      ),
      const VocabItem(
        kanji: '名前',
        kana: 'なまえ',
        romaji: 'namae',
        meaning: 'tên',
      ),
      const VocabItem(
        kanji: '学校',
        kana: 'がっこう',
        romaji: 'gakkou',
        meaning: 'trường học',
      ),
      const VocabItem(
        kanji: '学生',
        kana: 'がくせい',
        romaji: 'gakusei',
        meaning: 'học sinh',
      ),
      const VocabItem(
        kanji: '先生',
        kana: 'せんせい',
        romaji: 'sensei',
        meaning: 'giáo viên',
      ),
      const VocabItem(
        kanji: '友達',
        kana: 'ともだち',
        romaji: 'tomodachi',
        meaning: 'bạn bè',
      ),
      const VocabItem(
        kanji: '家族',
        kana: 'かぞく',
        romaji: 'kazoku',
        meaning: 'gia đình',
      ),
      const VocabItem(
        kanji: '時間',
        kana: 'じかん',
        romaji: 'jikan',
        meaning: 'thời gian',
      ),
      const VocabItem(
        kanji: '今日',
        kana: 'きょう',
        romaji: 'kyou',
        meaning: 'hôm nay',
      ),
      const VocabItem(
        kanji: '明日',
        kana: 'あした',
        romaji: 'ashita',
        meaning: 'ngày mai',
      ),
      const VocabItem(
        kanji: '昨日',
        kana: 'きのう',
        romaji: 'kinou',
        meaning: 'hôm qua',
      ),
      const VocabItem(
        kanji: '食べ物',
        kana: 'たべもの',
        romaji: 'tabemono',
        meaning: 'đồ ăn',
      ),
      const VocabItem(
        kanji: '飲み物',
        kana: 'のみもの',
        romaji: 'nomimono',
        meaning: 'đồ uống',
      ),
      const VocabItem(
        kanji: '水',
        kana: 'みず',
        romaji: 'mizu',
        meaning: 'nước',
      ),
      const VocabItem(
        kanji: 'お茶',
        kana: 'おちゃ',
        romaji: 'ocha',
        meaning: 'trà',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n4_w1_2',
    title: 'Từ vựng N4: Thiên nhiên',
    description: 'Học từ vựng về thiên nhiên và môi trường.',
    vocabItems: [
      const VocabItem(
        kanji: '森',
        kana: 'もり',
        romaji: 'mori',
        meaning: 'rừng rậm',
      ),
      const VocabItem(
        kanji: '林',
        kana: 'はやし',
        romaji: 'hayashi',
        meaning: 'rừng thưa',
      ),
      const VocabItem(
        kanji: '星',
        kana: 'ほし',
        romaji: 'hoshi',
        meaning: 'ngôi sao',
      ),
      const VocabItem(kanji: '草', kana: 'くさ', romaji: 'kusa', meaning: 'cỏ'),
      const VocabItem(
        kanji: '虫',
        kana: 'むし',
        romaji: 'mushi',
        meaning: 'côn trùng',
      ),
      const VocabItem(
        kanji: '雲',
        kana: 'くも',
        romaji: 'kumo',
        meaning: 'đám mây',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n4_w1_3',
    title: 'Ngữ pháp N4: Thể điều kiện',
    description: 'Làm quen với thể điều kiện ば, と, たら, なら.',
    vocabItems: [
      const VocabItem(
        kanji: '春になれば',
        kana: 'はるになれば',
        romaji: 'haru ni nareba',
        meaning: 'nếu mùa xuân đến',
      ),
      const VocabItem(
        kanji: '雨が降ったら',
        kana: 'あめがふったら',
        romaji: 'ame ga futtara',
        meaning: 'nếu trời mưa',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n4_w2_1',
    title: 'Từ vựng N4: Xã hội',
    description: 'Học từ vựng về xã hội và cộng đồng.',
    vocabItems: [
      const VocabItem(
        kanji: '警察',
        kana: 'けいさつ',
        romaji: 'keisatsu',
        meaning: 'cảnh sát',
      ),
      const VocabItem(
        kanji: '病院',
        kana: 'びょういん',
        romaji: 'byouin',
        meaning: 'bệnh viện',
      ),
      const VocabItem(
        kanji: '法律',
        kana: 'ほうりつ',
        romaji: 'houritsu',
        meaning: 'pháp luật',
      ),
      const VocabItem(
        kanji: '規則',
        kana: 'きそく',
        romaji: 'kisoku',
        meaning: 'quy tắc',
      ),
      const VocabItem(
        kanji: '政治',
        kana: 'せいじ',
        romaji: 'seiji',
        meaning: 'chính trị',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n4_w2_2',
    title: 'Ngữ pháp N4: Kính ngữ cơ bản',
    description: 'Làm quen với Tôn kính ngữ và Khiêm nhường ngữ.',
    vocabItems: [
      const VocabItem(
        kanji: '召し上がる',
        kana: 'めしあがる',
        romaji: 'meshiagaru',
        meaning: 'ăn, uống (Tôn kính ngữ)',
      ),
      const VocabItem(
        kanji: 'いらっしゃる',
        kana: 'いらっしゃる',
        romaji: 'irassharu',
        meaning: 'đi, đến, ở (Tôn kính ngữ)',
      ),
      const VocabItem(
        kanji: '拝見する',
        kana: 'はいけんする',
        romaji: 'haikensuru',
        meaning: 'xem, nhìn (Khiêm nhường ngữ)',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n4_w3_1',
    title: 'Kanji N4: Phần 1',
    description: 'Học các Kanji N4 thường gặp nhất.',
    vocabItems: [
      const VocabItem(
        kanji: '建',
        kana: 'た(てる)',
        romaji: 'ta(teru)',
        meaning: 'kiến (xây dựng)',
      ),
      const VocabItem(
        kanji: '物',
        kana: 'もの',
        romaji: 'mono',
        meaning: 'vật (đồ vật)',
      ),
      const VocabItem(
        kanji: '急',
        kana: 'いそ(ぐ)',
        romaji: 'iso(gu)',
        meaning: 'cấp (vội vàng)',
      ),
      const VocabItem(
        kanji: '乗',
        kana: 'の(る)',
        romaji: 'no(ru)',
        meaning: 'thừa (lên xe)',
      ),
      const VocabItem(
        kanji: '降',
        kana: 'お(りる)',
        romaji: 'o(riru)',
        meaning: 'giáng (xuống xe)',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n4_w3_2',
    title: 'Đọc hiểu: Thông báo & Biển báo',
    description: 'Đọc và dịch các biển báo thực tế tại Nhật.',
    vocabItems: [
      const VocabItem(
        kanji: '注意',
        kana: 'ちゅうい',
        romaji: 'chuui',
        meaning: 'chú ý',
      ),
      const VocabItem(
        kanji: '禁止',
        kana: 'きんし',
        romaji: 'kinshi',
        meaning: 'cấm',
      ),
      const VocabItem(
        kanji: '危険',
        kana: 'きけん',
        romaji: 'kiken',
        meaning: 'nguy hiểm',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n4_w4_1',
    title: 'Luyện nghe N4',
    description: 'Nghe hiểu các đoạn hội thoại thường nhật.',
    vocabItems: [
      const VocabItem(
        kanji: '質問',
        kana: 'しつもん',
        romaji: 'shitsumon',
        meaning: 'câu hỏi',
      ),
      const VocabItem(
        kanji: '答え',
        kana: 'こたえ',
        romaji: 'kotae',
        meaning: 'câu trả lời',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n4_w4_2',
    title: 'Thi thử N4 (Mock Test)',
    description: 'Làm bài thi thử N4 theo cấu trúc chuẩn JLPT.',
    vocabItems: [
      const VocabItem(
        kanji: '試験',
        kana: 'しけん',
        romaji: 'shiken',
        meaning: 'kỳ thi',
      ),
      const VocabItem(
        kanji: '合格',
        kana: 'ごうかく',
        romaji: 'goukaku',
        meaning: 'đỗ, đậu',
      ),
    ],
  ),

  // ==========================================
  // DỮ LIỆU N3
  // ==========================================
  ConversationLesson(
    id: 'n3_w1_1',
    title: 'Ôn tập ngữ pháp N4',
    description: 'Ôn lại các cấu trúc ngữ pháp N4.',
    vocabItems: [
      const VocabItem(
        kanji: '復習',
        kana: 'ふくしゅう',
        romaji: 'fukushuu',
        meaning: 'ôn tập',
      ),
      const VocabItem(
        kanji: '練習',
        kana: 'れんしゅう',
        romaji: 'renshuu',
        meaning: 'luyện tập',
      ),
      const VocabItem(
        kanji: '勉強',
        kana: 'べんきょう',
        romaji: 'benkyou',
        meaning: 'học tập',
      ),
      const VocabItem(
        kanji: '文法',
        kana: 'ぶんぽう',
        romaji: 'bunpou',
        meaning: 'ngữ pháp',
      ),
      const VocabItem(
        kanji: '例文',
        kana: 'れいぶん',
        romaji: 'reibun',
        meaning: 'câu ví dụ',
      ),
      const VocabItem(
        kanji: '動詞',
        kana: 'どうし',
        romaji: 'doushi',
        meaning: 'động từ',
      ),
      const VocabItem(
        kanji: '形容詞',
        kana: 'けいようし',
        romaji: 'keiyoushi',
        meaning: 'tính từ',
      ),
      const VocabItem(
        kanji: '副詞',
        kana: 'ふくし',
        romaji: 'fukushi',
        meaning: 'trạng từ',
      ),
      const VocabItem(
        kanji: '接続',
        kana: 'せつぞく',
        romaji: 'setsuzoku',
        meaning: 'kết nối',
      ),
      const VocabItem(
        kanji: '条件',
        kana: 'じょうけん',
        romaji: 'jouken',
        meaning: 'điều kiện',
      ),
      const VocabItem(
        kanji: '理由',
        kana: 'りゆう',
        romaji: 'riyuu',
        meaning: 'lý do',
      ),
      const VocabItem(
        kanji: '目的',
        kana: 'もくてき',
        romaji: 'mokuteki',
        meaning: 'mục đích',
      ),
      const VocabItem(
        kanji: '結果',
        kana: 'けっか',
        romaji: 'kekka',
        meaning: 'kết quả',
      ),
      const VocabItem(
        kanji: '変化',
        kana: 'へんか',
        romaji: 'henka',
        meaning: 'thay đổi',
      ),
      const VocabItem(
        kanji: '表現',
        kana: 'ひょうげん',
        romaji: 'hyougen',
        meaning: 'biểu đạt',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n3_w1_2',
    title: 'Ngữ pháp N3: Mệnh đề phức',
    description: 'Học cách sử dụng mệnh đề phức trong N3.',
    vocabItems: [
      const VocabItem(
        kanji: '〜について',
        kana: '〜について',
        romaji: '~ni tsuite',
        meaning: 'về vấn đề...',
      ),
      const VocabItem(
        kanji: '〜にとって',
        kana: '〜にとって',
        romaji: '~ni totte',
        meaning: 'đối với...',
      ),
      const VocabItem(
        kanji: '〜に比べて',
        kana: '〜にくらべて',
        romaji: '~ni kurabete',
        meaning: 'so với...',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n3_w2_1',
    title: 'Từ vựng N3: Cảm xúc & Tính cách',
    description: 'Từ vựng miêu tả trạng thái và tâm lý.',
    vocabItems: [
      const VocabItem(
        kanji: '怒る',
        kana: 'おこる',
        romaji: 'okoru',
        meaning: 'tức giận',
      ),
      const VocabItem(kanji: '泣く', kana: 'なく', romaji: 'naku', meaning: 'khóc'),
      const VocabItem(
        kanji: '喜ぶ',
        kana: 'よろこぶ',
        romaji: 'yorokobu',
        meaning: 'vui mừng',
      ),
      const VocabItem(
        kanji: '悲しい',
        kana: 'かなしい',
        romaji: 'kanashii',
        meaning: 'đau buồn',
      ),
      const VocabItem(
        kanji: '寂しい',
        kana: 'さびしい',
        romaji: 'sabishii',
        meaning: 'cô đơn',
      ),
      const VocabItem(
        kanji: '厳しい',
        kana: 'きびしい',
        romaji: 'kibishii',
        meaning: 'nghiêm khắc',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n3_w2_2',
    title: 'Ngữ pháp N3: Sự cho nhận',
    description: 'Học sâu hơn về V-te morau/kureru/ageru.',
    vocabItems: [
      const VocabItem(
        kanji: 'もらう',
        kana: 'もらう',
        romaji: 'morau',
        meaning: 'nhận được',
      ),
      const VocabItem(
        kanji: 'くれる',
        kana: 'くれる',
        romaji: 'kureru',
        meaning: 'ai đó cho mình',
      ),
      const VocabItem(
        kanji: 'あげる',
        kana: 'あげる',
        romaji: 'ageru',
        meaning: 'mình cho ai đó',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n3_w3_1',
    title: 'Kanji N3: Ký tự ghép (Jukugo)',
    description: 'Học các từ ghép Kanji thường thi.',
    vocabItems: [
      const VocabItem(
        kanji: '準備',
        kana: 'じゅんび',
        romaji: 'junbi',
        meaning: 'chuẩn bị',
      ),
      const VocabItem(
        kanji: '経験',
        kana: 'けいけん',
        romaji: 'keiken',
        meaning: 'kinh nghiệm',
      ),
      const VocabItem(
        kanji: '案内',
        kana: 'あんない',
        romaji: 'annai',
        meaning: 'hướng dẫn',
      ),
      const VocabItem(
        kanji: '紹介',
        kana: 'しょうかい',
        romaji: 'shoukai',
        meaning: 'giới thiệu',
      ),
      const VocabItem(
        kanji: '相談',
        kana: 'そうだん',
        romaji: 'soudan',
        meaning: 'thảo luận',
      ),
      const VocabItem(
        kanji: '連絡',
        kana: 'れんらく',
        romaji: 'renraku',
        meaning: 'liên lạc',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n3_w3_2',
    title: 'Đọc hiểu: Bài báo ngắn',
    description: 'Đọc và trả lời câu hỏi từ các tin tức Nhật Bản.',
    vocabItems: [
      const VocabItem(
        kanji: '記事',
        kana: 'きじ',
        romaji: 'kiji',
        meaning: 'bài báo',
      ),
      const VocabItem(
        kanji: '事実',
        kana: 'じじつ',
        romaji: 'jijitsu',
        meaning: 'sự thật',
      ),
      const VocabItem(
        kanji: '意見',
        kana: 'いけん',
        romaji: 'iken',
        meaning: 'ý kiến',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n3_w4_1',
    title: 'Luyện nghe N3: Bắt từ khóa',
    description: 'Kỹ năng nghe có chủ đích trong bài thi.',
    vocabItems: [
      const VocabItem(
        kanji: '要点',
        kana: 'ようてん',
        romaji: 'youten',
        meaning: 'điểm chính',
      ),
      const VocabItem(
        kanji: '結論',
        kana: 'けつろん',
        romaji: 'ketsuron',
        meaning: 'kết luận',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n3_w4_2',
    title: 'Thi thử N3 (Mock Test)',
    description: 'Đánh giá toàn diện kiến thức N3.',
    vocabItems: [
      const VocabItem(
        kanji: '満点',
        kana: 'まんてん',
        romaji: 'manten',
        meaning: 'điểm tối đa',
      ),
      const VocabItem(
        kanji: '不合格',
        kana: 'ふごうかく',
        romaji: 'fugoukaku',
        meaning: 'trượt',
      ),
    ],
  ),

  // ==========================================
  // DỮ LIỆU N2
  // ==========================================
  ConversationLesson(
    id: 'n2_w1_1',
    title: 'Ôn tập Kanji N3',
    description: 'Ôn lại các Kanji N3 quan trọng.',
    vocabItems: [
      const VocabItem(
        kanji: '復帰',
        kana: 'ふっき',
        romaji: 'fukki',
        meaning: 'quay lại, khôi phục',
      ),
      const VocabItem(
        kanji: '準備',
        kana: 'じゅんび',
        romaji: 'junbi',
        meaning: 'chuẩn bị',
      ),
      const VocabItem(
        kanji: '経験',
        kana: 'けいけん',
        romaji: 'keiken',
        meaning: 'kinh nghiệm',
      ),
      const VocabItem(
        kanji: '案内',
        kana: 'あんない',
        romaji: 'annai',
        meaning: 'hướng dẫn',
      ),
      const VocabItem(
        kanji: '紹介',
        kana: 'しょうかい',
        romaji: 'shoukai',
        meaning: 'giới thiệu',
      ),
      const VocabItem(
        kanji: '相談',
        kana: 'そうだん',
        romaji: 'soudan',
        meaning: 'thảo luận',
      ),
      const VocabItem(
        kanji: '連絡',
        kana: 'れんらく',
        romaji: 'renraku',
        meaning: 'liên lạc',
      ),
      const VocabItem(
        kanji: '確認',
        kana: 'かくにん',
        romaji: 'kakunin',
        meaning: 'xác nhận',
      ),
      const VocabItem(
        kanji: '説明',
        kana: 'せつめい',
        romaji: 'setsumei',
        meaning: 'giải thích',
      ),
      const VocabItem(
        kanji: '理解',
        kana: 'りかい',
        romaji: 'rikai',
        meaning: 'hiểu biết',
      ),
      const VocabItem(
        kanji: '努力',
        kana: 'どりょく',
        romaji: 'doryoku',
        meaning: 'nỗ lực',
      ),
      const VocabItem(
        kanji: '成功',
        kana: 'せいこう',
        romaji: 'seikou',
        meaning: 'thành công',
      ),
      const VocabItem(
        kanji: '失敗',
        kana: 'しっぱい',
        romaji: 'shippai',
        meaning: 'thất bại',
      ),
      const VocabItem(
        kanji: '進歩',
        kana: 'しんぽ',
        romaji: 'shinpo',
        meaning: 'tiến bộ',
      ),
      const VocabItem(
        kanji: '発展',
        kana: 'はってん',
        romaji: 'hatten',
        meaning: 'phát triển',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n2_w1_2',
    title: 'Kanji N2: Từ ghép phức tạp',
    description: 'Học các từ ghép phức tạp trong N2.',
    vocabItems: [
      const VocabItem(
        kanji: '条件',
        kana: 'じょうけん',
        romaji: 'jouken',
        meaning: 'điều kiện',
      ),
      const VocabItem(
        kanji: '状態',
        kana: 'じょうたい',
        romaji: 'joutai',
        meaning: 'trạng thái',
      ),
      const VocabItem(
        kanji: '影響',
        kana: 'えいきょう',
        romaji: 'eikyou',
        meaning: 'ảnh hưởng',
      ),
      const VocabItem(
        kanji: '評価',
        kana: 'ひょうか',
        romaji: 'hyouka',
        meaning: 'đánh giá',
      ),
      const VocabItem(
        kanji: '態度',
        kana: 'たいど',
        romaji: 'taido',
        meaning: 'thái độ',
      ),
      const VocabItem(
        kanji: '傾向',
        kana: 'けいこう',
        romaji: 'keikou',
        meaning: 'khuynh hướng',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n2_w2_1',
    title: 'Ngữ pháp N2: Văn viết',
    description: 'Các mẫu ngữ pháp thường dùng trong báo chí.',
    vocabItems: [
      const VocabItem(
        kanji: '〜に際して',
        kana: '〜にさいして',
        romaji: '~ni saishite',
        meaning: 'khi, nhân dịp...',
      ),
      const VocabItem(
        kanji: '〜に伴って',
        kana: '〜にともなって',
        romaji: '~ni tomonatte',
        meaning: 'cùng với...',
      ),
      const VocabItem(
        kanji: '〜を問わず',
        kana: '〜をとわず',
        romaji: '~o towazu',
        meaning: 'bất kể...',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n2_w2_2',
    title: 'Đọc hiểu: Quan điểm tác giả',
    description: 'Luyện kỹ năng nắm bắt ý chính của tác giả.',
    vocabItems: [
      const VocabItem(
        kanji: '筆者',
        kana: 'ひっしゃ',
        romaji: 'hissha',
        meaning: 'tác giả',
      ),
      const VocabItem(
        kanji: '主張',
        kana: 'しゅちょう',
        romaji: 'shuchou',
        meaning: 'chủ trương, quan điểm',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n2_w3_1',
    title: 'Từ vựng N2: Kinh doanh',
    description: 'Từ vựng sử dụng trong công ty Nhật Bản.',
    vocabItems: [
      const VocabItem(
        kanji: '営業',
        kana: 'えいぎょう',
        romaji: 'eigyou',
        meaning: 'kinh doanh, doanh số',
      ),
      const VocabItem(
        kanji: '企画',
        kana: 'きかく',
        romaji: 'kikaku',
        meaning: 'kế hoạch, dự án',
      ),
      const VocabItem(
        kanji: '報告',
        kana: 'ほうこく',
        romaji: 'houkoku',
        meaning: 'báo cáo',
      ),
      const VocabItem(
        kanji: '契約',
        kana: 'けいやく',
        romaji: 'keiyaku',
        meaning: 'hợp đồng',
      ),
      const VocabItem(
        kanji: '利益',
        kana: 'りえき',
        romaji: 'rieki',
        meaning: 'lợi nhuận',
      ),
      const VocabItem(
        kanji: '実績',
        kana: 'じっせき',
        romaji: 'jisseki',
        meaning: 'thành tích',
      ),
      const VocabItem(
        kanji: '納期',
        kana: 'のうき',
        romaji: 'nouki',
        meaning: 'thời hạn giao hàng',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n2_w4_1',
    title: 'Luyện nghe N2: Tin tức',
    description: 'Nghe hiểu các bản tin thời sự tiếng Nhật.',
    vocabItems: [
      const VocabItem(
        kanji: '報道',
        kana: 'ほうどう',
        romaji: 'houdou',
        meaning: 'thông tấn, báo cáo',
      ),
      const VocabItem(
        kanji: '放送',
        kana: 'ほうそう',
        romaji: 'housou',
        meaning: 'phát sóng',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n2_w4_2',
    title: 'Thi thử N2 (Mock Test)',
    description: 'Thử sức với đề thi N2 chuẩn hóa.',
    vocabItems: [
      const VocabItem(
        kanji: '本番',
        kana: 'ほんばん',
        romaji: 'honban',
        meaning: 'làm thật, thi thật',
      ),
      const VocabItem(
        kanji: '実力',
        kana: 'じつりょく',
        romaji: 'jitsuryoku',
        meaning: 'thực lực',
      ),
    ],
  ),

  // ==========================================
  // DỮ LIỆU N1
  // ==========================================
  ConversationLesson(
    id: 'n1_w1_1',
    title: 'Ôn tập ngữ pháp N2',
    description: 'Ôn lại các cấu trúc ngữ pháp N2 nâng cao.',
    vocabItems: [
      const VocabItem(
        kanji: '基礎',
        kana: 'きそ',
        romaji: 'kiso',
        meaning: 'cơ sở, nền tảng',
      ),
      const VocabItem(
        kanji: '構造',
        kana: 'こうぞう',
        romaji: 'kouzou',
        meaning: 'cấu trúc',
      ),
      const VocabItem(
        kanji: '体系',
        kana: 'たいけい',
        romaji: 'taikei',
        meaning: 'hệ thống',
      ),
      const VocabItem(
        kanji: '規則',
        kana: 'きそく',
        romaji: 'kisoku',
        meaning: 'quy tắc',
      ),
      const VocabItem(
        kanji: '原則',
        kana: 'げんそく',
        romaji: 'gensoku',
        meaning: 'nguyên tắc',
      ),
      const VocabItem(
        kanji: '例外',
        kana: 'れいがい',
        romaji: 'reigai',
        meaning: 'ngoại lệ',
      ),
      const VocabItem(
        kanji: '仮定',
        kana: 'かてい',
        romaji: 'katei',
        meaning: 'giả định',
      ),
      const VocabItem(
        kanji: '前提',
        kana: 'ぜんてい',
        romaji: 'zentei',
        meaning: 'tiền đề',
      ),
      const VocabItem(
        kanji: '必然',
        kana: 'ひつぜん',
        romaji: 'hitsuzen',
        meaning: 'tất yếu',
      ),
      const VocabItem(
        kanji: '偶然',
        kana: 'ぐうぜん',
        romaji: 'guuzen',
        meaning: 'tình cờ',
      ),
      const VocabItem(
        kanji: '抽象',
        kana: 'ちゅうしょう',
        romaji: 'chuushou',
        meaning: 'trừu tượng',
      ),
      const VocabItem(
        kanji: '具体',
        kana: 'ぐたい',
        romaji: 'gutai',
        meaning: 'cụ thể',
      ),
      const VocabItem(
        kanji: '分析',
        kana: 'ぶんせき',
        romaji: 'bunseki',
        meaning: 'phân tích',
      ),
      const VocabItem(
        kanji: '総合',
        kana: 'そうごう',
        romaji: 'sougou',
        meaning: 'tổng hợp',
      ),
      const VocabItem(
        kanji: '論理',
        kana: 'ろんり',
        romaji: 'ronri',
        meaning: 'lôgic',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n1_w1_2',
    title: 'Ngữ pháp N1: Biểu đạt tinh tế',
    description: 'Học các cách biểu đạt tinh tế trong N1.',
    vocabItems: [
      const VocabItem(
        kanji: '〜であれ',
        kana: '〜であれ',
        romaji: '~de are',
        meaning: 'cho dù là...',
      ),
      const VocabItem(
        kanji: '〜極まる',
        kana: '〜きわまる',
        romaji: '~kiwamaru',
        meaning: 'cực kỳ...',
      ),
      const VocabItem(
        kanji: '〜を余儀なくされる',
        kana: '〜をよぎなくされる',
        romaji: '~o yoginaku sareru',
        meaning: 'buộc phải...',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n1_w2_1',
    title: 'Kanji N1: Nghĩa bóng',
    description: 'Hiểu sâu nghĩa bóng của các cụm Kanji.',
    vocabItems: [
      const VocabItem(
        kanji: '妥協',
        kana: 'だきょう',
        romaji: 'dakyou',
        meaning: 'thỏa hiệp',
      ),
      const VocabItem(
        kanji: '懸念',
        kana: 'けねん',
        romaji: 'kenen',
        meaning: 'lo ngại, bận tâm',
      ),
      const VocabItem(
        kanji: '促進',
        kana: 'そくしん',
        romaji: 'sokushin',
        meaning: 'thúc đẩy, xúc tiến',
      ),
      const VocabItem(
        kanji: '矛盾',
        kana: 'むじゅん',
        romaji: 'mujun',
        meaning: 'mâu thuẫn',
      ),
      const VocabItem(
        kanji: '貢献',
        kana: 'こうけん',
        romaji: 'kouken',
        meaning: 'cống hiến, đóng góp',
      ),
      const VocabItem(
        kanji: '排除',
        kana: 'はいじょ',
        romaji: 'haijo',
        meaning: 'loại trừ, bài trừ',
      ),
      const VocabItem(
        kanji: '把握',
        kana: 'はあく',
        romaji: 'haaku',
        meaning: 'nắm bắt, thấu hiểu',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n1_w2_2',
    title: 'Đọc hiểu: Luận văn & Triết học',
    description: 'Luyện đọc các chủ đề trừu tượng.',
    vocabItems: [
      const VocabItem(
        kanji: '概念',
        kana: 'がいねん',
        romaji: 'gainen',
        meaning: 'khái niệm',
      ),
      const VocabItem(
        kanji: '哲学',
        kana: 'てつがく',
        romaji: 'tetsugaku',
        meaning: 'triết học',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n1_w3_1',
    title: 'Nghe hiểu: Phỏng vấn',
    description: 'Bắt ý chính trong các bài phát biểu dài.',
    vocabItems: [
      const VocabItem(
        kanji: '対談',
        kana: 'たいだん',
        romaji: 'taidan',
        meaning: 'cuộc đối thoại, phỏng vấn',
      ),
      const VocabItem(
        kanji: '討論',
        kana: 'とうろん',
        romaji: 'touron',
        meaning: 'thảo luận, tranh luận',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n1_w3_2',
    title: 'Ngữ pháp N1: Quán dụng ngữ (Idioms)',
    description: 'Các cụm từ cố định (Idioms) người Nhật hay dùng.',
    vocabItems: [
      const VocabItem(
        kanji: '気が散る',
        kana: 'きがちる',
        romaji: 'ki ga chiru',
        meaning: 'bị phân tâm',
      ),
      const VocabItem(
        kanji: '腹が立つ',
        kana: 'はらがたつ',
        romaji: 'hara ga tatsu',
        meaning: 'phát tức, nổi giận',
      ),
      const VocabItem(
        kanji: '耳が痛い',
        kana: 'みみがいたい',
        romaji: 'mimi ga itai',
        meaning: 'chướng tai, xấu hổ khi nghe',
      ),
      const VocabItem(
        kanji: '頭が下がる',
        kana: 'あたまがさがる',
        romaji: 'atama ga sagaru',
        meaning: 'khâm phục, kính trọng',
      ),
      const VocabItem(
        kanji: '目がない',
        kana: 'めがない',
        romaji: 'me ga nai',
        meaning: 'cực kỳ thích, mê mẩn',
      ),
      const VocabItem(
        kanji: '手を抜く',
        kana: 'てをぬく',
        romaji: 'te o nuku',
        meaning: 'làm qua loa, lơ là',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n1_w4_1',
    title: 'Thực hành: Đọc nhanh (Skimming)',
    description: 'Kỹ năng tìm kiếm thông tin nhanh trong bài đọc dài.',
    vocabItems: [
      const VocabItem(
        kanji: '抜粋',
        kana: 'ばっすい',
        romaji: 'bassui',
        meaning: 'trích dẫn, trích đoạn',
      ),
      const VocabItem(
        kanji: '要約',
        kana: 'ようやく',
        romaji: 'youyaku',
        meaning: 'tóm tắt',
      ),
    ],
  ),
  ConversationLesson(
    id: 'n1_w4_2',
    title: 'Thi thử N1 (Mock Test)',
    description: 'Bài thi thử N1 với độ khó thực tế.',
    vocabItems: [
      const VocabItem(
        kanji: '究極',
        kana: 'きゅうきょく',
        romaji: 'kyuukyoku',
        meaning: 'tối hậu, cuối cùng',
      ),
      const VocabItem(
        kanji: '達成',
        kana: 'たっせい',
        romaji: 'tassei',
        meaning: 'đạt được, hoàn thành',
      ),
    ],
  ),
];
