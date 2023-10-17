import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_manager_app/model/bill_history.dart' as Model;
import 'package:restaurant_manager_app/model/profile.dart';
import 'package:restaurant_manager_app/ui/blocs/auth/authentication_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/bill/history_bill_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';
import 'package:restaurant_manager_app/ui/widgets/form_profile.dart';
import 'package:restaurant_manager_app/ui/widgets/item_card.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button_gradient.dart';
import 'package:restaurant_manager_app/ui/widgets/my_outline_button.dart';
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
  final List<Model.BillHistory> _bills = [
    Model.BillHistory(
        id: "HD06748",
        table: 01,
        money: 10000,
        dateTime: DateTime(2023, 09, 07),
        status: "Đã hoàn thành"),
    Model.BillHistory(
        id: "HD03814",
        table: 02,
        money: 230000,
        dateTime: DateTime(2023, 09, 07),
        status: "Đã hoàn thành"),
    Model.BillHistory(
        id: "HD09573",
        table: 04,
        money: 150000,
        dateTime: DateTime(2023, 09, 06),
        status: "Đã hoàn thành"),
    Model.BillHistory(
        id: "HD01157",
        table: 06,
        money: 80000,
        dateTime: DateTime(2023, 09, 05),
        status: "Đã hoàn thành"),
    Model.BillHistory(
        id: "HD00576",
        table: 03,
        money: 92000,
        dateTime: DateTime(2023, 09, 04),
        status: "Đã hoàn thành"),
    Model.BillHistory(
        id: "HD04628",
        table: 01,
        money: 392000,
        dateTime: DateTime(2023, 09, 03),
        status: "Đã hoàn thành"),
    Model.BillHistory(
        id: "HD06748",
        table: 06,
        money: 912000,
        dateTime: DateTime(2023, 09, 02),
        status: "Đã hoàn thành"),
    Model.BillHistory(
        id: "HD06748",
        table: 06,
        money: 912000,
        dateTime: DateTime(2023, 09, 02),
        status: "Đã hoàn thành"),
    Model.BillHistory(
        id: "HD06748",
        table: 06,
        money: 912000,
        dateTime: DateTime(2023, 09, 02),
        status: "Đã hoàn thành"),
    Model.BillHistory(
        id: "HD06748",
        table: 06,
        money: 912000,
        dateTime: DateTime(2023, 09, 02),
        status: "Đã hoàn thành"),
  ];
  final _controllerSearch = TextEditingController(text: "");
  final outerController = ScrollController();
  final innerController = ScrollController();

  @override
  void dispose() {
    _controllerSearch.dispose();
    super.dispose();
  }

  @override
  Scaffold build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorScheme(context).onPrimary.withOpacity(0.92),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        titleSpacing: -5.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme(context).scrim,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Client Profile',
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
                onChanged: (value) {
                  setState(() {});
                },
                controller: _controllerSearch,
                style: TextStyle(color: colorScheme(context).outline),
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      colorScheme(context).outlineVariant.withOpacity(0.5),
                  prefixIcon: Icon(
                    Icons.search,
                    color: colorScheme(context).outline,
                  ),
                  suffixIcon: _controllerSearch.text.isEmpty
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
                              _controllerSearch.clear();
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
                onChanged: (value) {
                  setState(() {});
                },
                controller: _controllerSearch,
                style: TextStyle(color: colorScheme(context).outline),
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      colorScheme(context).outlineVariant.withOpacity(0.5),
                  prefixIcon: Icon(
                    Icons.search,
                    color: colorScheme(context).outline,
                  ),
                  suffixIcon: _controllerSearch.text.isEmpty
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
                              _controllerSearch.clear();
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
              padding: const EdgeInsets.all(18.0),
              backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
              foregroundColor: colorScheme(context).outlineVariant,
            ),
            child: const Icon(
              Icons.notifications,
              color: Color.fromRGBO(149, 156, 164, 1),
              size: 20.0,
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
                child:
                    Image.asset('assets/images/avatar.jpg', fit: BoxFit.fill),
              ),
            ),
          ),
        ],
        shape: Border(
            bottom: BorderSide(
          color: colorScheme(context).outline.withOpacity(0.4),
          width: 1,
        )),
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
              Profile profile = state.profile ??
                  Profile(
                      id: 0,
                      username: "nhuy123",
                      password: "123456",
                      name: "Đặng Đình Thiên Như Ý",
                      role: "admin",
                      phoneNumber: "9876543210",
                      email: "email",
                      imgUrl: "imgUrl",
                      );
              return Center(
                  child: checkDevice(
                size.width,
                Center(
                  child: Column(children: [
                    FormProfile(profile: profile),
                    const SizedBox(
                      width: 20,
                      height: 20,
                    ),
                    _ListBill(
                      bills: _bills,
                      size: size,
                      innerController: innerController,
                      outerController: outerController,
                    ),
                  ]),
                ),
                Center(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FormProfile(profile: profile),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _ListBill(
                            bills: _bills,
                            size: size,
                            innerController: innerController,
                            outerController: outerController,
                          ),
                        )
                      ]),
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FormProfile(profile: profile),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _ListBill(
                          bills: _bills,
                          size: size,
                          innerController: innerController,
                          outerController: outerController,
                        ),
                      ),
                    ]),
              ));
            }),
          ),
        ),
      ),
    );
  }
}

