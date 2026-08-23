import 'package:dev_hub/core/constants/api_endpoints.dart';
import 'package:dev_hub/features/workspace/data/Datasource/github_workspace_datasource.dart';
import 'package:dev_hub/shared/data/datasources/remote/api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';

// Create a Mock class
class MockApiClient extends Mock implements ApiClientInterface {}

void main() {
  late GithubWorkspaceDataSourceImpl datasource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    datasource = GithubWorkspaceDataSourceImpl(
      apiClient: mockApiClient,
      apiEndpoints: ApiEndpoints(),
    );
  });

  test('searchMember should return list of users on success', () async {
    // Arrange: Define what the mock should return
    final mockResponse = {
      'items': [
        {
          'id': 123,
          'login': 'bharathos',
          // ... add other required user fields
        }
      ]
    };

    when(() => mockApiClient.get(any()))
        .thenAnswer((_) async => Right(mockResponse));

    // Act
    final result = await datasource.searchMember(
      username: 'bharathos',
      accessToken: 'dummy_token',
    );

    // Assert
    expect(result, isA<List>());
    expect(result.first.githubUsername, 'bharathos');

    // Verify the API was actually called once
    verify(() => mockApiClient.get(any())).called(1);
  });
}