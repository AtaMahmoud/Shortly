import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme.dart';
import '../../../util/overflow_extension.dart';
import 'package:shorty/src/util/assets.dart';
class ShortenLinkCard extends StatelessWidget {
  const ShortenLinkCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      shadowColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "https://github.com/ AtaMahmoudAtaaaaaaaaaaaaaaaaa"
                        .overflow,
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                SvgPicture.asset(delete)
              ],
            ),
          ),
          Divider(
            color: AppTheme.lightGray,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              "https://github.com/AtaMahmoudAta",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: AppTheme.cyan),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.center,
              child: Container(
                width: mediaQuery.size.width * .85,
                height: mediaQuery.size.height * .075,
                child: ElevatedButton(onPressed: () {}, child: Text("COPY")),
              )),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
