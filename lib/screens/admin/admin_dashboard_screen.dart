import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../utils/app_colors.dart';
import '../../controllers/admin_dashboard_controller.dart';
import '../../controllers/booking_controller.dart';
import 'admin_bookings_screen.dart';
import 'admin_menu_screen.dart';
import 'admin_login_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(AdminDashboardController());
    final bookingController = Get.put(BookingController());
    bookingController.initAdmin();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return Row(
              children: [
                _buildSidebar(context, controller),
                Expanded(child: Obx(() => _getPage(controller.selectedIndex))),
              ],
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Admin Dashboard'),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              drawer: Drawer(
                child: _buildSidebar(context, controller, isInDrawer: true),
              ),
              body: Obx(() => _getPage(controller.selectedIndex)),
            );
          }
        },
      ),
    );
  }

  Widget _getPage(int index) {
    final pages = [
      const _DashboardContent(),
      const AdminBookingsScreen(),
      const AdminMenuScreen(),
      const Center(child: Text("Customers Page Placeholder")),
      const Center(child: Text("Settings Page Placeholder")),
    ];
    return pages[index];
  }

  Widget _buildSidebar(
    BuildContext context,
    AdminDashboardController controller, {
    bool isInDrawer = false,
  }) {
    return Material(
      color: Colors.white,
      child: SizedBox(
        width: 260,
        child: Column(
          children: [
            _buildSidebarHeader(),
            const SizedBox(height: 20),
            _buildSidebarItem(
              0,
              Icons.dashboard_outlined,
              'Dashboard',
              controller,
              context,
              isInDrawer,
            ),
            _buildSidebarItem(
              1,
              Icons.calendar_today_outlined,
              'Bookings',
              controller,
              context,
              isInDrawer,
            ),
            _buildSidebarItem(
              2,
              Icons.restaurant_menu,
              'Menu Management',
              controller,
              context,
              isInDrawer,
            ),
            _buildSidebarItem(
              3,
              Icons.people_outline,
              'Customers',
              controller,
              context,
              isInDrawer,
            ),
            _buildSidebarItem(
              4,
              Icons.settings_outlined,
              'Settings',
              controller,
              context,
              isInDrawer,
            ),
            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () => Get.offAll(() => const AdminLoginScreen()),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarHeader() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primaryOrange.withOpacity(0.1),
            child: const Icon(Icons.restaurant, color: AppColors.primaryOrange),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Abhoy Catering',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                'Admin Panel',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(
    int index,
    IconData icon,
    String title,
    AdminDashboardController controller,
    BuildContext context,
    bool isInDrawer,
  ) {
    return Obx(() {
      final bool isSelected = controller.selectedIndex == index;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Material(
          color: isSelected ? const Color(0xFFFFF0E0) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: () {
              controller.selectPage(index);
              // Only close drawer if we're actually in a drawer
              if (isInDrawer) {
                Navigator.of(context).pop();
              }
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: isSelected
                    ? const Border(
                        left: BorderSide(
                          color: AppColors.primaryOrange,
                          width: 4,
                        ),
                      )
                    : null,
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: isSelected
                        ? AppColors.primaryOrange
                        : Colors.grey[700],
                    size: 24,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.primaryOrange
                          : Colors.grey[800],
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context) {
    final bookingController = Get.find<BookingController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopBar(),
          const SizedBox(height: 32),
          _buildStatsRow(bookingController),
          const SizedBox(height: 40),
          _buildRecentBookingsHeader(),
          const SizedBox(height: 16),
          _buildBookingList(bookingController),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dashboard Overview',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Welcome back, admin. Here\'s what\'s happening today in Digha.',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                'Last updated: ${DateFormat('MMM dd, yyyy at hh:mm a').format(DateTime.now())}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(BookingController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        // Simple responsive logic for cards
        int crossAxisCount = width > 1100 ? 3 : (width > 700 ? 2 : 1);

        List<Widget> cards = [
          Obx(
            () => _buildStatCard(
              'Pending Bookings',
              '${controller.allBookings.where((b) => b.status == 'pending').length}',
              'Requesting attention',
              Icons.pending_actions,
              Colors.orange,
              isPositive: true,
            ),
          ),
          Obx(
            () => _buildStatCard(
              'Confirmed Today',
              '${controller.allBookings.where((b) => b.status == 'confirmed' && isSameDay(b.createdAt, DateTime.now())).length}',
              'New confirmations',
              Icons.check_circle,
              Colors.green,
              isPositive: true,
            ),
          ),
          Obx(
            () => _buildStatCard(
              'Total Bookings', // Total Revenue requires pricing logic
              '${controller.allBookings.length}',
              'All time',
              Icons.book_online,
              Colors.blue,
              isPositive: true,
            ),
          ),
        ];

        if (width <= 700) {
          return Column(
            children: cards
                .map(
                  (c) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: c,
                  ),
                )
                .toList(),
          );
        }

        return Row(
          children: cards
              .map(
                (c) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: c,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color, {
    bool isPositive = true,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: subtitle.split(' ').first + ' ',
                  style: TextStyle(
                    color: isPositive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                TextSpan(
                  text: subtitle.split(' ').skip(1).join(' '),
                  style: TextStyle(color: Colors.grey[500], fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentBookingsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Recent Booking Requests',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'View All Bookings',
            style: TextStyle(color: AppColors.primaryOrange),
          ),
        ),
      ],
    );
  }

  Widget _buildBookingList(BookingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildBookingHeaderFull(),
          Obx(() {
            if (controller.allBookings.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: Text("No bookings yet"),
              );
            }
            // Sort by Date descending and take 5
            final recent = List.of(controller.allBookings)
              ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
            return Column(
              children: recent.take(5).map((booking) {
                Color statusColor = Colors.grey;
                if (booking.status == 'confirmed')
                  statusColor = Colors.green;
                else if (booking.status == 'pending')
                  statusColor = Colors.orange;
                else if (booking.status == 'cancelled')
                  statusColor = Colors.red;
                else if (booking.status == 'completed')
                  statusColor = Colors.blue;

                return BookingRow(
                  eventType: booking.eventType,
                  customerName: booking.customerName ?? 'Unknown',
                  initials: (booking.customerName?.isNotEmpty ?? false)
                      ? booking.customerName![0]
                      : '?',
                  date: DateFormat('dd MMM yyyy').format(booking.eventDate),
                  status: booking.status,
                  statusColor: statusColor,
                  showApprove: booking.status == 'pending',
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Widget _buildBookingHeaderFull() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(flex: 2, child: _headerText('EVENT TYPE')),
          Expanded(flex: 3, child: _headerText('CUSTOMER NAME')),
          Expanded(flex: 2, child: _headerText('DATE')),
          Expanded(flex: 2, child: _headerText('STATUS')),
          Expanded(
            flex: 2,
            child: _headerText('ACTIONS', align: TextAlign.end),
          ),
        ],
      ),
    );
  }

  Widget _headerText(String text, {TextAlign align = TextAlign.start}) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.grey[500],
        letterSpacing: 0.5,
      ),
    );
  }
}

class BookingRow extends StatelessWidget {
  final String eventType;
  final String customerName;
  final String initials;
  final String date;
  final String status;
  final Color statusColor;
  final bool showApprove;
  final Color initialsColor;
  final String? actionText;

  const BookingRow({
    super.key,
    required this.eventType,
    required this.customerName,
    required this.initials,
    required this.date,
    required this.status,
    required this.statusColor,
    this.showApprove = false,
    this.initialsColor = Colors.orange,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[100]!)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(eventType, style: TextStyle(color: Colors.grey[700])),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: initialsColor.withOpacity(0.1),
                  child: Text(
                    initials,
                    style: TextStyle(
                      color: initialsColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  customerName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(date, style: TextStyle(color: Colors.grey[700])),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (showApprove)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOrange,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        minimumSize: const Size(0, 32),
                      ),
                      child: const Text(
                        'Approve',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: const Size(0, 32),
                  ),
                  child: Text(
                    actionText ?? (showApprove ? 'VIEW' : 'VIEW DETAILS'),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
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
}
