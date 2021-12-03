import 'dart:convert';

import 'package:equatable/equatable.dart';

class Source extends Equatable {
  final dynamic id;
  final String? name;

  const Source({this.id, this.name});

  factory Source.fromMap(Map<String, dynamic> data) => Source(
        id: data['id'] as dynamic,
        name: data['name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Source].
  factory Source.fromJson(String data) {
    return Source.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Source] to a JSON string.
  String toJson() => json.encode(toMap());

  Source copyWith({
    dynamic id,
    String? name,
  }) {
    return Source(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
