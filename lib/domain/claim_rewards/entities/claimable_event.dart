class ClaimableEvent {
  final String title;
  final String description;
  final DateTime validUntil;
  final int steps;

  ClaimableEvent({
    required this.title,
    required this.description,
    required this.validUntil,
    required this.steps,
  });
}
