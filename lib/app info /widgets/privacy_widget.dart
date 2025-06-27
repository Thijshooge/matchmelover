import 'package:flutter/material.dart';

class PrivacyWidget extends StatefulWidget {
  const PrivacyWidget({super.key});

  @override
  State<PrivacyWidget> createState() => _PrivacyWidgetState();
}

class _PrivacyWidgetState extends State<PrivacyWidget> {
  final List<bool> _expandedStates = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        toolbarHeight: 45,
        title: const Text('Privacybeleid'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surface.withValues(alpha: 0.1),

                borderRadius: BorderRadius.circular(16),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.privacy_tip,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Privacybeleid',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Jouw privacy staat voorop',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(
                                  context,
                                ).colorScheme.surface.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Welkom bij MatchMe, de datingapp die mensen op een veilige, respectvolle en leuke manier met elkaar in contact wil brengen. MatchMe is gevestigd in Leiden, en ons doel is eenvoudig maar krachtig: het verbinden van mensen die op zoek zijn naar betekenisvolle relaties, vriendschappen of gewoon een gezellige match.\n\nBij MatchMe staat jouw privacy voorop. Wij begrijpen dat je ons persoonlijke informatie toevertrouwt, en daar gaan we zorgvuldig mee om. In dit privacybeleid leggen we helder en transparant uit welke gegevens we verzamelen, waarom we dat doen, en hoe we die gegevens beveiligen.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Expandable Privacy Sections
            _buildExpandableCard(
              0,
              '1. Wie zijn wij?',
              'Match Me\nKVK: later\nContactpersoon privacy: Mo\nE-Mail: MatchMeLovers@gmail.com\nWebsite: www.MatchMe.com',
              Icons.business_outlined,
            ),

            _buildExpandableCard(
              1,
              '2. Welke persoonsgegevens verzamelen wij?',
              'Bij MatchMe verzamelen wij persoonsgegevens wanneer jij:\n• Een account aanmaakt\n• Onze app of website gebruikt\n• Contact met ons opneemt via support of andere kanalen\n\nDe persoonsgegevens die wij kunnen verzamelen, zijn onder andere:\n• Voor- en achternaam – om je profiel te personaliseren\n• E-mailadres – voor communicatie, verificatie en beveiliging\n• Gebruikersnaam – jouw unieke naam binnen MatchMe\n• Geboortedatum – om te bevestigen dat je ouder bent dan 18 jaar\n• Locatie – om matches in jouw buurt te kunnen voorstellen\n• IP-adres – voor beveiligings- en analytische doeleinden\n• Apparaat Informatie – zoals type toestel, besturingssysteem en versie\n• Inloggegevens – inclusief wachtwoord (versleuteld opgeslagen)\n• Chatberichten binnen de app – voor het bieden van de chatfunctie en handhaving van gedragsregels\n• Foto\'s binnen de app – voor je profiel en interactie met anderen\n• Betaalgegevens – alleen bij aankopen, zoals premium functies (verwerkt via een beveiligde betalingsprovider)\n\nWij verzamelen alleen gegevens die nodig zijn om MatchMe goed te laten werken, jouw ervaring te verbeteren en de veiligheid van onze community te waarborgen.',
              Icons.data_usage_outlined,
            ),

            _buildExpandableCard(
              2,
              '3. Waarom verwerken wij uw persoonsgegevens?',
              'Wij verwerken uw persoonsgegevens om MatchMe veilig, gebruiksvriendelijk en effectief te kunnen laten werken. Concreet doen we dit om de volgende redenen:\n\n• Om je account aan te maken en te beheren – We gebruiken je gegevens om je een persoonlijk profiel te geven, je toegang te geven tot de app en je gebruikerservaring aan te passen\n• Om je te koppelen aan andere gebruikers – Je locatie, leeftijd en voorkeuren helpen ons om geschikte matches voor jou te vinden\n• Om communicatie tussen gebruikers mogelijk te maken – Je chatberichten en foto\'s worden verwerkt om jou te laten communiceren met andere leden binnen de app\n• Om betalingen en aankopen te verwerken – Als je een premiumdienst afneemt, gebruiken wij je betaalgegevens via een beveiligde betalingsverwerker\n• Voor klantenservice en support – Wanneer je contact met ons opneemt, gebruiken wij je gegevens om je vragen te beantwoorden en je te helpen\n• Voor veiligheid, fraude- en misbruikpreventie – We monitoren gedrag binnen de app om ervoor te zorgen dat MatchMe een veilige en respectvolle plek blijft voor iedereen\n• Om onze diensten te verbeteren – Technische gegevens zoals IP-adres en apparaat informatie helpen ons om de app technisch goed te laten draaien, fouten op te sporen en te verbeteren\n• Om te voldoen aan wettelijke verplichtingen – In sommige gevallen zijn we wettelijk verplicht bepaalde gegevens te bewaren of te verstrekken (bijvoorbeeld bij fraudeonderzoeken)',
              Icons.settings_outlined,
            ),

            _buildExpandableCard(
              3,
              '4. Met wie delen wij gegevens?',
              'Wij behandelen jouw persoonsgegevens met zorg en delen ze alleen wanneer dat echt nodig is. Hieronder leggen we uit met wie wij je gegevens eventueel delen en waarom:\n\n1. Dienstverleners (verwerkers)\nWij werken samen met betrouwbare derde partijen die ons helpen MatchMe goed te laten functioneren. Denk aan:\n• Hostingproviders (voor het opslaan van gegevens)\n• Betalingsverwerkers (voor afhandelen van aankopen)\n• E-mail- en berichtensystemen (voor communicatie)\n• Analyse Diensten (om de app te verbeteren)\nDeze partijen verwerken je gegevens alleen in onze opdracht en onder strikte voorwaarden.\n\n2. Andere gebruikers van MatchMe\nWanneer je een profiel aanmaakt, kunnen bepaalde gegevens zichtbaar zijn voor andere gebruikers, zoals:\n• Je naam of gebruikersnaam\n• Leeftijd\n• Locatie (in de buurt, nooit je exacte adres)\n• Foto\'s\n• Profielinformatie en voorkeuren\nPrivégegevens zoals je e-mailadres, chatberichten en betaalinformatie worden nooit gedeeld met andere gebruikers.\n\n3. Autoriteiten en wetshandhaving\nWij kunnen je gegevens delen met overheidsinstanties, toezichthouders of wetshandhavingsdiensten wanneer:\n• Wij daartoe wettelijk verplicht zijn\n• Er sprake is van (een vermoeden van) fraude, misbruik of crimineel gedrag\n• Het nodig is om onze rechten of die van anderen te beschermen\n\n4. Binnen ons bedrijf (MatchMe)\nAls MatchMe in de toekomst fuseert, overgenomen wordt of een samenwerking aangaat, kunnen je gegevens worden overgedragen aan de betrokken partij – uiteraard onder naleving van de geldende privacywetgeving.',
              Icons.share_outlined,
            ),

            _buildExpandableCard(
              4,
              '5. Hoe lang bewaren wij jouw gegevens?',
              'Wij bewaren jouw persoonsgegevens niet langer dan noodzakelijk is voor de doeleinden waarvoor ze zijn verzameld. Hoe lang dat precies is, hangt af van het soort gegevens en het doel van de verwerking. Hieronder geven we een overzicht:\n\n1. Accountgegevens\nZolang je een actief MatchMe-account hebt, bewaren we je gegevens. Verwijder je je account? Dan verwijderen of anonimiseren wij jouw persoonsgegevens binnen 30 dagen, tenzij we ze langer moeten bewaren vanwege een wettelijke verplichting of voor fraudepreventie.\n\n2. Chatberichten en foto\'s\nDeze worden bewaard zolang je account actief is. Na verwijdering van je account worden deze gegevens binnen 30 dagen automatisch verwijderd of geanonimiseerd.\n\n3. Betaalgegevens\nIn verband met fiscale en administratieve verplichtingen bewaren we gegevens over betalingen en facturen tot 7 jaar na de transactie.\n\n4. Contact met support\nBerichten of e-mails die je stuurt naar onze klantenservice bewaren we tot 2 jaar na afhandeling van je vraag, om je beter van dienst te kunnen zijn als je later nog eens contact opneemt.\n\n5. Technische en analytische gegevens\nDeze gegevens (zoals IP-adres, apparaat info) bewaren we meestal 12 tot 24 maanden, tenzij ze nodig zijn voor het verbeteren van de veiligheid of het oplossen van bugs.\n\nWe zorgen ervoor dat gegevens die we niet meer nodig hebben, zorgvuldig worden verwijderd of geanonimiseerd, zodat ze niet meer tot jou te herleiden zijn.',
              Icons.schedule_outlined,
            ),

            _buildExpandableCard(
              5,
              '6. Hoe beveiligen wij jouw gegevens?',
              'Bij MatchMe nemen we de bescherming van jouw persoonsgegevens zeer serieus. We doen er alles aan om je gegevens veilig te houden en misbruik, verlies, onbevoegde toegang of ongewenste openbaarmaking te voorkomen. Daarom hebben we zowel technische als organisatorische maatregelen genomen, zoals:\n\n✅ Technische beveiligingsmaatregelen:\n• Versleuteling (encryptie) van gegevens, zowel tijdens verzending (via HTTPS) als opslag van gevoelige informatie zoals wachtwoorden\n• Firewall- en inbraakdetectiesystemen om onze systemen te beschermen tegen ongeautoriseerde toegang\n• Beveiligde servers en databanken, gehost bij betrouwbare en gecertificeerde partijen\n• Toegangscontrole: alleen geautoriseerd personeel heeft toegang tot persoonsgegevens, en alleen voor zover dat nodig is voor hun werk\n\n✅ Organisatorische beveiligingsmaatregelen:\n• Regelmatige veiligheidsaudits en updates van onze systemen\n• Interne procedures voor het omgaan met datalekken, inclusief meldplicht\n• Training en bewustwording van medewerkers over privacy en gegevensbescherming\n• Strikte afspraken met externe partijen (verwerkers) via verwerkersovereenkomsten\n\nHoewel we er alles aan doen om je gegevens veilig te houden, is geen enkel systeem 100% waterdicht. Mocht er toch iets misgaan, dan zullen we dit onmiddellijk onderzoeken en waar nodig jou en de toezichthouder (Autoriteit Persoonsgegevens) op de hoogte stellen.',
              Icons.security_outlined,
            ),

            _buildExpandableCard(
              6,
              '7. Jouw rechten',
              'Als gebruiker van MatchMe heb je op basis van de privacywetgeving (zoals de Algemene Verordening Gegevensbescherming – AVG) een aantal belangrijke rechten met betrekking tot jouw persoonsgegevens. We vinden het belangrijk dat jij controle hebt over jouw eigen gegevens.\n\n✅ Recht op inzage\nJe hebt het recht om te weten welke persoonsgegevens wij van jou verwerken en waarom. Je kunt op elk moment een overzicht opvragen.\n\n✅ Recht op correctie\nKlopt er iets niet in je gegevens? Dan kun je ons vragen om deze te corrigeren of aan te vullen.\n\n✅ Recht op verwijdering ("recht om vergeten te worden")\nWil je niet langer dat we jouw gegevens bewaren? Je kunt je account op elk moment verwijderen. We verwijderen dan je persoonsgegevens, tenzij we wettelijk verplicht zijn ze langer te bewaren (bijvoorbeeld bij betalingsgegevens).\n\n✅ Recht op beperking van de verwerking\nIn bepaalde gevallen kun je ons vragen om het verwerken van jouw gegevens tijdelijk stop te zetten – bijvoorbeeld als je de juistheid ervan betwist.\n\n✅ Recht op bezwaar\nJe hebt het recht om bezwaar te maken tegen de verwerking van je gegevens als wij die verwerken op basis van een gerechtvaardigd belang of voor direct marketing.\n\n✅ Recht op overdraagbaarheid\nJe kunt ons vragen om jouw gegevens in een machineleesbaar formaat aan jou of een andere dienstverlener over te dragen.\n\n✅ Recht om toestemming in te trekken\nHeb je ons eerder toestemming gegeven voor een bepaalde verwerking (zoals locatie gebruik of marketing)? Dan kun je die toestemming altijd weer intrekken.\n\n📬 Hoe kun je deze rechten uitoefenen?\nJe kunt je rechten uitoefenen door een verzoek te sturen naar:\n📧 privacy@matchme.app\nWe reageren binnen uiterlijk 30 dagen op je verzoek.\nOm misbruik te voorkomen, kunnen we je vragen om je identiteit te bevestigen.',
              Icons.account_circle_outlined,
            ),

            _buildExpandableCard(
              7,
              '8. Cookies',
              'MatchMe maakt gebruik van cookies en vergelijkbare technologieën (zoals pixels en SDK\'s) om onze app en website goed te laten werken, te verbeteren en jouw gebruikservaring te personaliseren.\n\nWat zijn cookies?\nCookies zijn kleine tekstbestandjes die op je apparaat worden geplaatst wanneer je onze app of website gebruikt. Ze helpen ons om jou te herkennen, je voorkeuren te onthouden en onze diensten beter op jou af te stemmen.\n\nWelke soorten cookies gebruiken we?\n\nFunctionele cookies\nDeze zijn nodig om MatchMe goed te laten functioneren, bijvoorbeeld om je ingelogd te houden of je voorkeurstaal te onthouden.\n\nAnalytische cookies\nMet deze cookies verzamelen we anonieme statistieken over hoe gebruikers onze app en website gebruiken (bijvoorbeeld via Google Analytics), zodat we MatchMe kunnen verbeteren.\n\nTracking Cookies (optioneel, met toestemming)\nMet jouw toestemming gebruiken wij tracking cookies om jou gepersonaliseerde content of advertenties te tonen, op basis van je gedrag binnen de app of website.\n\nCookies beheren of uitschakelen\nJe kunt zelf bepalen of je cookies accepteert of niet. Je kunt je cookie-instellingen beheren via:\n• De instellingen in onze app of website\n• De instellingen van je browser of apparaat\n\nLet op: als je bepaalde cookies uitschakelt, kan het zijn dat MatchMe niet optimaal werkt.',
              Icons.cookie_outlined,
            ),

            _buildExpandableCard(
              8,
              '9. Minderjarigen',
              'De diensten van MatchMe zijn uitsluitend bedoeld voor personen van 18 jaar en ouder. Wij richten ons niet op minderjarigen en verzamelen dan ook niet bewust persoonsgegevens van gebruikers onder de 18 jaar.\n\nBij het aanmaken van een account vragen wij naar je geboortedatum om te bevestigen dat je de vereiste leeftijd hebt bereikt. Als wij erachter komen dat iemand onder de 18 zich toch heeft geregistreerd, zullen wij het account zo snel mogelijk verwijderen en de bijbehorende persoonsgegevens wissen.\n\nOuders of wettelijke vertegenwoordigers die vermoeden dat hun kind zonder toestemming gebruikmaakt van MatchMe, kunnen contact met ons opnemen via privacy@matchme.app.',
              Icons.child_care_outlined,
            ),

            _buildExpandableCard(
              9,
              '10. Wijzigingen',
              'MatchMe behoudt zich het recht voor om dit privacybeleid van tijd tot tijd te wijzigen. Wij kunnen bijvoorbeeld wijzigingen aanbrengen om te voldoen aan nieuwe wet- en regelgeving of om onze diensten te verbeteren.\n\nAls er belangrijke wijzigingen zijn die invloed hebben op de manier waarop wij jouw persoonsgegevens verwerken, zullen wij jou hierover op de hoogte stellen via een melding binnen de app of per e-mail.\n\nWe raden je aan om dit privacybeleid regelmatig te raadplegen, zodat je op de hoogte blijft van de laatste updates. De datum van de laatste wijziging wordt altijd bovenaan het privacybeleid weergegeven.\n\nHeb je vragen over dit privacybeleid of hoe we jouw gegevens verwerken? Neem dan gerust contact met ons op via:\n📧 privacy@matchme.app\n\nWe staan klaar om je te helpen!',
              Icons.update_outlined,
            ),

            const SizedBox(height: 24),

            // Last updated info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surface.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Laatst bijgewerkt: ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableCard(
    int index,
    String title,
    String content,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: () {
              setState(() {
                _expandedStates[index] = !_expandedStates[index];
              });
            },
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surface.withValues(alpha: 0.1),
                borderRadius: _expandedStates[index]
                    ? const BorderRadius.vertical(top: Radius.circular(12))
                    : BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: Theme.of(context).colorScheme.surface,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expandedStates[index] ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expandable Content
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surface.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
              ),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Theme.of(
                    context,
                  ).colorScheme.surface.withValues(alpha: 0.8),
                ),
              ),
            ),
            crossFadeState: _expandedStates[index]
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
