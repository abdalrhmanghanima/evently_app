import 'package:evently_app/database/EventsDao.dart';
import 'package:evently_app/database/model/Category.dart';
import 'package:evently_app/database/model/event.dart';
import 'package:evently_app/extensions/context_extension.dart';
import 'package:evently_app/extensions/date_time_extensions.dart';
import 'package:evently_app/routes.dart';
import 'package:evently_app/ui/common/CutomFormField.dart';
import 'package:evently_app/ui/common/events_tabs.dart';
import 'package:evently_app/ui/providers/AppAuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditEventScreen extends StatefulWidget {
  final Event eventToEdit;

  const EditEventScreen({super.key, required this.eventToEdit});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  int selectedTabIndex = 0;
  List<Category> allCategories = Category.getCategories(includeAll: false);
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.eventToEdit.title ?? '';
    descriptionController.text = widget.eventToEdit.desc ?? '';
    selectedDate = widget.eventToEdit.date;
    if (widget.eventToEdit.time != null) {
      selectedTime = TimeOfDay.fromDateTime(widget.eventToEdit.time!);
    }
    selectedTabIndex = allCategories.indexWhere(
          (cat) => cat.id == widget.eventToEdit.categoryId,
    );
    if (selectedTabIndex == -1) selectedTabIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Event')),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleChildScrollView(
                child: Column(
                  spacing: 16,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image(
                        image: AssetImage(
                          Category.getCategoryImage(
                            allCategories[selectedTabIndex].id,
                          ),
                        ),
                      ),
                    ),
                    EventsTabs(
                      allCategories,
                      reversed: true,
                      selectedTabIndex,
                          (index, category) {
                        setState(() {
                          selectedTabIndex = index;
                        });
                      },
                    ),
                    AppFormField(
                      controller: titleController,
                      label: "",
                      icon: Icons.edit,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "please enter title";
                        }
                      },
                    ),
                    AppFormField(
                      controller: descriptionController,
                      label: "",
                      lines: 5,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "please enter description";
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.date_range_outlined),
                            Text(
                              "Event Date",
                              style: context.fonts.bodyMedium?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            chooseDate();
                          },
                          child: Text(
                            selectedDate == null
                                ? "Choose Date"
                                : selectedDate?.format() ?? "",
                            style: context.fonts.bodyMedium?.copyWith(
                              color: context.appColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.timer_outlined),
                            Text(
                              "Event time",
                              style: context.fonts.bodyMedium?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            chooseTime();
                          },
                          child: Text(
                            selectedTime == null
                                ? "Choose time"
                                : selectedTime?.format(context) ?? "",
                            style: context.fonts.bodyMedium?.copyWith(
                              color: context.appColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  updateEvent();
                },
                child: Text("Update Event"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    var date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 60)),
    );
    setState(() {
      selectedDate = date;
    });
  }

  void chooseTime() async {
    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() {
      selectedTime = time;
    });
  }

  bool isValidData() {
    var isValid = formKey.currentState?.validate() ?? false;
    if (selectedDate == null) {
      context.showMessageDialog("please Choose Event Date");
      isValid = false;
    } else if (selectedTime == null) {
      context.showMessageDialog("please Choose Event time");
      isValid = false;
    }
    return isValid;
  }

  void updateEvent() async {
    if (!isValidData()) {
      return;
    }
    context.showLoadingDialog(
      message: "Updating Event ...",
      isDismissible: false,
    );
    var updatedEvent = widget.eventToEdit;
    updatedEvent.title = titleController.text;
    updatedEvent.desc = descriptionController.text;
    updatedEvent.date = selectedDate;
    updatedEvent.time = selectedTime?.toDateTime();
    updatedEvent.categoryId = allCategories[selectedTabIndex].id;
    try {
      await EventsDao.updateEvent(updatedEvent);
      Navigator.pop(context);
      context.showMessageDialog(
        "Event updated successfully",
        posActionText: "OK",
        onPosActionClick: () {
          Navigator.popUntil(
            context,
            ModalRoute.withName(AppRoutes.HomeScreen.name),
          );
        },
        isDismissible: false,
      );
    } catch (e) {
      Navigator.pop(context);
      context.showMessageDialog("Error updating event: $e");
    }
  }

}
