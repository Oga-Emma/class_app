import 'dart:convert';

import 'package:class_app/model/post_dto.dart';
import 'package:class_app/ui/helper_widgets/toast_helper.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share/share.dart';

class ShareUtils {
  //google-site-verification=vQ2flDqR1TlpBbVZ7g5Y3HH91jtVNTUvuATNbrCY8Pw
  // Dynamic Links will start with https://areabuzz.net
//  "appAssociation": "AUTO",
//  "rewrites": [ { "source": "/**", "dynamicLinks": true } ]
//  static Future<String> generateDynamicLink() async {
//    final DynamicLinkParameters parameters = DynamicLinkParameters(
//      uriPrefix: 'https://abc123.app.goo.gl',
//      link: Uri.parse('https://example.com/'),
//      androidParameters: AndroidParameters(
//        packageName: 'com.example.android',
//        minimumVersion: 2,
//      ),
//      iosParameters: IosParameters(
//        bundleId: 'com.example.ios',
//        minimumVersion: '1.0.1',
//        appStoreId: '123456789',
//      ),
//      googleAnalyticsParameters: GoogleAnalyticsParameters(
//        campaign: 'example-promo',
//        medium: 'social',
//        source: 'orkut',
//      ),
//      itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
//        providerToken: '123456',
//        campaignToken: 'example-promo',
//      ),
//      socialMetaTagParameters: SocialMetaTagParameters(
//        title: 'Example of a Dynamic Link',
//        description: 'This link works whether app is installed or not!',
//      ),
//    );
//
//    final Uri dynamicUrl = await parameters.buildUrl();
//
//    return dynamicUrl.toString();
//  }

  static SharePost(PostDTO post) async {
//    print('share');
//    return;
    /*
    https://areabuzz.page.link/?link=https://www.areabuzz.net/posts&apn=com.areabuzz.area_buzz&st=View+my+post&sd=view+my+post+on+areabuzz&si=https://www.imageurl.com
     */

    var content = post.content;
    if (content.length > 100) {
      content = content.substring(0, 100);
    }
    var imageUrl = "";
    if (post.medias != null && post.medias.isNotEmpty) {
      imageUrl = post.medias[0].content;
    }
    showSuccessToast("Sharing...");
    var link = await shortenDynamicLink(Uri.parse(
        '''https://classapp.page.link/?link=https://www.classapp.info?data=${json.encode({
      'type': 'PUBLICATION',
      'id': post.id
    })}
        &apn=ng.com.a7apps.classapp&st=${post.heading.replaceAll(' ', '+')}&sd=${content.replaceAll(' ', '+')}&si=$imageUrl'''));
//    return;
/*
 var link = await shortenDynamicLink(Uri.parse(
        'https://cerchy.page.link/?link='
        'https://www.areabuzz.net/?type=PUBLICATION&postId=${pub.id}&apn=com.cerchy.www.cerchy&amv=1&isi=1451146568&ibi='
        'app.cerchy.cerchyflutterios&st=$content+-Found+on+Cerchy-&si=$imageUrl'));
*/

    if (link != null) {
//      print("Link => $link");
      Share.share("$link");
    }
  }

  static Future<String> shortenDynamicLink(Uri link) async {
    final ShortDynamicLink shortenedLink =
        await DynamicLinkParameters.shortenUrl(
      link,
//    Uri.parse(
//        'https://example.page.link/?link=https://example.com/&apn=com.example.android&ibn=com.example.ios'),
      DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
    );

    final Uri shortUrl = shortenedLink.shortUrl;
    return shortUrl.toString();
  }
}
