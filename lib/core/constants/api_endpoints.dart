class ApiEndpoints {
  String searchUserEndpoint({required String userName}) =>
      "/search/users?q=$userName";
  String inviteMemberToWorkspaceEndpoint({required String orgName}) =>
      "/orgs/$orgName/invitations";

  String getOrganizationRepositoriesEndpoint({required String orgName}) =>
      "/orgs/$orgName/repos";
}
