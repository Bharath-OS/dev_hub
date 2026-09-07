enum OrgRoles {
  admin('admin'),
  member('direct_member'),
  billingManager('billing_manager'),
  reinstate('reinstate');

  final String apiValue;

  const OrgRoles(this.apiValue);

  bool get isAdmin => this == OrgRoles.admin;

  bool get isMember => this == OrgRoles.member;

  bool get isBillingManager => this == OrgRoles.billingManager;
}