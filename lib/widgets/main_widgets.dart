import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/data/constants/constants.dart';
import 'package:weather_app/utils/utils.dart';

// PopupMenuButton<PopUpModel> buildMainPopUp({
//   required BuildContext context,
//   required List<PopUpModel> popUpItems,
// }) {
//   return PopupMenuButton<PopUpModel>(
//     tooltip: StringsKeys.more.tr(),
//     padding: EdgeInsets.zero,
//     icon: const Icon(Icons.more_vert),
//     onSelected: (v) => v.func(),
//     onCanceled: () => FocusScope.of(context).unfocus(),
//     itemBuilder: (_) {
//       return popUpItems.map((PopUpModel e) {
//         return PopupMenuItem<PopUpModel>(
//           value: e,
//           child: Text(e.title),
//         );
//       }).toList();
//     },
//   );
// }

RichText buildTempText({
  required BuildContext context,
  required double? temp,
}) {
  return RichText(
    text: TextSpan(
      text: temp!.toStringAsFixed(0),
      style: Theme.of(context).textTheme.headline6,
      children: <TextSpan>[
        TextSpan(
          text: '° C',
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    ),
  );
}

ClipRRect buildWeatherIcon(String? icon) {
  return ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(0)),
    child: SizedBox(
      width: 84,
      height: 84,
      child: buildNetworkImage(
        icon,
      ),
    ),
  );
}

Container buildNetworkImage(String? url, {bool isProgress = false}) {
  return Container(
    color: Colors.black.withOpacity(0.03),
    child: url == null
        ? buildMediaErrorIcon()
        : url.isEmpty
            ? buildMediaErrorIcon()
            : Image.network(
                url,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return isProgress ? getProgress() : const Offstage();
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return buildMediaErrorIcon();
                },
              ),
  );
}

ColoredBox getProgress() {
  return ColoredBox(
    color: Colors.white,
    child: Center(
      child: kIsWeb
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Constants.green),
            )
          : Platform.isIOS || Platform.isMacOS
              ? const CupertinoActivityIndicator()
              : const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Constants.green),
                ),
    ),
  );
}

Center buildMediaErrorIcon() {
  return const Center(
    child: Icon(Icons.error_outline),
  );
}
