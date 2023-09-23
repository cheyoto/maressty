// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // هذا هو المسار الافتراضي عند بدء التطبيق
      routes: {
        '/': (context) => LoginPage(), // الصفحة التي يشير إليها المسار '/'
        '/home': (context) => HomePage(),
        '/signup': (context) => SignUpPage(),
      },
    );
  }
}

class User {
  final String firstName;
  final String lastName;
  final String username;
  final String phoneNumber;
  final String nationalID;
  final String password;
  final File? profileImage;

  User(
      {required this.firstName,
      required this.lastName,
      required this.username,
      required this.phoneNumber,
      required this.nationalID,
      required this.password,
      this.profileImage});
}

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تسجيل الدخول'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: usernameController,
              decoration:
                  InputDecoration(labelText: 'إسم المستخدم أو رقم الهاتف'),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'كلمة المرور'),
            ),
            ElevatedButton(
              onPressed: () {
                final username = usernameController.text;
                final password = passwordController.text;

                if (username.isEmpty || password.isEmpty) {
                  setState(() {
                    errorText = 'يرجى ملء جميع الحقول المطلوبة.';
                  });
                  return;
                }

                // يمكنك التحقق من صحة المدخلات ومقارنتها مع بيانات التطبيق
                // إذا نجحت عملية تسجيل الدخول، انتقل إلى الصفحة الرئيسية
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => HomePage()));
              },
              child: Text('تسجيل الدخول'),
            ),
            Text(
              errorText,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            TextButton(
              onPressed: () {
                // انتقل إلى صفحة إنشاء الحساب عند الضغط على "إنشاء حساب جديد"
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SignUpPage()));
              },
              child: Text('إنشاء حساب جديد'),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إنشاء حساب جديد'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'الإسم الشخصي'),
            ),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'إسم العائلة'),
            ),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'إسم المستخدم'),
            ),
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'رقم الهاتف (8 أرقام)'),
            ),
            TextFormField(
              controller: nationalIdController,
              decoration:
                  InputDecoration(labelText: 'رقم البطاقة الوطنية (10 أرقام)'),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'كلمة المرور'),
            ),
            TextFormField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'تأكيد كلمة المرور'),
            ),
            ElevatedButton(
              onPressed: () {
                final firstName = firstNameController.text;
                final lastName = lastNameController.text;
                final username = usernameController.text;
                final phoneNumber = phoneNumberController.text;
                final nationalId = nationalIdController.text;
                final password = passwordController.text;
                final confirmPassword = confirmPasswordController.text;

                if (firstName.isEmpty ||
                    lastName.isEmpty ||
                    username.isEmpty ||
                    phoneNumber.isEmpty ||
                    nationalId.isEmpty ||
                    password.isEmpty ||
                    confirmPassword.isEmpty) {
                  setState(() {
                    errorText = 'يرجى ملء جميع الحقول المطلوبة.';
                  });
                  return;
                }

                // التحقق من متطلبات الحقول الإضافية وتأكيد كلمة المرور
                if (phoneNumber.length != 8) {
                  setState(() {
                    errorText = 'رقم الهاتف يجب أن يتكون من 8 أرقام.';
                  });
                  return;
                }

                if (nationalId.length != 10) {
                  setState(() {
                    errorText = 'رقم البطاقة الوطنية يجب أن يتكون من 10 أرقام.';
                  });
                  return;
                }

                if (password != confirmPassword) {
                  setState(() {
                    errorText = 'كلمة المرور وتأكيد كلمة المرور غير متطابقين.';
                  });
                  return;
                }
                final userProvider =
                    Provider.of<UserProvider>(context, listen: false);
                final user = User(
                  username:
                      username, // استبدل هذا بالمعلومات المدخلة من المستخدم
                  firstName:
                      firstName, // استبدل هذا بالمعلومات المدخلة من المستخدم
                  lastName:
                      lastName, // استبدل هذا بالمعلومات المدخلة من المستخدم
                  phoneNumber:
                      phoneNumber, // استبدل هذا بالمعلومات المدخلة من المستخد
                  password: password,
                  nationalID: nationalId,
                );
                userProvider.setUser(user);

                // إذا تم التحقق من جميع المتطلبات، يمكنك إنشاء الحساب وحفظ المعلومات
                // يمكنك إضافة المزيد من الخطوات هنا مثل حفظ البيانات في قاعدة البيانات
                // ثم الانتقال إلى صفحة تسجيل الدخول
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LoginPage()));
              },
              child: Text('إنشاء حساب'),
            ),
            Text(
              errorText,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // تعيين الصفحة الرئيسية كالصفحة الافتراضية
  final List<Product> products = [];

  void _navigateToAddProductPage(BuildContext context) async {
    final newProduct = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProductPage()),
    );
    if (newProduct != null) {
      setState(() {
        products.add(newProduct);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مرصتي'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu_outlined, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {
              // اضافة تعليق لعمل الأيقونة هنا
            },
          ),
          IconButton(
            icon: Icon(Icons.search_outlined, color: Colors.black),
            onPressed: () {
              // اضافة تعليق لعمل الأيقونة هنا
            },
          ),
        ],
        centerTitle: true,
      ),
      drawer: _buildNavigationDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 750,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailsPage(products[index]),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          products[index].mainImagePath != null &&
                                  products[index].mainImagePath!.isNotEmpty
                              ? Image.file(
                                  File(products[index].mainImagePath!),
                                  height: 129,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  height: 129,
                                  color: Colors.grey,
                                ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              products[index].name,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '\$${products[index].price}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Color.fromARGB(255, 13, 13, 13),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department_outlined),
            label: 'الأكثر مبيعًا',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'إضافة منتج',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.shopping_cart_outlined), // رمز يعبر عن المشتريات
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PurchasesPage(products), // تمرير قائمة المشتريات هنا
                  ),
                );
              },
            ),
            label: 'المشتريات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'حسابي',
          ),
        ],
        onTap: (index) {
          if (index == 2) {
            _navigateToAddProductPage(context);
          } else if (index == 3) {
            // عند الانتقال إلى صفحة المشتريات
            setState(() {});
          }
        },
      ),
    );
  }

  Widget _buildNavigationDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/user_avatar.jpg'),
                ),
                SizedBox(height: 8),
                Text(
                  'اسم المستخدم',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('الإعدادات'),
            onTap: () {
              // اضافة تعليق للانتقال إلى صفحة الإعدادات هنا
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('المزيد عن المطور'),
            onTap: () {
              // اضافة تعليق للانتقال إلى صفحة المزيد عن المطور هنا
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app_outlined),
            title: Text('تسجيل الخروج'),
            onTap: () {
              // اضافة تعليق لتنفيذ عملية تسجيل الخروج هنا
            },
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  final String description;
  String? mainImagePath;

  Product(this.name, this.price, this.description);

  void setMainImage(String imagePath) {
    mainImagePath = imagePath;
  }
}

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();
  TextEditingController _productDescriptionController = TextEditingController();
  File? mainImage;

  void _addProduct() async {
    String productName = _productNameController.text;
    double productPrice = double.parse(_productPriceController.text);
    String productDescription = _productDescriptionController.text;

    if (mainImage == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('خطأ'),
            content: Text('يرجى اختيار صورة رئيسية للمنتج.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('حسناً'),
              ),
            ],
          );
        },
      );
      return;
    }

    String mainImagePath = await saveImage(mainImage!);
    Product newProduct = Product(productName, productPrice, productDescription);
    newProduct.setMainImage(mainImagePath);
    Navigator.pop(context, newProduct);
  }

  Future<String> saveImage(File image) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String imageName =
        'product_image_${DateTime.now().millisecondsSinceEpoch}.png';
    final String imagePath = '${appDir.path}/$imageName';

    await image.copy(imagePath);
    return imagePath;
  }

  void _pickMainImage() async {
    final mainImagePicker = ImagePicker();
    final pickedImage = await mainImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        mainImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة منتج جديد'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(labelText: 'اسم المنتج'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _productPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'سعر المنتج'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _productDescriptionController,
              maxLines: 4,
              decoration: InputDecoration(labelText: 'وصف المنتج'),
            ),
            SizedBox(height: 16),
            Text('صورة المنتج الرئيسية'),
            SizedBox(height: 8),
            mainImage != null
                ? Image.file(
                    mainImage!,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 200,
                    color: Colors.grey,
                  ),
            SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _pickMainImage,
              icon: Icon(Icons.add_photo_alternate_outlined),
              label: Text('اختر صورة المنتج الرئيسية'),
            ),
            SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                // يمكنك تنفيذ اجراء لإضافة صور إضافية هنا
              },
              icon: Icon(Icons.add_photo_alternate_outlined),
              label: Text('إضافة صور إضافية'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addProduct,
              child: Text('إضافة المنتج'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  ProductDetailsPage(this.product);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isAddedToCart = false;

  void addToCart() {
    // قم بتنفيذ الإجراءات اللازمة لإضافة المنتج إلى قائمة المشتريات
    setState(() {
      isAddedToCart = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            widget.product.mainImagePath != null &&
                    widget.product.mainImagePath!.isNotEmpty
                ? Image.file(
                    File(widget.product.mainImagePath!),
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 200,
                    color: Colors.grey,
                  ),
            SizedBox(height: 16),
            Text(
              'السعر: \$${widget.product.price}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'وصف المنتج:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.product.description,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60, // ارتفاع الشريط السفلي للأزرار
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  // إضافة المنتج إلى قائمة المشتريات
                  List<Product> purchasedProducts = [
                    widget.product
                  ]; // قم بتمديد القائمة حسب الحاجة
                },
                child: Container(
                  width: 200, // عرض المستطيل
                  height: 50, // ارتفاع المستطيل
                  color: Colors.blue, // لون المستطيل
                  child: Center(
                    child: Text(
                      'إضافة إلى المشتريات', // النص داخل المستطيل
                      style: TextStyle(
                        color: Colors.white, // لون النص
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // يمكنك هنا تنفيذ الإجراءات اللازمة لشراء المنتج
                },
                child: Container(
                  width: 200, // عرض المستطيل
                  height: 50, // ارتفاع المستطيل
                  color: Colors.green, // لون المستطيل
                  child: Center(
                    child: Text(
                      'شراء المنتج', // النص داخل المستطيل
                      style: TextStyle(
                        color: Colors.white, // لون النص
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PurchasesPage extends StatefulWidget {
  final List<Product> purchasedProducts;

  PurchasesPage(this.purchasedProducts);

  @override
  _PurchasesPageState createState() => _PurchasesPageState();
}

class _PurchasesPageState extends State<PurchasesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المشتريات'),
      ),
      body: ListView.builder(
        itemCount: widget.purchasedProducts.length,
        itemBuilder: (BuildContext context, int index) {
          final product = widget.purchasedProducts[index];
          return Card(
            child: ListTile(
              leading: product.mainImagePath != null &&
                      product.mainImagePath!.isNotEmpty
                  ? Image.file(
                      File(product.mainImagePath!),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 100,
                      width: 100,
                      color: Colors.grey,
                    ),
              title: Text(product.name),
              subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              trailing: ElevatedButton(
                onPressed: () {
                  // إزالة المنتج من قائمة المشتريات هنا
                  setState(() {
                    widget.purchasedProducts.removeAt(index);
                  });
                },
                child: Text('حذف المنتج'),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60, // ارتفاع الشريط السفلي للأزرار
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  // إضافة المنتج إلى قائمة المشتريات
                  List<Product> purchasedProducts =
                      widget.purchasedProducts; // قائمة المشتريات
                  // قم بتنفيذ الإجراءات اللازمة لشراء جميع المنتجات هنا
                },
                child: Container(
                  width: 400, // عرض المستطيل
                  height: 50, // ارتفاع المستطيل
                  color: Colors.blue, // لون المستطيل
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "شراء الكل",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
