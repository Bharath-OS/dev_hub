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
  }) => '/repos/$ownerName/$repoName/collaborators/$username';
}
