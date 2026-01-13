part of 'deck_bloc.dart';

/// Base state for deck operations
abstract class DeckState extends Equatable {
  const DeckState();

  @override
  List<Object> get props => [];
}

/// Initial state
class DeckInitial extends DeckState {}

/// Loading decks
class DeckLoading extends DeckState {}

/// Decks loaded successfully
class DeckLoaded extends DeckState {
  final List<Deck> decks;

  const DeckLoaded(this.decks);

  @override
  List<Object> get props => [decks];
}

/// Creating a new deck
class DeckCreating extends DeckState {}

/// Deck created successfully
class DeckCreated extends DeckState {
  final Deck deck;

  const DeckCreated(this.deck);

  @override
  List<Object> get props => [deck];
}

/// Error state
class DeckError extends DeckState {
  final String message;

  const DeckError(this.message);

  @override
  List<Object> get props => [message];
}
