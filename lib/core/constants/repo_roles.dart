
enum RepoRoles {
  workspaceAdmin('admin'),
  developer('write'),
  teamLead('maintainer');

  final String apiValue;

  const RepoRoles(this.apiValue);

  bool get isWorkspaceAdmin => this == RepoRoles.workspaceAdmin;

  bool get isDeveloper => this == RepoRoles.developer;

  bool get isTeamLead => this == RepoRoles.teamLead;
}
