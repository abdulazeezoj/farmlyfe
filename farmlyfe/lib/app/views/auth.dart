import 'package:farmlyfe/app/controllers/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthView extends StatelessWidget {
  AuthView({Key? key}) : super(key: key);

  // Controllers
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Stack(
            children: [
              Align(
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  height: 250,
                  child: Column(
                    children: [
                      const Image(
                        image: AssetImage('assets/icons/farmlyfe_full_nbg.png'),
                        width: 150,
                        height: 150,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Let\'s get you started',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      authController.login();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 20,
                        bottom: 20,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                            width: 30,
                            height: 30,
                            child: Image(
                              image: AssetImage('assets/icons/google_icon.png'),
                            )),
                        Expanded(
                          child: Text(
                            'Sign in with Google',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .fontSize,
                            ),
                          ),
                        ),
                      ],
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
