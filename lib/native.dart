import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class native_ads extends StatefulWidget {
  native_ads({super.key, this.adContainerColor});
  Color? adContainerColor;
  @override
  State<native_ads> createState() => _native_adsState();
}

class _native_adsState extends State<native_ads>
    with AutomaticKeepAliveClientMixin {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _nativeAd = NativeAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1044960115'
          : 'ca-app-pub-3940256099942544/3986624511',
      request: const AdRequest(),
      nativeTemplateStyle:
          NativeTemplateStyle(templateType: TemplateType.medium),
      customOptions: options,
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          log('$NativeAd loaded.');
          setState(() {
            _nativeAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          log('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => log('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => log('$NativeAd onAdClosed.'),
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(builder: (ctx, cons) {
      if (_nativeAd != null && _nativeAdIsLoaded) {
        return Container(
          color: widget.adContainerColor,
          width: cons.maxWidth,
          height: 260,
          alignment: Alignment.center,
          child: AdWidget(
            ad: _nativeAd!,
          ),
        );
      } else {
        return Container(
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class NativeSmallAd extends StatefulWidget {
  NativeSmallAd({super.key, this.adContainerColor});
  Color? adContainerColor;
  @override
  State<NativeSmallAd> createState() => _NativeSmallAdState();
}

class _NativeSmallAdState extends State<NativeSmallAd>
    with AutomaticKeepAliveClientMixin {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _nativeAd = NativeAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1044960115'
          : 'ca-app-pub-3940256099942544/3986624511',
      request: const AdRequest(),
      factoryId: 'listTileSmall',
      customOptions: options,
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          log('$NativeAd loaded.');
          setState(() {
            _nativeAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          log('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => log('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => log('$NativeAd onAdClosed.'),
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(builder: (ctx, cons) {
      if (_nativeAd != null && _nativeAdIsLoaded) {
        return Container(
          color: widget.adContainerColor,
          width: cons.maxWidth,
          height: 120,
          alignment: Alignment.center,
          child: AdWidget(
            ad: _nativeAd!,
          ),
        );
      } else {
        return Container(
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  bool get wantKeepAlive => true;
}

final Map<String, String> options = {
  "adIconConfig": "AdIconConfig(height: 55, width: 55)",
  "adAdvertiserConfig": "AdAdvertiserConfig(textColor: '#000000')",
  "adHeadlineConfig": "AdHeadlineConfig(textColor: '#000000')",
  "adStoreConfig": "AdStoreConfig(fontSize: 10, textColor: '#808080')",
  "adPriceConfig": "AdPriceConfig(fontSize: 10, textColor: '#808080')",
  "adStarsConfig": "AdStarsConfig(visible: true, emptyStarsColor: '#808080')",
  "backgroundColor": "#FFFFFF",
  "adLayoutConfig": "AdLayoutConfig(adTileHeight: 55)",
  "adMediaConfig": "AdMediaConfig(visible: true)",
};
