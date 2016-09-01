//
//  FJUser.h
//  02-百思不得姐
//
//  Created by mac123 on 16/9/1.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJUser : NSObject

/** 用户名 */
@property (nonatomic,copy) NSString *username;

/** 性别 */
@property (nonatomic,copy) NSString *sex;

/** 头像 */
@property (nonatomic,copy) NSString *profile_image;


@end
