import 'package:flutter/material.dart';

void main() {
  runApp(const DriverApp());
}

class DriverApp extends StatelessWidget {
  const DriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Driver App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

// ----------------- LOGIN PAGE -----------------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DriverHomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid credentials")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Driver Login")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}

// ----------------- DRIVER HOME PAGE -----------------
class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  bool isSharingLocation = false;
  final TextEditingController _incidentController = TextEditingController();

  void _toggleLocationSharing() {
    setState(() {
      isSharingLocation = !isSharingLocation;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isSharingLocation
            ? "GPS Location Sharing Started"
            : "GPS Location Sharing Stopped"),
      ),
    );
  }

  void _reportIncident() {
    if (_incidentController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Incident reported: ${_incidentController.text}")),
      );
      _incidentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // GPS sharing
            ListTile(
              leading: Icon(
                Icons.gps_fixed,
                color: isSharingLocation ? Colors.green : Colors.red,
              ),
              title: Text(isSharingLocation
                  ? "Location Sharing ON"
                  : "Location Sharing OFF"),
              trailing: ElevatedButton(
                onPressed: _toggleLocationSharing,
                child: Text(isSharingLocation ? "Stop" : "Start"),
              ),
            ),
            const Divider(),

            // Route Navigation (dummy placeholder)
            ListTile(
              leading: const Icon(Icons.map, color: Colors.blue),
              title: const Text("Route Navigation"),
              subtitle: const Text("Shows the assigned bus route"),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Route navigation opened")),
                  );
                },
                child: const Text("Open"),
              ),
            ),
            const Divider(),

            // Stop Reminders (dummy list)
            const Text(
              "Upcoming Stops",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...["Central Bus Stand", "Market Street", "School Road", "Tech Park"]
                .map((stop) => Card(
              child: ListTile(
                leading: const Icon(Icons.directions_bus),
                title: Text(stop),
                subtitle: const Text("Reminder will pop up 500m before"),
              ),
            )),
            const Divider(),

            // Incident Reporting
            const Text(
              "Report Incident",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _incidentController,
              decoration:
              const InputDecoration(hintText: "Describe incident here"),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _reportIncident,
              child: const Text("Submit Incident"),
            ),
          ],
        ),
      ),
    );
  }
}
