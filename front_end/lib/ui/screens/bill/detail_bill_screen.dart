
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

class DetailBillScreen extends StatefulWidget {
  const DetailBillScreen({super.key});

  @override
  State<DetailBillScreen> createState() => _detailBillState();
}

class _detailBillState extends State<DetailBillScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
          child:AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: colorScheme(context).onSecondary,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: colorScheme(context).scrim,
            ),
          ),
          title: Text(
            'CHI TIẾT HÓA ĐƠN',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16,fontWeight: FontWeight.w900),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colorScheme(context).onTertiary,
        ),
        child: Column(
          children: [
            Stack(
                children: <Widget>[      
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeaderBill(),
                      BodyBill(),
                      FooterBill(),
                    ],
                  ),
                  Positioned(
                    top: 55,
                    right: -1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            topLeft: Radius.circular(100)
                            ),
                            color: colorScheme(context).onTertiary,
                            shape: BoxShape.rectangle,
                        ),
                        height: 45,
                        width: 25,
                    ),
                  ),
                  Positioned(
                    top: 55,
                    left: -1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(100),
                            bottomRight: Radius.circular(100)
                            ),
                            color: colorScheme(context).onTertiary,
                            shape: BoxShape.rectangle,
                        ),
                        height: 45,
                        width: 25,
                    ),
                  ),
                ]
              ),
          ],
        ),
      ),
    );
  }
}

class FooterBill extends StatelessWidget{
  const FooterBill({
  super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal:15.0, vertical: 10.0),
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tổng tiền:',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              Text(
                '1.200.000 đ',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ],
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white, // Màu chữ đen
            ),
            child: const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                'In hóa đơn',
                style: TextStyle(fontSize: 17, color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BodyBill extends StatelessWidget {
  const BodyBill({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0XFFD4D4D8).withOpacity(0.3),
        // borderRadius: const BorderRadius.only(
        //   bottomLeft: Radius.circular(15.0),
        //   bottomRight: Radius.circular(15.0),
        // ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(
              'assets/svgs/check_bill.svg',
              width: 84,
              height: 84,
            ),
          ),
          const Text(
            'THÔNG TIN HÓA ĐƠN',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(width: double.infinity, height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mã hóa đơn',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    Text(
                      'HD100',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(width: double.infinity, height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Số bàn',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    Text(
                      'Bàn 2',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(width: double.infinity, height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Số lượng món',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    Text(
                      '12',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(width: double.infinity, height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Khuyến mãi',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    Text(
                      '3%',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(width: double.infinity, height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Đã vào bàn lúc',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45),
                    ),
                    Text(
                      '3h40p, ngày 25/8/2023',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(width: double.infinity, height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Đã xuất hóa đơn lúc',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45),
                    ),
                    Text(
                      '5h40p, ngày 25/8/2023',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(width: double.infinity, height: 15),    
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderBill extends StatelessWidget {
  const HeaderBill({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0XFF8E2DE2), Color(0XFF4A00E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('29-8-2023',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.3),
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              ),
              child: const Text(
                'Chi tiết món',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
