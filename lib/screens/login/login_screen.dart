import 'package:flutter/material.dart';
import 'package:the_online_shop/screens/model/user.dart';
import 'package:the_online_shop/screens/product/product_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final usernameText = TextEditingController();
  final passwordText = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool rememberStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30,),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('The', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.black87),),
                      Text('Online Shop', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  TextFormField(
                    controller: usernameText,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      label: Text('Username'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      } else if (value.length < 6){
                        return 'Username must be at least 5 character long!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    controller: passwordText,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      label: Text('Password'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 6){
                        return 'Password must be at least 5 character long!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15,),
                  CheckboxListTile(
                    title: const Text("Remember me", style: TextStyle(fontWeight: FontWeight.w700),),
                    value: rememberStatus,
                    checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    onChanged: (newValue) {
                      setState(() {
                        rememberStatus = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ElevatedButton(onPressed: (){
                        checkLoginData();
                      }, child: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)))
                ],),
            ),
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> checkLoginData() async {
    if (_formKey.currentState!.validate()) {
      String response = await User(usernameText.text, passwordText.text).checkLogin();
      if(response == "Success"){
        if(mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ProductScreen()));
        }
      } else{
        errorDialog();
      }
    }
  }

  void errorDialog() {
    showDialog(context: context, builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      content: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text('Login Failed !!!', style: TextStyle(fontSize: 24, ),),
      ),
    ));
  }
}