import 'package:dev_hub/features/auth/domain/entities/user_entity.dart';
import 'package:dev_hub/features/auth/presentation/pages/choose_org_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ChooseOrgScreen renders without overflow', (
    WidgetTester tester,
  ) async {
    // Set a typical mobile screen size to reproduce layout overflow on small screens
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final mockUser = UserEntity(
      id: '1',
      githubId: 12345,
      githubUsername: 'test_user',
      displayName: 'Test User',
      avatarUrl: 'https://example.com/avatar.png',
      email: 'test@example.com',
      ownOrganizations: [
        GitHubOrgInfo(
          id: '101',
          login: 'codecrew306',
          avatarUrl: 'https://example.com/avatar101.png',
          role: 'admin',
          state: 'active',
        ),
      ],
      subscription: SubscriptionInfo(plan: 'free', status: 'active'),
      createdAt: DateTime.now(),
      lastSeen: DateTime.now(),
    );

    await tester.pumpWidget(MaterialApp(home: ChooseOrgScreen(user: mockUser)));

    // Let the screen build and settle
    await tester.pumpAndSettle();

    // Verify no exceptions or overflows were thrown during build
    expect(find.byType(ChooseOrgScreen), findsOneWidget);
  });
}
