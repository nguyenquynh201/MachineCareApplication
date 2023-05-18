import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:machine_care/constants/app_colors.dart';
import 'package:machine_care/constants/app_images.dart';
import 'package:machine_care/constants/app_text_styles.dart';
import 'package:machine_care/utils/string_utils.dart';
import 'package:machine_care/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../ui.dart';


class WidgetComment extends StatefulWidget {
  const WidgetComment(
      {Key? key,
        required this.comment,
        this.isReplay = false,
        required this.controller,
        required this.index})
      : super(key: key);
  final CommentEntity comment;
  final bool isReplay;
  final RepairDetailController controller;
  final int index;

  @override
  State<WidgetComment> createState() => _WidgetCommentViewState();
}

class _WidgetCommentViewState extends State<WidgetComment> {
  bool isReplay = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateUTC = widget.comment.createdAt!;
    DateTime dateNow = dateUTC.toLocal();
    String convertedDateTime = StringUtils.getDifferenceTimeString(dateStr: dateNow.toString());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.comment.userId == null)
          _buildThumbnailDefault()
        else if (widget.comment.userId!.avatar != null)
          WidgetThumbnail(url: widget.comment.userId!.avatar!)
        else
          _buildThumbnailDefault(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(
                    left: 10),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(
                      8),
                  border: Border.all(color: AppColor.lineColor, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.comment.userId != null)
                      _buildTitle(
                          title: '${(widget.comment.userId!.fullName)}')
                    else
                      _buildTitle(title: '${(widget.comment.userName)}'),
                    const SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      width: Get.width,
                      child: Linkify(
                        onOpen: (link) async {
                          if (await canLaunch(link.url)) {
                            await launch(link.url);
                          } else {
                            throw 'Could not launch $link';
                          }
                        },
                        maxLines: 10,
                        softWrap: true,
                        text: '${widget.comment.contentComment}',
                        style: AppTextStyles.customTextStyle().copyWith(
                            fontSize:13,
                            color: AppColor.colorTitleHome,
                            fontFamily: Fonts.Quicksand.name,
                            fontWeight: FontWeight.w400),
                        linkStyle: TextStyle(
                            fontSize:13,
                            color: AppColor.primary,
                            fontWeight: FontWeight.w400,
                            fontFamily: Fonts.Quicksand.name,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isReplay == true) {
                            isReplay = false;
                          } else {
                            isReplay = true;
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            'replys'.tr,
                            style: AppTextStyles.customTextStyle().copyWith(
                                fontSize: 13,
                                color: AppColor.colorButton,
                                fontFamily: Fonts.Quicksand.name,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (isReplay == false &&
                              widget.controller.comments
                                  .elementAt(widget.index)
                                  .replys.isNotEmpty)
                            Text(
                              '${widget.controller.comments.elementAt(widget.index).replys.length} ${'replys'.tr}',
                              style: AppTextStyles.customTextStyle().copyWith(
                                  fontSize: 13,
                                  color: AppColor.primary,
                                  fontFamily: Fonts.Quicksand.name,
                                  fontWeight: FontWeight.w600),
                            )
                          else
                            Container()
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      convertedDateTime,
                      style: AppTextStyles.customTextStyle().copyWith(
                          fontSize: 12,
                          color: AppColor.colorTitleHome,
                          fontFamily: Fonts.Quicksand.name,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: DimensManager.dimens.setHeight(10),
              // ),
              // if (isReplay == true)
              //   Column(
              //     children: [
              //       if (viewModel.comment
              //           .elementAt(widget.index)
              //           .replys
              //           .isNotEmpty)
              //         SizedBox(
              //             child: _buildListComment(
              //                 comment: viewModel.comment
              //                     .elementAt(widget.index)
              //                     .replys))
              //       else
              //         Container(),
              //       SizedBox(
              //         height: DimensManager.dimens.setHeight(16),
              //       ),
              //       _buildContentComment(idComment: widget.comment.id)
              //     ],
              //   )
              // else
              //   Container()
            ],
          ),
        )
      ],
    );
  }

  // Widget _buildListComment({required List<CommentEntity> comment}) {
  //   return ListView.separated(
  //       physics: const NeverScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       itemBuilder: (_, index) {
  //         if (comment.isEmpty) {
  //           return Container();
  //         } else {
  //           return _buildItemComment(
  //             comment.elementAt(index),
  //           );
  //         }
  //       },
  //       separatorBuilder: (_, index) {
  //         return Divider(
  //           thickness: 1,
  //           color: UIColors.colorLine,
  //         );
  //       },
  //       itemCount: comment.length);
  // }

  // Widget _buildItemComment(CommentEntity comment) {
  //   DateTime dateUTC = comment.createdAt!;
  //   DateTime dateNow = dateUTC.toLocal();
  //
  //   String convertedDateTime =
  //       " ${dateNow.hour.toString().padLeft(2, '0')}:${dateNow.minute.toString().padLeft(2, '0')} ${dateNow.day.toString().padLeft(2, '0')}Thg${dateNow.month.toString().padLeft(2, '0')}";
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       if (comment.userId!.avatar != null)
  //         _buildThumbnail(avatar: comment.userId!.avatar!)
  //       else
  //         _buildThumbnailDefault(),
  //       Expanded(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Container(
  //               padding: EdgeInsets.all(DimensManager.dimens.setRadius(10)),
  //               margin:
  //               EdgeInsets.only(left: DimensManager.dimens.setHeight(10)),
  //               decoration: BoxDecoration(
  //                 color: UIColors.white,
  //                 borderRadius:
  //                 BorderRadius.circular(DimensManager.dimens.setRadius(8)),
  //                 border: Border.all(color: UIColors.colorLine, width: 1),
  //               ),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   if (comment.userId != null)
  //                     _buildTitle(title: '${comment.userId!.fullName}')
  //                   else
  //                     _buildTitle(title: '${comment.userName}'),
  //                   SizedBox(
  //                     height: DimensManager.dimens.setHeight(4),
  //                   ),
  //                   Container(
  //                     width: DimensManager.dimens.fullWidth,
  //                     child: Linkify(
  //                       onOpen: (link) async {
  //                         if (await canLaunch(link.url)) {
  //                           await launch(link.url);
  //                         } else {
  //                           throw 'Could not launch $link';
  //                         }
  //                       },
  //                       maxLines: 10,
  //                       softWrap: true,
  //                       text: '${comment.contentComment}',
  //                       style: TextStyle(
  //                           fontSize: DimensManager.dimens.setSp(13),
  //                           color: UIColors.title,
  //                           fontWeight: FontWeight.w400),
  //                       linkStyle: TextStyle(
  //                           fontSize: DimensManager.dimens.setSp(13),
  //                           color: UIColors.primary,
  //                           fontWeight: FontWeight.w400,
  //                           decoration: TextDecoration.underline),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(
  //               height: DimensManager.dimens.setHeight(10),
  //             ),
  //             Container(
  //               margin:
  //               EdgeInsets.only(left: DimensManager.dimens.setHeight(20)),
  //               child: Row(
  //                 children: [
  //                   SizedBox(
  //                     width: DimensManager.dimens.setHeight(10),
  //                   ),
  //                   UIText(
  //                     convertedDateTime,
  //                     style: TextStyle(
  //                         fontSize: DimensManager.dimens.setSp(12),
  //                         color: UIColors.title,
  //                         fontWeight: FontWeight.w400),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }



  Widget _buildThumbnailDefault() {
    return Container(
      height: 40,
      width: 40,
      child: ClipRRect(
          borderRadius:
          BorderRadius.circular(24),
          child: Image.asset(
            AppImages.icNoAvatar,
            height: 40,
            width: 40,
            fit: BoxFit.contain,
          )),
    );
  }

  // Widget _buildContentComment({required String idComment}) {
  //   return Row(
  //     children: [
  //       Selector<OrderDetailViewModel, String?>(
  //         selector: (_, viewModel) => viewModel.avatar,
  //         builder: (_, avatar, __) {
  //           return _buildThumbnail(avatar: avatar);
  //         },
  //       ),
  //       SizedBox(
  //         width: DimensManager.dimens.setWidth(10),
  //       ),
  //       Consumer<OrderDetailViewModel>(builder: (_, viewModel, __) {
  //         return Expanded(
  //           child: _buildInput(
  //               hint: Strings.of(context).postComment,
  //               controller: _commentController,
  //               onFocus: widget.orderDetailViewModel.onFocusReplyContent,
  //               onChanged: widget.orderDetailViewModel.onChangedReplyContent,
  //               iconRight: Container(
  //                 margin:
  //                 EdgeInsets.only(right: DimensManager.dimens.setWidth(10)),
  //                 child: Consumer<OrderDetailViewModel>(
  //                   builder: (_, viewModel, __) {
  //                     if (viewModel.isLoadingReply == true) {
  //                       return Container(
  //                           width: DimensManager.dimens.setWidth(13),
  //                           height: DimensManager.dimens.setWidth(13),
  //                           child: CircularProgressIndicator(
  //                             strokeWidth: 1,
  //                             color: UIColors.primary,
  //                           ));
  //                     } else {
  //                       return Container(
  //                         width: DimensManager.dimens.setWidth(35),
  //                         height: DimensManager.dimens.setWidth(35),
  //                         child: Center(
  //                           child: UIText(
  //                             Strings.of(context).sendComment,
  //                             style: TextStyle(
  //                                 color: UIColors.primary,
  //                                 fontSize: DimensManager.dimens.setSp(13)),
  //                           ),
  //                         ),
  //                       );
  //                     }
  //                   },
  //                 ),
  //               ),
  //               onRightIconPressed: () {
  //                 if (_commentController.text.isEmpty) {
  //                   ToastWidget.showToast(message: "Vui lòng nhập nội dung");
  //                 } else {
  //                   FocusScope.of(context).unfocus();
  //                   viewModel.addReplyComment(idComment);
  //                   // viewModel.fetchCommentOrdersById(orderId: idComment);
  //                   _commentController.clear();
  //                 }
  //               }),
  //         );
  //       })
  //     ],
  //   );
  // }

  Widget _buildTitle({required String title}) {
    return Text(
      title,
      style: AppTextStyles.customTextStyle().copyWith(
          fontSize: 13,
          color: AppColor.colorButton,
          fontFamily: Fonts.Quicksand.name,
          fontWeight: FontWeight.w600),
    );
  }

  Widget _buildInput({
    String? name,
    String? description,
    String? unit,
    String? hint,
    String? errorMessage,
    TextEditingController? controller,
    TextInputType? keyboardType,
    Function(String)? onChanged,
    VoidCallback? onRightIconPressed,
    VoidCallback? onFocus,
    Widget? iconRight,
  }) {
    return UIInputComment(
      hint: hint,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onFocus: onFocus,
      controller: controller,
      errorMessage: errorMessage,
      onRightIconPressed: onRightIconPressed,
      iconRight: iconRight,
    );
  }
}
