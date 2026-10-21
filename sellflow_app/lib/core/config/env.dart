class Env {
  // TSG API Configuration
  // For local development: http://localhost:8000/api/v1
  // For production: https://your-tsg-domain.com/api/v1
  static const String apiUrl = const String.fromEnvironment('TSG_API_URL',
      defaultValue: 'http://localhost:8000/api/v1');
  
  // For backend URL (base domain) - via nginx proxy
  static const String baseUrl = 'http://localhost/api/v1';
  
  static const String appTitle = 'SellFlow TSG';
}
