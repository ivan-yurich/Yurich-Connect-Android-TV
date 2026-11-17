import 'package:aurum_vpn/src/services/app_update_service.dart';
import 'package:aurum_vpn/src/tv_app_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('TV uses its own application and release identifiers', () {
    expect(TvAppIdentity.applicationId, 'online.dnsai.ivanvpn.tv');
    expect(
      TvAppIdentity.releasesUrl,
      'https://github.com/ivan-yurich/Yurich-Connect-Android-TV/releases',
    );
    expect(AppUpdateService.latestApkDownloadUri.pathSegments, [
      'ivan-yurich',
      'Yurich-Connect-Android-TV',
      'releases',
      'latest',
      'download',
      'YurichConnect-android-tv-release.apk',
    ]);
  });

  test('no reported channel enables OTA in the TV product', () {
    for (final channel in AppDistributionChannel.values) {
      expect(channel.externalUpdatesEnabled, isFalse, reason: channel.name);
    }
  });
}
