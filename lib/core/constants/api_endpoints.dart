class ApiEndpoints {
  String searchUserEndpoint({required String userName}) =>
      "/search/users?q=$userName";
  String inviteMemberToWorkspaceEndpoint({required String orgName}) =>
      "/orgs/$orgName/invitations";

  String getOrganizationRepositoriesEndpoint({required String orgName}) =>
      "/orgs/$orgName/repos";

  String checkOrgMembershipStatusEndpoint({
    required String orgName,
    required String username,
  }) => "/orgs/$orgName/members/$username";

  String sendOrgInvitationEndpoint({required String orgName}) =>
      '/orgs/$orgName/invitations';

  String giveRepositoryAccessEndpoint({
    required String ownerName,
    required String username,
    required String repoName,
  }) {
    // repositoryName may be a GitHub full name like "owner/repo";
    // the endpoint needs the bare repo name with the owner supplied separately.
    final bareRepoName = repoName.split('/').last;
    return '/repos/$ownerName/$bareRepoName/collaborators/$username';
  }

  String getRepoCollaboratorsEndpoint({
    required String ownerNameWithRepoName,
  }) => '/repos/$ownerNameWithRepoName/collaborators';

  String invokeRepoAccessEndpoint({
    required String ownerNameWithRepoName,
    required String username,
  }) => '/repos/$ownerNameWithRepoName/collaborators/$username';

  String createTeamEndpoint({required String orgName})=> '/orgs/$orgName/teams';

  String updateTeamEndpoint({required String orgName, required String teamSlug}) => '/orgs/$orgName/teams/$teamSlug';

  String deleteATeamEndpoint({required String orgName, required String teamSlug})=>'/orgs/$orgName/teams/$teamSlug';

  String getAllTeamsInOrgEndpoint({required String orgName}) => '/orgs/$orgName/teams';

  String getASpecificTeamEndpoint({required String orgName, required String teamSlug}) => '/orgs/$orgName/teams/$teamSlug';
}
