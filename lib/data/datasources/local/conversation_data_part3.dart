
import '../../../domain/entities/conversation_models.dart';

final List<ConversationLesson> conversationDataPart3 = [
  // --- HỘI THOẠI 11: DU LỊCH (DAIGO & CHIKI) ---
  ConversationLesson(
    id: 'conv_11_travel',
    title: '11. Du lịch (旅行)',
    description: 'Hội thoại về kế hoạch đi du lịch Nhật Bản, thời gian và người đồng hành.',
    characters: [CharacterName.daigo, CharacterName.chiki],
    prerequisites: ['travel', 'numbers'],
    lines: [
      const DialogueLine(
        id: 1,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "旅行", furigana: "りょこう"), Segment(text: "が"), Segment(text: "好", furigana: "す"), Segment(text: "きですか。")],
        kana: 'りょこうがすきですか。',
        romaji: 'Ryokou ga suki desu ka?',
        meaning: 'Bạn có thích du lịch không?',
      ),
      const DialogueLine(
        id: 2,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "旅行", furigana: "りょこう"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Công việc (Shigoto)', 'Du lịch', 'Học tập (Benkyou)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は...")],
        kana: 'いみは...',
        romaji: 'Imi wa...',
        meaning: '💡 Giải thích: "Ryokou" nghĩa là Du lịch.',
      ),
      const DialogueLine(
        id: 3,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "はい、"), Segment(text: "好", furigana: "す"), Segment(text: "きです。")],
        kana: 'はい、すきです。',
        romaji: 'Hai, suki desu.',
        meaning: 'Vâng, tôi thích.',
      ),
      const DialogueLine(
        id: 4,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "どこへ"), Segment(text: "行", furigana: "い"), Segment(text: "きたいですか。")],
        kana: 'どこへいきたいですか。',
        romaji: 'Doko e ikitai desu ka?',
        meaning: 'Bạn muốn đi đâu?',
      ),
      const DialogueLine(
        id: 5,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "日本", furigana: "にほん"), Segment(text: "へ"), Segment(text: "行", furigana: "い"), Segment(text: "きたいです。")],
        kana: 'にほんへいきたいです。',
        romaji: 'Nihon e ikitai desu.',
        meaning: 'Tôi muốn đi Nhật Bản.',
      ),
      const DialogueLine(
        id: 6,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "日本", furigana: "にほん"), Segment(text: "へ...」の「へ」は？")
        ],
        quizOptions: ['Nơi xuất phát', 'Hướng / Điểm đến', 'Thời gian'],
        correctOptionIndex: 1,
        segments: [Segment(text: "方向", furigana: "ほうこう"), Segment(text: "です。")],
        kana: 'ほうこうです。',
        romaji: 'Houkou desu.',
        meaning: '💡 Giải thích: Trợ từ "He" (đọc là E) chỉ phương hướng hoặc điểm đến của hành động di chuyển.',
      ),
      const DialogueLine(
        id: 7,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "行", furigana: "い"), Segment(text: "きたいです」は"), Segment(text: "何", furigana: "なに"), Segment(text: "を表す？")
        ],
        quizOptions: ['Hành động đã xong', 'Mong muốn (Want)', 'Mệnh lệnh'],
        correctOptionIndex: 1,
        segments: [Segment(text: "希望", furigana: "きぼう"), Segment(text: "です。")],
        kana: 'きぼうです。',
        romaji: 'Kibou desu.',
        meaning: '💡 Giải thích: Mẫu câu "V-tai desu" diễn tả mong muốn làm gì đó (Muốn đi).',
      ),
      const DialogueLine(
        id: 8,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "いつ"), Segment(text: "行", furigana: "い"), Segment(text: "きますか。")],
        kana: 'いついきますか。',
        romaji: 'Itsu ikimasu ka?',
        meaning: 'Khi nào bạn đi?',
      ),
      const DialogueLine(
        id: 9,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "来年", furigana: "らいねん"), Segment(text: "行", furigana: "い"), Segment(text: "きます。")],
        kana: 'らいねんいきます。',
        romaji: 'Rainen ikimasu.',
        meaning: 'Năm sau tôi sẽ đi.',
      ),
      const DialogueLine(
        id: 10,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "来年", furigana: "らいねん"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Năm ngoái (Kyonen)', 'Năm nay (Kotoshi)', 'Năm sau'],
        correctOptionIndex: 2,
        segments: [Segment(text: "次", furigana: "つぎ"), Segment(text: "の"), Segment(text: "年", furigana: "とし"), Segment(text: "...")],
        kana: 'つぎのとし...',
        romaji: 'Tsugi no toshi...',
        meaning: '💡 Giải thích: "Rainen" là năm sau (Lai niên).',
      ),
      const DialogueLine(
        id: 11,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "何日", furigana: "なんにち"), Segment(text: "ぐらい"), Segment(text: "行", furigana: "い"), Segment(text: "きますか。")],
        kana: 'なんにちぐらいいきますか。',
        romaji: 'Nannichi gurai ikimasu ka?',
        meaning: 'Bạn đi khoảng bao nhiêu ngày?',
      ),
      const DialogueLine(
        id: 12,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "5"), Segment(text: "日", furigana: "にち"), Segment(text: "ぐらい"), Segment(text: "行", furigana: "い"), Segment(text: "きます。")],
        kana: 'ごにちぐらいいきます。',
        romaji: 'Gonichi gurai ikimasu.',
        meaning: 'Tôi đi khoảng 5 ngày.',
      ),
      const DialogueLine(
        id: 13,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「ぐらい」は"), Segment(text: "何", furigana: "なに"), Segment(text: "を表す？")
        ],
        quizOptions: ['Số lượng chính xác', 'Khoảng chừng (Ước lượng)', 'So sánh'],
        correctOptionIndex: 1,
        segments: [Segment(text: "およそ...")],
        kana: 'およそ...',
        romaji: 'Oyoso...',
        meaning: '💡 Giải thích: "Gurai" (hoặc Kurai) đứng sau số lượng từ để chỉ sự ước lượng (Khoảng chừng).',
      ),
      const DialogueLine(
        id: 14,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "一人", furigana: "ひとり"), Segment(text: "で"), Segment(text: "行", furigana: "い"), Segment(text: "きますか。")],
        kana: 'ひとりでいきますか。',
        romaji: 'Hitori de ikimasu ka?',
        meaning: 'Bạn đi một mình à?',
      ),
      const DialogueLine(
        id: 15,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "一人", furigana: "ひとり"), Segment(text: "で」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Một mình', 'Cùng nhau (Issho ni)', 'Nhanh chóng'],
        correctOptionIndex: 0,
        segments: [Segment(text: "他", furigana: "ほか"), Segment(text: "の"), Segment(text: "人", furigana: "ひと"), Segment(text: "なしで...")],
        kana: 'ほかのひとなしで...',
        romaji: 'Hoka no hito nashi de...',
        meaning: '💡 Giải thích: "Hitori" (1 người) + "De" -> Một mình (trạng thái làm việc gì đó một mình).',
      ),
      const DialogueLine(
        id: 16,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "いいえ、"), Segment(text: "友", furigana: "とも"), Segment(text: "だちと"), Segment(text: "行", furigana: "い"), Segment(text: "きます。")],
        kana: 'いいえ、ともだちといきます。',
        romaji: 'Iie, tomodachi to ikimasu.',
        meaning: 'Không, tôi đi cùng bạn.',
      ),
      const DialogueLine(
        id: 17,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": Bは"), Segment(text: "旅行", furigana: "りょこう"), Segment(text: "が"), Segment(text: "好", furigana: "す"), Segment(text: "きですか。")
        ],
        quizOptions: ['はい、好きです', 'いいえ、好きではありません', 'わかりません'],
        correctOptionIndex: 0,
        segments: [Segment(text: "正解", furigana: "せいかい"), Segment(text: "は...")],
        kana: 'せいかいは...',
        romaji: 'Seikai wa...',
        meaning: '💡 Giải thích: Chiki đã trả lời "Hai, suki desu" ở đầu bài.',
      ),
      const DialogueLine(
        id: 18,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": Bはいつ"), Segment(text: "行", furigana: "い"), Segment(text: "きますか。")
        ],
        quizOptions: ['Tháng này (Kongetsu)', 'Năm sau (Rainen)', 'Tuần sau (Raishuu)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "時期", furigana: "じき"), Segment(text: "は...")],
        kana: 'じきは...',
        romaji: 'Jiki wa...',
        meaning: '💡 Giải thích: Chiki nói "Rainen ikimasu" (Năm sau).',
      ),
      const DialogueLine(
        id: 19,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": どのくらい"), Segment(text: "行", furigana: "い"), Segment(text: "きますか。")
        ],
        quizOptions: ['Khoảng 3 ngày', 'Khoảng 5 ngày', 'Khoảng 7 ngày'],
        correctOptionIndex: 1,
        segments: [Segment(text: "期間", furigana: "きかん"), Segment(text: "は...")],
        kana: 'きかんは...',
        romaji: 'Kikan wa...',
        meaning: '💡 Giải thích: Chiki nói "5-nichi gurai" (Khoảng 5 ngày).',
      ),
      const DialogueLine(
        id: 20,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": "), Segment(text: "誰", furigana: "だれ"), Segment(text: "と"), Segment(text: "行", furigana: "い"), Segment(text: "きますか。")
        ],
        quizOptions: ['Một mình (Hitori)', 'Gia đình (Kazoku)', 'Bạn bè (Tomodachi)'],
        correctOptionIndex: 2,
        segments: [Segment(text: "同行者", furigana: "どうこうしゃ"), Segment(text: "は...")],
        kana: 'どうこうしゃは...',
        romaji: 'Doukousha wa...',
        meaning: '💡 Giải thích: Chiki nói "Tomodachi to ikimasu" (Đi cùng bạn).',
      )
    ]
  )
