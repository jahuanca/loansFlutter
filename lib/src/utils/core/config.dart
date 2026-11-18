
const String serverUrl = String.fromEnvironment(
  'API_URL',
  defaultValue: 'http://10.0.2.2:3001',
);

const String socketUrl = String.fromEnvironment(
  'SOCKET_URL',
  defaultValue: 'http://10.0.2.2:3002',
);

const String appEnvironment = String.fromEnvironment(
  'APP_ENV',
  defaultValue: 'emulator',
);
