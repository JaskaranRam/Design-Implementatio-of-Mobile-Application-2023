import 'package:dreamy_tales/pages/login_register_page.dart';
import 'package:dreamy_tales/pages/settings_story.dart';
import 'package:flutter/material.dart';
import 'package:dreamy_tales/pages/analitics_page.dart';
import 'package:dreamy_tales/pages/myStories.dart';
import 'package:dreamy_tales/pages/settings_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'app_category.dart';
import 'package:dreamy_tales/auth.dart';
import 'package:dreamy_tales/pages/settings_story.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AppCategory _currentCategory = AppCategory.home;
  bool _buttonPressed = false;
  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
  Future<void> signOut() async {
    await Auth().signOut();
  }
  void _exitApp() {
    Navigator.pop(context); // Chiudi il Drawer
    signOut();
    _logout();
  }

  void _changeCategory(AppCategory category) {
    setState(() {
      _currentCategory = category;
    });
    Navigator.pop(context); // Chiudi il Drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Comic Sans MS',
          ),
        ),
        elevation: 10,
      ),
      body: _buildBody(),
      drawer: MyDrawer(
        currentCategory: _currentCategory,
        onCategorySelected: _changeCategory,
        onLogout: _logout,
        onExit: _exitApp,
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentCategory) {
    case AppCategory.home:
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/sfondo.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 70.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Main Characters:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color:Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start, // Questo allinea i widget a sinistra
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/female.png'), // Inserisci il percorso della tua immagine qui
                  ),
                  SizedBox(width: 20), // Aggiunge spazio tra l'avatar e il pulsante
                  Container(
                    width: 100.0, // Imposta la larghezza del pulsante
                    height: 100.0, // Imposta l'altezza del pulsante
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor, // Imposta il colore del pulsante
                      shape: BoxShape.circle, // Rende il pulsante tondo
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        size: 50.0,
                      ),
                      color: Colors.white, // Imposta il colore dell'icona
                      onPressed: () {
                        // Aggiungi qui il tuo codice per aggiungere un personaggio
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 70.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Second Characters:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color:Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 100.0, // Imposta la larghezza del pulsante
                    height: 100.0, // Imposta l'altezza del pulsante
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor, // Imposta il colore del pulsante
                      shape: BoxShape.circle, // Rende il pulsante tondo
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        size: 50.0,
                      ),
                      color: Colors.white, // Imposta il colore dell'icona
                      onPressed: () {
                        // Aggiungi qui il tuo codice per aggiungere un personaggio
                      },
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Container(), // Questo spinge il pulsante in fondo alla pagina
          ),
          Builder(
            builder: (BuildContext context) {
              return Container(
                width: double.infinity, // Questo rende il pulsante largo quanto la pagina
                height: 60.0, // Imposta l'altezza del pulsante
                decoration: BoxDecoration(
                  color: Colors.amber, // Imposta il colore di sfondo del pulsante
                ),
                child: TextButton.icon(
                  icon: Icon(Icons.star), // Imposta l'icona del pulsante
                  label: Text("Let's start the magic"), // Imposta il testo del pulsante
                  onPressed: () {
                  Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => SettingsStoryPage()));
                  },
                ),
              );
            },
          ),
          ], 
        ),
        
      );
      case AppCategory.myStories:
        return MyStories();
      case AppCategory.analytics:
        return Analytics();
      case AppCategory.settings:
        return SettingsScreen();
      default:
        return Container();
    }
  }
}

class MyDrawer extends StatelessWidget {
  final AppCategory currentCategory;
  final void Function(AppCategory) onCategorySelected;
  final void Function() onLogout;
  final void Function() onExit;

  MyDrawer({
    required this.currentCategory,
    required this.onCategorySelected,
    required this.onLogout,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.withOpacity(0.9),
              Colors.deepPurple.withOpacity(0.7),
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.deepPurple.withOpacity(0.9),
                    Colors.deepPurple.withOpacity(0.7),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Text(
                'Bentornato !',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            _buildDrawerButton('Home', AppCategory.home, Icons.home),
            _buildDrawerButton('My Stories', AppCategory.myStories, FontAwesomeIcons.book),
            _buildDrawerButton('Analytics', AppCategory.analytics, FontAwesomeIcons.chartBar),
            _buildDrawerButton('Settings', AppCategory.settings, FontAwesomeIcons.gear),
            _buildDrawerButton('EXIT', AppCategory.logout, Icons.exit_to_app, onPressed: onExit),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerButton(String title, AppCategory category, IconData icon, {void Function()? onPressed}) {
    final isSelected = currentCategory == category;
    final tileColor = isSelected ? Colors.deepPurple.withOpacity(0.4) : Colors.transparent;

    return InkWell(
      onTap: () {
        if (onPressed != null) {
          onPressed();
        } else {
          onCategorySelected(category);
        }
      },
      child: Container(
        color: tileColor,
        child: ListTile(
          title: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.deepPurple,
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.deepPurple,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
