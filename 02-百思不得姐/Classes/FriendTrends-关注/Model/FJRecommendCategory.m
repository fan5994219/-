//
//  FJRecommendCategory.m
//  02-百思不得姐
//
//  Created by mac123 on 16/8/19.
//  Copyright © 2016年 Faniew. All rights reserved.
//  推荐关注   左边的数据模型

#import "FJRecommendCategory.h"

@implementation FJRecommendCategory


+(NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID":@"id"
             
             };
}

- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
