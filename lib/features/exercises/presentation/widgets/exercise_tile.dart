import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/config/configs.dart';
import '../../domain/entities/exercise.dart';

class ExerciseWidget extends StatelessWidget {
  final ExerciseEntity? exercise;
  final bool? isRemovable;
  final void Function(ExerciseEntity exercise)? onRemove;
  final void Function(ExerciseEntity exercise)? onExercisePressed;

  const ExerciseWidget({
    Key? key,
    this.exercise,
    this.onExercisePressed,
    this.isRemovable = false,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Container(
        padding: Space.all(),
        height: AppDimensions.normalize(70),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(context),
            Space.x!,
            _buildNameAndDescription(),
            _buildRemovableArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: exercise!.gifUrl!,
        imageBuilder: (context, imageProvider) => Container(
              width: AppDimensions.normalize(55),
              height: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.contain)),
            ),
        progressIndicatorBuilder: (context, url, downloadProgress) => ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.normalize(12)),
              child: Container(
                width: AppDimensions.normalize(55),
                height: double.maxFinite,
                child: CupertinoActivityIndicator(),
                decoration: BoxDecoration(),
              ),
            ),
        errorWidget: (context, url, error) => Padding(
              padding: Space.all(),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppDimensions.normalize(12)),
                child: Container(
                  width: AppDimensions.normalize(55),
                  height: double.maxFinite,
                  child: Icon(Icons.error),
                ),
              ),
            ));
  }

  Widget _buildNameAndDescription() {
    return Expanded(
      child: Padding(
        padding: Space.vf(.4),
        child: Column(
          //  mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise!.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.h3b,
            ),
            Space.y!,
            Padding(
              padding: Space.vf(.3),
              child: Row(
                children: [
                  Icon(
                    Icons.sports_gymnastics,
                    color: Colors.blue,
                    size: AppDimensions.normalize(10),
                  ),
                  Space.xf(.5),
                  Text(
                    "Equpment: ",
                    style: AppText.b2b,
                  ),
                  Text(
                    "${exercise!.equipment}" ?? '',
                    style: AppText.b2,
                  ),
                ],
              ),
            ),

            // Datetime
            Row(
              children: [
                Icon(
                  Icons.personal_injury,
                  color: Colors.blue,
                  size: AppDimensions.normalize(10),
                ),
                Space.xf(.5),
                Text(
                  "Body Part: ",
                  style: AppText.b2b,
                ),
                Text(
                  "${exercise!.bodyPart}" ?? '',
                  style: AppText.b2,
                ),
              ],
            ),
            Space.yf(.2),
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person_search,
                      color: Colors.blue,
                      size: AppDimensions.normalize(10),
                    ),
                    Space.xf(.5),
                    Text(
                      "Secondary muscle: ",
                      style: AppText.b2b,
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: AppDimensions.normalize(50),
                      child: Text(
                        "${exercise!.secondaryMuscles}" ?? '',
                        style: AppText.b2,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRemovableArea() {
    if (isRemovable!) {
      return GestureDetector(
        onTap: _onRemove,
        child: Padding(
          padding: Space.v!,
          child: Icon(Icons.remove_circle_outline, color: Colors.red),
        ),
      );
    }
    return Container();
  }

  void _onTap() {
    if (onExercisePressed != null) {
      onExercisePressed!(exercise!);
    }
  }

  void _onRemove() {
    if (onRemove != null) {
      onRemove!(exercise!);
    }
  }
}