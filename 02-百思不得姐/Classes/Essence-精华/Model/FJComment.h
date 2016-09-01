//
//  FJComment.h
//  02-百思不得姐
//
//  Created by mac123 on 16/9/1.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FJUser;
@interface FJComment : NSObject

/** 音频文件的时长 */
@property (nonatomic,assign) NSInteger voicetime;

/** 评论的文字内容 */
@property (nonatomic,copy) NSString *content;

/** 被点赞的数量 */
@property (nonatomic,assign) NSInteger like_count;


/** 用户 */
@property (nonatomic,strong) FJUser *user;


@end
