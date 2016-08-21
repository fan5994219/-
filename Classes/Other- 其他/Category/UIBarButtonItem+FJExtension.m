//
//  UIBarButtonItem+FJExtension.m
//  01-百思不得姐
//
//  Created by mac123 on 16/8/19.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "UIBarButtonItem+FJExtension.h"

@implementation UIBarButtonItem (FJExtension)

+ (instancetype)itemWithImage:(NSString *)image hightImage:(NSString *)hightImage target:(id)target action:(SEL)action{
    
    //设置导航栏左边的按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    //自适应 （两种方法都可以）
    [button sizeToFit];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];

    
}
@end
