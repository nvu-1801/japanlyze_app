import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/deck.dart';
import '../../../domain/usecases/flashcard/get_decks_usecase.dart';
import '../../../domain/usecases/flashcard/create_deck_usecase.dart';

part 'deck_event.dart';
part 'deck_state.dart';

/// BLoC for managing flashcard decks
class DeckBloc extends Bloc<DeckEvent, DeckState> {
  final GetDecksUseCase _getDecksUseCase;
  final CreateDeckUseCase _createDeckUseCase;

  DeckBloc({
    required GetDecksUseCase getDecksUseCase,
    required CreateDeckUseCase createDeckUseCase,
  }) : _getDecksUseCase = getDecksUseCase,
       _createDeckUseCase = createDeckUseCase,
       super(DeckInitial()) {
    on<LoadDecksEvent>(_onLoadDecks);
    on<CreateDeckEvent>(_onCreateDeck);
    on<RefreshDecksEvent>(_onRefreshDecks);
  }

  Future<void> _onLoadDecks(
    LoadDecksEvent event,
    Emitter<DeckState> emit,
  ) async {
    emit(DeckLoading());

    final result = await _getDecksUseCase(const NoParams());

    result.fold(
      (failure) => emit(DeckError(failure.message)),
      (decks) => emit(DeckLoaded(decks)),
    );
  }

  Future<void> _onCreateDeck(
    CreateDeckEvent event,
    Emitter<DeckState> emit,
  ) async {
    emit(DeckCreating());

    final result = await _createDeckUseCase(
      CreateDeckParams(
        title: event.title.trim(),
        description: event.description?.trim(),
      ),
    );

    result.fold((failure) => emit(DeckError(failure.message)), (deck) {
      emit(DeckCreated(deck));
      add(LoadDecksEvent()); // Refresh the list
    });
  }

  Future<void> _onRefreshDecks(
    RefreshDecksEvent event,
    Emitter<DeckState> emit,
  ) async {
    final result = await _getDecksUseCase(const NoParams());

    result.fold(
      (failure) => emit(DeckError(failure.message)),
      (decks) => emit(DeckLoaded(decks)),
    );
  }
}
