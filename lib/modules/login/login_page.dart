import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // The controller should be initialized via a Route Binding.
    // Get.put() is used here as a fallback if not already registered.
    Get.put(LoginController());

    return ShadTheme(
      data: ShadThemeData(
        brightness: Brightness.light,
      ),
      // Use a Builder to get a context that is a descendant of ShadTheme
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: ShadTheme.of(context).colorScheme.background,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.airplanemode_active_rounded,
                        size: 64,
                        color: Color(0xFF0D47A1),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Airnav Helpdesk',
                        style: ShadTheme.of(context).textTheme.h2.copyWith(
                              color: Color(0xFF0D47A1),
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Mohon login untuk melanjutkan',
                        style: ShadTheme.of(context).textTheme.muted,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      ShadInput(
                        controller: controller.personnelNumberController,
                        placeholder: const Text('NIK'),
                        leading: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(
                            () => ShadInput(
                          controller: controller.passwordController,
                          placeholder: const Text('Password'),
                          leading: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.lock_outline),
                          ),
                          obscureText: controller.isObscure.value,
                          trailing: ShadButton.ghost(
                            width: 32,
                            height: 32,
                            leading: Icon(
                              color: Color(0xFF0D47A1),
                              controller.isObscure.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 16,
                            ),
                            onPressed: controller.toggleObscure,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ShadButton.link(
                          onPressed: () {
                            // Implement forgot password logic
                          },
                          child: const Text('Lupa Kata Sandi?'),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Obx(
                            () => ShadButton(
                          onPressed:
                          controller.isLoading.value ? null : controller.login,
                          width: double.infinity,
                          height: 48,
                          backgroundColor: Color(0xFF0D47A1),
                          child: controller.isLoading.value
                              ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              // The theme will color this appropriately
                            ),
                          )
                              : const Text('Login',
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}