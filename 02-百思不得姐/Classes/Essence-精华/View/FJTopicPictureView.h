//
//  FJTopicPictureView.h
//  02-百思不得姐
//
//  Created by mac123 on 16/8/26.
//  Copyright © 2016年 Faniew. All rights reserved.
//   图片帖子中间的内容

#import <UIKit/UIKit.h>
@class FJTopic;

@interface FJTopicPictureView : UIView

+ (instancetype)pictureView;

/** 帖子数据 */
@property (nonatomic,strong) FJTopic *topices;


@end
