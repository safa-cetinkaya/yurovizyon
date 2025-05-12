part of 'register_screen.dart';

extension RegisterView on _RegisterScreenState {
  Widget _build(BuildContext context) {
    return BaseScaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: SizedBox.fromSize(
                  child: Image.asset('assets/images/yurovizyon_logo.png',
                      width: 350, fit: BoxFit.cover),
                ),
              ),
            ),
            InputWidget(
              hintText: 'Username',
              onChanged: (q) => username = q,
            ),
            InputWidget(
              hintText: 'Password',
              isPassword: true,
              onChanged: (q) => password = q,
            ),
            InputWidget(
              hintText: 'Confirm Password',
              isPassword: true,
              onChanged: (q) => confirmPassword = q,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0, bottom: 12.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Text(
                        'Have an account? ',
                        style: TextStyle(
                          color: Utils.textColor,
                        ),
                      ),
                    ),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          Routes.replace(path: LoginScreen.route);
                        },
                        child: Text(
                          'Sign in.',
                          style: TextStyle(
                            color: Utils.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ButtonWidget(
              text: 'Sign Up',
              width: 200,
              backgroundColor: Utils.primaryColor,
              onPressed: register,
            ),
          ],
        ),
      ),
    );
  }
}
