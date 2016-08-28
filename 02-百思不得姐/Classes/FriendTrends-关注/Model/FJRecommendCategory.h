//
//  FJRecommendCategory.h
//  02-百思不得姐
//
//  Created by mac123 on 16/8/19.
//  Copyright © 2016年 Faniew. All rights reserved.
//  推荐关注   左边的数据模型

#import <Foundation/Foundation.h>

@interface FJRecommendCategory : NSObject

/**************** 网络数据 *******************/

/** id */
@property (nonatomic,assign) NSInteger ID;

/** 总数 */
@property (nonatomic,assign) NSInteger count;

/** 名字 */
@property (nonatomic,copy) NSString *name;

/*************** 用户数据  ********************/

/** 这个类别对应的用户数据 */
@property (nonatomic,strong) NSMutableArray *users;

/** 总数 */
@property (nonatomic,assign) NSInteger total;

/** 当前页码 */
@property (nonatomic,assign) NSInteger current_page;






@end
