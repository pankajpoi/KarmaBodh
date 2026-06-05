
class Mantra{
  final String id;
  final String sanskrit;
  final String translation;
  final String? audio;

  final List<dynamic> usage;
  Mantra({
    required this.id,
    required this.sanskrit,
    required this.translation,
    required this.usage,
    this.audio
});
}