import 'package:flt_keep/resources/app_colors.dart';
import 'package:flt_keep/widget/list_view_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../icons.dart';
import '../styles.dart';

class ItemAddScreen extends StatefulWidget {
  @override
  _ItemAddScreenState createState() => _ItemAddScreenState();
}

class _ItemAddScreenState extends State<ItemAddScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> alphabetList = [
    'A',
    'B',
  ];

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 1,
        ),
        bottomNavigationBar: _buildBottomAppBar(context),
        body: ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 720),
          child: ReorderableListView(
            onReorder: _onReorder,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            children: List.generate(
              alphabetList.length,
              (index) {
                return ListViewCard(
                  alphabetList,
                  index,
                  Key('$index'),
                );
              },
            ),
          ),
        ),
      ));

  void _onReorder(int oldIndex, int newIndex) {
    setState(
      () {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final String item = alphabetList.removeAt(oldIndex);
        alphabetList.insert(newIndex, item);
      },
    );
  }

  Widget _buildBottomAppBar(BuildContext context) => BottomAppBar(
        child: Container(
          height: kBottomBarSize,
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.add_box),
                color: kIconTintLight,
                onPressed: () => {formBottomSheetMenu()},
              ),
            ],
          ),
        ),
      );

  var myFocusNode = FocusNode();

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  formBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: SingleChildScrollView(
                      child: FormBuilder(
                        key: _fbKey,
                        autovalidate: false,
                        child: Column(
                          children: <Widget>[
                            FormBuilderTextField(
                              attribute: "item_name",
                              autofocus: true,
                              style: TextStyle(fontSize: 32),
                              decoration: InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none),
                              validators: [
                                FormBuilderValidators.required(),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: FloatingActionButton(
                                highlightElevation: 0,
                                focusElevation: 0,
                                mini: true,
                                elevation: 0,
                                heroTag: null,
                                onPressed: () {},
                                child: Icon(Icons.send),
                              ),
                            )
                          ],
                        ),
//                        child: Row(
//                          children: <Widget>[
//                            Expanded(
//                              flex: 6,
//                              child: FormBuilderTextField(
//                                autofocus: true,
//                                attribute: "item_name",
//                                decoration: InputDecoration(
//                                    labelText: "Item name",
//                                    enabledBorder: InputBorder.none),
//                                validators: [FormBuilderValidators.required()],
//                              ),
//                            ),
//                            SizedBox(
//                              width: 16,
//                            ),
//                            Expanded(
//                              flex: 2,
//                              child: FormBuilderTextField(
//                                attribute: "item_name",
//                                decoration: InputDecoration(
//                                    labelText: "Quantity",
//                                    enabledBorder: InputBorder.none),
//                                validators: [FormBuilderValidators.required()],
//                              ),
//                            ),
//                            SizedBox(
//                              width: 16,
//                            ),
//                            Expanded(
//                              flex: 3,
//                              child: OutlineButton.icon(
//                                icon: Icon(Icons.add),
//                                label: Text("Add"),
//                                onPressed: () {},
//                              ),
//                            )
//                          ],
//                        ),
                      ),
                    ),
                  )));
        });
  }

  _appbar() {
    return SliverAppBar(
      floating: true,
      snap: true,
      title: Text(""),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        tooltip: 'Menu',
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      automaticallyImplyLeading: false,
    );
  }
}
