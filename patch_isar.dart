import 'dart:io';

void main() async {
  final Map<String, Map<String, String>> replacements = {
    'lib/domain/entities/flashcard_models.g.dart': {
      '-9191743303447364249': '-9191743303447364608',
      '-8501089313549364976': '-8501089313549365248',
      '-312090079606683354': '-312090079606683328',
      '4152658090540413903': '4152658090540413952',
      '2663524640301590320': '2663524640301590528',
      '-1182505463565197889': '-1182505463565197824',
      '2752025977959805259': '2752025977959805440',
    },
    'lib/domain/entities/test_result.g.dart': {
      '-8094768535068101560': '-8094768535068101632',
    },
    'lib/domain/entities/app_notification.g.dart': {
      '7576332975032865864': '7576332975032865792',
      '-7636685945352118059': '-7636685945352118272',
      '5117122708147080838': '5117122708147081216',
      '1852253767416892198': '1852253767416892160',
      '-944277114070112791': '-944277114070112768',
    },
    'lib/domain/entities/user.g.dart': {
      '-7838171048429979076': '-7838171048429978624',
    },
    'lib/domain/entities/user_progress.g.dart': {
      '518958300452706037': '518958300452706048',
    },
    'lib/domain/entities/translation_history.g.dart': {
      '-1670349568942576793': '-1670349568942576896',
    },
    'lib/domain/entities/exercise_progress.g.dart': {
      '31330896869534267': '31330896869534268',
    },
  };

  for (final entry in replacements.entries) {
    final file = File(entry.key);
    if (!await file.exists()) continue;
    String content = await file.readAsString();
    for (final replace in entry.value.entries) {
      content = content.replaceAll(replace.key, replace.value);
    }
    await file.writeAsString(content);
    print('Patched \${entry.key}');
  }
}
