import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  final String userName;
  final int currentLevel;

  const HomePage({
    super.key,
    required this.userName,
    required this.currentLevel,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int selectedMoodIndex = -1;
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _bounceAnimations;
  late List<Animation<double>> _rotateAnimations;
  late List<Animation<double>> _shakeAnimations;
  int currentFoodIndex = 0;
  final PageController _foodPageController = PageController();

  // Define emoji states with their animations and expressions
  final List<Map<String, dynamic>> _moodStates = [
    {
      'initial': '😠',
      'animated': '😡',
      'animation': 'shake'
    },
    {
      'initial': '😞',
      'animated': '😢',
      'animation': 'bounce'
    },
    {
      'initial': '😐',
      'animated': '😑',
      'animation': 'blink'
    },
    {
      'initial': '🙂',
      'animated': '😊',
      'animation': 'bounce'
    },
    {
      'initial': '😄',
      'animated': '😆',
      'animation': 'rotate'
    },
  ];

  final List<Map<String, dynamic>> foodItems = [
    {
      'image': 'assets/food/smooth_maize_porride.png',
      'name': 'Smooth Maize Porridge',
    },
    {
      'image': 'assets/food/liquidised_shicken_soup.png',
      'name': 'Liquidised Chicken Soup',
    },
    {
      'image': 'assets/food/custard.png',
      'name': 'Smooth Custard',
    },
    {
      'image': 'assets/food/mageu.png',
      'name': 'Traditional Mageu',
    },
    {
      'image': 'assets/food/pureed_vegetable_curry.png',
      'name': 'Pureed Vegetable Curry',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationControllers = List.generate(
      5,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      ),
    );

    _bounceAnimations = _animationControllers.map((controller) {
      return Tween<double>(begin: 1.0, end: 1.3).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.elasticOut,
          reverseCurve: Curves.easeIn,
        ),
      );
    }).toList();

    _rotateAnimations = _animationControllers.map((controller) {
      return Tween<double>(begin: 0, end: 0.2).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.elasticInOut,
        ),
      );
    }).toList();

    _shakeAnimations = _animationControllers.map((controller) {
      return Tween<double>(begin: 0, end: 15).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.elasticIn,
        ),
      );
    }).toList();
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    _foodPageController.dispose();
    super.dispose();
  }

  // Navigation methods
  void _navigateToHome() {
    print('Already on Home Page');
  }

  void _navigateToFramework() {
    Navigator.pushNamed(context, '/framework');
  }

  void _navigateToFoodTesting() {
    Navigator.pushNamed(context, '/testing');
  }

  void _navigateToChatbot() {
    Navigator.pushNamed(context, '/chatbot');
  }

  void _navigateToProfile() {
    Navigator.pushNamed(context, '/profile');
  }

  void _navigateToSearch() {
    Navigator.pushNamed(context, '/search');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Top purple header with rounded bottom corners
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF44157F),
                    Color(0xFF7A60D6),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
                  child: Column(
                    children: [
                      // Header with profile and notifications
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.grey[300],
                            child: const Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Hi,',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                widget.userName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Stack(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                    'assets/icons/notification.svg',
                                    color: Colors.grey,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                              // Notification badge
                              Positioned(
                                right: 2,
                                top: 2,
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '1',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 45,
                            height: 45,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                'assets/icons/menu_icon.svg',
                                color: Colors.grey,
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      // Search bar - Navigate to SearchPage when tapped
                      GestureDetector(
                        onTap: _navigateToSearch,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.search, color: Colors.grey, size: 22),
                              ),
                              const Text(
                                'Search for...',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // How Do You Feel Today section
                      const Text(
                        'How Do You Feel Today?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildMoodIcon(0),
                          _buildMoodIcon(1),
                          _buildMoodIcon(2),
                          _buildMoodIcon(3),
                          _buildMoodIcon(4),
                        ],
                      ),
                      const SizedBox(height: 25),

                      // Current Saved Level
                      const Text(
                        'Current Saved Level',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: _navigateToFramework,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF44157F), Color(0xFF7A60D6)],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                            child: Row(
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFD700),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 18),
                                const Text(
                                  'Level 3: Moderately Thick',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Food Suggestions
                      const Text(
                        'Food Suggestions',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF44157F), Color(0xFF7A60D6)],
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          child: Row(
                            children: [
                              const Text(
                                'Level 3: Moderately Thick',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFD700),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Food items - Show 2 at a time with smooth sliding
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFB0E0E6), // Powder blue background
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Stack(
                                children: [
                                  PageView.builder(
                                    controller: _foodPageController,
                                    onPageChanged: (index) {
                                      setState(() {
                                        currentFoodIndex = index;
                                      });
                                    },
                                    itemCount: foodItems.length > 1 ? foodItems.length - 1 : 1,
                                    itemBuilder: (context, pageIndex) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(
                                          children: [
                                            // First food item
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 120,
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.transparent,
                                                    ),
                                                    child: ClipOval(
                                                      child: Image.asset(
                                                        foodItems[pageIndex]['image'],
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context, error, stackTrace) {
                                                          return Container(
                                                            decoration: const BoxDecoration(
                                                              color: Color(0xFF44157F),
                                                              shape: BoxShape.circle,
                                                            ),
                                                            child: const Icon(
                                                              Icons.fastfood,
                                                              color: Colors.white,
                                                              size: 40,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 12),
                                                  Text(
                                                    foodItems[pageIndex]['name'],
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xFF333333),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            // Second food item
                                            if (pageIndex + 1 < foodItems.length)
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: 120,
                                                      height: 120,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.transparent,
                                                      ),
                                                      child: ClipOval(
                                                        child: Image.asset(
                                                          foodItems[pageIndex + 1]['image'],
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context, error, stackTrace) {
                                                            return Container(
                                                              decoration: const BoxDecoration(
                                                                color: Color(0xFF44157F),
                                                                shape: BoxShape.circle,
                                                              ),
                                                              child: const Icon(
                                                                Icons.fastfood,
                                                                color: Colors.white,
                                                                size: 40,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 12),
                                                    Text(
                                                      foodItems[pageIndex + 1]['name'],
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(0xFF333333),
                                                      ),
                                                      textAlign: TextAlign.center,
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            else
                                              const Expanded(child: SizedBox()), // Empty space if no second item
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  // Left tap area for going to previous page
                                  if (currentFoodIndex > 0)
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      bottom: 0,
                                      width: 80,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (currentFoodIndex > 0) {
                                            _foodPageController.previousPage(
                                              duration: const Duration(milliseconds: 300),
                                              curve: Curves.easeInOut,
                                            );
                                          }
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: const Center(
                                            child: Icon(
                                              Icons.chevron_left,
                                              color: Colors.grey,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  // Right tap area for going to next page
                                  if (currentFoodIndex < (foodItems.length > 1 ? foodItems.length - 2 : 0))
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      width: 80,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (currentFoodIndex < (foodItems.length > 1 ? foodItems.length - 2 : 0)) {
                                            _foodPageController.nextPage(
                                              duration: const Duration(milliseconds: 300),
                                              curve: Curves.easeInOut,
                                            );
                                          }
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: const Center(
                                            child: Icon(
                                              Icons.chevron_right,
                                              color: Colors.grey,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            
                            // Page indicator dots
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                foodItems.length > 1 ? foodItems.length - 1 : 1,
                                (index) => Container(
                                  width: 8,
                                  height: 8,
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: currentFoodIndex == index
                                        ? const Color(0xFF44157F)
                                        : Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Learn section
                      const Text(
                        'Learn',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Learn buttons grid
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 1.5,
                        children: [
                          _buildLearnButton('What is\nDysphagia?', () {}),
                          _buildLearnButton('What are\nIDDSI Levels?', _navigateToFramework),
                          _buildLearnButton('How to\nTest Food', _navigateToFoodTesting),
                          _buildLearnButton('Tips for\nOlder Adults', () {}),
                        ],
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            height: 65,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  iconPath: 'assets/icons/home.svg',
                  isSelected: true,
                  label: 'Home',
                  onTap: _navigateToHome,
                ),
                _buildNavItem(
                  iconPath: 'assets/icons/framework.svg',
                  isSelected: false,
                  label: 'Records',
                  onTap: _navigateToFramework,
                ),
                _buildNavItem(
                  iconPath: 'assets/icons/testing.svg',
                  isSelected: false,
                  label: 'Test',
                  onTap: _navigateToFoodTesting,
                ),
                _buildNavItem(
                  iconPath: 'assets/icons/profile.svg',
                  isSelected: false,
                  label: 'Chat',
                  onTap: _navigateToChatbot,
                ),
                _buildNavItem(
                  iconPath: 'assets/icons/Account.svg',
                  isSelected: false,
                  label: 'Profile',
                  onTap: _navigateToProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoodIcon(int index) {
    bool isSelected = selectedMoodIndex == index;
    const defaultColor = Color(0xFF00529A); // Updated emoji color
    const selectedColor = Color(0xFFFFD700);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedMoodIndex != -1) {
            if (selectedMoodIndex != index) {
              _animationControllers[selectedMoodIndex].reverse();
            }
          }
          selectedMoodIndex = selectedMoodIndex == index ? -1 : index;
          if (selectedMoodIndex == index) {
            _animationControllers[index].forward();
          } else {
            _animationControllers[index].reverse();
          }
        });
      },
      child: AnimatedBuilder(
        animation: _animationControllers[index],
        builder: (context, child) {
          double scale = 1.0;
          double rotate = 0.0;
          double translateX = 0.0;

          switch (_moodStates[index]['animation']) {
            case 'bounce':
              scale = _bounceAnimations[index].value;
              break;
            case 'rotate':
              rotate = _rotateAnimations[index].value;
              scale = _bounceAnimations[index].value;
              break;
            case 'shake':
              translateX = sin(_shakeAnimations[index].value) * 5;
              break;
            case 'blink':
              scale = _bounceAnimations[index].value;
              break;
          }

          return Transform.translate(
            offset: Offset(translateX, 0),
            child: Transform.rotate(
              angle: rotate,
              child: Transform.scale(
                scale: scale,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: isSelected ? selectedColor : defaultColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (isSelected ? selectedColor : defaultColor).withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      _animationControllers[index].status == AnimationStatus.forward ||
                      _animationControllers[index].status == AnimationStatus.completed
                          ? _moodStates[index]['animated']
                          : _moodStates[index]['initial'],
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLearnButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF44157F), Color(0xFF7A60D6)],
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String iconPath,
    required bool isSelected,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF44157F).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            iconPath,
            color: isSelected ? const Color(0xFF44157F) : Colors.grey,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}