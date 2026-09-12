import 'package:dev_hub/features/membership/presentation/member%20invitation/pages/invite_member_sheet.dart';
import 'package:dev_hub/features/workspace/domain/entity/workspace_entity.dart';
import 'package:dev_hub/shared/presentation/widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../bloc/workspace_bloc.dart';

class WorkspaceDetailScreen extends StatefulWidget {
  final String workspaceId;
  const WorkspaceDetailScreen({super.key, required this.workspaceId});

  @override
  State<WorkspaceDetailScreen> createState() => _WorkspaceDetailScreenState();
}

class _WorkspaceDetailScreenState extends State<WorkspaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final state = context.read<WorkspaceBloc>().state as WorkspaceDisplayState;
    final WorkspaceEntity workspace = state.workspaces.firstWhere(
      (workspace) => workspace.id == widget.workspaceId,
    );
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _WorkspaceDetailAppBar(title: workspace.name),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Repository URL row
            _RepoUrlRow(url: workspace.repositoryName),
            SizedBox(height: AppSpacing.lg),

            // Overview card
            _OverviewCard(
              progress: 0.65,
              teamCount: 12,
              taskCount: 45,
              openPRCount: 12,
              developerCount: 8,
              milestoneName: 'MVP Release',
              milestoneDue: 'Aug 15, 2026',
            ),
            SizedBox(height: AppSpacing.lg),

            // Teams section (grid layout)
            _SectionHeader(title: 'Teams', actionLabel: 'View All'),
            SizedBox(height: AppSpacing.sm),
            _TeamsGrid(
              teams: [
                _TeamData(
                  acronym: 'FE',
                  name: 'Frontend',
                  memberCount: 8,
                  completedTasks: 16,
                  totalTasks: 20,
                  color: Color(0xFF3525CD),
                ),
                _TeamData(
                  acronym: 'BE',
                  name: 'Backend',
                  memberCount: 8,
                  completedTasks: 6,
                  totalTasks: 15,
                  color: Color(0xFF892200),
                ),
                _TeamData(
                  acronym: 'DS',
                  name: 'Design',
                  memberCount: 4,
                  completedTasks: 9,
                  totalTasks: 12,
                  color: Color(0xFF10B981),
                ),
                _TeamData(
                  acronym: 'QA',
                  name: 'QA',
                  memberCount: 3,
                  completedTasks: 5,
                  totalTasks: 8,
                  color: Color(0xFFF59E0B),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.lg),

            // Quick Actions section
            _SectionHeader(title: 'Quick Actions'),
            SizedBox(height: AppSpacing.sm),
            _QuickActionsGrid(workspace),
            SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Page-level AppBar
// ---------------------------------------------------------------------------

class _WorkspaceDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  const _WorkspaceDetailAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        title,
        style: AppTextStyles.title.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.headingTextColor,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: AppColors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// ---------------------------------------------------------------------------
// Repository URL Row
// ---------------------------------------------------------------------------

class _RepoUrlRow extends StatelessWidget {
  final String url;
  const _RepoUrlRow({required this.url});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.link, size: 16, color: AppColors.mutedTextColor),
        const SizedBox(width: 6),
        Text(
          url,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.surfaceTint,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section Header
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;

  const _SectionHeader({required this.title, this.actionLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.title.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.headingTextColor,
          ),
        ),
        if (actionLabel != null)
          GestureDetector(
            onTap: () {},
            child: Text(
              actionLabel!,
              style: AppTextStyles.caption.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.surfaceTint,
              ),
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Overview Card
// ---------------------------------------------------------------------------

class _OverviewCard extends StatelessWidget {
  final double progress;
  final int teamCount;
  final int taskCount;
  final int openPRCount;
  final int developerCount;
  final String milestoneName;
  final String milestoneDue;

  const _OverviewCard({
    required this.progress,
    required this.teamCount,
    required this.taskCount,
    required this.openPRCount,
    required this.developerCount,
    required this.milestoneName,
    required this.milestoneDue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.primaryBorderRadius,
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8), // 0.03 * 255 approx 8
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingCard),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: AppTextStyles.title.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.headingTextColor,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Overall progress row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Overall Progress',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mutedTextColor,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.surfaceTint,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 7,
              backgroundColor: AppColors.outlineVariant,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.surfaceTint,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatItem(value: '$teamCount', label: 'TEAMS'),
              _StatItem(value: '$taskCount', label: 'TASKS'),
              _StatItem(value: '$openPRCount', label: 'OPEN PRS'),
              _StatItem(value: '$developerCount', label: 'DEVELOPERS'),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: AppSpacing.md),

          // Active Milestone
          Text(
            'ACTIVE MILESTONE',
            style: AppTextStyles.overline.copyWith(
              color: AppColors.mutedTextColor,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(
                Icons.flag_outlined,
                size: 16,
                color: AppColors.surfaceTint,
              ),
              const SizedBox(width: 6),
              Text(
                milestoneName,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.headingTextColor,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              Text(
                'Due: $milestoneDue',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.mutedTextColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stat Item — used inside Overview card
// ---------------------------------------------------------------------------

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: AppTextStyles.title.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.headingTextColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTextStyles.overline.copyWith(
            color: AppColors.mutedTextColor,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Team Data model
// ---------------------------------------------------------------------------

class _TeamData {
  final String acronym;
  final String name;
  final int memberCount;
  final int completedTasks;
  final int totalTasks;
  final Color color;

  const _TeamData({
    required this.acronym,
    required this.name,
    required this.memberCount,
    required this.completedTasks,
    required this.totalTasks,
    required this.color,
  });
}

// ---------------------------------------------------------------------------
// Teams Grid
// ---------------------------------------------------------------------------

class _TeamsGrid extends StatelessWidget {
  final List<_TeamData> teams;

  const _TeamsGrid({required this.teams});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: teams.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 1.4,
      ),
      itemBuilder: (context, index) => _TeamCard(team: teams[index]),
    );
  }
}

// ---------------------------------------------------------------------------
// Team Card — tile in the teams grid
// ---------------------------------------------------------------------------

class _TeamCard extends StatelessWidget {
  final _TeamData team;

  const _TeamCard({required this.team});

  @override
  Widget build(BuildContext context) {
    final taskProgress = team.totalTasks > 0
        ? team.completedTasks / team.totalTasks
        : 0.0;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.mdBorderRadius,
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5), // 0.02 * 255 approx 5
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.sm + 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Team avatar
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: team.color,
                  borderRadius: AppRadius.smBorderRadius,
                ),
                alignment: Alignment.center,
                child: Text(
                  team.acronym,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      team.name,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.headingTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${team.memberCount} Members',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 11,
                        color: AppColors.mutedTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tasks label
              Text(
                '${team.completedTasks}/${team.totalTasks} Tasks',
                style: AppTextStyles.caption.copyWith(
                  fontSize: 11,
                  color: AppColors.mutedTextColor,
                ),
              ),
              const SizedBox(height: 4),
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: taskProgress,
                  minHeight: 5,
                  backgroundColor: AppColors.outlineVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(team.color),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Quick Actions Grid
// ---------------------------------------------------------------------------

class _QuickActionsGrid extends StatelessWidget {
  final WorkspaceEntity workspace;
  const _QuickActionsGrid(this.workspace);

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickActionData(
        icon: Icons.group_add_outlined,
        label: 'Create Team',
        onTap: () {},
      ),
      _QuickActionData(
        icon: Icons.person_add_outlined,
        label: 'Invite Member',
        onTap: () {
          CustomBottomSheet.show(context: context, child: InviteMemberSheet(workspace: workspace,));
        },
      ),
      _QuickActionData(
        icon: Icons.add_task_outlined,
        label: 'Create Task',
        onTap: () {},
      ),
      _QuickActionData(
        icon: Icons.settings_outlined,
        label: 'Workspace Settings',
        onTap: () {},
      ),
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: actions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 2.2,
      ),
      itemBuilder: (context, index) => _QuickActionTile(data: actions[index]),
    );
  }
}

// ---------------------------------------------------------------------------
// Quick Action Data model
// ---------------------------------------------------------------------------

class _QuickActionData {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionData({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

// ---------------------------------------------------------------------------
// Quick Action Tile
// ---------------------------------------------------------------------------

class _QuickActionTile extends StatelessWidget {
  final _QuickActionData data;

  const _QuickActionTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: data.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: AppRadius.mdBorderRadius,
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(5),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primaryFixed,
                borderRadius: AppRadius.smBorderRadius,
              ),
              alignment: Alignment.center,
              child: Icon(data.icon, size: 18, color: AppColors.surfaceTint),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                data.label,
                style: AppTextStyles.caption.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.headingTextColor,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
