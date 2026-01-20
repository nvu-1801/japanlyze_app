
import '../../../domain/entities/conversation_models.dart';

final List<ConversationLesson> conversationDataPart2 = [
  // --- HỘI THOẠI 6: MUA SẮM (CHIKI & AKI) ---
  ConversationLesson(
    id: 'conv_6_shopping',
    title: '6. Mua sắm (買い物)',
    description: 'Hội thoại về việc đi siêu thị, mua đồ ăn và hỏi giá tiền.',
    characters: [CharacterName.chiki, CharacterName.aki],
    prerequisites: ['food', 'numbers'],
    lines: [
      const DialogueLine(
        id: 1,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "今日", furigana: "きょう"), Segment(text: "は"), Segment(text: "買い物", furigana: "かいもの"), Segment(text: "に"), Segment(text: "行", furigana: "い"), Segment(text: "きますか。")],
        kana: 'きょうはかいものにいきますか。',
        romaji: 'Kyou wa kaimono ni ikimasu ka?',
        meaning: 'Hôm nay bạn có đi mua sắm không?',
      ),
      const DialogueLine(
        id: 2,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "買い物", furigana: "かいもの"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Bán hàng', 'Mua sắm', 'Nấu ăn'],
        correctOptionIndex: 1,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は...")],
        kana: 'いみは...',
        romaji: 'Imi wa...',
        meaning: '💡 Giải thích: "Kaimono" (Cai vật) nghĩa là Mua sắm/Đi chợ.',
      ),
      const DialogueLine(
        id: 3,
        speaker: CharacterName.aki,
        segments: [Segment(text: "はい、"), Segment(text: "行", furigana: "い"), Segment(text: "きます。")],
        kana: 'はい、いきます。',
        romaji: 'Hai, ikimasu.',
        meaning: 'Vâng, có đi.',
      ),
      const DialogueLine(
        id: 4,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "行", furigana: "い"), Segment(text: "きます」はどの"), Segment(text: "形", furigana: "かたち"), Segment(text: "？")
        ],
        quizOptions: ['Quá khứ', 'Hiện tại / Tương lai', 'Mệnh lệnh'],
        correctOptionIndex: 1,
        segments: [Segment(text: "時制", furigana: "じせい"), Segment(text: "は...")],
        kana: 'じせいは...',
        romaji: 'Jisei wa...',
        meaning: '💡 Giải thích: "Ikimasu" (Thể Masu) dùng cho thì hiện tại hoặc tương lai (Sẽ đi/Đi).',
      ),
      const DialogueLine(
        id: 5,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "どこで"), Segment(text: "買い物", furigana: "かいもの"), Segment(text: "をしますか。")],
        kana: 'どこでかいものをしますか。',
        romaji: 'Doko de kaimono o shimasu ka?',
        meaning: 'Bạn mua sắm ở đâu?',
      ),
      const DialogueLine(
        id: 6,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "買い物", furigana: "かいもの"), Segment(text: "をします」の「を」は？")
        ],
        quizOptions: ['Chỉ nơi chốn', 'Chỉ hành động tác động (Tân ngữ)', 'Chỉ thời gian'],
        correctOptionIndex: 1,
        segments: [Segment(text: "目的語", furigana: "もくてきご"), Segment(text: "を...")],
        kana: 'もくてきごを...',
        romaji: 'Mokutekigo o...',
        meaning: '💡 Giải thích: Trợ từ "O" (Wo) chỉ đối tượng của hành động (Làm cái gì? -> Mua sắm).',
      ),
      const DialogueLine(
        id: 7,
        speaker: CharacterName.aki,
        segments: [Segment(text: "スーパーで"), Segment(text: "買い物", furigana: "かいもの"), Segment(text: "をします。")],
        kana: 'スーパーでかいものをします。',
        romaji: 'Suupaa de kaimono o shimasu.',
        meaning: 'Tôi mua sắm ở siêu thị.',
      ),
      const DialogueLine(
        id: 8,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "練習", furigana: "れんしゅう"), Segment(text: ": スーパー ______ "), Segment(text: "買い物", furigana: "かいもの"), Segment(text: "をします。(Điền trợ từ)")
        ],
        quizOptions: ['で (de)', 'に (ni)', 'へ (he)'],
        correctOptionIndex: 0,
        segments: [Segment(text: "場所", furigana: "ばしょ"), Segment(text: "で...")],
        kana: 'ばしょで...',
        romaji: 'Basho de...',
        meaning: '💡 Giải thích: Trợ từ "De" dùng để chỉ địa điểm diễn ra hành động (Mua sắm TẠI siêu thị).',
      ),
      const DialogueLine(
        id: 9,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「スーパー」は"), Segment(text: "何", furigana: "なん"), Segment(text: "ですか。")
        ],
        quizOptions: ['Siêu thị', 'Cửa hàng tiện lợi (Konbini)', 'Chợ (Ichiba)'],
        correctOptionIndex: 0,
        segments: [Segment(text: "カタカナ語", furigana: "ご"), Segment(text: "です。")],
        kana: 'カタカナごです。',
        romaji: 'Katakanago desu.',
        meaning: '💡 Giải thích: "Suupaa" là từ vay mượn của "Supermarket" (Siêu thị).',
      ),
      const DialogueLine(
        id: 10,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "何", furigana: "なに"), Segment(text: "を"), Segment(text: "買", furigana: "か"), Segment(text: "いますか。")],
        kana: 'なにをかいますか。',
        romaji: 'Nani o kaimasu ka?',
        meaning: 'Bạn mua cái gì?',
      ),
      const DialogueLine(
        id: 11,
        speaker: CharacterName.aki,
        segments: [Segment(text: "りんごとパンを"), Segment(text: "買", furigana: "か"), Segment(text: "います。")],
        kana: 'りんごとパンをかいます。',
        romaji: 'Ringo to pan o kaimasu.',
        meaning: 'Tôi mua táo và bánh mì.',
      ),
      const DialogueLine(
        id: 12,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "練習", furigana: "れんしゅう"), Segment(text: ": りんごとパンを ______ ます。(Động từ Mua)")
        ],
        quizOptions: ['買い (Kaimasu)', '行き (Ikimasu)', '食べ (Tabemasu)'],
        correctOptionIndex: 0,
        segments: [Segment(text: "「"), Segment(text: "買", furigana: "か"), Segment(text: "う」の...")],
        kana: 'かうの...',
        romaji: 'Kau no...',
        meaning: '💡 Giải thích: Động từ "Mua" là "Kau", chuyển sang thể Masu là "Kaimasu".',
      ),
      const DialogueLine(
        id: 13,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "それはいくらですか。")],
        kana: 'それはいくらですか。',
        romaji: 'Sore wa ikura desu ka?',
        meaning: 'Cái đó bao nhiêu tiền?',
      ),
      const DialogueLine(
        id: 14,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「いくら」は"), Segment(text: "何", furigana: "なに"), Segment(text: "を"), Segment(text: "聞", furigana: "き"), Segment(text: "きますか？")
        ],
        quizOptions: ['Số lượng (Ikutsu)', 'Giá tiền', 'Thời gian (Itsu)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "値段", furigana: "ねだん"), Segment(text: "を...")],
        kana: 'ねだんを...',
        romaji: 'Nedan o...',
        meaning: '💡 Giải thích: "Ikura" dùng để hỏi giá tiền (Bao nhiêu?).',
      ),
      const DialogueLine(
        id: 15,
        speaker: CharacterName.aki,
        segments: [Segment(text: "500"), Segment(text: "円", furigana: "えん"), Segment(text: "です。")],
        kana: 'ごひゃくえんです。',
        romaji: 'Gohyaku-en desu.',
        meaning: 'Là 500 yên.',
      ),
      const DialogueLine(
        id: 16,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "安", furigana: "やす"), Segment(text: "いですか。")],
        kana: 'やすいですか。',
        romaji: 'Yasui desu ka?',
        meaning: 'Có rẻ không?',
      ),
      const DialogueLine(
        id: 17,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "安", furigana: "やす"), Segment(text: "い」はどの"), Segment(text: "種類", furigana: "しゅるい"), Segment(text: "？")
        ],
        quizOptions: ['Tính từ đuôi I', 'Tính từ đuôi Na', 'Danh từ'],
        correctOptionIndex: 0,
        segments: [Segment(text: "「い」で"), Segment(text: "終", furigana: "お"), Segment(text: "わる...")],
        kana: 'いでおわる...',
        romaji: 'I de owaru...',
        meaning: '💡 Giải thích: "Yasui" kết thúc bằng "i", là tính từ đuôi I (Rẻ).',
      ),
      const DialogueLine(
        id: 18,
        speaker: CharacterName.aki,
        segments: [Segment(text: "はい、"), Segment(text: "安", furigana: "やす"), Segment(text: "いです。")],
        kana: 'はい、やすいです。',
        romaji: 'Hai, yasui desu.',
        meaning: 'Vâng, rẻ.',
      ),
      const DialogueLine(
        id: 19,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": どこで"), Segment(text: "買い物", furigana: "かいもの"), Segment(text: "をしますか。")
        ],
        quizOptions: ['Trung tâm thương mại (Depaato)', 'Siêu thị (Suupaa)', 'Cửa hàng tiện lợi (Konbini)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "場所", furigana: "ばしょ"), Segment(text: "は...")],
        kana: 'ばしょは...',
        romaji: 'Basho wa...',
        meaning: '💡 Giải thích: Aki nói "Suupaa de kaimono o shimasu".',
      ),
      const DialogueLine(
        id: 20,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": "), Segment(text: "何", furigana: "なに"), Segment(text: "を"), Segment(text: "買", furigana: "か"), Segment(text: "いますか。")
        ],
        quizOptions: ['Chỉ bánh mì', 'Táo và Bánh mì', 'Quýt (Mikan)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "買", furigana: "か"), Segment(text: "い"), Segment(text: "物", furigana: "もの"), Segment(text: "は...")],
        kana: 'かいものは...',
        romaji: 'Kaimono wa...',
        meaning: '💡 Giải thích: Aki nói "Ringo to Pan o kaimasu".',
      ),
      const DialogueLine(
        id: 21,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": 500"), Segment(text: "円", furigana: "えん"), Segment(text: "はどうですか。")
        ],
        quizOptions: ['Đắt (Takai)', 'Rẻ (Yasui)', 'Khó (Muzukashii)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "値段", furigana: "ねだん"), Segment(text: "の"), Segment(text: "感想", furigana: "かんそう"), Segment(text: "。")],
        kana: 'ねだんのかんそう。',
        romaji: 'Nedan no kansou.',
        meaning: '💡 Giải thích: Aki xác nhận "Hai, yasui desu" (Vâng, rẻ).',
      ),
      const DialogueLine(
        id: 22,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": "), Segment(text: "値段", furigana: "ねだん"), Segment(text: "を"), Segment(text: "聞", furigana: "き"), Segment(text: "く"), Segment(text: "文", furigana: "ぶん"), Segment(text: "は？(Câu hỏi giá?)")
        ],
        quizOptions: ['Mua gì? (Nani o kaimasu ka)', 'Bao nhiêu tiền? (Ikura desu ka)', 'Ở đâu? (Doko desu ka)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "いくら...")],
        kana: 'いくら...',
        romaji: 'Ikura...',
        meaning: '💡 Giải thích: Để hỏi giá, ta dùng câu "Ikura desu ka".',
      )
    ]
  )
