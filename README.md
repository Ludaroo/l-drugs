# Advanced Drug Status System

An advanced system for managing drug and alcohol statuses in FiveM RP servers.

## Main Features

- **Predefined Drugs**: Includes common drugs with effects similar to those in Rockstar games.
- **Configurable Drugs and Effects**: Allows adding new drugs and their effects via an in-game admin tablet.
- **Health Impact**: Reduces player health based on the consumed drug.
- **Status Tracking**: Maintains a "quantity" status from 0 to 100 (0 = sober, 100 = heavily intoxicated).
- **Effect Levels**: Different stages of effects; some drugs cause severe impairment at 100%.
- **Test Items**: Use items like blood tests or breathalyzers to check the current status.
- **Antidote**: An item for medics that immediately nullifies all effects.
- **Custom Effects**: Ability to create and add custom effects (e.g., displaying a kaleidoscope-style PNG when using LSD).
- **Notifications**: Alerts about the player's current condition.
- **Integration with Medical Systems**: Records drug or alcohol consumption as a cause of death in systems like esx_ambulance or wasabi_ambulance.
- **Alcohol Management**: Implements drunkenness levels and corresponding effects.

## Optional Features

- **Drug Tolerance**: With frequent use, players require more to feel the effects, with a maximum tolerance of 50 to prevent immediate overdosing.
- **Combination Effects**: Combining drugs results in unique effects (e.g., if Drug 1 and Drug 2 are both above a value of 15, their individual effects are replaced with a new combined effect).

## Dependencies

- **ESX Framework**: Required for server integration.
- **ox_lib**: For advanced functions and callback management.
- **oxmysql**: For database management.

## Installation

1. **Download**: Obtain the script from [GitHub](https://github.com/YourGitHubRepo).
2. **Install Dependencies**: Ensure all required dependencies are installed.
3. **Configuration**: Customize the `config.lua` to define drugs, effects, and other settings.
4. **Database**: Execute the provided SQL file to create necessary tables.
5. **Start**: Add the script to your `server.cfg` and restart the server.

## Customization

- **Adding New Drugs**: Edit the `config.lua` to include new drugs and their corresponding effects.
- **Defining Effects**: Specify health impact, visual effects, and other parameters for each drug.
- **Tolerance Settings**: Adjust how quickly tolerance builds and its maximum limit.
- **Combination Rules**: Set conditions and outcomes for combining different drugs.

---

# Erweitertes Drogenstatus-System

Ein fortschrittliches System zur Verwaltung von Drogen- und Alkoholzuständen in FiveM RP-Servern.

## Hauptfunktionen

- **Vordefinierte Drogen**: Enthält gängige Drogen mit Effekten, die denen in Rockstar-Spielen ähneln.
- **Konfigurierbare Drogen und Effekte**: Ermöglicht das Hinzufügen neuer Drogen und deren Effekte über ein In-Game-Admin-Tablet.
- **Gesundheitsbeeinträchtigung**: Reduziert die Gesundheit des Spielers basierend auf der konsumierten Droge.
- **Statusverfolgung**: Verwaltet einen "Mengen"-Status von 0 bis 100 (0 = nüchtern, 100 = stark beeinträchtigt).
- **Effektstufen**: Verschiedene Stufen der Effekte; einige Drogen verursachen bei 100% starke Beeinträchtigungen.
- **Test-Items**: Verwendung von Items wie Bluttests oder Alkoholtests zur Überprüfung des aktuellen Zustands.
- **Gegengift**: Ein Item für Mediziner, das alle Effekte sofort aufhebt.
- **Eigene Effekte**: Möglichkeit, benutzerdefinierte Effekte zu erstellen und hinzuzufügen (z.B. Anzeige eines Kaleidoskop-ähnlichen PNGs bei Verwendung von LSD).
- **Benachrichtigungen**: Hinweise zum aktuellen Zustand des Spielers.
- **Integration in Medizinsysteme**: Erfasst Drogen- oder Alkoholkonsum als Todesursache in Systemen wie esx_ambulance oder wasabi_ambulance.
- **Alkoholmanagement**: Implementiert Betrunkenheitsstufen und entsprechende Effekte.

## Optionale Funktionen

- **Drogentoleranz**: Bei häufigem Gebrauch benötigen Spieler mehr, um die Wirkung zu spüren, mit einer maximalen Toleranz von 50, um sofortige Überdosierungen zu verhindern.
- **Kombinationseffekte**: Die Kombination von Drogen führt zu einzigartigen Effekten (z.B. wenn Droge 1 und Droge 2 beide über einem Wert von 15 liegen, werden ihre individuellen Effekte durch einen neuen kombinierten Effekt ersetzt).

## Abhängigkeiten

- **ESX Framework**: Erforderlich für die Server-Integration.
- **ox_lib**: Für erweiterte Funktionen und Callback-Management.
- **oxmysql**: Für die Datenbankverwaltung.

## Installation

1. **Download**: Laden Sie das Skript von [GitHub](https://github.com/YourGitHubRepo) herunter.
2. **Abhängigkeiten installieren**: Stellen Sie sicher, dass alle erforderlichen Abhängigkeiten installiert sind.
3. **Konfiguration**: Passen Sie die `config.lua` an, um Drogen, Effekte und andere Einstellungen zu definieren.
4. **Datenbank**: Führen Sie die bereitgestellte SQL-Datei aus, um die notwendigen Tabellen zu 