import '../../../auth/data/models/user_model.dart';
import '../../domain/entity/repository_entity.dart';

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
      id: map['id'],
      name: map['name'],
      fullName: map['full_name'],
      owner: UserModel.fromMap(map['owner']),
      isPrivate: map['private'],
      htmlUrl: map['html_url'],
      description: map['description'],
      fork: map['fork'],
      apiUrl: map['url'],
      forksCount: map['forks_count'],
      openIssuesCount: map['open_issues_count'],
      visibility: map['visibility'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      pushedAt: DateTime.parse(map['pushed_at']),
      permissions: {
        'admin': map['permissions']['admin'],
        'push': map['permissions']['push'],
        'pull': map['permissions']['pull'],
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
