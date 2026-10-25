/// A bookable service as the server stores it.
class ServiceRecord {
  const ServiceRecord({
    required this.id,
    required this.name,
    required this.description,
    required this.priceCents,
    required this.durationMinutes,
  });

  final String id;
  final String name;
  final String description;
  final int priceCents;
  final int durationMinutes;

  /// The GraphQL shape, with __typename so the client cache can normalise it.
  Map<String, Object?> toResponse() => <String, Object?>{
    '__typename': 'Service',
    'id': id,
    'name': name,
    'description': description,
    'priceCents': priceCents,
    'durationMinutes': durationMinutes,
  };
}
