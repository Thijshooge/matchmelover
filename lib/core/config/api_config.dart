class ApiConfig {
  // Google Places API Key
  // BELANGRIJK: Vervang deze placeholder door je echte API key
  // Haal je API key op via: https://console.cloud.google.com/
  // Zorg ervoor dat je de Places API hebt geactiveerd
  static const String googlePlacesApiKey =
      'AIzaSyAainGYDyswAPX4TqgbhgyDv51ANbyNfcE';

  // INSTRUCTIES:
  // 1. Ga naar https://console.cloud.google.com/
  // 2. Activeer de Places API
  // 3. Maak een API Key aan
  // 4. Vervang 'YOUR_GOOGLE_PLACES_API_KEY_HERE' door je echte key

  // Base URLs
  static const String googlePlacesBaseUrl =
      'https://maps.googleapis.com/maps/api/place';

  // Check of de API key is ingesteld
  static bool get isApiKeyConfigured =>
      googlePlacesApiKey != 'YOUR_GOOGLE_PLACES_API_KEY_HERE' &&
      googlePlacesApiKey.isNotEmpty;
}