,
  // --- HỘI THOẠI 7: PHỎNG VẤN (ISORA & DAIGO) ---
  ConversationLesson(
    id: 'conv_7_interview',
    title: '7. Phỏng vấn (インタビュー)',
    description: 'Cuộc phỏng vấn giữa Isora và Nam (Daigo đóng vai) về thông tin cá nhân và ước mơ tương lai.',
    characters: [CharacterName.isora, CharacterName.daigo],
    prerequisites: ['jobs', 'school'],
    lines: [
      const DialogueLine(
        id: 1,
        speaker: CharacterName.isora,
        segments: [Segment(text: "今日", furigana: "きょう"), Segment(text: "はインタビューを"), Segment(text: "始", furigana: "はじ"), Segment(text: "めます。")],
        kana: 'きょうはインタビューをはじめます。',
        romaji: 'Kyou wa intabyuu ohajimemasu.',
        meaning: 'Hôm nay chúng ta sẽ bắt đầu buổi phỏng vấn.',
      ),
      const DialogueLine(
        id: 2,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「インタビュー」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Cuộc họp (Kaigi)', 'Phỏng vấn', 'Thuyết trình (Purezen)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は...")],
        kana: 'いみは...',
        romaji: 'Imi wa...',
        meaning: '💡 Giải thích: "Intabyuu" là từ vay mượn của "Interview" (Phỏng vấn).',
      ),
      const DialogueLine(
        id: 3,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "はい、お"), Segment(text: "願", furigana: "ねが"), Segment(text: "いします。")],
        kana: 'はい、おねがいします。',
        romaji: 'Hai, onegaishimasu.',
        meaning: 'Vâng, xin nhờ anh ạ.',
      ),
      const DialogueLine(
        id: 4,
        speaker: CharacterName.isora,
        segments: [Segment(text: "お"), Segment(text: "名前", furigana: "なまえ"), Segment(text: "を"), Segment(text: "教", furigana: "おし"), Segment(text: "えてください。")],
        kana: 'おなまえをおしえてください。',
        romaji: 'Onamae o oshiete kudasai.',
        meaning: 'Hãy cho tôi biết tên của bạn.',
      ),
      const DialogueLine(
        id: 5,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "名前", furigana: "なまえ"), Segment(text: "を"), Segment(text: "教", furigana: "おし"), Segment(text: "えて」の「を」は？")
        ],
        quizOptions: ['Chỉ nơi chốn', 'Chỉ đối tượng của hành động', 'Chỉ thời gian'],
        correctOptionIndex: 1,
        segments: [Segment(text: "目的語", furigana: "もくてきご"), Segment(text: "を...")],
        kana: 'もくてきごを...',
        romaji: 'Mokutekigo o...',
        meaning: '💡 Giải thích: Trợ từ "O" chỉ đối tượng chịu tác động (Cho biết cái gì? -> Cho biết Tên).',
      ),
      const DialogueLine(
        id: 6,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "ナムです。")],
        kana: 'ナムです。',
        romaji: 'Namu desu.',
        meaning: 'Tôi là Nam.',
      ),
      const DialogueLine(
        id: 7,
        speaker: CharacterName.isora,
        segments: [Segment(text: "今", furigana: "いま"), Segment(text: "、"), Segment(text: "何", furigana: "なに"), Segment(text: "をしていますか。")],
        kana: 'いま、なにをしていますか。',
        romaji: 'Ima, nani o shiteimasu ka?',
        meaning: 'Bây giờ bạn đang làm gì?',
      ),
      const DialogueLine(
        id: 8,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "何", furigana: "なに"), Segment(text: "をしていますか」は"), Segment(text: "何", furigana: "なに"), Segment(text: "を"), Segment(text: "聞", furigana: "き"), Segment(text: "く？")
        ],
        quizOptions: ['Tuổi tác', 'Nghề nghiệp / Tình trạng hiện tại', 'Quốc tịch'],
        correctOptionIndex: 1,
        segments: [Segment(text: "職業", furigana: "しょくぎょう"), Segment(text: "などを...")],
        kana: 'しょくぎょうなどを...',
        romaji: 'Shokugyou nado o...',
        meaning: '💡 Giải thích: Câu hỏi này dùng để hỏi về nghề nghiệp hoặc việc đang làm trong giai đoạn hiện tại.',
      ),
      const DialogueLine(
        id: 9,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "学生", furigana: "がくせい"), Segment(text: "です。")],
        kana: 'がくせいです。',
        romaji: 'Gakusei desu.',
        meaning: 'Tôi là học sinh.',
      ),
      const DialogueLine(
        id: 10,
        speaker: CharacterName.isora,
        segments: [Segment(text: "日本語", furigana: "にほんご"), Segment(text: "を"), Segment(text: "勉強", furigana: "べんきょう"), Segment(text: "していますか。")],
        kana: 'にほんごをべんきょうしていますか。',
        romaji: 'Nihongo o benkyou shiteimasu ka?',
        meaning: 'Bạn đang học tiếng Nhật phải không?',
      ),
      const DialogueLine(
        id: 11,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "勉強", furigana: "べんきょう"), Segment(text: "しています」はどの"), Segment(text: "形", furigana: "かたち"), Segment(text: "？")
        ],
        quizOptions: ['Quá khứ', 'Hiện tại tiếp diễn', 'Phủ định'],
        correctOptionIndex: 1,
        segments: [Segment(text: "〜ています。")],
        kana: 'て います。',
        romaji: '~Te imasu.',
        meaning: '💡 Giải thích: "Benkyou shiteimasu" là thì hiện tại tiếp diễn (Đang học).',
      ),
      const DialogueLine(
        id: 12,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "はい、"), Segment(text: "勉強", furigana: "べんきょう"), Segment(text: "しています。")],
        kana: 'はい、べんきょうしています。',
        romaji: 'Hai, benkyou shiteimasu.',
        meaning: 'Vâng, tôi đang học.',
      ),
      const DialogueLine(
        id: 13,
        speaker: CharacterName.isora,
        segments: [Segment(text: "将来", furigana: "しょうらい"), Segment(text: "、"), Segment(text: "何", furigana: "なに"), Segment(text: "になりたいですか。")],
        kana: 'しょうらい、なにになりたいですか。',
        romaji: 'Shourai, nani ni naritai desu ka?',
        meaning: 'Trong tương lai, bạn muốn trở thành gì?',
      ),
      const DialogueLine(
        id: 14,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "将来", furigana: "しょうらい"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Hiện tại', 'Quá khứ', 'Tương lai'],
        correctOptionIndex: 2,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は...")],
        kana: 'いみは...',
        romaji: 'Imi wa...',
        meaning: '💡 Giải thích: "Shourai" nghĩa là Tương lai (gần với cá nhân).',
      ),
      const DialogueLine(
        id: 15,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「～になりたいです」は"), Segment(text: "何", furigana: "なに"), Segment(text: "を"), Segment(text: "表", furigana: "あらわ"), Segment(text: "す？")
        ],
        quizOptions: ['Kế hoạch đã xong', 'Mong muốn (Want)', 'Mệnh lệnh'],
        correctOptionIndex: 1,
        segments: [Segment(text: "希望", furigana: "きぼう"), Segment(text: "です。")],
        kana: 'きぼうです。',
        romaji: 'Kibou desu.',
        meaning: '💡 Giải thích: Mẫu câu "V-tai desu" diễn tả mong muốn của bản thân (Muốn trở thành...).',
      ),
      const DialogueLine(
        id: 16,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "エンジニアになりたいです。")],
        kana: 'エンジニアになりたいです。',
        romaji: 'Enjinia ni naritai desu.',
        meaning: 'Tôi muốn trở thành kỹ sư.',
      ),
      const DialogueLine(
        id: 17,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": Bの"), Segment(text: "名前", furigana: "なまえ"), Segment(text: "は？")
        ],
        quizOptions: ['ミン (Min)', 'ナム (Nam)', 'リン (Lin)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "正解", furigana: "せいかい"), Segment(text: "は...")],
        kana: 'せいかいは...',
        romaji: 'Seikai wa...',
        meaning: '💡 Giải thích: Nhân vật B đã giới thiệu "Namu desu".',
      ),
      const DialogueLine(
        id: 18,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": "), Segment(text: "今", furigana: "いま"), Segment(text: "、Bは"), Segment(text: "何", furigana: "なに"), Segment(text: "ですか。")
        ],
        quizOptions: ['Nhân viên công ty', 'Học sinh', 'Giáo viên'],
        correctOptionIndex: 1,
        segments: [Segment(text: "職業", furigana: "しょくぎょう"), Segment(text: "は...")],
        kana: 'しょくぎょうは...',
        romaji: 'Shokugyou wa...',
        meaning: '💡 Giải thích: Nam nói "Gakusei desu" (Tôi là học sinh).',
      ),
      const DialogueLine(
        id: 19,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "意味", furigana: "いみ"), Segment(text: ": 「"), Segment(text: "将来", furigana: "しょうらい"), Segment(text: "、"), Segment(text: "何", furigana: "なに"), Segment(text: "になりたいですか」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Bây giờ làm gì?', 'Sau này muốn trở thành gì?', 'Đang học gì?'],
        correctOptionIndex: 1,
        segments: [Segment(text: "質問", furigana: "しつもん"), Segment(text: "の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "。")],
        kana: 'しつもんのいみ。',
        romaji: 'Shitsumon no imi.',
        meaning: '💡 Giải thích: Câu này hỏi về ước mơ/nghề nghiệp mong muốn trong tương lai.',
      ),
      const DialogueLine(
        id: 20,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": Bは"), Segment(text: "将来", furigana: "しょうらい"), Segment(text: "、"), Segment(text: "何", furigana: "なに"), Segment(text: "になりたいですか。")
        ],
        quizOptions: ['Bác sĩ (Isha)', 'Giáo viên (Kyoushi)', 'Kỹ sư (Enjinia)'],
        correctOptionIndex: 2,
        segments: [Segment(text: "夢", furigana: "ゆめ"), Segment(text: "は...")],
        kana: 'ゆめは...',
        romaji: 'Yume wa...',
        meaning: '💡 Giải thích: Nam trả lời "Enjinia ni naritai desu" (Muốn làm kỹ sư).',
      )
    ]
  ),
  // --- HỘI THOẠI 8: BẢO VỆ MÔI TRƯỜNG (AKI & CHIKI) ---
  ConversationLesson(
    id: 'conv_8_environment',
    title: '8. Bảo vệ môi trường (環境保護)',
    description: 'Hội thoại về tầm quan trọng của việc bảo vệ môi trường và các hành động thiết thực hàng ngày.',
    characters: [CharacterName.aki, CharacterName.chiki],
    prerequisites: ['housework', 'weather'],
    lines: [
      const DialogueLine(
        id: 1,
        speaker: CharacterName.aki,
        segments: [Segment(text: "環境", furigana: "かんきょう"), Segment(text: "を"), Segment(text: "守", furigana: "まも"), Segment(text: "ることは"), Segment(text: "大切", furigana: "たいせつ"), Segment(text: "ですか。")],
        kana: 'かんきょうをまもることはたいせつですか。',
        romaji: 'Kankyou o mamoru koto wa taisetsu desu ka?',
        meaning: 'Việc bảo vệ môi trường có quan trọng không?',
      ),
      const DialogueLine(
        id: 2,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "環境", furigana: "かんきょう"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Kinh tế (Keizai)', 'Môi trường', 'Xã hội (Shakai)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は...")],
        kana: 'いみは...',
        romaji: 'Imi wa...',
        meaning: '💡 Giải thích: "Kankyou" nghĩa là Môi trường. Kinh tế là "Keizai", Xã hội là "Shakai".',
      ),
      const DialogueLine(
        id: 3,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "環境", furigana: "かんきょう"), Segment(text: "を"), Segment(text: "守", furigana: "まも"), Segment(text: "る」の「を」は？")
        ],
        quizOptions: ['Chỉ chủ đề', 'Chỉ đối tượng của hành động', 'Chỉ nơi chốn'],
        correctOptionIndex: 1,
        segments: [Segment(text: "目的語", furigana: "もくてきご"), Segment(text: "を...")],
        kana: 'もくてきごを...',
        romaji: 'Mokutekigo o...',
        meaning: '💡 Giải thích: Trợ từ "O" (Wo) chỉ đối tượng chịu tác động (Bảo vệ cái gì? -> Bảo vệ Môi trường).',
      ),
      const DialogueLine(
        id: 4,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "はい、とても"), Segment(text: "大切", furigana: "たいせつ"), Segment(text: "です。")],
        kana: 'はい、とてもたいせつです。',
        romaji: 'Hai, totemo taisetsu desu.',
        meaning: 'Vâng, rất quan trọng.',
      ),
      const DialogueLine(
        id: 5,
        speaker: CharacterName.aki,
        segments: [Segment(text: "毎日", furigana: "まいにち"), Segment(text: "、"), Segment(text: "何", furigana: "なに"), Segment(text: "かしていますか。")],
        kana: 'まいにち、なにかしていますか。',
        romaji: 'Mainichi, nanika shiteimasu ka?',
        meaning: 'Hàng ngày bạn có làm gì không?',
      ),
      const DialogueLine(
        id: 6,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "はい、ゴミを"), Segment(text: "分別", furigana: "ぶんべつ"), Segment(text: "しています。")],
        kana: 'はい、ゴミをぶんべつしています。',
        romaji: 'Hai, gomi o bunbetsu shiteimasu.',
        meaning: 'Vâng, tôi đang phân loại rác.',
      ),
      const DialogueLine(
        id: 7,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "分別", furigana: "ぶんべつ"), Segment(text: "しています」はどの"), Segment(text: "形", furigana: "かたち"), Segment(text: "？")
        ],
        quizOptions: ['Quá khứ', 'Hiện tại tiếp diễn / Thói quen', 'Mệnh lệnh'],
        correctOptionIndex: 1,
        segments: [Segment(text: "〜ています。")],
        kana: 'て います。',
        romaji: '~Te imasu.',
        meaning: '💡 Giải thích: "Shiteimasu" diễn tả hành động thói quen lặp lại hàng ngày (Tôi vẫn thường xuyên phân loại rác).',
      ),
      const DialogueLine(
        id: 8,
        speaker: CharacterName.aki,
        segments: [Segment(text: "プラスチックを"), Segment(text: "使", furigana: "つか"), Segment(text: "いますか。")],
        kana: 'プラスチックをつかいますか。',
        romaji: 'Purasuchikku o tsukaimasu ka?',
        meaning: 'Bạn có dùng đồ nhựa không?',
      ),
      const DialogueLine(
        id: 9,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「プラスチック」は"), Segment(text: "何", furigana: "なに"), Segment(text: "ですか。")
        ],
        quizOptions: ['Giấy (Kami)', 'Nhựa (Plastic)', 'Kim loại (Kinzoku)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "素材", furigana: "そざい"), Segment(text: "は...")],
        kana: 'そざいは...',
        romaji: 'Sozai wa...',
        meaning: '💡 Giải thích: "Purasuchikku" là từ vay mượn của "Plastic" (Nhựa).',
      ),
      const DialogueLine(
        id: 10,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "いいえ、あまり"), Segment(text: "使", furigana: "つか"), Segment(text: "いません。")],
        kana: 'いいえ、あまりつかいません。',
        romaji: 'Iie, amari tsukaimasen.',
        meaning: 'Không, tôi không dùng nhiều lắm.',
      ),
      const DialogueLine(
        id: 11,
        speaker: CharacterName.aki,
        segments: [Segment(text: "電気", furigana: "でんき"), Segment(text: "を"), Segment(text: "無駄", furigana: "むだ"), Segment(text: "にしませんか。")],
        kana: 'でんきをむだにしませんか。',
        romaji: 'Denki o muda ni shimasen ka?',
        meaning: 'Bạn có lãng phí điện không?',
      ),
      const DialogueLine(
        id: 12,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "はい、"), Segment(text: "無駄", furigana: "むだ"), Segment(text: "にしません。")],
        kana: 'はい、むだにしません。',
        romaji: 'Hai, muda ni shimasen.',
        meaning: 'Vâng, tôi không lãng phí.',
      ),
      const DialogueLine(
        id: 13,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "無駄", furigana: "むだ"), Segment(text: "にしません」はどの"), Segment(text: "形", furigana: "かたち"), Segment(text: "？")
        ],
        quizOptions: ['Khẳng định', 'Phủ định', 'Quá khứ'],
        correctOptionIndex: 1,
        segments: [Segment(text: "否定形", furigana: "ひていけい"), Segment(text: "です。")],
        kana: 'ひていけいです。',
        romaji: 'Hiteikei desu.',
        meaning: '💡 Giải thích: Đuôi "Masen" biểu thị thể phủ định (Không làm...).',
      ),
      const DialogueLine(
        id: 14,
        speaker: CharacterName.aki,
        segments: [Segment(text: "これからも"), Segment(text: "続", furigana: "つづ"), Segment(text: "けますか。")],
        kana: 'これからもつづけますか。',
        romaji: 'Korekara mo tsuzukemasu ka?',
        meaning: 'Từ nay về sau bạn vẫn sẽ tiếp tục chứ?',
      ),
      const DialogueLine(
        id: 15,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "はい、"), Segment(text: "続", furigana: "つづ"), Segment(text: "けます。")],
        kana: 'はい、つづけます。',
        romaji: 'Hai, tsuzukemasu.',
        meaning: 'Vâng, tôi sẽ tiếp tục.',
      ),
      const DialogueLine(
        id: 16,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "続", furigana: "つづ"), Segment(text: "けます」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Dừng lại (Yameru)', 'Bắt đầu (Hajimeru)', 'Tiếp tục'],
        correctOptionIndex: 2,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は...")],
        kana: 'いみは...',
        romaji: 'Imi wa...',
        meaning: '💡 Giải thích: "Tsuzukemasu" nghĩa là Tiếp tục / Duy trì.',
      ),
      const DialogueLine(
        id: 17,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": Bは"), Segment(text: "環境", furigana: "かんきょう"), Segment(text: "のために"), Segment(text: "何", furigana: "なに"), Segment(text: "をしていますか。")
        ],
        quizOptions: ['Vứt rác lung tung (Gomi o sutemasu)', 'Phân loại rác (Gomi o bunbetsu shimasu)', 'Dùng nhiều điện (Denki o tsukaimasu)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "正解", furigana: "せいかい"), Segment(text: "は...")],
        kana: 'せいかいは...',
        romaji: 'Seikai wa...',
        meaning: '💡 Giải thích: Chiki nói "Gomi o bunbetsu shiteimasu" (Phân loại rác).',
      ),
      const DialogueLine(
        id: 18,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": プラスチックをどうしますか。")
        ],
        quizOptions: ['Thường dùng', 'Không dùng nhiều lắm', 'Dùng mỗi ngày'],
        correctOptionIndex: 1,
        segments: [Segment(text: "答", furigana: "こた"), Segment(text: "えは...")],
        kana: 'こたえは...',
        romaji: 'Kotae wa...',
        meaning: '💡 Giải thích: Chiki nói "Amari tsukaimasen" (Không dùng nhiều lắm).',
      ),
      const DialogueLine(
        id: 19,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "意味", furigana: "いみ"), Segment(text: ": 「"), Segment(text: "無駄", furigana: "むだ"), Segment(text: "にしません」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Lãng phí', 'Không lãng phí', 'Dùng nhiều'],
        correctOptionIndex: 1,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は...")],
        kana: 'いみは...',
        romaji: 'Imi wa...',
        meaning: '💡 Giải thích: "Muda" (Lãng phí) + "Shimasen" (Phủ định) -> Không lãng phí.',
      ),
      const DialogueLine(
        id: 20,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": Bは"), Segment(text: "将来", furigana: "しょうらい"), Segment(text: "どうしますか。")
        ],
        quizOptions: ['Bỏ cuộc (Yamemasu)', 'Tiếp tục (Tsuzukemasu)', 'Thay đổi (Kaemasu)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "最後", furigana: "さいご"), Segment(text: "の"), Segment(text: "答", furigana: "こた"), Segment(text: "え...")],
        kana: 'さいごのこたえ...',
        romaji: 'Saigo no kotae...',
        meaning: '💡 Giải thích: Chiki xác nhận "Hai, tsuzukemasu" (Vâng, tôi sẽ tiếp tục).',
      )
    ]
  )
