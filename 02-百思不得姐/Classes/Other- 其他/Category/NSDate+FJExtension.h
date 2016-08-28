//
//  NSDate+FJExtension.h
//  02-百思不得姐
//
//  Created by mac123 on 16/8/25.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (FJExtension)
/**
 * 比较from和self的差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 * 是否是今年
 */
- (BOOL)isThisYear;

/**
 * 是否是今天
 */
- (BOOL)isThisDay;
/**
 * 是否是昨天
 */
- (BOOL)isYesterDay;

@end
