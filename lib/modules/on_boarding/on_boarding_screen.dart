import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingItem {
  String title = '';
  String body = '';
  String image = '';

  BoardingItem({
    this.title,
    this.body,
    this.image,
  });
}

var controller = PageController();
List<BoardingItem> boardPages = [
  BoardingItem(
      image: 'assets/images/onboard1.png', title: 'Online Shopping', body: 'Choose The Products that you need easily!'),
  BoardingItem(
      image: 'assets/images/onboard2.png', title: 'Favorite Products', body: 'Add your favorite products to card, Buy now and pay later!'),
  BoardingItem(
      image: 'assets/images/onboard3.png', title: 'Special Offers', body: 'Check out our offers, a lot of discounts!'),
];

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  bool isLast = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( elevation: 0.0,
        actions: [
          defaultTextButton(onPressed: () {
            CacheHelper.saveData(key: 'onBoarding', value: true).then((value) => navigateAndFinish(context, LoginScreen()));

          }, text: 'skip')
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == 2)
                    setState(() {
                      isLast = true;
                    });
                  else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) {
                  return buildBoardingItem(item: boardPages[index]);
                },
                physics: BouncingScrollPhysics(),
                controller: controller,
                itemCount: boardPages.length,
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: SmoothPageIndicator(
                  controller: controller,
                  count: boardPages.length,
                  effect: ExpandingDotsEffect(
                      spacing: 5.0,
                      radius: 25.0,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      expansionFactor: 3,
                      paintStyle: PaintingStyle.fill,
                      dotColor: Colors.grey,
                      activeDotColor: primaryColor),
                  onDotClicked: (index) {},
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 30),
                child: FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      CacheHelper.saveData(key: 'onBoarding', value: true).then((value) => navigateAndFinish(context, LoginScreen()));
                    } else {
                      controller.nextPage(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void navigateTo(context, widget) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => true);
}

Widget buildBoardingItem({BoardingItem item}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          child: Image(
        image: AssetImage(
      '${item.image}',
        ),
        width: 355,height: 250,
      )),
      SizedBox(
        height: 40,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          '${item.title}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('${item.body}',),
        ),
      ),
      // SizedBox(height: 10,),
    ],
  );
}
