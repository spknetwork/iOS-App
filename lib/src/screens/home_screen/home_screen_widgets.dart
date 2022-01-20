import 'package:acela/src/bloc/server.dart';
import 'package:acela/src/models/home_screen_feed_models/home_feed_models.dart';
import 'package:acela/src/utils/seconds_to_duration.dart';
import 'package:acela/src/widgets/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreenWidgets {
  Widget loadingData() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: const Center(
        child: Text('Loading Data'),
      ),
    );
  }

  Widget _tileTitle(HomeFeed item, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3,
            blurStyle: BlurStyle.outer,
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/branding/three_speak_logo.png',
            image: item.baseThumbUrl,
          ),
          Container(
            height: 5,
          ),
          Row(
            children: [
              CustomCircleAvatar(
                  height: 40,
                  width: 40,
                  url: server.userOwnerThumb(item.owner)),
              Container(
                width: 5,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Text(
                      "📆 ${timeago.format(item.created)} 👤 ${item.owner} 🕚 ${Utilities.formatTime(item.duration.toInt())}",
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _listTile(HomeFeed item, BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListTile(
        title: _tileTitle(item, context),
        onTap: () {
          debugPrint("Hello world");
        },
      ),
    );
  }

  Widget list(List<HomeFeed> list) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return _listTile(list[index], context);
        },
        separatorBuilder: (context, index) => const Divider(
              thickness: 0,
              height: 0,
              color: Colors.transparent,
            ),
        itemCount: list.length);
  }
}
