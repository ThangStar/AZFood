/// Get your own App ID at https://dashboard.agora.io/
String get appId {
  // Allow pass an `appId` as an environment variable with name `TEST_APP_ID` by using --dart-define
  return const String.fromEnvironment('TEST_APP_ID',
      defaultValue: '5afbfb56efc04d56b7bcb475454f1675');
}

/// Please refer to https://docs.agora.io/en/Agora%20Platform/token
String get token {
  // Allow pass a `token` as an environment variable with name `TEST_TOKEN` by using --dart-define
  return const String.fromEnvironment('TEST_TOKEN',
      defaultValue: '0065afbfb56efc04d56b7bcb475454f1675IACmZElIqwiXUiD61ppbmms82LEtLkok+PuTvm1/vi6QTyo6c+T3yPnbIgB4ZnkEpHImZQQAAQA0LyVlAgA0LyVlAwA0LyVlBAA0LyVl');
}

/// Your channel ID
String get channelId {
  // Allow pass a `channelId` as an environment variable with name `TEST_CHANNEL_ID` by using --dart-define
  return const String.fromEnvironment(
    'TEST_CHANNEL_ID',
    defaultValue: 'a',
  );
}

/// Your int user ID
const int uid = 0;

/// Your user ID for the screen sharing
const int screenSharingUid = 10;

/// Your string user ID
const String stringUid = 'a';

String get musicCenterAppId {
  // Allow pass a `token` as an environment variable with name `TEST_TOKEN` by using --dart-define
  return const String.fromEnvironment('MUSIC_CENTER_APPID',
      defaultValue: '<MUSIC_CENTER_APPID>');
}
