//
//  FJTopic.h
//  02-百思不得姐
//
//  Created by mac123 on 16/8/24.
//  Copyright © 2016年 Faniew. All rights reserved.
//  帖子

#import <UIKit/UIKit.h>

@interface FJTopic : NSObject

/** 名称 */
@property (nonatomic,copy) NSString *name;

/** 头像 */
@property (nonatomic,copy) NSString *profile_image;

/** 发帖时间 */
@property (nonatomic,copy) NSString *create_time;

/** 发帖内容 */
@property (nonatomic,copy) NSString *text;

/** 顶的数量 */
@property (nonatomic,assign) NSInteger ding;

/** 踩的数量 */
@property (nonatomic,assign) NSInteger cai;

/** 转发数 */
@property (nonatomic,assign) NSInteger repost;

/** 评论数量 */
@property (nonatomic,assign) NSInteger comment;

/** 图片的宽度 */
@property (nonatomic,assign) CGFloat width;

/** 图片的高度 */
@property (nonatomic,assign) CGFloat height;

/** 小图片的URL */
@property (nonatomic,copy) NSString *small_image;
/** 大图片的URL */
@property (nonatomic,copy) NSString *large_image;
/** 中图片的URL */
@property (nonatomic,copy) NSString *middle_image;

/** 帖子的类型 */
@property (nonatomic,assign)  FJTopicType type;

/** 是否为新浪的加V用户 */
@property (nonatomic,assign,getter=issina_v) BOOL sina_v;



/********* 额外的辅助属性 ********/

/** cell模型的高度*/
@property (nonatomic,assign,readonly) CGFloat cellHeight;

/** 图片控件的frame */
@property (nonatomic,assign,readonly)  CGRect pictureF;

/** 图片是否过大 */
@property (nonatomic,assign,getter=isBigPicture) BOOL bigPicture;

/** 图片的下载进度 */
@property (nonatomic,assign) CGFloat pictureProgress;


@end
