// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  String id;
  final String email;
  final String username;

  User({required this.id, required this.email, required this.username});

  @override
  List<Object?> get props => [id, email, username];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
