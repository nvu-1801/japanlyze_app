
import '../../../domain/entities/conversation_models.dart';

final List<ConversationLesson> conversationDataPart1 = [
  // --- HỘI THOẠI 1: GIỚI THIỆU BẢN THÂN (MIN & NAM) ---
  ConversationLesson(
    id: 'conv_1_intro',
    title: '1. Giới thiệu bản thân (自己紹介)',
    description: 'Hội thoại làm quen giữa Min (Aki đóng vai) và Nam (Daigo đóng vai).',
    characters: [CharacterName.aki, CharacterName.daigo],
    prerequisites: ['numbers', 'countries'],
    lines: [
      const DialogueLine(
        id: 1,
        speaker: CharacterName.aki,
        segments: [Segment(text: "はじめまして。")],
        kana: 'はじめまして。',
        romaji: 'Hajimemashite.',
        meaning: 'Rất vui được gặp bạn.',
      ),
      const DialogueLine(
        id: 2,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
           Segment(text: "クイズ: 初対面", furigana: "しょたいめん"), Segment(text: "のあいさつは？(Câu nào dùng khi lần đầu gặp mặt?)")
        ],
        quizOptions: ['ありがとう (Cảm ơn)', 'はじめまして (Hajimemashite)', 'さようなら (Tạm biệt)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "はじめまして。")],
        kana: 'はじめまして。',
        romaji: 'Hajimemashite.',
        meaning: '💡 Giải thích: "Hajimemashite" là câu chào tiêu chuẩn khi gặp ai đó lần đầu tiên. "Arigatou" là cảm ơn, "Sayounara" là tạm biệt.',
      ),
      const DialogueLine(
        id: 3,
        speaker: CharacterName.aki,
        segments: [Segment(text: "わたしはミンです。")],
        kana: 'わたしはミンです。',
        romaji: 'Watashi wa Min desu.',
        meaning: 'Tôi là Min.',
      ),
      const DialogueLine(
        id: 4,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「わたしは...」の「は」は？(Trợ từ Ha dùng để làm gì?)")
        ],
        quizOptions: ['Chỉ nơi chốn', 'Chỉ chủ đề câu', 'Chỉ thời gian'],
        correctOptionIndex: 1,
        segments: [Segment(text: "わたしはナムです。")],
        kana: 'わたしはナムです。',
        romaji: 'Watashi wa Namu desu.',
        meaning: '💡 Giải thích: Trợ từ "Wa" (viết là Ha) dùng để đánh dấu chủ đề của câu (ở đây chủ đề là "Tôi").',
      ),
      const DialogueLine(
        id: 5,
        speaker: CharacterName.aki,
        segments: [Segment(text: "ベトナムから"), Segment(text: "来", furigana: "き"), Segment(text: "ました。")],
        kana: 'ベトナムからきました。',
        romaji: 'Betonamu kara kimashita.',
        meaning: 'Tôi đến từ Việt Nam.',
      ),
      const DialogueLine(
        id: 6,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "来", furigana: "き"), Segment(text: "ました」の"), Segment(text: "辞書形", furigana: "じしょけい"), Segment(text: "は？(Dạng từ điển của Kimashita)")
        ],
        quizOptions: ['来る (Kuru)', '行く (Iku)', '見る (Miru)'],
        correctOptionIndex: 0,
        segments: [Segment(text: "「"), Segment(text: "来", furigana: "き"), Segment(text: "ました」は...")],
        kana: 'きましたは...',
        romaji: 'Kimashita wa...',
        meaning: '💡 Giải thích: "Kimashita" là quá khứ lịch sự của "Kuru" (Đến). "Iku" là Đi, "Miru" là Nhìn.',
      ),
      const DialogueLine(
        id: 7,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": ベトナム ____ "), Segment(text: "来", furigana: "き"), Segment(text: "ました。(Điền trợ từ)")
        ],
        quizOptions: ['に (ni)', 'から (kara)', 'へ (he)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "「から」は...")],
        kana: 'からは...',
        romaji: 'Kara wa...',
        meaning: '💡 Giải thích: "Kara" nghĩa là "Từ", chỉ điểm xuất phát (Đến từ Việt Nam). Dùng để chỉ nơi chốn xuất phát.',
      ),
      const DialogueLine(
        id: 8,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "16"), Segment(text: "歳", furigana: "さい"), Segment(text: "です。")],
        kana: 'じゅうろくさいです。',
        romaji: 'Juu-roku sai desu.',
        meaning: 'Tôi 16 tuổi.',
      ),
      const DialogueLine(
        id: 9,
        speaker: CharacterName.aki,
        segments: [Segment(text: "学生", furigana: "がくせい"), Segment(text: "です。")],
        kana: 'がくせいです。',
        romaji: 'Gakusei desu.',
        meaning: 'Tôi là học sinh.',
      ),
      const DialogueLine(
        id: 10,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "学生", furigana: "がくせい"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？(Gakusei nghĩa là gì?)")
        ],
        quizOptions: ['Giáo viên', 'Học sinh / Sinh viên', 'Nhân viên'],
        correctOptionIndex: 1,
        segments: [Segment(text: "「"), Segment(text: "学生", furigana: "がくせい"), Segment(text: "」ですね。")],
        kana: 'がくせいですね。',
        romaji: 'Gakusei desu ne.',
        meaning: '💡 Giải thích: "Gakusei" là Học sinh/Sinh viên. Giáo viên là "Sensei", Nhân viên công ty là "Kaishain".',
      ),
      const DialogueLine(
        id: 11,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "日本語", furigana: "にほんご"), Segment(text: "を"), Segment(text: "勉強", furigana: "べんきょう"), Segment(text: "しています。")],
        kana: 'にほんごをべんきょうしています。',
        romaji: 'Nihongo o benkyou shiteimasu.',
        meaning: 'Tôi đang học tiếng Nhật.',
      ),
      const DialogueLine(
        id: 12,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "勉強", furigana: "べんきょう"), Segment(text: "しています」はどんな"), Segment(text: "時", furigana: "とき"), Segment(text: "？(Thì gì?)")
        ],
        quizOptions: ['Quá khứ', 'Hiện tại tiếp diễn', 'Tương lai'],
        correctOptionIndex: 1,
        segments: [Segment(text: "〜ています。")],
        kana: 'て います。',
        romaji: '~Te imasu.',
        meaning: '💡 Giải thích: Mẫu câu "V-te imasu" diễn tả hành động đang diễn ra (đang học) hoặc một trạng thái kéo dài.',
      ),
      const DialogueLine(
        id: 13,
        speaker: CharacterName.aki,
        segments: [Segment(text: "よろしくお"), Segment(text: "願", furigana: "ねが"), Segment(text: "いします。")],
        kana: 'よろしくおねがいします。',
        romaji: 'Yoroshiku onegaishimasu.',
        meaning: 'Rất mong được giúp đỡ.',
      ),
      const DialogueLine(
        id: 14,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "よろしくお"), Segment(text: "願", furigana: "ねが"), Segment(text: "いします。")],
        kana: 'よろしくおねがいします。',
        romaji: 'Yoroshiku onegaishimasu.',
        meaning: 'Tôi cũng vậy, rất mong được giúp đỡ.',
      ),
      const DialogueLine(
        id: 15,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": ミンはどこの"), Segment(text: "国", furigana: "くに"), Segment(text: "から"), Segment(text: "来", furigana: "き"), Segment(text: "ましたか。(Min đến từ đâu?)")
        ],
        quizOptions: ['日本 (Nhật)', 'ベトナム (Việt Nam)', '中国 (Trung Quốc)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "正解", furigana: "せいかい"), Segment(text: "は...")],
        kana: 'せいかいは...',
        romaji: 'Seikai wa...',
        meaning: '💡 Giải thích: Ở đầu bài, Min đã nói "Betonamu kara kimashita" (Tôi đến từ Việt Nam).',
      ),
      const DialogueLine(
        id: 16,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": ナムは"), Segment(text: "何歳", furigana: "なんさい"), Segment(text: "ですか。(Nam bao nhiêu tuổi?)")
        ],
        quizOptions: ['15歳', '16歳', '17歳'],
        correctOptionIndex: 1,
        segments: [Segment(text: "正解", furigana: "せいかい"), Segment(text: "は...")],
        kana: 'せいかいは...',
        romaji: 'Seikai wa...',
        meaning: '💡 Giải thích: Nam đã giới thiệu "16-sai desu" (Tôi 16 tuổi).',
      ),
      const DialogueLine(
        id: 17,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "意味", furigana: "いみ"), Segment(text: ": 「よろしくお"), Segment(text: "願", furigana: "ねが"), Segment(text: "いします」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Xin lỗi', 'Rất vui được gặp bạn/Mong giúp đỡ', 'Tạm biệt'],
        correctOptionIndex: 1,
        segments: [Segment(text: "大切", furigana: "たいせつ"), Segment(text: "なあいさつです。")],
        kana: 'たいせつなあいさつです。',
        romaji: 'Taisetsu na aisatsu desu.',
        meaning: '💡 Giải thích: Đây là câu chào quan trọng để kết thúc màn giới thiệu, thể hiện sự khiêm tốn và mong muốn xây dựng quan hệ tốt.',
      ),
      const DialogueLine(
        id: 18,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": "), Segment(text: "誰", furigana: "だれ"), Segment(text: "が"), Segment(text: "日本語", furigana: "にほんご"), Segment(text: "を"), Segment(text: "勉強", furigana: "べんきょう"), Segment(text: "していますか。(Ai đang học tiếng Nhật?)")
        ],
        quizOptions: ['ミン (Min)', 'ナム (Nam)', '両方 (Cả hai)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "正解", furigana: "せいかい"), Segment(text: "は...")],
        kana: 'せいかいは...',
        romaji: 'Seikai wa...',
        meaning: '💡 Giải thích: Trong đoạn hội thoại, chính Nam (nhân vật B) đã nói câu "Nihongo o benkyou shiteimasu".',
      )
    ]
  ),
  // --- HỘI THOẠI 2: QUÊ QUÁN (ISORA & AKI) ---
  ConversationLesson(
    id: 'conv_2_hometown',
    title: '2. Quê quán (出身)',
    description: 'Hội thoại giữa Isora và Aki về quê quán, nơi sinh sống hiện tại và gia đình.',
    characters: [CharacterName.isora, CharacterName.aki],
    prerequisites: ['family', 'countries'],
    lines: [
      const DialogueLine(
        id: 1,
        speaker: CharacterName.isora,
        segments: [Segment(text: "あなたの"), Segment(text: "出身", furigana: "しゅっしん"), Segment(text: "はどこですか。")],
        kana: 'あなたのしゅっしんはどこですか。',
        romaji: 'Anata no shusshin wa doko desu ka?',
        meaning: 'Quê quán của bạn ở đâu?',
      ),
      const DialogueLine(
        id: 2,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "出身", furigana: "しゅっしん"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Nơi đang sống', 'Quê quán / Nơi sinh', 'Quốc tịch'],
        correctOptionIndex: 1,
        segments: [Segment(text: "「"), Segment(text: "出身", furigana: "しゅっしん"), Segment(text: "」は...")],
        kana: 'しゅっしんは...',
        romaji: 'Shusshin wa...',
        meaning: '💡 Giải thích: "Shusshin" nghĩa là xuất thân, quê quán. Nơi đang sống là "Juusho", Quốc tịch là "Kokuseki".',
      ),
      // Adding missing lines from TS for Conv 2
      const DialogueLine(
        id: 3,
        speaker: CharacterName.aki,
        segments: [Segment(text: "ベトナムのハノイです。")],
        kana: 'ベトナムのハノイです。',
        romaji: 'Betonamu no Hanoi desu.',
        meaning: 'Tôi ở Hà Nội, Việt Nam.',
      ),
      const DialogueLine(
        id: 4,
        speaker: CharacterName.isora,
        segments: [Segment(text: "ハノイはどんな"), Segment(text: "町", furigana: "まち"), Segment(text: "ですか。")],
        kana: 'ハノイはどんなまちですか。',
        romaji: 'Hanoi wa donna machi desu ka?',
        meaning: 'Hà Nội là thành phố như thế nào?',
      ),
      const DialogueLine(
        id: 5,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「どんな」は"), Segment(text: "何", furigana: "なに"), Segment(text: "を"), Segment(text: "聞", furigana: "き"), Segment(text: "く？")
        ],
        quizOptions: ['Số lượng', 'Tính chất/Đặc điểm', 'Vị trí'],
        correctOptionIndex: 1,
        segments: [Segment(text: "特徴", furigana: "とくちょう"), Segment(text: "を...")],
        kana: 'とくちょうを...',
        romaji: 'Tokuchou o...',
        meaning: '💡 Giải thích: "Donna" dùng để hỏi về tính chất, đặc điểm cuả sự vật/nơi chốn (Như thế nào?).',
      ),
      const DialogueLine(
        id: 6,
        speaker: CharacterName.aki,
        segments: [Segment(text: "とてもにぎやかな"), Segment(text: "町", furigana: "まち"), Segment(text: "です。")],
        kana: 'とてもにぎやかなまちです。',
        romaji: 'Totemo nigiyaka na machi desu.',
        meaning: 'Là một thành phố rất náo nhiệt.',
      ),
      const DialogueLine(
        id: 7,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「にぎやか」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Yên tĩnh (Shizuka)', 'Náo nhiệt / Đông đúc', 'Đẹp (Kirei)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は中")],
        kana: 'いみはなか',
        romaji: 'Imi wa naka...',
        meaning: '💡 Giải thích: "Nigiyaka" là tính từ đuôi Na, nghĩa là náo nhiệt, đông vui.',
      ),
      const DialogueLine(
        id: 8,
        speaker: CharacterName.isora,
        segments: [Segment(text: "今", furigana: "いま"), Segment(text: "、どこに"), Segment(text: "住", furigana: "す"), Segment(text: "んでいますか。")],
        kana: 'いま、どこにすんでいますか。',
        romaji: 'Ima, doko ni sunde imasu ka?',
        meaning: 'Bây giờ bạn đang sống ở đâu?',
      ),
      const DialogueLine(
        id: 9,
        speaker: CharacterName.aki,
        segments: [Segment(text: "東京", furigana: "とうきょう"), Segment(text: "に"), Segment(text: "住", furigana: "す"), Segment(text: "んでいます。")],
        kana: 'とうきょうにすんでいます。',
        romaji: 'Toukyou ni sunde imasu.',
        meaning: 'Tôi đang sống ở Tokyo.',
      ),
      const DialogueLine(
        id: 10,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "住", furigana: "す"), Segment(text: "んでいます」の"), Segment(text: "助詞", furigana: "じょし"), Segment(text: "は？(Trợ từ đi với Sundeimasu)")
        ],
        quizOptions: ['を (o)', 'に (ni)', 'で (de)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "場所", furigana: "ばしょ"), Segment(text: "に...")],
        kana: 'ばしょに...',
        romaji: 'Basho ni...',
        meaning: '💡 Giải thích: Động từ "Sumu" (Sống) thường đi với trợ từ "Ni" để chỉ địa điểm cư trú (Sống TẠI đâu).',
      ),
      const DialogueLine(
        id: 11,
        speaker: CharacterName.isora,
        segments: [Segment(text: "一人", furigana: "ひとり"), Segment(text: "で"), Segment(text: "住", furigana: "す"), Segment(text: "んでいますか。")],
        kana: 'ひとりですんでいますか。',
        romaji: 'Hitori de sunde imasu ka?',
        meaning: 'Bạn sống một mình à?',
      ),
      const DialogueLine(
        id: 12,
        speaker: CharacterName.aki,
        segments: [Segment(text: "いいえ、"), Segment(text: "家族", furigana: "かぞく"), Segment(text: "と"), Segment(text: "住", furigana: "す"), Segment(text: "んでいます。")],
        kana: 'いいえ、かぞくとすんでいます。',
        romaji: 'Iie, kazoku to sunde imasu.',
        meaning: 'Không, tôi sống cùng gia đình.',
      ),
      const DialogueLine(
        id: 13,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "家族", furigana: "かぞく"), Segment(text: "と」の「と」は？")
        ],
        quizOptions: ['Và / Cùng với', 'Tại / Ở', 'Của'],
        correctOptionIndex: 0,
        segments: [Segment(text: "一緒", furigana: "いっしょ"), Segment(text: "に...")],
        kana: 'いっしょに...',
        romaji: 'Issho ni...',
        meaning: '💡 Giải thích: Trợ từ "To" dùng để nối danh từ (Và) hoặc chỉ đối tượng cùng thực hiện hành động (Cùng với).',
      ),
      const DialogueLine(
        id: 14,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": ミンの"), Segment(text: "出身", furigana: "しゅっしん"), Segment(text: "はどこですか。(Quê Min ở đâu?)")
        ],
        quizOptions: ['Tokyo', 'Hanoi', 'Osaka'],
        correctOptionIndex: 1,
        segments: [Segment(text: "正解", furigana: "せいかい"), Segment(text: "は...")],
        kana: 'せいかいは...',
        romaji: 'Seikai wa...',
        meaning: '💡 Giải thích: Min trả lời "Betonamu no Hanoi desu".',
      ),
      const DialogueLine(
        id: 15,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": ミンは"), Segment(text: "今", furigana: "いま"), Segment(text: "どこに"), Segment(text: "住", furigana: "す"), Segment(text: "んでいますか。(Min đang sống ở đâu?)")
        ],
        quizOptions: ['Hanoi', 'Tokyo', 'Kyoto'],
        correctOptionIndex: 1,
        segments: [Segment(text: "場所", furigana: "ばしょ"), Segment(text: "は...")],
        kana: 'ばしょは...',
        romaji: 'Basho wa...',
        meaning: '💡 Giải thích: Min nói "Toukyou ni sunde imasu".',
      ),
      const DialogueLine(
        id: 16,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": ミンは"), Segment(text: "一人暮", furigana: "ひとりぐ"), Segment(text: "らしですか。(Min sống một mình?)")
        ],
        quizOptions: ['Đúng (Hai)', 'Sai (Iie)', 'Không biết'],
        correctOptionIndex: 1,
        segments: [Segment(text: "答", furigana: "こた"), Segment(text: "えは...")],
        kana: 'こたえは...',
        romaji: 'Kotae wa...',
        meaning: '💡 Giải thích: Min nói "Kazoku to sunde imasu" (Sống cùng gia đình).',
      )
    ]
  ),
  // ... Lessons 3, 4, 5 to adhere to length limits. I will do them in the next step.

  // --- HỘI THOẠI 3: BẠN THÂN (ISORA & CHIKI) ---
  ConversationLesson(
    id: 'conv_3_friends',
    title: '3. Bạn thân (親友)',
    description: 'Chiki kể cho Isora nghe về người bạn thân tên Lin.',
    characters: [CharacterName.isora, CharacterName.chiki],
    prerequisites: ['school', 'casual'],
    lines: [
      const DialogueLine(
        id: 1,
        speaker: CharacterName.isora,
        segments: [Segment(text: "あなたには"), Segment(text: "親友", furigana: "しんゆう"), Segment(text: "がいますか。")],
        kana: 'あなたにはしんゆうがいますか。',
        romaji: 'Anata niwa shinyuu ga imasu ka?',
        meaning: 'Bạn có bạn thân không?',
      ),
      const DialogueLine(
        id: 2,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "はい、います。")],
        kana: 'はい、います。',
        romaji: 'Hai, imasu.',
        meaning: 'Vâng, tôi có.',
      ),
      const DialogueLine(
        id: 3,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "親友", furigana: "しんゆう"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Bạn bình thường', 'Bạn thân', 'Người lạ'],
        correctOptionIndex: 1,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は...")],
        kana: 'いみは...',
        romaji: 'Imi wa...',
        meaning: '💡 Giải thích: "Shinyuu" (Thân hữu) nghĩa là bạn thân.',
      ),
      const DialogueLine(
        id: 4,
        speaker: CharacterName.isora,
        segments: [Segment(text: "その"), Segment(text: "人", furigana: "ひと"), Segment(text: "はどんな"), Segment(text: "人", furigana: "ひと"), Segment(text: "ですか。")],
        kana: 'そのひとはどんなひとですか。',
        romaji: 'Sono hito wa donna hito desu ka?',
        meaning: 'Người đó là người như thế nào?',
      ),
      const DialogueLine(
        id: 5,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "やさしくて、"), Segment(text: "真面目", furigana: "まじめ"), Segment(text: "な"), Segment(text: "人", furigana: "ひと"), Segment(text: "です。")],
        kana: 'やさしくて、まじめなひとです。',
        romaji: 'Yasashikute, majime na hito desu.',
        meaning: 'Là một người hiền lành và chăm chỉ.',
      ),
      const DialogueLine(
        id: 6,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「やさしくて」はどの"), Segment(text: "形", furigana: "かたち"), Segment(text: "？")
        ],
        quizOptions: ['Thể Te (Nối)', 'Thể Ta (Quá khứ)', 'Thể Nai (Phủ định)'],
        correctOptionIndex: 0,
        segments: [Segment(text: "接続形", furigana: "せつぞくけい"), Segment(text: "です。")],
        kana: 'せつぞくけいです。',
        romaji: 'Setsuzokukei desu.',
        meaning: '💡 Giải thích: "Yasashikute" là thể Te của tính từ "Yasashii", dùng để nối tiếp tính chất (Hiền VÀ...).',
      ),
      const DialogueLine(
        id: 7,
        speaker: CharacterName.isora,
        segments: [Segment(text: "名前", furigana: "なまえ"), Segment(text: "は"), Segment(text: "何", furigana: "なん"), Segment(text: "といいますか。")],
        kana: 'なまえはなんといいますか。',
        romaji: 'Namae wa nan to iimasu ka?',
        meaning: 'Tên người đó là gì?',
      ),
      const DialogueLine(
        id: 8,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "リンといいます。")],
        kana: 'リンといいます。',
        romaji: 'Rin to iimasu.',
        meaning: 'Tên là Lin.',
      ),
      const DialogueLine(
        id: 9,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「～といいます」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Gọi là / Tên là', 'Nói là', 'Ăn là'],
        correctOptionIndex: 0,
        segments: [Segment(text: "名前", furigana: "なまえ"), Segment(text: "を"), Segment(text: "言", furigana: "い"), Segment(text: "うとき...")],
        kana: 'なまえをいうとき...',
        romaji: 'Namae o iu toki...',
        meaning: '💡 Giải thích: Mẫu câu "... to iimasu" dùng để giới thiệu tên gọi (Gọi là/Tên là...).',
      ),
      const DialogueLine(
        id: 10,
        speaker: CharacterName.isora,
        segments: [Segment(text: "リンさんは"), Segment(text: "学生", furigana: "がくせい"), Segment(text: "ですか。")],
        kana: 'リンさんはがくせいですか。',
        romaji: 'Rin-san wa gakusei desu ka?',
        meaning: 'Lin có phải là học sinh không?',
      ),
      const DialogueLine(
        id: 11,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "はい、"), Segment(text: "高校生", furigana: "こうこうせい"), Segment(text: "です。")],
        kana: 'はい、こうこうせいです。',
        romaji: 'Hai, koukousei desu.',
        meaning: 'Vâng, là học sinh cấp 3.',
      ),
      const DialogueLine(
        id: 12,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "高校生", furigana: "こうこうせい"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Sinh viên đại học (Daigakusei)', 'Học sinh cấp 3', 'Học sinh cấp 2 (Chuugakusei)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "学年", furigana: "がくねん"), Segment(text: "は...")],
        kana: 'がくねんは...',
        romaji: 'Gakunen wa...',
        meaning: '💡 Giải thích: "Koukousei" là học sinh trung học phổ thông (Cấp 3).',
      ),
      const DialogueLine(
        id: 13,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": チキの"), Segment(text: "親友", furigana: "しんゆう"), Segment(text: "の"), Segment(text: "名前", furigana: "なまえ"), Segment(text: "は？")
        ],
        quizOptions: ['Min', 'Rin', 'Namu'],
        correctOptionIndex: 1,
        segments: [Segment(text: "正解", furigana: "せいかい"), Segment(text: "は...")],
        kana: 'せいかいは...',
        romaji: 'Seikai wa...',
        meaning: '💡 Giải thích: Chiki nói "Rin to iimasu".',
      ),
      const DialogueLine(
        id: 14,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": リンさんについて"), Segment(text: "正", furigana: "ただ"), Segment(text: "しいのは？(Điều nào đúng?)")
        ],
        quizOptions: ['Hiền và Chăm chỉ', 'Ồn ào và Khỏe mạnh', 'Yên lặng và Đáng sợ'],
        correctOptionIndex: 0,
        segments: [Segment(text: "最後", furigana: "さいご"), Segment(text: "の"), Segment(text: "問題", furigana: "もんだい"), Segment(text: "です。")],
        kana: 'さいごのもんだいです。',
        romaji: 'Saigo no mondai desu.',
        meaning: '💡 Giải thích: Chiki đã mô tả: "Yasashikute, majime na hito" (Hiền và chăm chỉ).',
      )
    ]
  ),
  // --- HỘI THOẠI 4: MÔN HỌC YÊU THÍCH (AKI & ISORA) ---
  ConversationLesson(
    id: 'conv_4_subject',
    title: '4. Môn học yêu thích (好きな科目)',
    description: 'Hội thoại về môn học yêu thích, lý do thích và việc học tập hàng ngày.',
    characters: [CharacterName.aki, CharacterName.isora],
    prerequisites: ['school', 'routine'],
    lines: [
      const DialogueLine(
        id: 1,
        speaker: CharacterName.aki,
        segments: [Segment(text: "あなたはどんな"), Segment(text: "科目", furigana: "かもく"), Segment(text: "が"), Segment(text: "好", furigana: "す"), Segment(text: "きですか。")],
        kana: 'あなたはどんなかもくがすきですか。',
        romaji: 'Anata wa donna kamoku ga suki desu ka?',
        meaning: 'Bạn thích môn học nào?',
      ),
      const DialogueLine(
        id: 2,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "科目", furigana: "かもく"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Lớp học (Kurasu)', 'Môn học', 'Bài kiểm tra (Tesuto)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は...")],
        kana: 'いみは...',
        romaji: 'Imi wa...',
        meaning: '💡 Giải thích: "Kamoku" nghĩa là Môn học (Toán, Lý, Tiếng Nhật...). Lớp học là "Kyoushitsu/Kurasu".',
      ),
      const DialogueLine(
        id: 3,
        speaker: CharacterName.isora,
        segments: [Segment(text: "日本語", furigana: "にほんご"), Segment(text: "が"), Segment(text: "好", furigana: "す"), Segment(text: "きです。")],
        kana: 'にほんごがすきです。',
        romaji: 'Nihongo ga suki desu.',
        meaning: 'Tôi thích tiếng Nhật.',
      ),
      const DialogueLine(
        id: 4,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 日本語"), Segment(text: " ______ "), Segment(text: "好", furigana: "す"), Segment(text: "きです。(Điền trợ từ)")
        ],
        quizOptions: ['は (wa) - Chủ đề chung', 'が (ga) - Đối tượng được thích', 'に (ni) - Nơi chốn'],
        correctOptionIndex: 1,
        segments: [Segment(text: "「が」ですね。")],
        kana: 'がですね。',
        romaji: 'Ga desu ne.',
        meaning: '💡 Giải thích: Với tính từ chỉ sở thích/năng lực (Suki, Kirai, Jouzu...), ta dùng trợ từ "Ga" để chỉ đối tượng.',
      ),
      const DialogueLine(
        id: 5,
        speaker: CharacterName.aki,
        segments: [Segment(text: "どうして"), Segment(text: "日本語", furigana: "にほんご"), Segment(text: "が"), Segment(text: "好", furigana: "す"), Segment(text: "きですか。")],
        kana: 'どうしてにほんごがすきですか。',
        romaji: 'Doushite Nihongo ga suki desu ka?',
        meaning: 'Tại sao bạn thích tiếng Nhật?',
      ),
      const DialogueLine(
        id: 6,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「どうして」は"), Segment(text: "何", furigana: "なに"), Segment(text: "を"), Segment(text: "聞", furigana: "き"), Segment(text: "きますか？")
        ],
        quizOptions: ['Khi nào (Itsu)', 'Ở đâu (Doko)', 'Tại sao'],
        correctOptionIndex: 2,
        segments: [Segment(text: "理由", furigana: "りゆう"), Segment(text: "を...")],
        kana: 'りゆうを...',
        romaji: 'Riyuu o...',
        meaning: '💡 Giải thích: "Doushite" dùng để hỏi lý do/nguyên nhân (Tại sao?).',
      ),
      const DialogueLine(
        id: 7,
        speaker: CharacterName.isora,
        segments: [Segment(text: "先生", furigana: "せんせい"), Segment(text: "がやさしいからです。")],
        kana: 'せんせいがやさしいからです。',
        romaji: 'Sensei ga yasashii kara desu.',
        meaning: 'Vì giáo viên hiền ạ.',
      ),
      const DialogueLine(
        id: 8,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「～からです」は"), Segment(text: "何", furigana: "なに"), Segment(text: "を"), Segment(text: "表", furigana: "あらわ"), Segment(text: "しますか？")
        ],
        quizOptions: ['Kết quả', 'Nguyên nhân / Lý do', 'Thứ tự'],
        correctOptionIndex: 1,
        segments: [Segment(text: "理由", furigana: "りゆう"), Segment(text: "です。")],
        kana: 'りゆうです。',
        romaji: 'Riyuu desu.',
        meaning: '💡 Giải thích: Cấu trúc "...kara desu" đứng cuối câu để giải thích nguyên nhân (Vì là...).',
      ),
      const DialogueLine(
        id: 9,
        speaker: CharacterName.aki,
        segments: [Segment(text: "日本語", furigana: "にほんご"), Segment(text: "の"), Segment(text: "授業", furigana: "じゅぎょう"), Segment(text: "はおもしろいですか。")],
        kana: 'にほんごのじゅぎょうはおもしろいですか。',
        romaji: 'Nihongo no jugyou wa omoshiroi desu ka?',
        meaning: 'Giờ học tiếng Nhật có thú vị không?',
      ),
      const DialogueLine(
        id: 10,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「おもしろい」はどの"), Segment(text: "種類", furigana: "しゅるい"), Segment(text: "？(Loại từ?)")
        ],
        quizOptions: ['Danh từ', 'Tính từ đuôi I', 'Tính từ đuôi Na'],
        correctOptionIndex: 1,
        segments: [Segment(text: "い"), Segment(text: "形容詞", furigana: "けいようし"), Segment(text: "です。")],
        kana: 'いけいようしです。',
        romaji: 'I-keiyoushi desu.',
        meaning: '💡 Giải thích: "Omoshiroi" kết thúc bằng "i", là tính từ đuôi I (Thú vị).',
      ),
      const DialogueLine(
        id: 11,
        speaker: CharacterName.isora,
        segments: [Segment(text: "はい、とてもおもしろいです。")],
        kana: 'はい、とてもおもしろいです。',
        romaji: 'Hai, totemo omoshiroi desu.',
        meaning: 'Vâng, rất thú vị.',
      ),
      const DialogueLine(
        id: 12,
        speaker: CharacterName.aki,
        segments: [Segment(text: "毎日", furigana: "まいにち"), Segment(text: "、"), Segment(text: "日本語", furigana: "にほんご"), Segment(text: "を"), Segment(text: "勉強", furigana: "べんきょう"), Segment(text: "しますか。")],
        kana: 'まいにち、にほんごをべんきょうしますか。',
        romaji: 'Mainichi, nihongo o benkyou shimasu ka?',
        meaning: 'Bạn có học tiếng Nhật mỗi ngày không?',
      ),
      const DialogueLine(
        id: 13,
        speaker: CharacterName.isora,
        segments: [Segment(text: "はい、"), Segment(text: "毎日", furigana: "まいにち"), Segment(text: "勉強", furigana: "べんきょう"), Segment(text: "します。")],
        kana: 'はい、まいにちべんきょうします。',
        romaji: 'Hai, mainichi benkyou shimasu.',
        meaning: 'Vâng, tôi học mỗi ngày.',
      ),
      const DialogueLine(
        id: 14,
        speaker: CharacterName.aki,
        segments: [Segment(text: "テストはむずかしいですか。")],
        kana: 'テストはむずかしいですか。',
        romaji: 'Tesuto wa muzukashii desu ka?',
        meaning: 'Bài kiểm tra có khó không?',
      ),
      const DialogueLine(
        id: 15,
        speaker: CharacterName.isora,
        segments: [Segment(text: "いいえ、あまりむずかしくないです。")],
        kana: 'いいえ、あまりむずかしくないです。',
        romaji: 'Iie, amari muzukashikunai desu.',
        meaning: 'Không, không khó lắm đâu.',
      ),
      const DialogueLine(
        id: 16,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「むずかしくない」はどの"), Segment(text: "形", furigana: "かたち"), Segment(text: "？(Dạng gì?)")
        ],
        quizOptions: ['Khẳng định', 'Phủ định của tính từ I', 'Quá khứ'],
        correctOptionIndex: 1,
        segments: [Segment(text: "否定形", furigana: "ひていけい"), Segment(text: "です。")],
        kana: 'ひていけいです。',
        romaji: 'Hiteikei desu.',
        meaning: '💡 Giải thích: "Muzukashii" (Khó) -> Phủ định là "Muzukashikunai" (Không khó). Bỏ "i" thêm "kunai".',
      ),
      const DialogueLine(
        id: 17,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": B(Isora)はどんな"), Segment(text: "科目", furigana: "かもく"), Segment(text: "が"), Segment(text: "好", furigana: "す"), Segment(text: "きですか。")
        ],
        quizOptions: ['数学 (Toán)', '日本語 (Tiếng Nhật)', '英語 (Tiếng Anh)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "正解", furigana: "せいかい"), Segment(text: "は...")],
        kana: 'せいかいは...',
        romaji: 'Seikai wa...',
        meaning: '💡 Giải thích: Isora đã nói "Nihongo ga suki desu".',
      ),
      const DialogueLine(
        id: 18,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": 日本語"), Segment(text: "の"), Segment(text: "授業", furigana: "じゅぎょう"), Segment(text: "はどうですか。")
        ],
        quizOptions: ['Chán (Tsumaranai)', 'Thú vị (Omoshiroi)', 'Khó (Muzukashii)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "感想", furigana: "かんそう"), Segment(text: "は...")],
        kana: 'かんそうは...',
        romaji: 'Kansou wa...',
        meaning: '💡 Giải thích: Isora nhận xét "Totemo omoshiroi desu" (Rất thú vị).',
      ),
      const DialogueLine(
        id: 19,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": どうして"), Segment(text: "好", furigana: "す"), Segment(text: "きですか。(Tại sao thích?)")
        ],
        quizOptions: ['Vì giáo viên hiền', 'Vì bài kiểm tra dễ', 'Vì lớp học vui'],
        correctOptionIndex: 0,
        segments: [Segment(text: "理由", furigana: "りゆう"), Segment(text: "は...")],
        kana: 'りゆうは...',
        romaji: 'Riyuu wa...',
        meaning: '💡 Giải thích: Isora nói "Sensei ga yasashii kara desu" (Vì giáo viên hiền).',
      ),
      const DialogueLine(
        id: 20,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": "), Segment(text: "毎日勉強", furigana: "まいにちべんきょう"), Segment(text: "しますか。(Có học mỗi ngày không?)")
        ],
        quizOptions: ['Có, mỗi ngày', 'Không, hiếm khi', 'Chỉ cuối tuần'],
        correctOptionIndex: 0,
        segments: [Segment(text: "最後", furigana: "さいご"), Segment(text: "の"), Segment(text: "質問", furigana: "しつもん"), Segment(text: "です。")],
        kana: 'さいごのしつもんです。',
        romaji: 'Saigo no shitsumon desu.',
        meaning: '💡 Giải thích: Isora xác nhận "Hai, mainichi benkyou shimasu".',
      )
    ]
  ),
  // --- HỘI THOẠI 5: CÔNG VIỆC (DAIGO & ISORA) ---
  ConversationLesson(
    id: 'conv_5_job',
    title: '5. Công việc (仕事)',
    description: 'Hội thoại hỏi thăm về công việc, nơi làm việc và mức độ bận rộn.',
    characters: [CharacterName.daigo, CharacterName.isora],
    prerequisites: ['jobs'],
    lines: [
      const DialogueLine(
        id: 1,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "今", furigana: "いま"), Segment(text: "、"), Segment(text: "仕事", furigana: "しごと"), Segment(text: "をしていますか。")],
        kana: 'いま、しごとをしていますか。',
        romaji: 'Ima, shigoto o shiteimasu ka?',
        meaning: 'Bây giờ bạn có đang đi làm không?',
      ),
      const DialogueLine(
        id: 2,
        speaker: CharacterName.isora,
        segments: [Segment(text: "はい、しています。")],
        kana: 'はい、しています。',
        romaji: 'Hai, shiteimasu.',
        meaning: 'Vâng, tôi có.',
      ),
      const DialogueLine(
        id: 3,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "仕事", furigana: "しごと"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Học tập (Benkyou)', 'Công việc', 'Nghỉ ngơi (Yasumi)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は...")],
        kana: 'いみは...',
        romaji: 'Imi wa...',
        meaning: '💡 Giải thích: "Shigoto" nghĩa là Công việc. Học tập là "Benkyou", Nghỉ ngơi là "Yasumi".',
      ),
      const DialogueLine(
        id: 4,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "どんな"), Segment(text: "仕事", furigana: "しごと"), Segment(text: "をしていますか。")],
        kana: 'どんなしごとをしていますか。',
        romaji: 'Donna shigoto o shiteimasu ka?',
        meaning: 'Bạn đang làm công việc gì?',
      ),
      const DialogueLine(
        id: 5,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "仕事", furigana: "しごと"), Segment(text: "をしています」の「を」は？")
        ],
        quizOptions: ['Chỉ nơi chốn', 'Chỉ đối tượng hành động', 'Chỉ thời gian'],
        correctOptionIndex: 1,
        segments: [Segment(text: "「を」の"), Segment(text: "働", furigana: "はたら"), Segment(text: "き...")],
        kana: 'をのはたらき...',
        romaji: 'O no hataraki...',
        meaning: '💡 Giải thích: Trợ từ "O" (Wo) dùng để chỉ đối tượng chịu tác động của hành động (Làm cái gì? -> Làm công việc).',
      ),
      const DialogueLine(
        id: 6,
        speaker: CharacterName.isora,
        segments: [Segment(text: "会社員", furigana: "かいしゃいん"), Segment(text: "です。")],
        kana: 'かいしゃいんです。',
        romaji: 'Kaishain desu.',
        meaning: 'Tôi là nhân viên công ty.',
      ),
      const DialogueLine(
        id: 7,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "会社員", furigana: "かいしゃいん"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Học sinh (Gakusei)', 'Nhân viên công ty', 'Giáo viên (Kyoushi)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "職業", furigana: "しょくぎょう"), Segment(text: "です。")],
        kana: 'しょくぎょうです。',
        romaji: 'Shokugyou desu.',
        meaning: '💡 Giải thích: "Kaisha" (Công ty) + "In" (Thành viên) -> "Kaishain" là nhân viên công ty.',
      ),
      const DialogueLine(
        id: 8,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "どこで"), Segment(text: "働", furigana: "はたら"), Segment(text: "いていますか。")],
        kana: 'どこではたらいていますか。',
        romaji: 'Doko de hataraite imasu ka?',
        meaning: 'Bạn làm việc ở đâu?',
      ),
      const DialogueLine(
        id: 9,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "働", furigana: "はたら"), Segment(text: "いています」はどの"), Segment(text: "形", furigana: "かたち"), Segment(text: "？")
        ],
        quizOptions: ['Quá khứ', 'Hiện tại tiếp diễn', 'Mệnh lệnh'],
        correctOptionIndex: 1,
        segments: [Segment(text: "〜ています。")],
        kana: 'て います。',
        romaji: '~Te imasu.',
        meaning: '💡 Giải thích: "Hataraite imasu" (V-te imasu) diễn tả trạng thái công việc đang diễn ra hiện tại.',
      ),
      const DialogueLine(
        id: 10,
        speaker: CharacterName.isora,
        segments: [Segment(text: "ハノイの"), Segment(text: "会社", furigana: "かいしゃ"), Segment(text: "で"), Segment(text: "働", furigana: "はたら"), Segment(text: "いています。")],
        kana: 'ハノイのかいしゃではたらいています。',
        romaji: 'Hanoi no kaisha de hataraite imasu.',
        meaning: 'Tôi làm việc tại một công ty ở Hà Nội.',
      ),
      const DialogueLine(
        id: 11,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "仕事", furigana: "しごと"), Segment(text: "は"), Segment(text: "忙", furigana: "いそが"), Segment(text: "しいですか。")],
        kana: 'しごとはいそがしいですか。',
        romaji: 'Shigoto wa isogashii desu ka?',
        meaning: 'Công việc có bận không?',
      ),
      const DialogueLine(
        id: 12,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "忙", furigana: "いそが"), Segment(text: "しい」はどの"), Segment(text: "種類", furigana: "しゅるい"), Segment(text: "？")
        ],
        quizOptions: ['Tính từ đuôi Na', 'Tính từ đuôi I', 'Danh từ'],
        correctOptionIndex: 1,
        segments: [Segment(text: "「い」で"), Segment(text: "終", furigana: "お"), Segment(text: "わる...")],
        kana: 'いでおわる...',
        romaji: 'I de owaru...',
        meaning: '💡 Giải thích: "Isogashii" kết thúc bằng "i", là tính từ đuôi I (Bận rộn).',
      ),
      const DialogueLine(
        id: 13,
        speaker: CharacterName.isora,
        segments: [Segment(text: "はい、"), Segment(text: "少", furigana: "すこ"), Segment(text: "し"), Segment(text: "忙", furigana: "いそが"), Segment(text: "しいです。")],
        kana: 'はい、すこしいそがしいです。',
        romaji: 'Hai, sukoshi isogashii desu.',
        meaning: 'Vâng, hơi bận một chút.',
      ),
      const DialogueLine(
        id: 14,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "少", furigana: "すこ"), Segment(text: "し」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Rất (Totemo)', 'Ít / Một chút', 'Luôn luôn (Itsumo)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "程度", furigana: "ていど"), Segment(text: "は...")],
        kana: 'ていどは...',
        romaji: 'Teido wa...',
        meaning: '💡 Giải thích: "Sukoshi" nghĩa là một chút, một ít. Trái nghĩa với "Takusan" (Nhiều).',
      ),
      const DialogueLine(
        id: 15,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "仕事", furigana: "しごと"), Segment(text: "は"), Segment(text: "好", furigana: "す"), Segment(text: "きですか。")],
        kana: 'しごとはすきですか。',
        romaji: 'Shigoto wa suki desu ka?',
        meaning: 'Bạn có thích công việc không?',
      ),
      const DialogueLine(
        id: 16,
        speaker: CharacterName.isora,
        segments: [Segment(text: "はい、"), Segment(text: "好", furigana: "す"), Segment(text: "きです。")],
        kana: 'はい、すきです。',
        romaji: 'Hai, suki desu.',
        meaning: 'Vâng, tôi thích.',
      ),
      const DialogueLine(
        id: 17,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": B(Isora)の"), Segment(text: "仕事", furigana: "しごと"), Segment(text: "は"), Segment(text: "何", furigana: "なに"), Segment(text: "ですか。")
        ],
        quizOptions: ['学生 (Gakusei)', '会社員 (Kaishain)', '教師 (Kyoushi)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "正解", furigana: "せいかい"), Segment(text: "は...")],
        kana: 'せいかいは...',
        romaji: 'Seikai wa...',
        meaning: '💡 Giải thích: Isora đã nói "Kaishain desu" (Tôi là nhân viên công ty).',
      ),
      const DialogueLine(
        id: 18,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": どこで"), Segment(text: "働", furigana: "はたら"), Segment(text: "いていますか。")
        ],
        quizOptions: ['日本', 'ハノイの会社', '学校'],
        correctOptionIndex: 1,
        segments: [Segment(text: "場所", furigana: "ばしょ"), Segment(text: "は...")],
        kana: 'ばしょは...',
        romaji: 'Basho wa...',
        meaning: '💡 Giải thích: Isora nói "Hanoi no kaisha de..." (Tại công ty ở Hà Nội).',
      ),
      const DialogueLine(
        id: 19,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "忙", furigana: "いそが"), Segment(text: "しい」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Rảnh rỗi (Hima)', 'Bận rộn', 'Vui vẻ (Tanoshii)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は...")],
        kana: 'いみは...',
        romaji: 'Imi wa...',
        meaning: '💡 Giải thích: "Isogashii" là bận rộn. Trái nghĩa là "Hima" (Rảnh).',
      ),
      const DialogueLine(
        id: 20,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": 仕事", furigana: "しごと"), Segment(text: "が"), Segment(text: "好", furigana: "す"), Segment(text: "きですか。")
        ],
        quizOptions: ['はい、好きです', 'いいえ、好きではありません', 'わかりません'],
        correctOptionIndex: 0,
        segments: [Segment(text: "最後", furigana: "さいご"), Segment(text: "の"), Segment(text: "答", furigana: "こた"), Segment(text: "え...")],
        kana: 'さいごのこたえ...',
        romaji: 'Saigo no kotae...',
        meaning: '💡 Giải thích: Isora trả lời "Hai, suki desu" (Vâng, tôi thích).',
      )
    ]
  )
];
