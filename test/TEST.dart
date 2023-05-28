import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';



class HomeHeader extends StatefulWidget {
  const HomeHeader({
    super.key,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            numOfItems: demoCarts.length, // le nombre de Item a parametrer après
            press: () =>Navigator.pushNamed(context, CartScreen.routeName),
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfItems: 3, // le nombre de Notification a parametrer après
            press: () {  },
          ),
        ],
      ),
    );
  }
}

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });
}

List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      "assets/images/Image Popular Product 1.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Wireles Controller for PS4™",
    price: 10000,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: false,

  ),
  Product(
    id: 2,
    images: [
      "assets/images/Image Popular Product LOGO_Png_sans_fond.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Sac a main",
    price: 8000,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: false,

  ),
  Product(
    id: 3,
    images: [
      "assets/images/Image Popular Product 3.png",
      "assets/images/Image Popular Product 1.png",
      "assets/images/Image Popular Product LOGO_Png_sans_fond.png",
      "assets/images/Image Popular Product 3.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Gloves XC Omega - Polygon",
    price: 7000,
    description: description,
    rating: 4.1,
    isFavourite: false,
    isPopular: true,

  ),
  Product(
    id: 4,
    images: [
      "assets/images/wireless headset.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Logitech Head",
    price: 100000,
    description: description,
    rating: 4.1,
    isFavourite: false,
    isPopular: true,

  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";



class Cart {
  final Product product;
  final int numOfItem;

  Cart({required this.product, required this.numOfItem});
}

// Demo data for our cart

List<Cart> demoCarts = [
  Cart(product: demoProducts[0], numOfItem: 2),
  Cart(product: demoProducts[1], numOfItem: 1),
  Cart(product: demoProducts[3], numOfItem: 1),
];



class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.6,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) {
        },
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Search Product",
          prefixIcon: Icon(Icons.search,color: kPrimaryColor),
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenWidth(9),
          ),
        ),
      ),
    );
  }
}

const kPrimaryColor = Color(0xFF0FADFF);
// 0xFF48B82C  vert
// 0xFF0FADFF bleu
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);

const kSecondaryGradientColor = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Color(0xFFF13B3B), Color(0xFFF8ACAC)],
);


const kSecondaryColor = Color(0xFF979797);
// 0xFF979797
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  enabledBorder:
  outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  border: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: kPrimaryColor,),
  );
}

class IconBtnWithCounter extends StatefulWidget {
  const IconBtnWithCounter({
    super.key,
    required this.svgSrc,
    this.numOfItems =0,
    required this.press,
  });

  final String svgSrc;
  final int numOfItems;
  final GestureTapCallback press;

  @override
  State<IconBtnWithCounter> createState() => _IconBtnWithCounterState();
}

class _IconBtnWithCounterState extends State<IconBtnWithCounter> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      borderRadius: BorderRadius.circular(50),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(12)) ,
              height: 46,
              width:46,
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(widget.svgSrc)
          ),
          if (widget.numOfItems != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: getProportionateScreenWidth(16),
                width: getProportionateScreenHeight(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text("${widget.numOfItems}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                      height: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

        ],
      ),
    );
  }
}


class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}


class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  static String routeName="/cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding:EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: ListView.builder(
          itemCount: demoCarts.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: Key(demoCarts[index].product.id.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    gradient: kSecondaryGradientColor,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  children: [
                    Spacer(),
                    SvgPicture.asset("assets/icons/Trash.svg")
                  ],
                ),
              ),
              onDismissed:(direction) {
                demoCarts.removeAt(index);
              },
              child: CartItemCard(cart: demoCarts[index]),
            ),
          ),

        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text("Your Cart",
            style: TextStyle(
              color:Colors.black,
            ),
          ),
          Text("${demoCarts.length} items",style: Theme.of(context).textTheme.caption,)
        ],
      ),
      centerTitle: true,
    );
  }
}




class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key, required this.cart,
  });
  final Cart cart;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(88),
          child: AspectRatio(aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              //*****************************Pour l'image de l'article *************************
              child:Image.asset(cart.product.images[0]) ,
            ),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(20)),
        //*****************************Pour le titre de l'article **************************
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(cart.product.title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10,),
            //*****************************Pour le prix de l'article **************************
            Text.rich(
              TextSpan(
                  text: "${cart.product.price.toInt()} FCFA",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(text: " x ${cart.numOfItem}",
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 16,
                      ),
                    ),
                  ]
              ),
            ),
          ],
        )
      ],
    );
  }
}