,
  // --- HỘI THOẠI 12: SỞ THÍCH (ISORA & AKI) ---
  ConversationLesson(
    id: 'conv_12_hobby',
    title: '12. Sở thích (趣味)',
    description: 'Hội thoại hỏi về sở thích, thể loại nhạc yêu thích và thói quen nghe nhạc.',
    characters: [CharacterName.isora, CharacterName.aki],
    prerequisites: ['hobbies', 'music'],
    lines: [
      const DialogueLine(
        id: 1,
        speaker: CharacterName.isora,
        segments: [Segment(text: "趣味", furigana: "しゅみ"), Segment(text: "は"), Segment(text: "何", furigana: "なん"), Segment(text: "ですか。")],
        kana: 'しゅみはなんですか。',
        romaji: 'Shumi wa nan desu ka?',
        meaning: 'Sở thích của bạn là gì?',
      ),
      const DialogueLine(
        id: 2,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "趣味", furigana: "しゅみ"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Công việc (Shigoto)', 'Sở thích', 'Thói quen (Shuukan)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は...")],
        kana: 'いみは...',
        romaji: 'Imi wa...',
        meaning: '💡 Giải thích: "Shumi" nghĩa là Sở thích.',
      ),
      const DialogueLine(
        id: 3,
        speaker: CharacterName.aki,
        segments: [Segment(text: "音楽", furigana: "おんがく"), Segment(text: "を"), Segment(text: "聞", furigana: "き"), Segment(text: "くことです。")],
        kana: 'おんがくをきくことです。',
        romaji: 'Ongaku o kiku koto desu.',
        meaning: 'Là việc nghe nhạc.',
      ),
      const DialogueLine(
        id: 4,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "音楽", furigana: "おんがく"), Segment(text: "を"), Segment(text: "聞", furigana: "き"), Segment(text: "く」の「を」は？")
        ],
        quizOptions: ['Chỉ nơi chốn', 'Chỉ đối tượng (Tân ngữ)', 'Chỉ thời gian'],
        correctOptionIndex: 1,
        segments: [Segment(text: "目的語", furigana: "もくてきご"), Segment(text: "を...")],
        kana: 'もくてきごを...',
        romaji: 'Mokutekigo o...',
        meaning: '💡 Giải thích: Trợ từ "O" chỉ đối tượng của hành động (Nghe cái gì? -> Nghe Nhạc).',
      ),
      const DialogueLine(
        id: 5,
        speaker: CharacterName.isora,
        segments: [Segment(text: "どんな"), Segment(text: "音楽", furigana: "おんがく"), Segment(text: "が"), Segment(text: "好", furigana: "す"), Segment(text: "きですか。")],
        kana: 'どんなおんがくがすきですか。',
        romaji: 'Donna ongaku ga suki desu ka?',
        meaning: 'Bạn thích loại nhạc nào?',
      ),
      const DialogueLine(
        id: 6,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「どんな」は"), Segment(text: "何", furigana: "なに"), Segment(text: "を"), Segment(text: "聞", furigana: "き"), Segment(text: "く？")
        ],
        quizOptions: ['Số lượng', 'Loại / Tính chất', 'Thời gian'],
        correctOptionIndex: 1,
        segments: [Segment(text: "種類", furigana: "しゅるい"), Segment(text: "や"), Segment(text: "特徴", furigana: "とくちょう"), Segment(text: "...")],
        kana: 'しゅるいやとくちょう...',
        romaji: 'Shurui ya tokuchou...',
        meaning: '💡 Giải thích: "Donna" dùng để hỏi về chủng loại hoặc tính chất của sự vật/sự việc.',
      ),
      const DialogueLine(
        id: 7,
        speaker: CharacterName.aki,
        segments: [Segment(text: "ポップスが"), Segment(text: "好", furigana: "す"), Segment(text: "きです。")],
        kana: 'ポップスがすきです。',
        romaji: 'Poppusu ga suki desu.',
        meaning: 'Tôi thích nhạc Pop.',
      ),
      const DialogueLine(
        id: 8,
        speaker: CharacterName.isora,
        segments: [Segment(text: "いつ"), Segment(text: "音楽", furigana: "おんがく"), Segment(text: "を"), Segment(text: "聞", furigana: "き"), Segment(text: "きますか。")],
        kana: 'いつおんがくをききますか。',
        romaji: 'Itsu ongaku o kikimasu ka?',
        meaning: 'Bạn nghe nhạc khi nào?',
      ),
      const DialogueLine(
        id: 9,
        speaker: CharacterName.aki,
        segments: [Segment(text: "ひまなときに"), Segment(text: "聞", furigana: "き"), Segment(text: "きます。")],
        kana: 'ひまなときにききます。',
        romaji: 'Hima na toki ni kikimasu.',
        meaning: 'Tôi nghe khi rảnh rỗi.',
      ),
      const DialogueLine(
        id: 10,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「ひまなとき」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Khi bận (Isogashii)', 'Khi rảnh rỗi', 'Khi buồn (Kanashii)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "時間", furigana: "じかん"), Segment(text: "がある"), Segment(text: "時", furigana: "とき"), Segment(text: "...")],
        kana: 'じかんがあるとき...',
        romaji: 'Jikan ga aru toki...',
        meaning: '💡 Giải thích: "Hima" (Rảnh) + "Toki" (Khi/Lúc) -> Khi rảnh rỗi.',
      ),
      const DialogueLine(
        id: 11,
        speaker: CharacterName.isora,
        segments: [Segment(text: "一日", furigana: "いちにち"), Segment(text: "にどのくらい"), Segment(text: "聞", furigana: "き"), Segment(text: "きますか。")],
        kana: 'いちにちにどのくらいききますか。',
        romaji: 'Ichinichi ni dono kurai kikimasu ka?',
        meaning: 'Một ngày bạn nghe khoảng bao lâu?',
      ),
      const DialogueLine(
        id: 12,
        speaker: CharacterName.aki,
        segments: [Segment(text: "1"), Segment(text: "時間", furigana: "じかん"), Segment(text: "ぐらい"), Segment(text: "聞", furigana: "き"), Segment(text: "きます。")],
        kana: 'いちじかんぐらいききます。',
        romaji: 'Ichi-jikan gurai kikimasu.',
        meaning: 'Tôi nghe khoảng 1 tiếng.',
      ),
      const DialogueLine(
        id: 13,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「1"), Segment(text: "時間", furigana: "じかん"), Segment(text: "ぐらい」の「ぐらい」は？")
        ],
        quizOptions: ['Chính xác', 'Khoảng chừng', 'So sánh'],
        correctOptionIndex: 1,
        segments: [Segment(text: "およそ...")],
        kana: 'およそ...',
        romaji: 'Oyoso...',
        meaning: '💡 Giải thích: "Gurai" dùng để chỉ lượng ước chừng (Khoảng 1 tiếng).',
      ),
      const DialogueLine(
        id: 14,
        speaker: CharacterName.isora,
        segments: [Segment(text: "毎日", furigana: "まいにち"), Segment(text: "聞", furigana: "き"), Segment(text: "きますか。")],
        kana: 'まいにちききますか。',
        romaji: 'Mainichi kikimasu ka?',
        meaning: 'Bạn có nghe mỗi ngày không?',
      ),
      const DialogueLine(
        id: 15,
        speaker: CharacterName.aki,
        segments: [Segment(text: "はい、"), Segment(text: "毎日", furigana: "まいにち"), Segment(text: "聞", furigana: "き"), Segment(text: "きます。")],
        kana: 'はい、まいにちききます。',
        romaji: 'Hai, mainichi kikimasu.',
        meaning: 'Vâng, tôi nghe mỗi ngày.',
      ),
      const DialogueLine(
        id: 16,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "毎日", furigana: "まいにち"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Thỉnh thoảng (Tokidoki)', 'Mỗi ngày', 'Cuối tuần (Shuumatsu)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "頻度", furigana: "ひんど"), Segment(text: "は...")],
        kana: 'ひんどは...',
        romaji: 'Hindo wa...',
        meaning: '💡 Giải thích: "Mainichi" nghĩa là mỗi ngày (Hàng ngày).',
      ),
      const DialogueLine(
        id: 17,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": Bの"), Segment(text: "趣味", furigana: "しゅみ"), Segment(text: "は"), Segment(text: "何", furigana: "なん"), Segment(text: "ですか。")
        ],
        quizOptions: ['Nghe nhạc', 'Học tập', 'Làm việc'],
        correctOptionIndex: 0,
        segments: [Segment(text: "正解", furigana: "せいかい"), Segment(text: "は...")],
        kana: 'せいかいは...',
        romaji: 'Seikai wa...',
        meaning: '💡 Giải thích: Aki nói "Ongaku o kiku koto desu" (Việc nghe nhạc).',
      ),
      const DialogueLine(
        id: 18,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": どんな"), Segment(text: "音楽", furigana: "おんがく"), Segment(text: "が"), Segment(text: "好", furigana: "す"), Segment(text: "きですか。")
        ],
        quizOptions: ['Rock (Rokku)', 'Pops (Poppusu)', 'Cổ điển (Kurashikku)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "ジャンルは...")],
        kana: 'ジャンルは...',
        romaji: 'Janru wa...',
        meaning: '💡 Giải thích: Aki nói "Poppusu ga suki desu".',
      ),
      const DialogueLine(
        id: 19,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "意味", furigana: "いみ"), Segment(text: ": 「ひまなとき」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Khi bận', 'Khi rảnh', 'Khi ngủ'],
        correctOptionIndex: 1,
        segments: [Segment(text: "時間", furigana: "じかん"), Segment(text: "がある"), Segment(text: "時", furigana: "とき"), Segment(text: "...")],
        kana: 'じかんがあるとき...',
        romaji: 'Jikan ga aru toki...',
        meaning: '💡 Giải thích: "Hima na toki" nghĩa là lúc rảnh rỗi.',
      ),
      const DialogueLine(
        id: 20,
        speaker: CharacterName.aki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": "), Segment(text: "毎日", furigana: "まいにち"), Segment(text: "聞", furigana: "き"), Segment(text: "きますか。")
        ],
        quizOptions: ['Có, nghe mỗi ngày', 'Không, không nghe', 'Thỉnh thoảng mới nghe'],
        correctOptionIndex: 0,
        segments: [Segment(text: "頻度", furigana: "ひんど"), Segment(text: "は...")],
        kana: 'ひんどは...',
        romaji: 'Hindo wa...',
        meaning: '💡 Giải thích: Aki xác nhận "Hai, mainichi kikimasu".',
      )
    ]
  ),
  // --- HỘI THOẠI 13: ĐỒ ĂN (CHIKI & DAIGO) ---
  ConversationLesson(
    id: 'conv_13_food',
    title: '13. Đồ ăn (食べ物)',
    description: 'Hội thoại về món ăn yêu thích, nơi ăn uống và khẩu vị cay/ngọt.',
    characters: [CharacterName.chiki, CharacterName.daigo],
    prerequisites: ['food', 'routine'],
    lines: [
      const DialogueLine(
        id: 1,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "好", furigana: "す"), Segment(text: "きな"), Segment(text: "食", furigana: "た"), Segment(text: "べ"), Segment(text: "物", furigana: "もの"), Segment(text: "は"), Segment(text: "何", furigana: "なん"), Segment(text: "ですか。")],
        kana: 'すきなたべものはなんですか。',
        romaji: 'Suki na tabemono wa nan desu ka?',
        meaning: 'Món ăn yêu thích của bạn là gì?',
      ),
      const DialogueLine(
        id: 2,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "食", furigana: "た"), Segment(text: "べ"), Segment(text: "物", furigana: "もの"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Đồ uống (Nomimono)', 'Đồ ăn', 'Nhà hàng (Resutoran)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は...")],
        kana: 'いみは...',
        romaji: 'Imi wa...',
        meaning: '💡 Giải thích: "Tabemono" là Đồ ăn. Đồ uống là "Nomimono".',
      ),
      const DialogueLine(
        id: 3,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "フォーが"), Segment(text: "好", furigana: "す"), Segment(text: "きです。")],
        kana: 'フォーがすきです。',
        romaji: 'Foo ga suki desu.',
        meaning: 'Tôi thích Phở.',
      ),
      const DialogueLine(
        id: 4,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「フォーが"), Segment(text: "好", furigana: "す"), Segment(text: "き」の「が」は？")
        ],
        quizOptions: ['Chỉ chủ đề', 'Chỉ đối tượng được thích', 'Chỉ nơi chốn'],
        correctOptionIndex: 1,
        segments: [Segment(text: "対象", furigana: "たいしょう"), Segment(text: "を...")],
        kana: 'たいしょうを...',
        romaji: 'Taishou o...',
        meaning: '💡 Giải thích: Với tính từ "Suki" (Thích), trợ từ "Ga" dùng để chỉ đối tượng mà mình thích.',
      ),
      const DialogueLine(
        id: 5,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "よく"), Segment(text: "食", furigana: "た"), Segment(text: "べますか。")],
        kana: 'よくたべますか。',
        romaji: 'Yoku tabemasu ka?',
        meaning: 'Bạn có hay ăn không?',
      ),
      const DialogueLine(
        id: 6,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「よく」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Hiếm khi (Amari)', 'Thường xuyên / Hay', 'Không bao giờ (Zenzen)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "頻度", furigana: "ひんど"), Segment(text: "は...")],
        kana: 'ひんどは...',
        romaji: 'Hindo wa...',
        meaning: '💡 Giải thích: "Yoku" là phó từ chỉ tần suất cao (Thường xuyên, hay).',
      ),
      const DialogueLine(
        id: 7,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "はい、よく"), Segment(text: "食", furigana: "た"), Segment(text: "べます。")],
        kana: 'はい、よくたべます。',
        romaji: 'Hai, yoku tabemasu.',
        meaning: 'Vâng, tôi hay ăn lắm.',
      ),
      const DialogueLine(
        id: 8,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "どこで"), Segment(text: "食", furigana: "た"), Segment(text: "べますか。")],
        kana: 'どこでたべますか。',
        romaji: 'Doko de tabemasu ka?',
        meaning: 'Bạn ăn ở đâu?',
      ),
      const DialogueLine(
        id: 9,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "家", furigana: "いえ"), Segment(text: "で"), Segment(text: "食", furigana: "た"), Segment(text: "べます。")],
        kana: 'いえでたべます。',
        romaji: 'Ie de tabemasu.',
        meaning: 'Tôi ăn ở nhà.',
      ),
      const DialogueLine(
        id: 10,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "家", furigana: "いえ"), Segment(text: "で"), Segment(text: "食", furigana: "た"), Segment(text: "べます」の「で」は？")
        ],
        quizOptions: ['Nơi diễn ra hành động', 'Hướng đi (He)', 'Thời gian (Ni)'],
        correctOptionIndex: 0,
        segments: [Segment(text: "場所", furigana: "ばしょ"), Segment(text: "を...")],
        kana: 'ばしょを...',
        romaji: 'Basho o...',
        meaning: '💡 Giải thích: Trợ từ "De" chỉ địa điểm nơi hành động (ăn) diễn ra.',
      ),
      const DialogueLine(
        id: 11,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "朝", furigana: "あさ"), Segment(text: "ごはんに"), Segment(text: "食", furigana: "た"), Segment(text: "べますか。")],
        kana: 'あさごはんにたべますか。',
        romaji: 'Asagohan ni tabemasu ka?',
        meaning: 'Bạn ăn vào bữa sáng à?',
      ),
      const DialogueLine(
        id: 12,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "いいえ、"), Segment(text: "昼", furigana: "ひる"), Segment(text: "ごはんに"), Segment(text: "食", furigana: "た"), Segment(text: "べます。")],
        kana: 'いいえ、ひるごはんにたべます。',
        romaji: 'Iie, hirugohan ni tabemasu.',
        meaning: 'Không, tôi ăn vào bữa trưa.',
      ),
      const DialogueLine(
        id: 13,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "昼", furigana: "ひる"), Segment(text: "ごはん」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Bữa sáng (Asagohan)', 'Bữa trưa', 'Bữa tối (Bangohan)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "食事", furigana: "しょくじ"), Segment(text: "の"), Segment(text: "時間", furigana: "じかん"), Segment(text: "...")],
        kana: 'しょくじのじかん...',
        romaji: 'Shokuji no jikan...',
        meaning: '💡 Giải thích: "Hirugohan" là bữa trưa. "Asagohan" là bữa sáng, "Bangohan" là bữa tối.',
      ),
      const DialogueLine(
        id: 14,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "辛", furigana: "から"), Segment(text: "い"), Segment(text: "食", furigana: "た"), Segment(text: "べ"), Segment(text: "物", furigana: "もの"), Segment(text: "が"), Segment(text: "好", furigana: "す"), Segment(text: "きですか。")],
        kana: 'からいたべものがすきですか。',
        romaji: 'Karai tabemono ga suki desu ka?',
        meaning: 'Bạn có thích đồ ăn cay không?',
      ),
      const DialogueLine(
        id: 15,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "辛", furigana: "から"), Segment(text: "い」はどの"), Segment(text: "種類", furigana: "しゅるい"), Segment(text: "？")
        ],
        quizOptions: ['Tính từ đuôi Na', 'Tính từ đuôi I', 'Danh từ'],
        correctOptionIndex: 1,
        segments: [Segment(text: "形容詞", furigana: "けいようし"), Segment(text: "の"), Segment(text: "種類", furigana: "しゅるい"), Segment(text: "...")],
        kana: 'けいようしのしゅるい...',
        romaji: 'Keiyoushi no shurui...',
        meaning: '💡 Giải thích: "Karai" kết thúc bằng "i", là tính từ đuôi I (Cay).',
      ),
      const DialogueLine(
        id: 16,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "はい、"), Segment(text: "好", furigana: "す"), Segment(text: "きです。")],
        kana: 'はい、すきです。',
        romaji: 'Hai, suki desu.',
        meaning: 'Vâng, tôi thích.',
      ),
      const DialogueLine(
        id: 17,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": Bはどの"), Segment(text: "食", furigana: "た"), Segment(text: "べ"), Segment(text: "物", furigana: "もの"), Segment(text: "が"), Segment(text: "好", furigana: "す"), Segment(text: "きですか。")
        ],
        quizOptions: ['Mì Ramen', 'Phở (Foo)', 'Sushi'],
        correctOptionIndex: 1,
        segments: [Segment(text: "正解", furigana: "せいかい"), Segment(text: "は...")],
        kana: 'せいかいは...',
        romaji: 'Seikai wa...',
        meaning: '💡 Giải thích: Daigo nói "Foo ga suki desu".',
      ),
      const DialogueLine(
        id: 18,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": Bはどこで"), Segment(text: "食", furigana: "た"), Segment(text: "べますか。")
        ],
        quizOptions: ['Nhà hàng', 'Nhà (Ie)', 'Trường học'],
        correctOptionIndex: 1,
        segments: [Segment(text: "場所", furigana: "ばしょ"), Segment(text: "は...")],
        kana: 'ばしょは...',
        romaji: 'Basho wa...',
        meaning: '💡 Giải thích: Daigo trả lời "Ie de tabemasu" (Ăn ở nhà).',
      ),
      const DialogueLine(
        id: 19,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "意味", furigana: "いみ"), Segment(text: ": 「"), Segment(text: "辛", furigana: "から"), Segment(text: "い"), Segment(text: "食", furigana: "た"), Segment(text: "べ"), Segment(text: "物", furigana: "もの"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Đồ ăn ngọt (Amai)', 'Đồ ăn cay', 'Đồ ăn mặn (Shiokarai)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "味", furigana: "あじ"), Segment(text: "は...")],
        kana: 'あじは...',
        romaji: 'Aji wa...',
        meaning: '💡 Giải thích: "Karai" là cay.',
      ),
      const DialogueLine(
        id: 20,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": Bは"), Segment(text: "辛", furigana: "から"), Segment(text: "いものが"), Segment(text: "好", furigana: "す"), Segment(text: "きですか。")
        ],
        quizOptions: ['Có, thích', 'Không, không thích', 'Không biết'],
        correctOptionIndex: 0,
        segments: [Segment(text: "好", furigana: "この"), Segment(text: "みは...")],
        kana: 'このみは...',
        romaji: 'Konomi wa...',
        meaning: '💡 Giải thích: Daigo xác nhận "Hai, suki desu".',
      )
    ]
  )
