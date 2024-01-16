import 'package:flare_flutter/asset_provider.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/services.dart';

final AssetProvider assetProvider =
    AssetFlare(bundle: rootBundle, name: 'assets/Error.flr');

Future<void> warmupAnimations() async {
  await cachedActor(assetProvider);
}
