import 'package:myspace_core/myspace_core.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService extends Dependency {
  Future<Result<void>> laurnchUrl(String url) async {
    try {
      final result = await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
      if (!result) {
        return Result.error('Failed to launch $url');
      }
      return Result.ok(null);
    } catch (e) {
      return Result.error(e);
    }
  }
}
