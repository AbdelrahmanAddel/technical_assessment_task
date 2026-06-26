import 'package:flutter_techincal_test/features/auth/domain/entities/user.dart';

const tUser = User(
  userId: 'user-1',
  email: 'john@example.com',
  fullName: 'John Doe',
  profilePicture: 'https://example.com/avatar.png',
);

const tCachedUser = User(
  userId: 'user-1',
  email: 'john@example.com',
  fullName: 'Cached John',
  profilePicture: 'https://example.com/cached.png',
);

const tFailureMessage = 'Something went wrong';
