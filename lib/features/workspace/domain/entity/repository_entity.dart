import 'package:dev_hub/features/auth/domain/entities/user_entity.dart';

class RepositoryEntity {
  final int id;
  final String name;
  final String fullName;
  final UserEntity owner; // already defined elsewhere
  final bool isPrivate;
  final String htmlUrl;
  final String? description;
  final bool fork;
  final String apiUrl;
  final int forksCount;
  final int openIssuesCount;
  final String visibility;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime pushedAt;
  final Map<String, bool> permissions;

  const RepositoryEntity({
    required this.id,
    required this.name,
    required this.fullName,
    required this.owner,
    required this.isPrivate,
    required this.htmlUrl,
    this.description,
    required this.fork,
    required this.apiUrl,
    required this.forksCount,
    required this.openIssuesCount,
    required this.visibility,
    required this.createdAt,
    required this.updatedAt,
    required this.pushedAt,
    required this.permissions,
  });

  // Domain logic: copyWith is allowed in entities
  RepositoryEntity copyWith({
    int? id,
    String? name,
    String? fullName,
    UserEntity? owner,
    bool? isPrivate,
    String? htmlUrl,
    String? description,
    bool? fork,
    String? apiUrl,
    int? forksCount,
    int? openIssuesCount,
    String? visibility,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? pushedAt,
    Map<String, bool>? permissions,
  }) {
    return RepositoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      fullName: fullName ?? this.fullName,
      owner: owner ?? this.owner,
      isPrivate: isPrivate ?? this.isPrivate,
      htmlUrl: htmlUrl ?? this.htmlUrl,
      description: description ?? this.description,
      fork: fork ?? this.fork,
      apiUrl: apiUrl ?? this.apiUrl,
      forksCount: forksCount ?? this.forksCount,
      openIssuesCount: openIssuesCount ?? this.openIssuesCount,
      visibility: visibility ?? this.visibility,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      pushedAt: pushedAt ?? this.pushedAt,
      permissions: permissions ?? this.permissions,
    );
  }
}
