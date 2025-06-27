# MatchMe - Achtergrond Componenten

## Structuur

### main.dart
- Bevat alleen Firebase initialisatie
- Roept MyApp() aan vanuit app.dart

### app.dart
- Bevat de hoofdapp configuratie
- Definieert theme en routing

### Achtergrond Widgets

Er zijn 3 verschillende achtergrond widgets en een logo widget beschikbaar in `lib/widgets/app_background.dart`:

#### 1. AppBackground (Gradient)
```dart
AppBackground(
  child: YourContent(),
  gradientColors: [Colors.black, Colors.red, Colors.white], // Optioneel
  begin: Alignment.topLeft, // Optioneel
  end: Alignment.bottomRight, // Optioneel
)
```

#### 2. AppBackgroundWithHearts (Met hartjes patroon)
```dart
AppBackgroundWithHearts(
  child: YourContent(),
  backgroundColor: Colors.grey[100], // Optioneel
)
```

#### 3. AppBackgroundSolid (Effen kleur)
```dart
AppBackgroundSolid(
  child: YourContent(),
  backgroundColor: Colors.grey[50], // Optioneel
)
```

#### 4. AppLogo (Logo widget)
```dart
AppLogo(
  size: 100, // Optioneel, standaard 60
  color: Colors.white, // Optioneel, standaard zwart
  showText: true, // Optioneel, standaard true
)
```

## Gebruik in nieuwe schermen

### Stap 1: Import
```dart
import '../widgets/app_background.dart';
```

### Stap 2: Wrap je content
```dart
class MijnNieuwScherm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Jouw content hier
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

## Kleuren Schema

De standaard kleuren zijn:
- Primair: Rood (#CC0000)
- Secundair: Zwart (#000000)
- Accent: Wit (#FFFFFF)
- Gradient: Van zwart naar rood naar wit

## Aanpassen

Om de achtergrondkleuren aan te passen, pas de default waarden aan in `app_background.dart`:

```dart
colors: gradientColors ?? [
  const Color(0xFF000000), // Zwart
  const Color(0xFFCC0000), // Rood
  const Color(0xFFFFFFFF), // Wit
],
```