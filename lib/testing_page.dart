import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestingPage extends StatelessWidget {
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Framework',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SizedBox(
                        height: 70,
                        width: 70,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 10, // Adjust to align icon visually
                              child: SvgPicture.asset(
                                'assets/icons/arrow1.svg',
                                height: 70,
                                width: 70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 0),
                Expanded(
                  child: ListView(
                    children: [
                      const Text('Fluids',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      _frameworkButton(
                          context, 0, 'Thin', Colors.white, '/level0'),
                      _frameworkButton(context, 1, 'Slightly Thick',
                          const Color(0xFF616566), '/level1'),
                      _frameworkButton(context, 2, 'Mildly Thick',
                          const Color(0xFFEE60A2), '/level2'),
                      _frameworkButton(context, 3, 'Moderately Thick',
                          const Color(0xFFE8D900), '/level3'),
                      _frameworkButton(context, 4, 'Extremely Thick',
                          const Color(0xFF76C04F), '/level4'),
                      const SizedBox(height: 20),
                      const Text('Food',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      _frameworkButton(context, 3, 'Liquidised',
                          const Color(0xFFE8D900), '/food3'),
                      _frameworkButton(context, 4, 'Puréed',
                          const Color(0xFF76C04F), '/food4'),
                      _frameworkButton(context, 5, 'Minced and Moist',
                          const Color(0xFFF0763D), '/food5'),
                      _frameworkButton(context, 6, 'Soft and Bite-Sized',
                          const Color(0xFF0175BC), '/food6'),
                      _frameworkButton(context, 7, 'Regular',
                          const Color(0xFF2E2E31), '/food7'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/home.svg', height: 24),
              label: ''),
          BottomNavigationBarItem(
              icon:
                  SvgPicture.asset('assets/icons/framework_h.svg', height: 30),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/testing.svg', height: 24),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/profile.svg', height: 24),
              label: ''),
        ],
      ),
    );
  }

  static Widget _frameworkButton(BuildContext context, int number, String label,
      Color color, String route) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 2 / 5;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        width: buttonWidth,
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF548AD8), Color(0xFF8256D5)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80),
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 43,
              height: 43,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(33),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(22),
                ),
              ),
              child: Text(
                '$number',
                style: TextStyle(
                  color: (label == 'Thin' && number == 0)
                      ? const Color(0xFFA6E3D0)
                      : Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Level: $label',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
