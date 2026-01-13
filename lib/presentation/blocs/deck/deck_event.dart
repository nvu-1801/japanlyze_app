part of 'deck_bloc.dart';

/// Base event for deck operations
abstract class DeckEvent extends Equatable {
  const DeckEvent();

  @override
  List<Object?> get props => [];
}

/// Load all decks for the current user
class LoadDecksEvent extends DeckEvent {}

/// Create a new deck
class CreateDeckEvent extends DeckEvent {
  final String title;
  final String? description;

  const CreateDeckEvent({required this.title, this.description});

  @override
  List<Object?> get props => [title, description];
}

/// Delete a deck
class DeleteDeckEvent extends DeckEvent {
  final int deckId;

  const DeleteDeckEvent(this.deckId);

  @override
  List<Object> get props => [deckId];
}

/// Refresh decks (pull to refresh)
class RefreshDecksEvent extends DeckEvent {}
