//
//  UIView+FJUIView.h
//  01-百思不得姐
//
//  Created by mac123 on 16/8/18.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FJUIView)
/** size */
@property (nonatomic,assign) CGSize size;
/** width */
@property (nonatomic,assign) CGFloat width;

/** height */
@property (nonatomic,assign) CGFloat height;

/** x */
@property (nonatomic,assign) CGFloat x;

/** y */
@property (nonatomic,assign) CGFloat y;


/** 在分类中声明@property,只会生成方法的声明，不会生成方法的实现和带有下划线的成员变量  */
@end
