import 'package:evently_app/database/EventsDao.dart';
import 'package:evently_app/database/model/event.dart';
import 'package:evently_app/extensions/context_extension.dart';
import 'package:evently_app/routes.dart';
import 'package:evently_app/ui/design/design.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatefulWidget {
  final Event event;
  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.lightPrimary),
        ),
        title: Text(
          "Event Details",
          style: context.fonts.titleLarge?.copyWith(
            color: AppColors.lightPrimary,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.EditEventScreen.name,
                arguments: widget.event,
              );
            },
            icon: Icon(Icons.edit, color: AppColors.lightPrimary),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              bool? confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Delete Event"),
                  content: const Text("Are you sure you want to delete this event?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text("Delete", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                await EventsDao.deleteEvent(widget.event.id!);
                if (mounted) {
                  Navigator.pop(context);
                }
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 210,
                width: 375,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: context.appColors.primary, width: 1),
                  image: DecorationImage(
                    image: AssetImage(widget.event.getCategoryImage()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${widget.event.title}',
              style: context.fonts.titleLarge?.copyWith(
                color: AppColors.lightPrimary,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: 360,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.lightPrimary, width: 2),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Container(
                    height: 48,
                    padding: const EdgeInsets.all(12),
                    child: const Icon(Icons.date_range, color: Colors.white),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.lightPrimary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('yyyy-MM-dd').format(widget.event.date!),
                        style: const TextStyle(
                          height: 2,
                          fontSize: 17,
                          color: AppColors.lightPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        DateFormat('hh:mm a').format(widget.event.time!),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: 360,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.lightPrimary, width: 2),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Container(
                    height: 48,
                    padding: const EdgeInsets.all(12),
                    child: const Icon(Icons.gps_fixed, color: Colors.white),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.lightPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Description",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${widget.event.desc}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
