//
//  FJTabBar.m
//  01-百思不得姐
//
//  Created by mac123 on 16/8/18.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJTabBar.h"
#import "FJPublishViewController.h"

@interface FJTabBar ()


/** 发布按钮 */
@property (nonatomic,strong) UIButton *publishButton;


@end

@implementation FJTabBar



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //设置背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];

        //添加发布按钮
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        
        //自适应
        [publishButton sizeToFit];

        self.publishButton = publishButton;

        [self addSubview:publishButton];

        
    }
    return self;
}


- (void)publishClick{
    
    FJPublishViewController *publishVC = [[FJPublishViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:NO completion:nil];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    //设置发布按钮的frame
    
    CGFloat width = self.width;
    
    CGFloat height = self.height;
    
//    self.publishButton.width =self.publishButton.currentBackgroundImage.size.width;
//    self.publishButton.height =self.publishButton.currentBackgroundImage.size.height;
    //自适应
//    [self.publishButton sizeToFit];
    //或者是
//    self.publishButton.size = self.publishButton.currentBackgroundImage.size;
    
    
    self.publishButton.center = CGPointMake(width *0.5, height *0.5);

    
    //设置其他按钮的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width/5;
    CGFloat buttonH = height;
    //创建索引
    NSInteger index = 0;
    //遍历子视图
    for (UIButton *button in self.subviews) {
        
        //两种判断方式都可以
//        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;

        //计算按钮的X值
        CGFloat buttonX = buttonW *((index>1)? index +1:index);
        //增加索引
        index++;
        //其他子视图的frame
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        
    }
    
    

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