,
  // --- HỘI THOẠI 14: SỨC KHỎE (ISORA & DAIGO) ---
  ConversationLesson(
    id: 'conv_14_health',
    title: '14. Sức khỏe (健康)',
    description: 'Hội thoại về tình trạng sức khỏe, thói quen ngủ nghỉ, tập thể dục và ăn uống.',
    characters: [CharacterName.isora, CharacterName.daigo],
    prerequisites: ['routine', 'sports'],
    lines: [
      const DialogueLine(
        id: 1,
        speaker: CharacterName.isora,
        segments: [Segment(text: "最近", furigana: "さいきん"), Segment(text: "、"), Segment(text: "体", furigana: "からだ"), Segment(text: "の"), Segment(text: "調子", furigana: "ちょうし"), Segment(text: "はどうですか。")],
        kana: 'さいきん、からだのちょうしはどうですか。',
        romaji: 'Saikin, karada no choushi wa dou desu ka?',
        meaning: 'Dạo này tình trạng cơ thể của bạn thế nào?',
      ),
      const DialogueLine(
        id: 2,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "元気", furigana: "げんき"), Segment(text: "です。")],
        kana: 'げんきです。',
        romaji: 'Genki desu.',
        meaning: 'Tôi khỏe.',
      ),
      const DialogueLine(
        id: 3,
        speaker: CharacterName.isora,
        segments: [Segment(text: "ちゃんと"), Segment(text: "寝", furigana: "ね"), Segment(text: "ていますか。")],
        kana: 'ちゃんとねていますか。',
        romaji: 'Chanto nete imasu ka?',
        meaning: 'Bạn có ngủ nghỉ đầy đủ (đúng cách) không?',
      ),
      const DialogueLine(
        id: 4,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「ちゃんと」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Không hề (Zenzen)', 'Đúng cách / Đầy đủ', 'Nhanh chóng (Hayaku)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "しっかり...")],
        kana: 'しっかり...',
        romaji: 'Shikkari...',
        meaning: '💡 Giải thích: "Chanto" diễn tả việc làm gì đó một cách cẩn thận, đúng đắn, đầy đủ.',
      ),
      const DialogueLine(
        id: 5,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "寝", furigana: "ね"), Segment(text: "ています」の"), Segment(text: "辞書形", furigana: "じしょけい"), Segment(text: "は？")
        ],
        quizOptions: ['寝る (Neru)', '食べる (Taberu)', '走る (Hashiru)'],
        correctOptionIndex: 0,
        segments: [Segment(text: "動詞", furigana: "どうし"), Segment(text: "の"), Segment(text: "原形", furigana: "げんけい"), Segment(text: "...")],
        kana: 'どうしのげんけい...',
        romaji: 'Doushi no genkei...',
        meaning: '💡 Giải thích: "Nete imasu" bắt nguồn từ động từ nhóm 2 "Neru" (Ngủ).',
      ),
      const DialogueLine(
        id: 6,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "はい、"), Segment(text: "毎日", furigana: "まいにち"), Segment(text: "7"), Segment(text: "時間", furigana: "じかん"), Segment(text: "寝", furigana: "ね"), Segment(text: "ています。")],
        kana: 'はい、まいにちななじかんねています。',
        romaji: 'Hai, mainichi nana-jikan nete imasu.',
        meaning: 'Vâng, mỗi ngày tôi ngủ 7 tiếng.',
      ),
      const DialogueLine(
        id: 7,
        speaker: CharacterName.isora,
        segments: [Segment(text: "運動", furigana: "うんどう"), Segment(text: "をしていますか。")],
        kana: 'うんどうをしていますか。',
        romaji: 'Undou o shiteimasu ka?',
        meaning: 'Bạn có tập thể dục không?',
      ),
      const DialogueLine(
        id: 8,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "運動", furigana: "うんどう"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Học tập', 'Nghỉ ngơi', 'Tập thể dục / Vận động'],
        correctOptionIndex: 2,
        segments: [Segment(text: "体", furigana: "からだ"), Segment(text: "を"), Segment(text: "動", furigana: "うご"), Segment(text: "かす...")],
        kana: 'からだをうごかす...',
        romaji: 'Karada o ugokasu...',
        meaning: '💡 Giải thích: "Undou" nghĩa là vận động, tập thể dục thể thao.',
      ),
      const DialogueLine(
        id: 9,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "はい、"), Segment(text: "週", furigana: "しゅう"), Segment(text: "に"), Segment(text: "3"), Segment(text: "回", furigana: "かい"), Segment(text: "運動", furigana: "うんどう"), Segment(text: "しています。")],
        kana: 'はい、しゅうにさんかいうんどうしています。',
        romaji: 'Hai, shuu ni sankai undou shiteimasu.',
        meaning: 'Vâng, tôi tập 3 lần một tuần.',
      ),
      const DialogueLine(
        id: 10,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "週", furigana: "しゅう"), Segment(text: "に3"), Segment(text: "回", furigana: "かい"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['3 ngày', '3 lần mỗi tuần', '3 giờ mỗi ngày'],
        correctOptionIndex: 1,
        segments: [Segment(text: "頻度", furigana: "ひんど"), Segment(text: "...")],
        kana: 'ひんど...',
        romaji: 'Hindo...',
        meaning: '💡 Giải thích: "Shuu" (Tuần) + "Ni" (Trong) + "3-kai" (3 lần) -> 3 lần trong một tuần.',
      ),
      const DialogueLine(
        id: 11,
        speaker: CharacterName.isora,
        segments: [Segment(text: "野菜", furigana: "やさい"), Segment(text: "をよく"), Segment(text: "食", furigana: "た"), Segment(text: "べますか。")],
        kana: 'やさいをよくたべますか。',
        romaji: 'Yasai o yoku tabemasu ka?',
        meaning: 'Bạn có hay ăn rau không?',
      ),
      const DialogueLine(
        id: 12,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "はい、"), Segment(text: "毎日", furigana: "まいにち"), Segment(text: "食", furigana: "た"), Segment(text: "べます。")],
        kana: 'はい、まいにちたべます。',
        romaji: 'Hai, mainichi tabemasu.',
        meaning: 'Vâng, tôi ăn mỗi ngày.',
      ),
      const DialogueLine(
        id: 13,
        speaker: CharacterName.isora,
        segments: [Segment(text: "これからも"), Segment(text: "健康", furigana: "けんこう"), Segment(text: "に"), Segment(text: "気", furigana: "き"), Segment(text: "をつけますか。")],
        kana: 'これからもけんこうにきをつけますか。',
        romaji: 'Korekara mo kenkou ni ki o tsukemasu ka?',
        meaning: 'Sau này bạn cũng sẽ chú ý đến sức khỏe chứ?',
      ),
      const DialogueLine(
        id: 14,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "健康", furigana: "けんこう"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Bệnh tật (Byouki)', 'Sức khỏe', 'Thể thao (Supootsu)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は...")],
        kana: 'いみは...',
        romaji: 'Imi wa...',
        meaning: '💡 Giải thích: "Kenkou" nghĩa là Sức khỏe.',
      ),
      const DialogueLine(
        id: 15,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "健康", furigana: "けんこう"), Segment(text: "に"), Segment(text: "気", furigana: "き"), Segment(text: "をつける」の「に」は？")
        ],
        quizOptions: ['Chỉ mục tiêu / đối tượng', 'Chỉ nơi chốn', 'Chỉ thời gian'],
        correctOptionIndex: 0,
        segments: [Segment(text: "注意", furigana: "ちゅうい"), Segment(text: "の"), Segment(text: "対象", furigana: "たいしょう"), Segment(text: "...")],
        kana: 'ちゅういのたいしょう...',
        romaji: 'Chuui no taishou...',
        meaning: '💡 Giải thích: Trợ từ "Ni" ở đây chỉ đối tượng mà sự chú ý hướng tới (Chú ý ĐẾN cái gì? -> Đến sức khỏe).',
      ),
      const DialogueLine(
        id: 16,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "はい、"), Segment(text: "気", furigana: "き"), Segment(text: "をつけます。")],
        kana: 'はい、きをつけます。',
        romaji: 'Hai, ki o tsukemasu.',
        meaning: 'Vâng, tôi sẽ chú ý.',
      ),
      const DialogueLine(
        id: 17,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": Bは"), Segment(text: "毎日", furigana: "まいにち"), Segment(text: "どのくらい"), Segment(text: "寝", furigana: "ね"), Segment(text: "ますか。")
        ],
        quizOptions: ['5 tiếng', '6 tiếng', '7 tiếng'],
        correctOptionIndex: 2,
        segments: [Segment(text: "正解", furigana: "せいかい"), Segment(text: "は...")],
        kana: 'せいかいは...',
        romaji: 'Seikai wa...',
        meaning: '💡 Giải thích: Daigo nói "Mainichi 7-jikan nete imasu" (7 tiếng).',
      ),
      const DialogueLine(
        id: 18,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": "), Segment(text: "週", furigana: "しゅう"), Segment(text: "に"), Segment(text: "何回運動", furigana: "なんかいうんどう"), Segment(text: "しますか。")
        ],
        quizOptions: ['1 lần', '2 lần', '3 lần'],
        correctOptionIndex: 2,
        segments: [Segment(text: "回数", furigana: "かいすう"), Segment(text: "は...")],
        kana: 'かいすうは...',
        romaji: 'Kaisuu wa...',
        meaning: '💡 Giải thích: Daigo nói "Shuu ni 3-kai" (3 lần).',
      ),
      const DialogueLine(
        id: 19,
        speaker: CharacterName.isora,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "意味", furigana: "いみ"), Segment(text: ": 「"), Segment(text: "気", furigana: "き"), Segment(text: "をつけます」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Bỏ qua', 'Chú ý / Cẩn thận', 'Quên đi'],
        correctOptionIndex: 1,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は...")],
        kana: 'いみは...',
        romaji: 'Imi wa...',
        meaning: '💡 Giải thích: "Ki o tsukemasu" nghĩa là cẩn thận, chú ý, giữ gìn.',
      ),
      const DialogueLine(
        id: 20,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": Bは"), Segment(text: "野菜", furigana: "やさい"), Segment(text: "を"), Segment(text: "毎日食", furigana: "まいにちた"), Segment(text: "べますか。")
        ],
        quizOptions: ['Có, ăn mỗi ngày', 'Không, không ăn', 'Thỉnh thoảng ăn'],
        correctOptionIndex: 0,
        segments: [Segment(text: "食習慣", furigana: "しょくしゅうかん"), Segment(text: "...")],
        kana: 'しょくしゅうかん...',
        romaji: 'Shokushuukan...',
        meaning: '💡 Giải thích: Daigo xác nhận "Hai, mainichi tabemasu" (Vâng, ăn mỗi ngày).',
      )
    ]
  ),
  // --- HỘI THOẠI 15: TIỀN BẠC (DAIGO & CHIKI) ---
  ConversationLesson(
    id: 'conv_15_money',
    title: '15. Tiền bạc (お金)',
    description: 'Hội thoại về thói quen chi tiêu, tiết kiệm và quản lý tài chính cá nhân.',
    characters: [CharacterName.daigo, CharacterName.chiki],
    prerequisites: ['housework', 'numbers'],
    lines: [
      const DialogueLine(
        id: 1,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "毎月", furigana: "まいつき"), Segment(text: "、"), Segment(text: "お金", furigana: "おかね"), Segment(text: "を"), Segment(text: "使", furigana: "つか"), Segment(text: "いますか。")],
        kana: 'まいつき、おかねをつかいますか。',
        romaji: 'Maitsuki, okane o tsukaimasu ka?',
        meaning: 'Hàng tháng bạn có tiêu tiền không?',
      ),
      const DialogueLine(
        id: 2,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "お金", furigana: "おかね"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Công việc', 'Tiền bạc', 'Mua sắm'],
        correctOptionIndex: 1,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は...")],
        kana: 'いみは...',
        romaji: 'Imi wa...',
        meaning: '💡 Giải thích: "Okane" (hoặc Kane) nghĩa là Tiền bạc.',
      ),
      const DialogueLine(
        id: 3,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "はい、"), Segment(text: "使", furigana: "つか"), Segment(text: "います。")],
        kana: 'はい、つかいます。',
        romaji: 'Hai, tsukaimasu.',
        meaning: 'Vâng, có tiêu.',
      ),
      const DialogueLine(
        id: 4,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "何", furigana: "なに"), Segment(text: "に"), Segment(text: "一番", furigana: "いちばん"), Segment(text: "お金", furigana: "おかね"), Segment(text: "を"), Segment(text: "使", furigana: "つか"), Segment(text: "いますか。")],
        kana: 'なににいちばんおかねをつかいますか。',
        romaji: 'Nani ni ichiban okane o tsukaimasu ka?',
        meaning: 'Bạn tiêu tiền vào việc gì nhiều nhất?',
      ),
      const DialogueLine(
        id: 5,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "お金", furigana: "おかね"), Segment(text: "を"), Segment(text: "使", furigana: "つか"), Segment(text: "う」の「を」は？")
        ],
        quizOptions: ['Chỉ nơi chốn', 'Chỉ đối tượng của hành động', 'Chỉ thời gian'],
        correctOptionIndex: 1,
        segments: [Segment(text: "目的語", furigana: "もくてきご"), Segment(text: "を...")],
        kana: 'もくてきごを...',
        romaji: 'Mokutekigo o...',
        meaning: '💡 Giải thích: Trợ từ "O" chỉ đối tượng chịu tác động (Tiêu cái gì? -> Tiêu tiền).',
      ),
      const DialogueLine(
        id: 6,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "一番", furigana: "いちばん"), Segment(text: "」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Ít nhất', 'Đầu tiên', 'Nhiều nhất / Nhất'],
        correctOptionIndex: 2,
        segments: [Segment(text: "最上級", furigana: "さいじょうきゅう"), Segment(text: "...")],
        kana: 'さいじょうきゅう...',
        romaji: 'Saijoukyuu...',
        meaning: '💡 Giải thích: "Ichiban" dùng để so sánh nhất (Số 1, nhất).',
      ),
      const DialogueLine(
        id: 7,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "食", furigana: "た"), Segment(text: "べ"), Segment(text: "物", furigana: "もの"), Segment(text: "に"), Segment(text: "一番", furigana: "いちばん"), Segment(text: "使", furigana: "つか"), Segment(text: "います。")],
        kana: 'たべものにいちばんつかいます。',
        romaji: 'Tabemono ni ichiban tsukaimasu.',
        meaning: 'Tôi tiêu nhiều nhất vào đồ ăn.',
      ),
      const DialogueLine(
        id: 8,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "お金", furigana: "おかね"), Segment(text: "を"), Segment(text: "貯", furigana: "た"), Segment(text: "めていますか。")],
        kana: 'おかねをためていますか。',
        romaji: 'Okane o tamete imasu ka?',
        meaning: 'Bạn có đang tiết kiệm tiền không?',
      ),
      const DialogueLine(
        id: 9,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "はい、"), Segment(text: "少", furigana: "すこ"), Segment(text: "し"), Segment(text: "貯", furigana: "た"), Segment(text: "めています。")],
        kana: 'はい、すこしためています。',
        romaji: 'Hai, sukoshi tamete imasu.',
        meaning: 'Có, tôi đang tiết kiệm một chút.',
      ),
      const DialogueLine(
        id: 10,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「"), Segment(text: "貯", furigana: "た"), Segment(text: "めています」はどの"), Segment(text: "形", furigana: "かたち"), Segment(text: "？")
        ],
        quizOptions: ['Quá khứ', 'Hiện tại tiếp diễn', 'Mệnh lệnh'],
        correctOptionIndex: 1,
        segments: [Segment(text: "〜ています。")],
        kana: 'て います。',
        romaji: '~Te imasu.',
        meaning: '💡 Giải thích: "Tamete imasu" diễn tả trạng thái hoặc hành động đang diễn ra (Đang tiết kiệm).',
      ),
      const DialogueLine(
        id: 11,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "毎月", furigana: "まいつき"), Segment(text: "、いくら"), Segment(text: "貯", furigana: "た"), Segment(text: "めますか。")],
        kana: 'まいつき、いくらためますか。',
        romaji: 'Maitsuki, ikura tamemasu ka?',
        meaning: 'Hàng tháng bạn tiết kiệm bao nhiêu?',
      ),
      const DialogueLine(
        id: 12,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "50"), Segment(text: "万", furigana: "まん"), Segment(text: "ドンぐらいです。")],
        kana: 'ごじゅうまんドンぐらいです。',
        romaji: 'Gojyuu-man don gurai desu.',
        meaning: 'Khoảng 500.000 VNĐ.',
      ),
      const DialogueLine(
        id: 13,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "文法", furigana: "ぶんぽう"), Segment(text: ": 「50"), Segment(text: "万", furigana: "まん"), Segment(text: "ドンぐらい」の「ぐらい」は？")
        ],
        quizOptions: ['Chính xác', 'Khoảng chừng', 'So sánh'],
        correctOptionIndex: 1,
        segments: [Segment(text: "概算", furigana: "がいさん"), Segment(text: "...")],
        kana: 'がいさん...',
        romaji: 'Gaisan...',
        meaning: '💡 Giải thích: "Gurai" dùng để chỉ số lượng ước chừng (Khoảng...).',
      ),
      const DialogueLine(
        id: 14,
        speaker: CharacterName.daigo,
        segments: [Segment(text: "無駄遣", furigana: "むだづか"), Segment(text: "いをしませんか。")],
        kana: 'むだづかいをしませんか。',
        romaji: 'Mudazukai o shimasen ka?',
        meaning: 'Bạn có tiêu xài lãng phí không?',
      ),
      const DialogueLine(
        id: 15,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "単語", furigana: "たんご"), Segment(text: ": 「"), Segment(text: "無駄遣", furigana: "むだづか"), Segment(text: "い」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Tiêu tiền hợp lý', 'Tiết kiệm (Chokin)', 'Tiêu xài lãng phí'],
        correctOptionIndex: 2,
        segments: [Segment(text: "浪費", furigana: "ろうひ"), Segment(text: "...")],
        kana: 'ろうひ...',
        romaji: 'Rouhi...',
        meaning: '💡 Giải thích: "Mudazukai" nghĩa là sự lãng phí tiền bạc, tiêu xài hoang phí.',
      ),
      const DialogueLine(
        id: 16,
        speaker: CharacterName.chiki,
        segments: [Segment(text: "いいえ、あまりしません。")],
        kana: 'いいえ、あまりしません。',
        romaji: 'Iie, amari shimasen.',
        meaning: 'Không, tôi không hay làm thế.',
      ),
      const DialogueLine(
        id: 17,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": Bは"), Segment(text: "何", furigana: "なに"), Segment(text: "に"), Segment(text: "一番お金", furigana: "いちばんおかね"), Segment(text: "を"), Segment(text: "使", furigana: "つか"), Segment(text: "いますか。")
        ],
        quizOptions: ['Quần áo (Fuku)', 'Đồ ăn (Tabemono)', 'Du lịch (Ryokou)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "正解", furigana: "せいかい"), Segment(text: "は...")],
        kana: 'せいかいは...',
        romaji: 'Seikai wa...',
        meaning: '💡 Giải thích: Chiki nói "Tabemono ni ichiban tsukaimasu".',
      ),
      const DialogueLine(
        id: 18,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": Bは"), Segment(text: "お金", furigana: "おかね"), Segment(text: "を"), Segment(text: "貯", furigana: "た"), Segment(text: "めていますか。")
        ],
        quizOptions: ['Có, đang tiết kiệm', 'Không, không tiết kiệm', 'Không biết'],
        correctOptionIndex: 0,
        segments: [Segment(text: "貯金", furigana: "ちょきん"), Segment(text: "...")],
        kana: 'ちょきん...',
        romaji: 'Chokin...',
        meaning: '💡 Giải thích: Chiki xác nhận "Hai, sukoshi tamete imasu".',
      ),
      const DialogueLine(
        id: 19,
        speaker: CharacterName.daigo,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "意味", furigana: "いみ"), Segment(text: ": 「"), Segment(text: "無駄遣", furigana: "むだづか"), Segment(text: "い」の"), Segment(text: "意味", furigana: "いみ"), Segment(text: "は？")
        ],
        quizOptions: ['Tiết kiệm', 'Tiêu xài lãng phí', 'Kiếm tiền'],
        correctOptionIndex: 1,
        segments: [Segment(text: "意味", furigana: "いみ"), Segment(text: "は...")],
        kana: 'いみは...',
        romaji: 'Imi wa...',
        meaning: '💡 Giải thích: "Mudazukai" là tiêu xài lãng phí.',
      ),
      const DialogueLine(
        id: 20,
        speaker: CharacterName.chiki,
        isQuiz: true,
        quizQuestion: [
          Segment(text: "質問", furigana: "しつもん"), Segment(text: ": Bは"), Segment(text: "毎月", furigana: "まいつき"), Segment(text: "いくら"), Segment(text: "貯", furigana: "た"), Segment(text: "めますか。")
        ],
        quizOptions: ['20 vạn (200k)', '50 vạn (500k)', '100 vạn (1tr)'],
        correctOptionIndex: 1,
        segments: [Segment(text: "金額", furigana: "きんがく"), Segment(text: "は...")],
        kana: 'きんがくは...',
        romaji: 'Kingaku wa...',
        meaning: '💡 Giải thích: Chiki nói "50-man don gurai desu".',
      )
    ]
  )
];
