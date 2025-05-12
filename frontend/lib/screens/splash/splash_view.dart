part of 'splash_screen.dart';

extension SplashView on _SplashScreenState {
  Widget _build(BuildContext context) {
    return BaseScaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: SizedBox.fromSize(
                  child: Image.asset('assets/images/yurovizyon_logo.png',
                      fit: BoxFit.cover),
                ),
              ),
            ),
            const Spacer(),
            Opacity(
              opacity: loading ? 1.0 : 0.0,
              child: CircularProgressIndicator(color: Utils.textColor),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
