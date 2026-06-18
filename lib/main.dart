import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forest Canopy Monitor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF5F7F5),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // لیست صفحات اصلی اپلیکیشن بر اساس ساختار نهایی شما
  final List<Widget> _screens = [
    const DashboardScreen(),
    const LiveAnalysisScreen(),
    const ResourcesScreen(),
    const AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Live Analysis'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Resources'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
        ],
      ),
    );
  }
}

// ================= صفحه اول: داشبورد =================
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forest Dashboard'), 
        backgroundColor: Colors.green[700], 
        foregroundColor: Colors.white
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Project: Forest Canopy Height', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green[900])),
            const SizedBox(height: 15),
            
            // تصویر آنلاین جنگل (بدون نیاز به تنظیمات آفلاین assets)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://images.unsplash.com/photo-1511497584788-876760111969?w=600',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            
            Text('Forest Metrics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800])),
            const SizedBox(height: 10),
            
            // کارت‌های نمایش داده‌های درخواستی شما
            const MetricCard(title: 'Forest Health', value: 'Optimal', icon: Icons.health_and_safety, color: Colors.green),
            const MetricCard(title: 'Average Height', value: '24.5 m', icon: Icons.height, color: Colors.blue),
            const MetricCard(title: 'Maximum Height', value: '42.1 m', icon: Icons.vertical_align_top, color: Colors.orange),
            const MetricCard(title: 'NDVI Index', value: '0.78', icon: Icons.eco, color: Colors.lightGreen),
          ],
        ),
      ),
    );
  }
}

// ================= صفحه دوم: تحلیل زنده (Live Analysis) =================
class LiveAnalysisScreen extends StatelessWidget {
  const LiveAnalysisScreen({super.key});

  Future<void> _openEarthEngine() async {
    final Uri url = Uri.parse('https://forest-canopy-hight.projects.earthengine.app/view/forest-canopy-monitor');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Analysis'), 
        backgroundColor: Colors.green[700], 
        foregroundColor: Colors.white
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.satellite_alt, size: 80, color: Colors.green[700]),
              const SizedBox(height: 20),
              const Text(
                'Forest Canopy Monitor Dashboard',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Click the button below to open your published live interactive dashboard on Google Earth Engine.',
                textAlign:  TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              // دکمه باز کردن لینک ارث انجین شما
              ElevatedButton.icon(
                onPressed: _openEarthEngine,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                icon: const Icon(Icons.open_in_new),
                label: const Text('Open Earth Engine Dashboard', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= صفحه سوم: منابع تحقیقاتی =================
class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Research Resources'), 
        backgroundColor: Colors.green[700], 
        foregroundColor: Colors.white
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ResourceLinkTile(
            title: 'Google Earth Engine',
            subtitle: 'Cloud platform for earth science data analysis.',
            onTap: () => _launchURL('https://earthengine.google.com/'),
          ),
          ResourceLinkTile(
            title: 'Sentinel-2 Mission Overview',
            subtitle: 'High-resolution optical imagery from ESA.',
            onTap: () => _launchURL('https://sentinels.copernicus.eu/web/sentinel/missions/sentinel-2'),
          ),
          ResourceLinkTile(
            title: 'NASA GEDI Mission',
            subtitle: 'Global Ecosystem Dynamics Investigation (LiDAR data).',
            onTap: () => _launchURL('https://gedi.umd.edu/'),
          ),
        ],
      ),
    );
  }
}

// ================= صفحه چهارم: درباره پروژه (About) =================
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Project'), 
        backgroundColor: Colors.green[700], 
        foregroundColor: Colors.white
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Forest Canopy Height Estimation Using Satellite-Derived DSM and Edge AI',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[900]),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            Text(
              'Description:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]),
            ),
            const SizedBox(height: 10),
            const Text(
              'This application targets the analysis of global and local environmental health by calculating tree canopy attributes. By cross-referencing satellite Digital Surface Models (DSM) alongside cutting-edge remote sensing indexes, the platform provides automated metrics to map biomass density, structural ecosystem traits, and localized carbon absorption performance.',
              style: TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= ویجت‌های کمکی گرافیکی =================
class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(
          value,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green[900]),
        ),
      ),
    );
  }
}
class ResourceLinkTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ResourceLinkTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blue),
        onTap: onTap,
      ),
    );
  }
}
