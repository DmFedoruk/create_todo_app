import 'package:create_todo_app/scoped_models/scoped_search.dart';
import 'package:create_todo_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/task.dart';
import '../../styles/text_string.dart';
import '../widgets/check_box.dart';
import '../widgets/list_item.dart';
import '../widgets/title.dart';
import '../widgets/type_of_task.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScopedSearch searchManager = ScopedSearch();
    searchManager.calculateCountOfTask();
    return ScopedModel(
      model: searchManager,
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(4.0),
                  child: Container(
                    color: Styles.extraLightGrey,
                    height: 1.0,
                  )),
              leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/icons/arrow_back.png',
                    height: Styles.backButtonSize,
                  )),
              title: TextField(
                controller: searchManager.textController,
                cursorColor: Styles.textColor,
                onChanged: (value) {
                  searchManager.searchTasks();
                },
                decoration: InputDecoration.collapsed(
                    focusColor: Colors.white,
                    hintText: TextString.search,
                    hintStyle: Styles.textFieldHintStyle),
              )),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Column(
                children: [
                  SizedBox(height: 12.0.h),
                  _listOfItems(context, TextString.tasks, true),
                  SizedBox(height: 16.0.h),
                  _listOfItems(context, TextString.list, false)
                ],
              ),
            ),
          )),
    );
  }

  Widget _listOfItems(BuildContext context, String title, bool isTasks) {
    return ScopedModelDescendant<ScopedSearch>(
        builder: (context, child, model) {
      return isTasks
          ? SizedBox(
              height: model.tasksToShow.isNotEmpty
                  ? model.tasksToShow.length * Styles.taskHeight +
                      Styles.searchScreenTitle
                  : 0,
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: Styles.searchScreenTitle,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 4.0.h),
                      child: Text(title, style: Styles.searchScreenTaskTitle)),
                  Expanded(
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: model.tasksToShow.length,
                          itemBuilder: (context, index) =>
                              _taskItem(model.tasksToShow[index]))),
                ],
              ),
            )
          : SizedBox(
              height: Styles.taskTypes.length * Styles.taskHeight +
                  Styles.searchScreenTitle,
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: Styles.searchScreenTitle,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 4.0.h),
                      child: Text(title, style: Styles.searchScreenTaskTitle)),
                  Expanded(
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: Styles.taskTypes.length,
                          itemBuilder: (context, index) => listItem(
                              Styles.taskTypes[index],
                              model.countOfTasks[index]))),
                ],
              ),
            );
    });
  }

  Widget _taskItem(Task task) => ScopedModelDescendant<ScopedSearch>(
        builder: (context, child, model) => GestureDetector(
          onTap: () {
            model.completeTask(task);
          },
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border.symmetric(
                    horizontal:
                        BorderSide(color: Styles.extraLightGrey, width: 1.0))),
            height: Styles.taskHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      checkBox(task.isCompleted),
                      title(task.text),
                    ],
                  ),
                ),
                typeOfTask(task.taskType)
              ],
            ),
          ),
        ),
      );
}
