import 'package:flutter/material.dart';
import 'package:matchme_lover/profile/profile%20edit/widgets/gender_widget.dart';

import 'widgets/photo_grid_widget.dart';
import 'widgets/bio_widget.dart';
import 'widgets/location_widget.dart';
import 'widgets/zodiac_widget.dart';
import 'widgets/sport_widget.dart';
import 'widgets/party_widget.dart';
import 'widgets/travel_widget.dart';
import 'widgets/height_widget.dart';
import 'widgets/language_widget.dart';
import 'widgets/looking_for_widget.dart';
import 'widgets/smoking_widget.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        toolbarHeight: 45.0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: const Text('Profile bewerken'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Gereed',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
          ),
        ),
        child: DefaultTextStyle(
          style: TextStyle(color: Theme.of(context).colorScheme.surface),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Photo\'s',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const PhotoGridWidget(),

                  const SizedBox(height: 20),
                  Text(
                    'Bio',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const BioWidget(),

                  const SizedBox(height: 20),
                  Text(
                    'Over mij',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const GenderWidget(),
                  const LocationWidget(),

                  const SizedBox(height: 20),
                  Text(
                    'Meer over mij',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const ZodiacWidget(),
                  const SportWidget(),
                  const PartyWidget(),
                  const TravelWidget(),
                  const HeightWidget(),
                  const SizedBox(height: 20),
                  Text(
                    'Nog meer over mij',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const LookingForWidget(),
                  const SmokingWidget(),
                  const LanguageWidget(),
                  const SizedBox(height: 40), // Extra space at bottom
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
