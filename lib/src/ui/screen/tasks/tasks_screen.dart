import 'package:flutter/material.dart';
import 'package:flutter_task_app/src/assets/styles/app_widget_size.dart';
import 'package:flutter_task_app/src/assets/theme/app_colors.dart';
import 'package:flutter_task_app/src/constants/app_constants.dart';
import 'package:flutter_task_app/src/constants/app_text_constants.dart';
import 'package:flutter_task_app/src/models/common/FloatingButtonModel.dart';
import 'package:flutter_task_app/src/ui/widgets/common_appbar_widget.dart';
import 'package:flutter_task_app/src/ui/widgets/common_body_widget.dart';

class TasksScreen extends StatefulWidget {
  TasksScreen({Key key}) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  GlobalKey _positionCardKey = GlobalKey();
  bool isToggleEnabled = false;
  List<FloatingButton> buttonList = FloatingButtonModel.fromJson({
    'floatingButton': [
      {
        'label': AppTextConstants.TEXT_GUEST,
        'icon': Icons.chat_bubble_outline_rounded
      },
      {'label': AppTextConstants.CALL_GUEST, 'icon': Icons.call},
      {'label': AppTextConstants.EMAIL_GUEST, 'icon': Icons.mail},
      {'label': AppTextConstants.LOGIN_PERSON, 'icon': Icons.person},
      {'label': AppTextConstants.CLOSE, 'icon': Icons.close}
    ]
  }).floatingButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      drawer: Container(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return commonAppbarWidget(
      AppTextConstants.TASKS,
      '0',
      callback,
      context,
    );
  }

  void callback(String type) {}

  Widget _buildBody(BuildContext context) {
    return commonBodyWidget(
      _buildListBody(),
      context,
    );
  }

  Widget _buildListBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSortSection(),
        ..._buildListSection(),
      ],
    );
  }

  Padding _buildSortSection() {
    return Padding(
      padding: EdgeInsets.only(
        top: AppWidgetSize.dimen_10,
        bottom: AppWidgetSize.dimen_10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                AppTextConstants.OPEN,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: AppColors.MEDIUM_INDICATION_COLOR),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: AppWidgetSize.dimen_20,
                ),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.MEDIUM_INDICATION_COLOR,
                  size: AppWidgetSize.dimen_20,
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.sort_by_alpha,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  List<Widget> _buildListSection() {
    return [
      Text(
        AppTextConstants.REAL_TIME_TASKS,
        style: Theme.of(context).textTheme.headline5,
      ),
      Expanded(
        child: SingleChildScrollView(
            child: Column(
          children: [
            _buildMainCard(),
            _buildMainCard(),
          ],
        )),
      )
    ];
  }

  Stack _buildMainCard() {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: AppWidgetSize.dimen_24),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppWidgetSize.dimen_10),
            ),
            margin: EdgeInsets.only(top: AppWidgetSize.dimen_16),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppWidgetSize.dimen_16,
                AppWidgetSize.dimen_5,
                AppWidgetSize.dimen_5,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 30,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Greet Task',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              'Urgent Priority',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    height: 1.6,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: floatingMenuPressed,
                        child: Icon(
                          Icons.check_circle,
                          color: AppColors.SUCCESS_COLOR,
                          size: AppWidgetSize.dimen_50,
                        ),
                      ),
                    ],
                  ),
                  if (!isToggleEnabled)
                    GestureDetector(
                      onTap: toggleButtonPressed,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: AppWidgetSize.dimen_24,
                      ),
                    ),
                  if (isToggleEnabled) _buildCollapseView()
                ],
              ),
            ),
          ),
        ),
        _buildIndicatorCard()
      ],
    );
  }

  void floatingMenuPressed() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(
            buttonList.length,
            (int index) {
              FloatingButton item = buttonList[index];
              final bool isLast = buttonList.length - 1 == index;
              return GestureDetector(
                onTap: () {
                  if (isLast) {
                    Navigator.of(context).pop();
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: AppWidgetSize.dimen_20),
                  child: Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        item.label,
                        style: Theme.of(context).primaryTextTheme.headline5,
                      ),
                      Container(
                        width: isLast
                            ? AppWidgetSize.dimen_70
                            : AppWidgetSize.dimen_50,
                        height: AppWidgetSize.dimen_50,
                        padding: EdgeInsets.only(
                            left: isLast ? AppWidgetSize.dimen_10 : 0),
                        margin: EdgeInsets.only(
                          left: AppWidgetSize.dimen_10,
                          right: isLast ? 0 : AppWidgetSize.dimen_20,
                        ),
                        alignment:
                            isLast ? Alignment.centerLeft : Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.MEDIUM_INDICATION_COLOR,
                          borderRadius: isLast
                              ? BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(AppWidgetSize.dimen_10),
                                  topLeft: Radius.circular(
                                    AppWidgetSize.dimen_10,
                                  ),
                                )
                              : BorderRadius.circular(
                                  AppWidgetSize.dimen_50 / 2),
                        ),
                        child: Icon(item.icon,
                            color: Theme.of(context).primaryIconTheme.color,
                            size: AppWidgetSize.dimen_30),
                      ),
                    ],
                  ),
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }

  void toggleButtonPressed() {
    setState(() {
      isToggleEnabled = true;
    });
  }

  Positioned _buildIndicatorCard() {
    final TextStyle textstyle =
        Theme.of(context).primaryTextTheme.headline2.copyWith(height: 1.7);
    return Positioned(
      top: AppWidgetSize.dimen_16,
      // left: -AppWidgetSize.dimen_16,
      child: Card(
        color: AppColors.MEDIUM_INDICATION_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppWidgetSize.dimen_10),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppWidgetSize.dimen_10,
            AppWidgetSize.dimen_5,
            AppWidgetSize.dimen_10,
            AppWidgetSize.dimen_5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'uncarded',
                style: textstyle,
              ),
              Text(
                AppTextConstants.LOC + 'xxxxxx',
                style: textstyle,
              ),
              Text(
                AppTextConstants.PLAY_TIME + '12 min',
                style: textstyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildCollapseView() {
    final TextStyle labeTextStyle =
        Theme.of(context).accentTextTheme.headline3.copyWith(height: 1.6);
    final TextStyle textStyle =
        Theme.of(context).textTheme.headline3.copyWith(height: 1.6);
    return Padding(
      padding: EdgeInsets.only(
          top: AppWidgetSize.dimen_24, bottom: AppWidgetSize.dimen_5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTextConstants.INFO,
                style: labeTextStyle,
              ),
              Expanded(
                child: Text(
                  'The tasks page must have the ability to grow based on the API response',
                  style: textStyle,
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTextConstants.CREATER,
                style: labeTextStyle,
              ),
              Expanded(
                child: Text(
                  'The tasks',
                  style: textStyle,
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTextConstants.CREATED_ON,
                style: labeTextStyle,
              ),
              Expanded(
                child: Text(
                  'The tasks ',
                  style: textStyle,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: AppWidgetSize.dimen_5),
            child: GestureDetector(
              onTap: collapseButtonPressed,
              child: Icon(
                Icons.keyboard_arrow_up,
                size: AppWidgetSize.dimen_24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void collapseButtonPressed() {
    setState(() {
      isToggleEnabled = false;
    });
  }
}
