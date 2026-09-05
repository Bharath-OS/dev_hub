
import '../../../features/auth/domain/entities/user_entity.dart';

class GitHubOrgInfoModel extends GitHubOrgInfo{
  GitHubOrgInfoModel({required super.id, required super.login, required super.avatarUrl, super.role , super.state});

  factory GitHubOrgInfoModel.fromMap(Map<String, dynamic> org) {
    return GitHubOrgInfoModel(
      id: org['id'],
      login: org['login'],
      avatarUrl: org['avatar_url'],
    );
  }

  GitHubOrgInfoModel copyWith({
    String? id,
    String? login,
    String? avatarUrl,
    String? role,
    String? state,
  }) {
    return GitHubOrgInfoModel(
      id: id ?? super.id,
      login: login ?? super.login,
      avatarUrl: avatarUrl ?? super.avatarUrl,
      role: role ?? super.role,
      state: state ?? super.state,
    );
  }
}