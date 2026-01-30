import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:abhoy_catering/l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../utils/app_colors.dart';
import 'logistics_screen.dart';

class MenuSelectionScreen extends StatefulWidget {
  final String eventType;

  const MenuSelectionScreen({super.key, required this.eventType});

  @override
  State<MenuSelectionScreen> createState() => _MenuSelectionScreenState();
}

class _MenuSelectionScreenState extends State<MenuSelectionScreen> {
  int currentCategoryIndex = 0; // Track current category
  final List<String> categories = [
    'Starters',
    'Main Course',
    'Desserts',
    'Drinks',
  ];
  Map<String, int> selectedItems = {};
  final TextEditingController searchController = TextEditingController();

  String get selectedCategory => categories[currentCategoryIndex];
  bool get isLastCategory => currentCategoryIndex == categories.length - 1;

  // Sample menu data - Authentic Digha & Bengali Cuisine
  final Map<String, List<MenuItem>> menuItems = {
    'Starters': [
      MenuItem(
        name: 'Fish Kabiraji',
        description:
            'Crispy breaded fish fillet with a traditional lacey egg...',
        price: 120,
        image:
            'https://images.unsplash.com/photo-1580959375944-57609b97d1e6?w=400',
        isVeg: false,
      ),
      MenuItem(
        name: 'Paneer Tikka',
        description: 'Marinated cottage cheese cubes grilled to perfection...',
        price: 100,
        image:
            'https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Mochar Chop',
        description: 'Deep-fried croquettes made from finely chopped banan...',
        price: 80,
        image:
            'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Vegetable Cutlet',
        description: 'Mixed seasonal vegetables mashed with roasted...',
        price: 60,
        image:
            'https://images.unsplash.com/photo-1606491956689-2ea866880c84?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Chicken 65',
        description: 'A spicy, deep-fried chicken dish originating from...',
        price: 140,
        image:
            'https://images.unsplash.com/photo-1610057099443-fde8c4d50f91?w=400',
        isVeg: false,
      ),
      MenuItem(
        name: 'Crispy Chilli Babycorn',
        description:
            'Tender babycorn fried to a crisp and tossed in a sweet...',
        price: 90,
        image:
            'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=400',
        isVeg: true,
      ),
    ],
    'Main Course': [
      MenuItem(
        name: 'Chingri Malai Curry',
        description: 'Digha prawns cooked in rich coconut milk gravy...',
        price: 280,
        image:
            'https://images.unsplash.com/photo-1633945274309-2c8c2b0d8b5f?w=400',
        isVeg: false,
      ),
      MenuItem(
        name: 'Pomfret Fry',
        description: 'Fresh Digha pomfret marinated with Bengali spices...',
        price: 250,
        image:
            'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=400',
        isVeg: false,
      ),
      MenuItem(
        name: 'Bhetki Paturi',
        description: 'Bhetki fish wrapped in banana leaf with mustard paste...',
        price: 220,
        image:
            'https://images.unsplash.com/photo-1534604973900-c43ab4c2e0ab?w=400',
        isVeg: false,
      ),
      MenuItem(
        name: 'Mutton Kosha',
        description: 'Slow-cooked Bengali mutton curry with aromatic spices...',
        price: 260,
        image:
            'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=400',
        isVeg: false,
      ),
      MenuItem(
        name: 'Shukto',
        description: 'Traditional Bengali mixed vegetable curry with bitter...',
        price: 120,
        image:
            'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Aloo Posto',
        description: 'Potatoes cooked in poppy seed paste - Bengali classic...',
        price: 100,
        image:
            'https://images.unsplash.com/photo-1589621316382-008455b857cd?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Chicken Rezala',
        description: 'Mughlai-style chicken in white gravy with cashews...',
        price: 200,
        image:
            'https://images.unsplash.com/photo-1603360946369-dc9bb6258143?w=400',
        isVeg: false,
      ),
      MenuItem(
        name: 'Dhokar Dalna',
        description: 'Fried lentil cakes in tomato-based curry...',
        price: 110,
        image:
            'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Ilish Bhapa',
        description: 'Steamed Hilsa fish with mustard - Bengali delicacy...',
        price: 300,
        image:
            'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=400',
        isVeg: false,
      ),
    ],
    'Desserts': [
      MenuItem(
        name: 'Rosogolla',
        description: 'Soft spongy cottage cheese balls in sugar syrup...',
        price: 60,
        image:
            'https://images.unsplash.com/photo-1621303837174-89787a7d4729?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Mishti Doi',
        description: 'Sweet yogurt - traditional Bengali dessert...',
        price: 50,
        image:
            'https://images.unsplash.com/photo-1571212515416-fca2b29c4668?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Sandesh',
        description: 'Delicate cottage cheese sweet with cardamom...',
        price: 70,
        image:
            'https://images.unsplash.com/photo-1606312619070-d48b4cbc5b52?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Rasmalai',
        description: 'Cottage cheese dumplings in sweetened milk...',
        price: 80,
        image:
            'https://images.unsplash.com/photo-1589985270826-4b7bb135bc9d?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Gulab Jamun',
        description: 'Deep-fried milk balls soaked in rose-flavored syrup...',
        price: 60,
        image:
            'https://images.unsplash.com/photo-1589985270826-4b7bb135bc9d?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Patishapta',
        description: 'Rice flour crepes filled with coconut and jaggery...',
        price: 70,
        image:
            'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Nolen Gurer Payesh',
        description: 'Rice pudding with date palm jaggery...',
        price: 90,
        image:
            'https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Langcha',
        description: 'Cylindrical sweet made from khoya, fried and soaked...',
        price: 65,
        image:
            'https://images.unsplash.com/photo-1606890737304-57a1ca8a5b62?w=400',
        isVeg: true,
      ),
    ],
    'Drinks': [
      MenuItem(
        name: 'Aam Pora Shorbot',
        description: 'Roasted raw mango drink - summer special...',
        price: 40,
        image:
            'https://images.unsplash.com/photo-1546173159-315724a31696?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Gondhoraj Lebu Shorbot',
        description: 'Aromatic Gondhoraj lime juice - Bengali specialty...',
        price: 45,
        image:
            'https://images.unsplash.com/photo-1523677011781-c91d1bbe2f9d?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Daab Shorbot',
        description: 'Fresh tender coconut water from Digha...',
        price: 50,
        image:
            'https://images.unsplash.com/photo-1585238341710-4a8fa2c4d1ae?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Masala Chaas',
        description: 'Spiced buttermilk with roasted cumin...',
        price: 35,
        image:
            'https://images.unsplash.com/photo-1623065422902-30a2d299bbe4?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Jal Jeera',
        description: 'Cumin-flavored refreshing drink...',
        price: 35,
        image:
            'https://images.unsplash.com/photo-1622597467836-f3285f2131b8?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Fresh Lime Soda',
        description: 'Sweet or salty lime soda with fresh mint...',
        price: 40,
        image:
            'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Lassi',
        description: 'Traditional yogurt-based drink - sweet or salted...',
        price: 50,
        image:
            'https://images.unsplash.com/photo-1623065422902-30a2d299bbe4?w=400',
        isVeg: true,
      ),
      MenuItem(
        name: 'Bel Pana',
        description: 'Wood apple juice with jaggery and spices...',
        price: 45,
        image:
            'https://images.unsplash.com/photo-1534353436294-0dbd4bdac845?w=400',
        isVeg: true,
      ),
    ],
  };

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  int getTotalItems() {
    return selectedItems.values.fold(0, (sum, qty) => sum + qty);
  }

