import '../../../auth/data/models/user_model.dart';
import '../../domain/entity/github_repository_entity.dart';

class RepositoryModel extends GitHubRepositoryEntity {
  RepositoryModel({
    required super.id,
    required super.name,
    required super.fullName,
    required UserModel super.owner,
    required super.isPrivate,
    required super.htmlUrl,
    super.description,
    required super.fork,
    required super.apiUrl,
    required super.forksCount,
    required super.openIssuesCount,
    required super.visibility,
    required super.createdAt,
    required super.updatedAt,
    required super.pushedAt,
    required super.permissions,
  });

  factory RepositoryModel.fromMap(Map<String, dynamic> map) {
    return RepositoryModel(
      id: map['id'] as int,
      name: map['name'] as String,
      fullName: map['full_name'] as String,
      owner: UserModel.fromMap(map['owner'] as Map<String, dynamic>),
      isPrivate: map['private'] as bool,
      htmlUrl: map['html_url'] as String,
      description: map['description'] as String?,
      fork: map['fork'] as bool,
      apiUrl: map['url'] as String,
      forksCount: map['forks_count'] as int,
      openIssuesCount: map['open_issues_count'] as int,
      visibility: map['visibility'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      pushedAt: DateTime.parse(map['pushed_at'] as String),
      permissions: {
        'admin': map['permissions']?['admin'] ?? false,
        'push': map['permissions']?['push'] ?? false,
        'pull': map['permissions']?['pull'] ?? false,
      },
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'full_name': fullName,
      'owner': (owner as UserModel).toMap(),
      'private': isPrivate,
      'html_url': htmlUrl,
      'description': description,
      'fork': fork,
      'url': apiUrl,
      'forks_count': forksCount,
      'open_issues_count': openIssuesCount,
      'visibility': visibility,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'pushed_at': pushedAt.toIso8601String(),
      'permissions': permissions,
    };
  }
}
