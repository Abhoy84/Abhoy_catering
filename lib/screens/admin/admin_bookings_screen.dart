import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../controllers/booking_controller.dart';

import 'booking_detail_screen.dart';
import 'package:intl/intl.dart';

class AdminBookingsScreen extends StatefulWidget {
  const AdminBookingsScreen({super.key});

  @override
  State<AdminBookingsScreen> createState() => _AdminBookingsScreenState();
}

class _AdminBookingsScreenState extends State<AdminBookingsScreen> {
  final BookingController _bookingController = Get.put(BookingController());
  String _selectedFilter = 'All Bookings';

  @override
  void initState() {
    super.initState();
    _bookingController.initAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildFilterTabs(),
            const SizedBox(height: 24),
            _buildBookingsTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bookings',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A1A),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage all catering booking requests and confirmations.',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ],
        ),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.filter_list, size: 18),
              label: const Text('Filter'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey[700],
                side: BorderSide(color: Colors.grey[300]!),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download_outlined, size: 18),
              label: const Text('Export'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey[700],
                side: BorderSide(color: Colors.grey[300]!),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
      ),
      child: Obx(() {
        int all = _bookingController.allBookings.length;
        int pending = _bookingController.allBookings
            .where((b) => b.status == 'pending')
            .length;
        int confirmed = _bookingController.allBookings
            .where((b) => b.status == 'confirmed')
            .length;
        int completed = _bookingController.allBookings
            .where((b) => b.status == 'completed')
            .length;
        int cancelled = _bookingController.allBookings
            .where((b) => b.status == 'cancelled')
            .length;

        return Row(
          children: [
            _buildTab(
              'All Bookings',
              _selectedFilter == 'All Bookings',
              '$all',
            ),
            _buildTab('Pending', _selectedFilter == 'Pending', '$pending'),
            _buildTab(
              'Confirmed',
              _selectedFilter == 'Confirmed',
              '$confirmed',
            ),
            _buildTab(
              'Completed',
              _selectedFilter == 'Completed',
              '$completed',
            ),
            _buildTab(
              'Cancelled',
              _selectedFilter == 'Cancelled',
              '$cancelled',
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTab(String label, bool isSelected, String count) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
        _bookingController.filterBookings(label);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        margin: const EdgeInsets.only(right: 32),
        decoration: BoxDecoration(
          border: isSelected
              ? const Border(
                  bottom: BorderSide(color: AppColors.primaryOrange, width: 3),
                )
              : null,
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primaryOrange : Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryOrange.withOpacity(0.1)
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                count,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.primaryOrange
                      : Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingsTable() {
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
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          _buildTableHeader(),
          Obx(() {
            if (_bookingController.filteredBookings.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(40),
                child: Center(child: Text('No bookings found')),
              );
            }

            return Column(
              children: _bookingController.filteredBookings.map((booking) {
                Color statusColor = Colors.grey;
                if (booking.status == 'confirmed')
                  statusColor = Colors.green;
                else if (booking.status == 'pending')
                  statusColor = Colors.orange;
                else if (booking.status == 'cancelled')
                  statusColor = Colors.red;
                else if (booking.status == 'completed')
                  statusColor = Colors.blue;

                // Calculate total price if not stored (Using dummy calculation or property if existing)
                // Booking model has selectedMenuItems map<String, int>.
                // We might need to fetch menu items to calculate price, or store price in booking.
                // Assuming simple display for now.

                String formattedDate = DateFormat(
                  'MMM dd, yyyy',
                ).format(booking.eventDate);

                return _buildBookingRow(
                  id: booking.id.substring(0, 8), // Short ID
                  customer: booking.customerName ?? 'Unknown',
                  initials: (booking.customerName?.isNotEmpty ?? false)
                      ? booking.customerName![0]
                      : '?',
                  eventType: booking.eventType,
                  date: formattedDate,
                  guests: booking.guestCount.toString(),
                  amount:
                      'View', // Placeholder as price calculation might be complex
                  status: booking.status,
                  statusColor: statusColor,
                  fullId: booking.id,
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(flex: 1, child: _headerText('BOOKING ID')),
          Expanded(flex: 2, child: _headerText('CUSTOMER')),
          Expanded(flex: 2, child: _headerText('EVENT TYPE')),
          Expanded(flex: 2, child: _headerText('DATE')),
          Expanded(flex: 1, child: _headerText('GUESTS')),
          Expanded(flex: 2, child: _headerText('AMOUNT')),
          Expanded(flex: 2, child: _headerText('STATUS')),
          Expanded(
            flex: 1,
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
        color: Colors.grey[600],
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildBookingRow({
    required String id,
    required String customer,
    required String initials,
    required String eventType,
    required String date,
    required String guests,
    required String amount,
    required String status,
    required Color statusColor,
    required String fullId,
  }) {
    return InkWell(
      onTap: () {
        Get.to(() => BookingDetailScreen(bookingId: fullId));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey[100]!)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                '#$id',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryOrange,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.primaryOrange.withOpacity(0.1),
                    child: Text(
                      initials,
                      style: const TextStyle(
                        color: AppColors.primaryOrange,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      customer,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                eventType,
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                date,
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                guests,
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, size: 20),
                    onPressed: () {
                      Get.to(() => BookingDetailScreen(bookingId: fullId));
                    },
                    color: AppColors.primaryOrange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
