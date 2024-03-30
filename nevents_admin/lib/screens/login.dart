import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevents_admin/resoureces/auth_methods.dart';
import 'package:nevents_admin/screens/home.dart';
import 'package:nevents_admin/screens/signup.dart';
import 'package:nevents_admin/utils/utils.dart';
import 'package:nevents_admin/widgets/welcome_scaffold.dart';




class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _formSignInKey =GlobalKey<FormState>();
  bool rememberpassword =true;
  final TextEditingController _emailcontroller =TextEditingController();
  final TextEditingController _passwordcontroller =TextEditingController();
  bool _isloading =false;
 @override
  void dispose() {
    
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    
  }


 void loginadmin()async{
    setState(() {
      
      _isloading=true;
    });
    String res =await  authmethods().loginadmin(
    
     email: _emailcontroller.text,
     password: _passwordcontroller.text,
    );

    setState(() {
      
      _isloading=false;
    });

    if(res!='success'){
      showSnackBar(res, context);
    }else{
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const home(),
        ),
      );
    }
    
 }
  @override
  Widget build(BuildContext context) {
    return welcomescafold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            //Flexible(child: Container(),flex: 2,),
            SvgPicture.asset(
              'assets/Nevents.svg',
              height: 50,
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formSignInKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 1,
                    ),
                   
                    const SizedBox(
                      height: 16,
                    ),
                
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                        isDense: true,
                        label: const Text(
                          'Email',
                          style: TextStyle(
                            color: Color.fromARGB(171, 1, 66, 0),
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                        hintText: 'Enter Email',
                        hintStyle: const TextStyle(
                          color: Colors.black26,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(22, 1, 66, 0),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(120, 1, 66, 0),
                            ),
                            borderRadius: BorderRadius.circular(100)),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                        controller: _passwordcontroller,
                        obscureText: true,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          isDense: true,
                          label: const Text(
                            'Password',
                            style: TextStyle(
                              color: Color.fromARGB(171, 1, 66, 0),
                            ),
                          ),
                          hintText: 'Enter Password',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(120, 1, 66, 0),
                              ),
                              borderRadius: BorderRadius.circular(100)),
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: loginadmin,
                        child: _isloading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.black,
                                ),
                              )
                            : Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(237, 83, 209, 0),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Center(
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don"t have an account?  ',
                          style: TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (e) => signup()),
                            );
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}