,
  // --- HỘI THOẠI 9: HỎI ĐƯỜNG (ISORA & DAIGO) ---
  ConversationLesson(
    id: 'conv_9_direction',
    title: '9. Hỏi đường (道を聞く)',
    description: 'Hội thoại hỏi đường đến nhà ga, thời gian đi bộ và các chỉ dẫn rẽ trái/phải.',
    characters: [CharacterName.isora, CharacterName.daigo],
    prerequisites: ['travel', 'numbers'],
    lines: [
      const DialogueLine(
        id: 1,
        speaker: CharacterName.isora,
        segments: [Segment(text: "すみません、"), Segment(text: "駅", furigana: "えき"), Segment(text: "はどこですか。")],
        kana: 'すみません、えきはどこですか。',
        romaji: 'Sumimasen, eki wa doko desu ka?',
        meaning: 'Xin lỗi, nhà ga ở đâu vậy ạ?',
      ),
      const DialogueLine(
        id: 2,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "駅", furigana: "えき"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Bến xe', 'Nhà ga', 'Sân bay'],
        correctOptionIndex: 1,
        segments: [Segment(text: "場所", furigana: "ばしょ"), Segment(text: "の"), Segment(text: "名前", furigana: "なまえ"), Segment(text: "。")],
        kana: 'ばしょのなまえ。',
        romaji: 'Basho no namae.',
        meaning: '💡 Giải thích: "Eki" nghĩa là Nhà ga (tàu điện). Sân bay là "Kuukou".',
      ),
      const DialogueLine(
        id: 3,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "この"), Segment(text: "道", furigana: "みち"), Segment(text: "をまっすぐ"), Segment(text: "行", furigana: "い"), Segment(text: "ってください。")],
        kana: 'このみちをまっすぐいってください。',
        romaji: 'Kono michi o massugu itte kudasai.',
        meaning: 'Hãy đi thẳng con đường này.',
      ),
      const DialogueLine(
        id: 4,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「この"), Segment(text: "道", furigana: "みち"), Segment(text: "を...」の「を」は？")
        ],
        quizOptions: ['Chỉ nơi chốn đi qua', 'Chỉ chủ đề', 'Chỉ thời gian'],
        correctOptionIndex: 0,
        segments: [Segment(text: "移動", furigana: "いどう"), Segment(text: "の"), Segment(text: "場所", furigana: "ばしょ"), Segment(text: "...")],
        kana: 'いどうのばしょ...',
        romaji: 'Idou no basho...',
        meaning: '💡 Giải thích: Với các động từ di chuyển (đi, chạy, bay), trợ từ "O" chỉ địa điểm mà hành động đi xuyên qua.',
      ),
      const DialogueLine(
        id: 5,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「まっすぐ」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Rẽ phải', 'Rẽ trái', 'Đi thẳng'],
        correctOptionIndex: 2,
        segments: [Segment(text: "方向", furigana: "ほうこう"), Segment(text: "です。")],
        kana: 'ほうこうです。',
        romaji: 'Houkou desu.',
        meaning: '💡 Giải thích: "Massugu" nghĩa là đi thẳng. Rẽ phải là "Migi ni magaru".',
      ),
      const DialogueLine(
        id: 6,
        speaker: CharacterName.isora,
        segments: [Segment(text: "どのくらいかかりますか。")],
        kana: 'どのくらいかかりますか。',
        romaji: 'Dono kurai kakarimasu ka?',
        meaning: 'Mất khoảng bao lâu?',
      ),
      const DialogueLine(
        id: 7,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「どのくらい」は"), Segment(text: "何", furigana: "なに"), Segment(text: "を"), Segment(text: "聞", furigana: "き"), Segment(text: "く？")
        ],
        quizOptions: ['Khoảng bao xa / bao lâu', 'Ở đâu (Doko)', 'Bao nhiêu tuổi (Ikutsu)'],
        correctOptionIndex: 0,
        segments: [Segment(text: "時間", furigana: "じかん"), Segment(text: "や"), Segment(text: "距離", furigana: "きょり"), Segment(text: "...")],
        kana: 'じかんやきょり...',
        romaji: 'Jikan ya kyori...',
        meaning: '💡 Giải thích: "Dono kurai" dùng để hỏi về khoảng lượng (thời gian, độ dài, chi phí...).',
      ),
      const DialogueLine(
        id: 8,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "5"), Segment(text: "分", furigana: "ふん"), Segment(text: "ぐらいです。")],
        kana: 'ごふんぐらいです。',
        romaji: 'Go-fun gurai desu.',
        meaning: 'Khoảng 5 phút ạ.',
      ),
      const DialogueLine(
        id: 9,
        speaker: CharacterName.isora,
        segments: [Segment(text: "右", furigana: "みぎ"), Segment(text: "に"), Segment(text: "曲", furigana: "ま"), Segment(text: "がりますか。")],
        kana: 'みぎにまがりますか。',
        romaji: 'Migi ni magarimasu ka?',
        meaning: 'Có rẽ phải không?',
      ),
      const DialogueLine(
        id: 10,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "はい、"), Segment(text: "右", furigana: "みぎ"), Segment(text: "に"), Segment(text: "曲", furigana: "ま"), Segment(text: "がってください。")],
        kana: 'はい、みぎにまがってください。',
        romaji: 'Hai, migi ni magatte kudasai.',
        meaning: 'Vâng, hãy rẽ phải.',
      ),
      const DialogueLine(
        id: 11,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "曲", furigana: "ま"), Segment(text: "がってください」はどの"), Segment(text: "形", furigana: "かたち"), Segment(text: "？")
        ],
        quizOptions: ['Câu mệnh lệnh lịch sự', 'Câu phủ định', 'Câu quá khứ'],
        correctOptionIndex: 0,
        segments: [Segment(text: "指示", furigana: "しじ"), Segment(text: "です。")],
        kana: 'しじです。',
        romaji: 'Shiji desu.',
        meaning: '💡 Giải thích: Mẫu câu "~Te kudasai" dùng để yêu cầu hoặc hướng dẫn ai đó làm gì một cách lịch sự.',
      ),
      const DialogueLine(
        id: 12,
        speaker: CharacterName.isora,
        segments: [Segment(text: "交差点", furigana: "こうさてん"), Segment(text: "がありますか。")],
        kana: 'こうさてんがありますか。',
        romaji: 'Kousaten ga arimasu ka?',
        meaning: 'Có ngã tư không?',
      ),
      const DialogueLine(
        id: 13,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "交差点", furigana: "こうさてん"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Cầu (Hashi)', 'Ngã tư / Giao lộ', 'Công viên (Kouen)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "道", furigana: "みち"), Segment(text: "が"), Segment(text: "交", furigana: "まじ"), Segment(text: "わる...")],
        kana: 'みちがまじわる...',
        romaji: 'Michi ga majiwaru...',
        meaning: '💡 Giải thích: "Kousaten" là giao lộ, ngã tư.',
      ),
      const DialogueLine(
        id: 14,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "はい、"), Segment(text: "大", furigana: "おお"), Segment(text: "きい"), Segment(text: "交差点", furigana: "こうさてん"), Segment(text: "があります。")],
        kana: 'はい、おおきいこうさてんがあります。',
        romaji: 'Hai, ookii kousaten ga arimasu.',
        meaning: 'Vâng, có một ngã tư lớn.',
      ),
      const DialogueLine(
        id: 15,
        speaker: CharacterName.isora,
        segments: [Segment(text: "わかりました。ありがとうございます。")],
        kana: 'わかりました。ありがとうございます。',
        romaji: 'Wakarimashita. Arigatou gozaimasu.',
        meaning: 'Tôi hiểu rồi. Cảm ơn anh.',
      ),
      const DialogueLine(
        id: 16,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "どういたしまして。")],
        kana: 'どういたしまして。',
        romaji: 'Dou itashimashite.',
        meaning: 'Không có chi.',
      ),
      const DialogueLine(
        id: 17,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": "), Segment(text: "駅", furigana: "えき"), Segment(text: "はどこですか。")
        ],
        quizOptions: ['Bên trái', 'Đi thẳng rồi rẽ phải', 'Không biết'],
        correctOptionIndex: 1,
        segments: [Segment(text: "行", furigana: "い"), Segment(text: "き"), Segment(text: "方", furigana: "かた"), Segment(text: "は...")],
        kana: 'いきかたは...',
        romaji: 'Ikikata wa...',
        meaning: '💡 Giải thích: Daigo chỉ dẫn: Đi thẳng (Massugu) sau đó rẽ phải (Migi ni magaru).',
      ),
      const DialogueLine(
        id: 18,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": どのくらいかかりますか。")
        ],
        quizOptions: ['Khoảng 5 phút', 'Khoảng 10 phút', 'Khoảng 20 phút'],
        correctOptionIndex: 0,
        segments: [Segment(text: "時間", furigana: "じかん"), Segment(text: "は...")],
        kana: 'じかんは...',
        romaji: 'Jikan wa...',
        meaning: '💡 Giải thích: Daigo nói "Go-fun gurai desu" (Khoảng 5 phút).',
      ),
      const DialogueLine(
        id: 19,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「すみません」はいつ"), Segment(text: "使", furigana: "つか"), Segment(text: "いますか。")
        ],
        quizOptions: ['Chào buổi sáng', 'Gọi người khác / Xin lỗi làm phiền', 'Tạm biệt'],
        correctOptionIndex: 1,
        segments: [Segment(text: "呼", furigana: "よ"), Segment(text: "びかける"), Segment(text: "時", furigana: "とき"), Segment(text: "...")],
        kana: 'よびかけるとき...',
        romaji: 'Yobikakeru toki...',
        meaning: '💡 Giải thích: Trong ngữ cảnh này, "Sumimasen" dùng để gọi người lạ một cách lịch sự trước khi hỏi đường.',
      ),
      const DialogueLine(
        id: 20,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": まっすぐ"), Segment(text: "行", furigana: "い"), Segment(text: "ってから、どうしますか。")
        ],
        quizOptions: ['Rẽ trái (Hidari ni magaru)', 'Rẽ phải (Migi ni magaru)', 'Dừng lại (Tomaru)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "次", furigana: "つぎ"), Segment(text: "の"), Segment(text: "動作", furigana: "どうさ"), Segment(text: "...")],
        kana: 'つぎのどうさ...',
        romaji: 'Tsugi no dousa...',
        meaning: '💡 Giải thích: Daigo hướng dẫn "Migi ni magatte kudasai" (Hãy rẽ phải).',
      )
    ]
  ),
  // --- HỘI THOẠI 10: GIA ĐÌNH (CHIKI & AKI) ---
  ConversationLesson(
    id: 'conv_10_family',
    title: '10. Gia đình (家族)',
    description: 'Hội thoại về thành viên gia đình, nghề nghiệp và anh chị em.',
    characters: [CharacterName.chiki, CharacterName.aki],
    prerequisites: ['family', 'jobs'],
    lines: [
      const DialogueLine(
        id: 1,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "家族", furigana: "かぞく"), Segment(text: "は"), Segment(text: "何人", furigana: "なんにん"), Segment(text: "いますか。")],
        kana: 'かぞくはなんにんいますか。',
        romaji: 'Kazoku wa nannin imasu ka?',
        meaning: 'Gia đình bạn có bao nhiêu người?',
      ),
      const DialogueLine(
        id: 2,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "家族", furigana: "かぞく"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Bạn bè (Tomodachi)', 'Gia đình', 'Họ hàng (Shinseki)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は...")],
        kana: 'いみは...',
        romaji: 'Imi wa...',
        meaning: '💡 Giải thích: "Kazoku" nghĩa là Gia đình.',
      ),
      const DialogueLine(
        id: 3,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "何人", furigana: "なんにん"), Segment(text: "いますか」は"), Segment(text: "何", furigana: "なに"), Segment(text: "を"), Segment(text: "聞", furigana: "き"), Segment(text: "く？")
        ],
        quizOptions: ['Tuổi tác', 'Số lượng người', 'Nghề nghiệp'],
        correctOptionIndex: 1,
        segments: [Segment(text: "人数", furigana: "にんずう"), Segment(text: "を...")],
        kana: 'にんずうを...',
        romaji: 'Ninzuu o...',
        meaning: '💡 Giải thích: "Nan-nin" dùng để hỏi về số lượng người (Mấy người?).',
      ),
      const DialogueLine(
        id: 4,
        speaker: CharacterName.aki,
        segments: [Segment(text: "4"), Segment(text: "人", furigana: "にん"), Segment(text: "います。")],
        kana: 'よにんいます。',
        romaji: 'Yonin imasu.',
        meaning: 'Có 4 người.',
      ),
      const DialogueLine(
        id: 5,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「4"), Segment(text: "人", furigana: "にん"), Segment(text: "」の「"), Segment(text: "人", furigana: "にん"), Segment(text: "」は"), Segment(text: "何", furigana: "なに"), Segment(text: "？")
        ],
        quizOptions: ['Động từ', 'Trợ từ', 'Trợ số đếm người'],
        correctOptionIndex: 2,
        segments: [Segment(text: "助数詞", furigana: "じょすうし"), Segment(text: "です。")],
        kana: 'じょすうしです。',
        romaji: 'Josuushi desu.',
        meaning: '💡 Giải thích: "Nin" là trợ số từ dùng để đếm người (Hitori, Futari, Sannin, Yonin...).',
      ),
      const DialogueLine(
        id: 6,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "お"), Segment(text: "父", furigana: "とう"), Segment(text: "さんは"), Segment(text: "何", furigana: "なに"), Segment(text: "をしていますか。")],
        kana: 'おとうさんはなにをしていますか。',
        romaji: 'Otousan wa nani o shiteimasu ka?',
        meaning: 'Bố bạn đang làm nghề gì?',
      ),
      const DialogueLine(
        id: 7,
        speaker: CharacterName.aki,
        segments: [Segment(text: "会社員", furigana: "かいしゃいん"), Segment(text: "です。")],
        kana: 'かいしゃいんです。',
        romaji: 'Kaishain desu.',
        meaning: 'Bố là nhân viên công ty.',
      ),
      const DialogueLine(
        id: 8,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "お"), Segment(text: "母", furigana: "かあ"), Segment(text: "さんは"), Segment(text: "仕事", furigana: "しごと"), Segment(text: "をしていますか。")],
        kana: 'おかあさんはしごとをしていますか。',
        romaji: 'Okaasan wa shigoto o shiteimasu ka?',
        meaning: 'Mẹ bạn có đi làm không?',
      ),
      const DialogueLine(
        id: 9,
        speaker: CharacterName.aki,
        segments: [Segment(text: "はい、しています。")],
        kana: 'はい、しています。',
        romaji: 'Hai, shiteimasu.',
        meaning: 'Vâng, có ạ.',
      ),
      const DialogueLine(
        id: 10,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "兄弟", furigana: "きょうだい"), Segment(text: "がいますか。")],
        kana: 'きょうだいがいますか。',
        romaji: 'Kyoudai ga imasu ka?',
        meaning: 'Bạn có anh chị em không?',
      ),
      const DialogueLine(
        id: 11,
        speaker: CharacterName.aki,
        segments: [Segment(text: "はい、"), Segment(text: "弟", furigana: "おとうと"), Segment(text: "が"), Segment(text: "一人", furigana: "ひとり"), Segment(text: "います。")],
        kana: 'はい、おとうとがひとりいます。',
        romaji: 'Hai, otouto ga hitori imasu.',
        meaning: 'Vâng, tôi có một em trai.',
      ),
      const DialogueLine(
        id: 12,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "弟", furigana: "おとうと"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Anh trai (Ani)', 'Em trai', 'Chị gái (Ane)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は...")],
        kana: 'いみは...',
        romaji: 'Imi wa...',
        meaning: '💡 Giải thích: "Otouto" là em trai.',
      ),
      const DialogueLine(
        id: 13,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "弟", furigana: "おとうと"), Segment(text: "がいます」の「が」は？")
        ],
        quizOptions: ['Chỉ chủ đề', 'Chỉ sự tồn tại', 'Chỉ nơi chốn'],
        correctOptionIndex: 1,
        segments: [Segment(text: "存在", furigana: "そんざい"), Segment(text: "を...")],
        kana: 'そんざいを...',
        romaji: 'Sonzai o...',
        meaning: '💡 Giải thích: Với động từ "Imasu" (Có người/động vật), trợ từ "Ga" chỉ đối tượng tồn tại (Có ai? -> Có em trai).',
      ),
      const DialogueLine(
        id: 14,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "家族", furigana: "かぞく"), Segment(text: "は"), Segment(text: "仲", furigana: "なか"), Segment(text: "がいいですか。")],
        kana: 'かぞくはなかがいいですか。',
        romaji: 'Kazoku wa naka ga ii desu ka?',
        meaning: 'Gia đình bạn có hòa thuận không?',
      ),
      const DialogueLine(
        id: 15,
        speaker: CharacterName.aki,
        segments: [Segment(text: "はい、とても"), Segment(text: "仲", furigana: "なか"), Segment(text: "がいいです。")],
        kana: 'はい、とてもなかがいいです。',
        romaji: 'Hai, totemo naka ga ii desu.',
        meaning: 'Vâng, rất hòa thuận.',
      ),
      const DialogueLine(
        id: 16,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "仲", furigana: "なか"), Segment(text: "がいい」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Hay cãi nhau (Kenka suru)', 'Hòa thuận / Thân thiết', 'Ít nói (Mukuchi)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "関係", furigana: "かんけい"), Segment(text: "が...")],
        kana: 'かんけいが...',
        romaji: 'Kankei ga...',
        meaning: '💡 Giải thích: "Naka ga ii" nghĩa là quan hệ tốt, thân thiết, hòa thuận.',
      ),
      const DialogueLine(
        id: 17,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": Bの"), Segment(text: "家族", furigana: "かぞく"), Segment(text: "は"), Segment(text: "何人", furigana: "なんにん"), Segment(text: "ですか。")
        ],
        quizOptions: ['3人', '4人', '5人'],
        correctOptionIndex: 1,
        segments: [Segment(text: "正解", furigana: "せいかい"), Segment(text: "は...")],
        kana: 'せいかいは...',
        romaji: 'Seikai wa...',
        meaning: '💡 Giải thích: Aki nói "Yonin imasu" (Có 4 người).',
      ),
      const DialogueLine(
        id: 18,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": Bに"), Segment(text: "兄弟", furigana: "きょうだい"), Segment(text: "がいますか。")
        ],
        quizOptions: ['Không, không có', 'Có, một em trai', 'Có, anh trai'],
        correctOptionIndex: 1,
        segments: [Segment(text: "答", furigana: "こた"), Segment(text: "えは...")],
        kana: 'こたえは...',
        romaji: 'Kotae wa...',
        meaning: '💡 Giải thích: Aki nói "Otouto ga hitori imasu" (Có 1 em trai).',
      ),
      const DialogueLine(
        id: 19,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "意味", furigana: "いみ"), Segment(text: ": 「"), Segment(text: "仲", furigana: "なか"), Segment(text: "がいい」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Không thân', 'Thân thiết', 'Xa cách'],
        correctOptionIndex: 1,
        segments: [Segment(text: "良", furigana: "よ"), Segment(text: "い"), Segment(text: "関係", furigana: "かんけい"), Segment(text: "。")],
        kana: 'よいかんけい。',
        romaji: 'Yoi kankei.',
        meaning: '💡 Giải thích: "Naka ga ii" là tình cảm tốt đẹp, thân thiết.',
      ),
      const DialogueLine(
        id: 20,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": お"), Segment(text: "母", furigana: "かあ"), Segment(text: "さんは"), Segment(text: "仕事", furigana: "しごと"), Segment(text: "をしていますか。")
        ],
        quizOptions: ['Có, đang làm', 'Không, không làm', 'Không biết'],
        correctOptionIndex: 0,
        segments: [Segment(text: "母", furigana: "はは"), Segment(text: "の"), Segment(text: "こと...")],
        kana: 'ははのこと...',
        romaji: 'Haha no koto...',
        meaning: '💡 Giải thích: Aki trả lời "Hai, shiteimasu" (Vâng, có làm).',
      )
    ]
  )
];