  double getSubtotal() {
    double total = 0;
    selectedItems.forEach((itemName, quantity) {
      final item = menuItems[selectedCategory]?.firstWhere(
        (item) => item.name == itemName,
        orElse: () => MenuItem(
          name: '',
          description: '',
          price: 0,
          image: '',
          isVeg: true,
        ),
      );
      if (item != null && item.name.isNotEmpty) {
        total += item.price * quantity;
      }
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context, l10n),
            _buildProgressBar(context, l10n),
            _buildMainContent(context, l10n),
            _buildFooter(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations? l10n) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      child: Row(
        children: [
          // Back button and Logo
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.textBlack),
                onPressed: () {
                  Navigator.pop(context);
                },
                tooltip: 'Back',
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(8),
                color: AppColors.primaryOrange,
                child: const Icon(
                  Icons.restaurant_menu,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                l10n?.appTitle ?? 'Digha Catering',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.textBlack,
                ),
              ),
            ],
          ),
          const SizedBox(width: 40),
          // Search bar
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.offWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search dishes...',
                  hintStyle: TextStyle(
                    color: AppColors.textGrey.withOpacity(0.6),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.textGrey,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
          // Language, Cart, User icons
          Consumer<LocaleProvider>(
            builder: (context, provider, child) {
              return IconButton(
                icon: const Icon(Icons.language, size: 24),
                color: AppColors.textBlack,
                onPressed: () {
                  // Show language selector
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, size: 24),
            color: AppColors.textBlack,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined, size: 24),
            color: AppColors.textBlack,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context, AppLocalizations? l10n) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n?.selectYourMenu ?? 'Select Your Menu',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlack,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n?.step2MenuDesc ??
                        'Step 2 of 5: Choose starters, mains and desserts',
                    style: TextStyle(fontSize: 14, color: AppColors.textGrey),
                  ),
                ],
              ),
              Text(
                '40% Complete',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryOrange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress bar
          Stack(
            children: [
              Container(
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.4, // 2/5 = 40%
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, AppLocalizations? l10n) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Menu items section
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category tabs
                _buildCategoryTabs(),
                const SizedBox(height: 32),
                // Menu items grid
                _buildMenuGrid(),
              ],
            ),
          ),
          const SizedBox(width: 32),
          // Your Plate sidebar
          SizedBox(width: 320, child: _buildYourPlateSidebar(context, l10n)),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Row(
      children: categories.asMap().entries.map((entry) {
        final index = entry.key;
        final category = entry.value;
        final isSelected = currentCategoryIndex == index;
        final isCompleted = index < currentCategoryIndex;

        return Padding(
          padding: const EdgeInsets.only(right: 32),
          child: Column(
            children: [
              Row(
                children: [
                  if (isCompleted)
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 16,
                    ),
                  if (isCompleted) const SizedBox(width: 4),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected
                          ? AppColors.primaryOrange
                          : isCompleted
                          ? Colors.green
                          : AppColors.textGrey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (isSelected)
                Container(
                  height: 3,
                  width: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMenuGrid() {
    final items = menuItems[selectedCategory] ?? [];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 0.85,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildMenuItem(items[index]);
      },
    );
  }

  Widget _buildMenuItem(MenuItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              image: DecorationImage(
                image: NetworkImage(item.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: item.isVeg
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.isVeg ? 'Veg' : 'Non-Veg',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: item.isVeg
                              ? Colors.green[700]
                              : Colors.red[700],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.description,
                  style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${item.price}/plate',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryOrange,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            selectedItems[item.name] =
                                (selectedItems[item.name] ?? 0) + 1;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYourPlateSidebar(BuildContext context, AppLocalizations? l10n) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.restaurant,
                    color: AppColors.primaryOrange,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.yourPlate ?? 'Your Plate',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textBlack,
                      ),
                    ),
                    Text(
                      '${getTotalItems()} Items Selected',
                      style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Selected items list
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: selectedItems.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(40),
                    child: Center(
                      child: Text(
                        'No items selected yet',
                        style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedItems.length,
                    itemBuilder: (context, index) {
                      final itemName = selectedItems.keys.elementAt(index);
                      final quantity = selectedItems[itemName]!;
                      final item = menuItems[selectedCategory]?.firstWhere(
                        (item) => item.name == itemName,
                        orElse: () => MenuItem(
                          name: '',
                          description: '',
                          price: 0,
                          image: '',
                          isVeg: true,
                        ),
                      );

                      if (item == null || item.name.isEmpty)
                        return const SizedBox();

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryOrange,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textBlack,
                                    ),
                                  ),
                                  Text(
                                    'x $quantity Plate${quantity > 1 ? 's' : ''}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '₹${item.price * quantity}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlack,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, size: 16),
                              color: AppColors.textGrey,
                              onPressed: () {
                                setState(() {
                                  selectedItems.remove(itemName);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          if (selectedItems.isNotEmpty) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    selectedItems.clear();
                  });
                },
                icon: const Icon(Icons.delete_outline, size: 16),
                label: const Text('Clear All Selection'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textGrey,
                ),
              ),
            ),
          ],
          const Divider(height: 1),
          // Subtotal
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal (per plate)',
                  style: TextStyle(fontSize: 14, color: AppColors.textGrey),
                ),
                Text(
                  '₹${getSubtotal().toInt()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryOrange,
                  ),
                ),
              ],
            ),
          ),
          // Next button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isLastCategory) {
                        // Navigate to Logistics screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LogisticsScreen(
                              eventType: widget.eventType,
                              selectedMenuItems: selectedItems,
                            ),
                          ),
                        );
                      } else {
                        // Move to next category
                        setState(() {
                          currentCategoryIndex++;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryOrange,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.primaryOrange
                          .withOpacity(0.5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isLastCategory
                              ? (l10n?.nextLogistics ?? 'Next: Logistics')
                              : 'Next: ${categories[currentCategoryIndex + 1]}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, size: 16),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      if (currentCategoryIndex > 0) {
                        // Go to previous category
                        setState(() {
                          currentCategoryIndex--;
                        });
                      } else {
                        // On first category, go back to event selection
                        Navigator.pop(context);
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textBlack,
                      side: BorderSide(color: Colors.grey.shade300),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.arrow_back, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          currentCategoryIndex > 0
                              ? 'Back: ${categories[currentCategoryIndex - 1]}'
                              : (l10n?.goBack ?? 'Go Back'),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, AppLocalizations? l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      color: Colors.white,
      child: Center(
        child: Text(
          l10n?.menuFooter ??
              '© 2024 Digha Catering Services. Serving traditional Bengali flavors with modern elegance.',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textGrey.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final String name;
  final String description;
  final double price;
  final String image;
  final bool isVeg;

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.isVeg,
  });
}
