import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_manager_app/model/profile.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';
import 'package:restaurant_manager_app/ui/blocs/invoice/invoice_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/profile/profile_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/home/home_menu.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';
import 'package:restaurant_manager_app/ui/widgets/form_profile.dart';
import 'package:restaurant_manager_app/ui/widgets/item_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    this.constraints,
  });
  final BoxConstraints? constraints;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controllerSearch = TextEditingController(text: "");
  final outerController = ScrollController();
  final innerController = ScrollController();
  late ProfileBloc profileBloc;
  late InvoiceBloc invoiceBloc;

  @override
  void initState() {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    invoiceBloc = BlocProvider.of<InvoiceBloc>(context);
    MySharePreferences.loadProfile().then((value) {
      print("GET BY ID ${value?.id}");
      profileBloc.add(GetProfileEvent(id: value?.id ?? 0));
      invoiceBloc.add(GetInvoiceByIdUserEvent(userID: value?.id ?? 0, keysearch: ''));
    });
    super.initState();
  }

  @override
  void dispose() {
    controllerSearch.dispose();
    super.dispose();
  }

  @override
  Scaffold build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: colorScheme(context).onPrimary,
        titleSpacing: checkDevice(size.width, -5.0, 20.0, 20.0),
        leading: checkDevice(
            widget.constraints?.maxWidth ?? 0,
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeMenuScreen(),
                    ),
                    (route) => false);
              },
            ),
            null,
            null),
        title: Text(
          'THÔNG TIN CÁ NHÂN',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        actions: [
          checkDevice(
            size.width,
            Container(),
            SizedBox(
              width: 300,
              height: 40.0,
              child: TextField(
                controller: controllerSearch,
                onChanged: (value) {
                  setState(() {
                    controllerSearch.text = value;
                    if (controllerSearch.text.isNotEmpty &&
                        !RegExp(r'^\s*$').hasMatch(controllerSearch.text)) {
                      MySharePreferences.loadProfile().then((value) {
                        invoiceBloc.add(GetInvoiceByIdUserEvent(
                            userID: value?.id ?? 0,
                            keysearch: controllerSearch.text));
                      });
                    }
                  });
                },
                style: TextStyle(color: colorScheme(context).outline),
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      colorScheme(context).outlineVariant.withOpacity(0.5),
                  prefixIcon: Icon(
                    Icons.search,
                    color: colorScheme(context).outline,
                  ),
                  suffixIcon: controllerSearch.text.isEmpty
                      ? null
                      : TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStatePropertyAll(
                                colorScheme(context).tertiary),
                            padding:
                                const MaterialStatePropertyAll(EdgeInsets.zero),
                            minimumSize:
                                const MaterialStatePropertyAll(Size.zero),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: const MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                            ),
                          ),
                          child: Icon(
                            Icons.clear_rounded,
                            color: colorScheme(context).outline,
                            size: 20.0,
                          ),
                          onPressed: () {
                            setState(() {
                              controllerSearch.clear();
                            });
                          },
                        ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 13,
                      color: colorScheme(context).outline,
                      fontWeight: FontWeight.bold),
                  hintText: 'Tìm kiếm...',
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 5.0),
                ),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: 300,
              height: 40.0,
              child: TextField(
                controller: controllerSearch,
                onChanged: (value) {
                  setState(() {
                    MySharePreferences.loadProfile().then((value) {
                      invoiceBloc.add(GetInvoiceByIdUserEvent(
                          userID: value?.id ?? 0,
                          keysearch: controllerSearch.text));
                    });
                  });
                },
                style: TextStyle(color: colorScheme(context).outline),
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      colorScheme(context).outlineVariant.withOpacity(0.5),
                  prefixIcon: Icon(
                    Icons.search,
                    color: colorScheme(context).outline,
                  ),
                  suffixIcon: controllerSearch.text.isEmpty
                      ? null
                      : TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStatePropertyAll(
                                colorScheme(context).tertiary),
                            padding:
                                const MaterialStatePropertyAll(EdgeInsets.zero),
                            minimumSize:
                                const MaterialStatePropertyAll(Size.zero),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: const MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                            ),
                          ),
                          child: Icon(
                            Icons.clear_rounded,
                            color: colorScheme(context).outline,
                            size: 20.0,
                          ),
                          onPressed: () {
                            setState(() {
                              controllerSearch.clear();
                              MySharePreferences.loadProfile().then((value) {
                                invoiceBloc.add(GetInvoiceByIdUserEvent(
                                    userID: value?.id ?? 0, keysearch: ' '));
                              });
                            });
                          },
                        ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 13,
                      color: colorScheme(context).outline,
                      fontWeight: FontWeight.bold),
                  hintText: 'Tìm kiếm...',
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 5.0),
                ),
                onTap: () {},
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
            ),
            child: ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(20.0),
                child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                  if (state is GetProfileLoading) {
                    return const Center(
                      child: SizedBox(
                        width: 10,
                        height: 10,
                        child: AspectRatio(
                            aspectRatio: 1, child: CircularProgressIndicator()),
                      ),
                    );
                  } else if ((state.profile?.imgUrl ?? "") != "") {
                    return Image.network(state.profile?.imgUrl ?? "",
                        fit: BoxFit.cover);
                  } else {
                    return Image.asset('assets/images/avatar.jpg',
                        fit: BoxFit.cover);
                  }
                }),
              ),
            ),
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return Center(
                    child: checkDevice(
                  size.width * 0.6,
                  Center(
                    child: Column(children: [
                      FormProfile(),
                      const SizedBox(
                        width: 20,
                        height: 20,
                      ),
                      _ListBill(
                        size: size,
                        innerController: innerController,
                        outerController: outerController,
                        controllerSearch: controllerSearch,
                      ),
                    ]),
                  ),
                  Center(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FormProfile(),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _ListBill(
                              size: size,
                              innerController: innerController,
                              outerController: outerController,
                              controllerSearch: controllerSearch,
                            ),
                          )
                        ]),
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FormProfile(),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _ListBill(
                            size: size,
                            innerController: innerController,
                            outerController: outerController,
                            controllerSearch: controllerSearch,
                          ),
                        ),
                      ]),
                ));
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ListCard extends StatelessWidget {
  const _ListCard({
    super.key,
    required this.outerController,
    required this.innerController,
  });
  final ScrollController outerController;
  final ScrollController innerController;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      height: 150.0,
      child: ListView(
        controller: outerController,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Listener(
                  onPointerSignal: (event) {
                    if (event is PointerScrollEvent) {
                      final offset = event.scrollDelta.dy;
                      innerController.jumpTo(innerController.offset + offset);
                      outerController.jumpTo(outerController.offset - offset);
                    }
                  },
                  child: SingleChildScrollView(
                    controller: innerController,
                    padding: const EdgeInsets.only(bottom: 15.0),
                    scrollDirection: Axis.horizontal,
                    child: const Row(children: [
                      ItemCard(
                        fistColor: Color.fromRGBO(236, 246, 255, 1),
                        secondColor: Color.fromRGBO(55, 163, 254, 1),
                        heights: [30.0, 20.0, 40.0, 80.0, 60.0],
                        titleCard: "Tất cả hóa đơn",
                        count: 28,
                        percent: 34.67,
                      ),
                      ItemCard(
                        fistColor: Color.fromRGBO(238, 234, 251, 1),
                        secondColor: Color.fromRGBO(131, 92, 237, 1),
                        heights: [40.0, 60.0, 30.0, 60.0, 10.0],
                        titleCard: "Tiền mặt",
                        count: 8,
                        percent: 12.45,
                      ),
                      ItemCard(
                        fistColor: Color.fromRGBO(254, 241, 233, 1),
                        secondColor: Color.fromRGBO(245, 106, 34, 1),
                        heights: [80.0, 30.0, 70.0, 20.0, 90.0],
                        titleCard: "Chuyển khoản",
                        count: 20,
                        percent: 86.32,
                      )
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ListBill extends StatelessWidget {
  const _ListBill({
    super.key,
    required this.size,
    required this.outerController,
    required this.innerController,
    required this.controllerSearch,
  });
  final Size size;
  final ScrollController outerController;
  final ScrollController innerController;
  final TextEditingController controllerSearch;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ListCard(
          innerController: innerController,
          outerController: outerController,
        ),
        const SizedBox(height: 15.0),
        DefaultTabController(
            length: 2,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: colorScheme(context).onPrimary,
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(227, 226, 235, 1),
                          width: 1.0,
                        ),
                      )),
                      child: Row(children: [
                        Expanded(
                          child: TabBar.secondary(
                            isScrollable: true,
                            tabs: const [
                              Tab(text: 'Danh sách hóa đơn'),
                              Tab(text: 'Khác'),
                            ],
                            labelColor: colorScheme(context).scrim,
                            dividerColor: Colors.transparent,
                            indicator: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: 300.0, maxHeight: 500),
                    child: TabBarView(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: BlocBuilder<InvoiceBloc, InvoiceState>(
                                  builder: (context, state) {
                                    if (state is InvoiceLoadingState) {
                                      return const Center(
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: AspectRatio(
                                              aspectRatio: 1,
                                              child:
                                                  CircularProgressIndicator()),
                                        ),
                                      );
                                    } else {
                                      return Column(
                                        children: [
                                          if (state.invoices.isNotEmpty) ...[
                                            ListView.separated(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: state.invoices.length,
                                              separatorBuilder: (_, __) =>
                                                  const Divider(),
                                              itemBuilder:
                                                  (context, int index) {
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "HD00${state.invoices[index].id}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: colorScheme(
                                                                              context)
                                                                          .scrim),
                                                            ),
                                                            Text(
                                                              '${state.invoices[index].tableName}',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall
                                                                  ?.copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      color: colorScheme(
                                                                              context)
                                                                          .outlineVariant),
                                                            ),
                                                            const SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          6,
                                                                      vertical:
                                                                          4),
                                                              color: Colors
                                                                  .greenAccent
                                                                  .withOpacity(
                                                                      0.1),
                                                              child: const Text(
                                                                "Hoành thành",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .green),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              "${NumberFormat("#,###.000", "en_US").format(state.invoices[index].total! * 0.001)} đ"
                                                                  .replaceAll(
                                                                      ',', '.'),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall
                                                                  ?.copyWith(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: colorScheme(
                                                                              context)
                                                                          .scrim),
                                                            ),
                                                            Text(
                                                              state
                                                                          .invoices[
                                                                              index]
                                                                          .createAt !=
                                                                      null
                                                                  ? DateFormat(
                                                                          "dd-MM-yyyy")
                                                                      .format(state
                                                                          .invoices[
                                                                              index]
                                                                          .createAt!)
                                                                  : "",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall
                                                                  ?.copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    color: colorScheme(
                                                                            context)
                                                                        .outlineVariant,
                                                                  ),
                                                            ),
                                                          ],
                                                        )
                                                      ]),
                                                );
                                              },
                                            ),
                                          ] else ...[
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 150),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/svgs/icon_empty_bill.svg',
                                                      width: 100,
                                                      height: 100,
                                                    ),
                                                    Text(
                                                      "Hiện tại không có hóa đơn nào !",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.copyWith(
                                                              fontSize: 15,
                                                              color: colorScheme(
                                                                      context)
                                                                  .outline),
                                                    ),
                                                  ]),
                                            )
                                          ]
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Center(
                          child: Text('Nội dung Tab 2'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
