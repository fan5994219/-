//
//  UIBarButtonItem+FJExtension.h
//  01-百思不得姐
//
//  Created by mac123 on 16/8/19.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (FJExtension)

+ (instancetype)itemWithImage:(NSString *)image hightImage:(NSString *)hightImage target:(id)target action:(SEL)action;

@end