// class _FormProfile extends StatelessWidget {
//   const _FormProfile({
//     super.key,
//     required this.size,
//     required this.controllerPhone,
//     required this.controllerEmail,
//   });
//   final Size size;
//   final TextEditingController controllerPhone;
//   final TextEditingController controllerEmail;
//   @override
//   Widget build(BuildContext context) {
//     return ConstrainedBox(
//       constraints: const BoxConstraints(maxWidth: 400.0),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
//         decoration: BoxDecoration(
//           color: colorScheme(context).onPrimary,
//           borderRadius: const BorderRadius.all(Radius.circular(20.0)),
//           border: Border.all(
//             color: Colors.white,
//             width: 2.0,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 0,
//               blurRadius: 3,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Stack(
//               alignment: Alignment(checkDevice(size.width, 1.5, 1.1, 1.1),
//                   checkDevice(size.width, -1.2, -1.0, -1.0)),
//               children: [
//                 ClipOval(
//                   child: SizedBox.fromSize(
//                     size: Size.fromRadius(
//                         50.0 * checkDevice(size.width, 1.0, 1.5, 1.6)),
//                     child:
//                         // changeImage
//                         //     ? Image.file(
//                         //         selectedImage!,
//                         //         width: 250,
//                         //         height: 250,
//                         //         fit: BoxFit.cover,
//                         //       )
//                         //     :
//                         Image.asset('assets/images/avatar.jpg',
//                             fit: BoxFit.cover),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // _showDialog();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     shape: const CircleBorder(),
//                     padding: EdgeInsets.all(
//                         15.0 * checkDevice(size.width, 1, 1.2, 1.2)),
//                     surfaceTintColor: colorScheme(context).onSecondary,
//                     backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
//                     foregroundColor: colorScheme(context).outlineVariant,
//                   ),
//                   child: const Icon(
//                     Icons.create_outlined,
//                     color: Color.fromRGBO(102, 103, 106, 1),
//                     size: 20.0,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "Nguyễn Văn A",
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                   fontSize: 15.0 * checkDevice(size.width, 1.0, 1.2, 1.3),
//                   fontWeight: FontWeight.bold,
//                   color: colorScheme(context).scrim.withOpacity(0.8)),
//             ),
//             const SizedBox(height: 10),
//             Container(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
//               decoration: const BoxDecoration(
//                 color: Color.fromRGBO(238, 245, 239, 1),
//                 borderRadius: BorderRadius.all(Radius.circular(8.0)),
//               ),
//               child: Text(
//                 "Admin",
//                 style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                     fontSize: 15.0,
//                     color: const Color.fromRGBO(94, 194, 129, 1)),
//               ),
//             ),
//             const SizedBox(height: 50),
//             Column(
//               children: [
//                 TextField(
//                   style: TextStyle(color: colorScheme(context).scrim),
//                   controller: controllerPhone,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                       borderSide: BorderSide(
//                         width: 2,
//                         color: colorScheme(context).outlineVariant,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                       borderSide: BorderSide(
//                         width: 2,
//                         color: colorScheme(context).outlineVariant,
//                       ),
//                     ),
//                     hintStyle: TextStyle(
//                         fontSize: 15, color: colorScheme(context).scrim),
//                     hintText: 'Nhập địa chỉ email...',
//                     labelText: 'Email',
//                     labelStyle: TextStyle(
//                       color: colorScheme(context).outline,
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 15.0, vertical: 20.0),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextField(
//                   style: TextStyle(color: colorScheme(context).scrim),
//                   controller: controllerEmail,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                       borderSide: BorderSide(
//                         width: 2,
//                         color: colorScheme(context).outlineVariant,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                       borderSide: BorderSide(
//                         width: 2,
//                         color: colorScheme(context).outlineVariant,
//                       ),
//                     ),
//                     hintStyle: TextStyle(
//                         fontSize: 15, color: colorScheme(context).scrim),
//                     hintText: 'Nhập số điện thoại...',
//                     labelText: 'Số điện thoại',
//                     labelStyle: TextStyle(
//                       color: colorScheme(context).outline,
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 15.0, vertical: 20.0),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextField(
//                   readOnly: true,
//                   enableInteractiveSelection: true,
//                   style: TextStyle(color: colorScheme(context).scrim),
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                       borderSide: BorderSide(
//                         width: 2,
//                         color: colorScheme(context).outlineVariant,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                       borderSide: BorderSide(
//                         width: 2,
//                         color: colorScheme(context).outlineVariant,
//                       ),
//                     ),
//                     hintStyle: TextStyle(
//                         fontSize: 15, color: colorScheme(context).scrim),
//                     hintText: '08/09/2001',
//                     labelText: 'Ngày sinh',
//                     labelStyle: TextStyle(
//                       color: colorScheme(context).outline,
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 15.0, vertical: 20.0),
//                     suffixIcon: Theme(
//                       data: Theme.of(context).copyWith(
//                         splashFactory: NoSplash.splashFactory,
//                       ),
//                       child: TextButton(
//                         style: TextButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 13.0, vertical: 20.0),
//                           minimumSize: Size.zero,
//                           shape: const RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(100.0)),
//                           ),
//                         ),
//                         child: Icon(
//                           Icons.calendar_month_outlined,
//                           color: colorScheme(context).onSurfaceVariant,
//                         ),
//                         onPressed: () => {},
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: [
//                     const Spacer(),
//                     ConstrainedBox(
//                         constraints: const BoxConstraints(maxWidth: 350.0),
//                         child: Container(
//                           height: 45.0,
//                           decoration: BoxDecoration(
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(15.0)),
//                               gradient: const LinearGradient(colors: [
//                                 Color.fromRGBO(109, 92, 255, 1),
//                                 Color.fromRGBO(160, 91, 255, 1)
//                               ]),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: const Color.fromARGB(255, 0, 0, 0)
//                                       .withOpacity(0.2),
//                                   spreadRadius: 4,
//                                   blurRadius: 12,
//                                   offset: const Offset(0, 5),
//                                 )
//                               ]),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         const HistoryBillScreen()),
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.transparent,
//                               shadowColor: Colors.transparent,
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15.0),
//                               ),
//                             ),
//                             child: Text(
//                               'LƯU THAY ĐỔI',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .labelMedium
//                                   ?.copyWith(
//                                       fontSize: 14,
//                                       color: colorScheme(context).background),
//                             ),
//                           ),
//                         )),
//                   ],
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

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
    required this.bills,
    required this.size,
    required this.outerController,
    required this.innerController,
  });
  final Size size;
  final List<Model.BillHistory> bills;
  final ScrollController outerController;
  final ScrollController innerController;
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
                              Tab(text: 'Appointments'),
                              Tab(text: 'Invoices'),
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
                    constraints: const BoxConstraints(maxHeight: 500),
                    child: TabBarView(
                      children: [
                        // Nội dung của Tab 1
                        Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    if (bills.isNotEmpty) ...[
                                      ListView.separated(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: bills.length,
                                        separatorBuilder: (_, __) =>
                                            const Divider(),
                                        itemBuilder: (context, int index) {
                                          return Container(
                                            padding: const EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        bills[index].id,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.copyWith(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: colorScheme(
                                                                        context)
                                                                    .scrim),
                                                      ),
                                                      Text(
                                                        'BÀN: ${bills[index].table}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                                fontSize: 12,
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
                                                                horizontal: 6,
                                                                vertical: 4),
                                                        color: Colors
                                                            .greenAccent
                                                            .withOpacity(0.1),
                                                        child: Text(
                                                          bills[index].status,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12,
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
                                                        "${NumberFormat("#######.000", "en_US").format(bills[index].money * 0.001)} đ",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: colorScheme(
                                                                        context)
                                                                    .scrim),
                                                      ),
                                                      Text(
                                                        DateFormat("dd-MM-yyyy")
                                                            .format(bills[index]
                                                                .dateTime),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                                fontSize: 12,
                                                                color: colorScheme(
                                                                        context)
                                                                    .outlineVariant),
                                                      ),
                                                    ],
                                                  )
                                                ]),
                                          );
                                        },
                                      ),
                                    ] else ...[
                                      Container(
                                        padding: const EdgeInsets.symmetric(
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
                                                        color:
                                                            colorScheme(context)
                                                                .outline),
                                              ),
                                            ]),
                                      )
                                    ]
                                  ],
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
        // ),
      ],
    );
  }
}
