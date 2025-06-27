import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchme_lover/widgets/my_text_field.dart';
import 'package:matchme_lover/screens/main/persistent_nav.dart';
import 'package:matchme_lover/repositories/auth_repository.dart';
import 'package:matchme_lover/blocs/auth/auth_bloc.dart';
import 'package:matchme_lover/blocs/auth/auth_event.dart';
import 'package:matchme_lover/blocs/auth/auth_state.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(AuthRepository()),
      child: const SignUpScreenContent(),
    );
  }
}

class SignUpScreenContent extends StatefulWidget {
  const SignUpScreenContent({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreenContent> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  DateTime? _selectedBirthDate;
  int? _calculatedAge;
  bool _isPasswordVisible = false;

  final List<String> _passwordRequirements = [
    "Minimaal 8 karakters",
    "Minimaal 1 hoofdletter",
    "Minimaal 1 kleine letter",
    "Minimaal 1 cijfer",
    "Minimaal 1 speciaal teken",
  ];
  final List<bool> _requirementsMet = List.filled(5, false);

  void _validatePassword(String password) {
    setState(() {
      _requirementsMet[0] = password.length >= 8;
      _requirementsMet[1] = password.contains(RegExp(r'[A-Z]'));
      _requirementsMet[2] = password.contains(RegExp(r'[a-z]'));
      _requirementsMet[3] = password.contains(RegExp(r'[0-9]'));
      _requirementsMet[4] = password.contains(
        RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
      );
    });
  }

  int _calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now().subtract(Duration(days: 365 * 18));
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedBirthDate = picked;
        _calculatedAge = _calculateAge(picked);
        // Toon leeftijd als tekst (gebruiker ziet alleen leeftijd)
        _birthDateController.text = "$_calculatedAge jaar";
      });
    }
  }

  void _signUp() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final name = _nameController.text.trim();
    final birthDateString = _birthDateController.text.trim();

    if (email.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        birthDateString.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Vul alle velden in.')));
      return;
    }

    if (_requirementsMet.contains(false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wachtwoord voldoet niet aan de eisen.')),
      );
      return;
    }

    // Controleer of er een geboortedatum is geselecteerd
    if (_selectedBirthDate == null || _calculatedAge == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecteer een geboortedatum.')),
      );
      return;
    }

    // Controleer minimumleeftijd van 18 jaar
    if (_calculatedAge! < 18) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Je moet minimaal 18 jaar oud zijn om een account aan te maken.',
          ),
        ),
      );
      return;
    }

    // Gebruik BLoC voor signup met zowel geboortedatum als leeftijd
    context.read<AuthBloc>().add(
      SignUpRequested(
        email: email,
        password: password,
        naam: name,
        geboortedatum: _selectedBirthDate!,
        leeftijd: _calculatedAge!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isStandalone = ModalRoute.of(context)?.settings.name != null;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registratie succesvol!')),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const PersistentTabScreen(),
            ),
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return _buildContent(context, isStandalone, state);
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    bool isStandalone,
    AuthState state,
  ) {
    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MyTextField(
          controller: _emailController,
          hintText: 'Email',
          obscureText: false,
          prefixIcon: Icons.email,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 8),
        MyTextField(
          controller: _passwordController,
          hintText: 'Wachtwoord',
          obscureText: !_isPasswordVisible,
          prefixIcon: Icons.lock,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
            child: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
          onChanged: (value) {
            _validatePassword(value);
          },
        ),
        SizedBox(height: 6),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [0, 1, 2].map((idx) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 1.0),
                    child: Row(
                      children: [
                        Icon(
                          _requirementsMet[idx]
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: _requirementsMet[idx]
                              ? Colors.green
                              : Color.fromARGB(255, 236, 28, 36),
                          size: 18,
                        ),
                        SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            _passwordRequirements[idx],
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [3, 4].map((idx) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 1.0),
                    child: Row(
                      children: [
                        Icon(
                          _requirementsMet[idx]
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: _requirementsMet[idx]
                              ? Colors.green
                              : Color.fromARGB(255, 236, 28, 36),
                          size: 18,
                        ),
                        SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            _passwordRequirements[idx],
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),

        MyTextField(
          controller: _nameController,
          hintText: 'Naam',
          obscureText: false,
          prefixIcon: Icons.person,
        ),
        SizedBox(height: 8),

        MyTextField(
          controller: _birthDateController,
          hintText: 'Leeftijd',
          obscureText: false,
          prefixIcon: Icons.cake,
          onTap: () => _selectDate(context),
          suffixIcon: Icon(Icons.arrow_drop_down),
          readOnly: true,
        ),
        SizedBox(height: 10),

        ElevatedButton(
          onPressed: state is AuthLoading ? null : _signUp,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 236, 28, 36),
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: state is AuthLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
      ],
    );

    return isStandalone
        ? Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: SingleChildScrollView(child: content),
              ),
            ),
          )
        : Container(
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: content,
              ),
            ),
          );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }
}
