//
//  FJTopicVoiceView.h
//  02-百思不得姐
//
//  Created by mac123 on 16/9/1.
//  Copyright © 2016年 Faniew. All rights reserved.
//   声音帖子中间的内容

#import <UIKit/UIKit.h>
@class FJTopic;
@interface FJTopicVoiceView : UIView

+ (instancetype)voiceView;

/** 帖子数据 */
@property (nonatomic,strong) FJTopic *topices;


@end
