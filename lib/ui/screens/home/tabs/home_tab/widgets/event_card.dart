import 'package:evently_app/database/UsersDao.dart';
import 'package:evently_app/database/model/event.dart';
import 'package:evently_app/extensions/context_extension.dart';
import 'package:evently_app/extensions/date_time_extensions.dart';
import 'package:evently_app/routes.dart';
import 'package:evently_app/ui/providers/AppAuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EventCard extends StatefulWidget {
  final Event event;
  const EventCard(this.event, {super.key});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.EventDetailsScreen.name,
          arguments: widget.event,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        height: size.height * .25,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.appColors.primary, width: 1),
          image: DecorationImage(
            image: AssetImage(widget.event.getCategoryImage()),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      '${widget.event.date?.day}',
                      style: context.fonts.bodyMedium?.copyWith(
                        fontFamily: GoogleFonts.inter().fontFamily,
                        color: context.appColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.event.date?.formatMonth() ?? "",
                      style: context.fonts.bodyMedium?.copyWith(
                        fontFamily: GoogleFonts.inter().fontFamily,
                        color: context.appColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 8,
              right: 8,
              bottom: 8,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.event.title ?? "",
                      style: context.fonts.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontSize: 14,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        toggleFavorite(widget.event);
                      },
                      child: Icon(
                        widget.event.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toggleFavorite(Event event) async {
    AppAuthProvider provider = Provider.of<AppAuthProvider>(
      context,
      listen: false,
    );
    var user = provider.getUser();
    var isFavorite = provider.isFavorite(event);
    if (isFavorite) {
      user = await UsersDao.removeEventFromFavorites(
        provider.getUser()!,
        event.id,
      );
    } else {
      user = await UsersDao.addEventToFavorites(provider.getUser()!, event.id);
    }
    provider.updateFavorites(user.favorites);
    setState(() {
      widget.event.isFavorite = !isFavorite;
    });
  }
}
