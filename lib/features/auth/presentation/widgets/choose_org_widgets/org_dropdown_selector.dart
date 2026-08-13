import 'package:flutter/material.dart';
import 'package:dev_hub/core/constants/app_colors.dart';
import 'package:dev_hub/core/constants/app_constants.dart';
import 'package:dev_hub/core/constants/app_text_styles.dart';
import '../../../domain/entities/user_entity.dart';

class OrgDropdownSelector extends StatelessWidget {
  final List<GitHubOrgInfo> organizations;
  final GitHubOrgInfo? selectedOrg;
  final ValueChanged<GitHubOrgInfo?> onChanged;

  const OrgDropdownSelector({
    super.key,
    required this.organizations,
    required this.selectedOrg,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<GitHubOrgInfo>(
      initialValue: selectedOrg,
      onChanged: onChanged,
      isExpanded: true,
      isDense: false,
      itemHeight: 80, // This height will now be respected because isDense is false
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppPalette.outline,
        size: 24,
      ),
      dropdownColor: AppPalette.surfaceContainerLowest,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        filled: true,
        fillColor: AppPalette.surfaceContainerLowest,
        hintText: 'Select an organization',
        hintStyle: AppTextStyles.body.copyWith(color: AppPalette.outline),
        border: OutlineInputBorder(
          borderRadius: AppRadius.mdBorderRadius,
          borderSide: const BorderSide(color: AppPalette.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdBorderRadius,
          borderSide: const BorderSide(color: AppPalette.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdBorderRadius,
          borderSide: const BorderSide(color: AppPalette.primary, width: 1.5),
        ),
      ),
      selectedItemBuilder: (BuildContext context) {
        return organizations.map<Widget>((GitHubOrgInfo org) {
          return SizedBox(
            height: 100,
            // alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Avatar
                Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppPalette.border, width: 1),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      org.avatarUrl,
                      width: 36,
                      height: 36,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.business_rounded,
                        size: 20,
                        color: AppPalette.outline,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                
                // Name & Description (Role & Status)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        org.login,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppPalette.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Role: ${org.role ?? 'Member'} â€¢ Status: ${org.state ?? 'active'}',
                        style: AppTextStyles.caption.copyWith(
                          color: AppPalette.onSurfaceVariant,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                
                // Badge (e.g. ADMIN)
                if (org.role != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs / 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppPalette.surfaceContainerLow,
                      borderRadius: AppRadius.smBorderRadius,
                    ),
                    child: Text(
                      org.role!.toUpperCase(),
                      style: AppTextStyles.overline.copyWith(
                        color: AppPalette.primaryContainer,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        }).toList();
      },
      items: organizations.map<DropdownMenuItem<GitHubOrgInfo>>((GitHubOrgInfo org) {
        return DropdownMenuItem<GitHubOrgInfo>(
          value: org,
          child: Container(
            height: 150,
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppPalette.border, width: 1),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      org.avatarUrl,
                      width: 36,
                      height: 36,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.business_rounded,
                        size: 20,
                        color: AppPalette.outline,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                
                // Name & details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        org.login,
                        style: AppTextStyles.body.copyWith(
                          color: AppPalette.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Role: ${org.role ?? 'Member'} â€¢ Status: ${org.state ?? 'active'}',
                        style: AppTextStyles.caption.copyWith(
                          color: AppPalette.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Role Badge
                if (org.role != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs / 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppPalette.surfaceContainerLow,
                      borderRadius: AppRadius.smBorderRadius,
                    ),
                    child: Text(
                      org.role!.toUpperCase(),
                      style: AppTextStyles.overline.copyWith(
                        color: AppPalette.primaryContainer,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
