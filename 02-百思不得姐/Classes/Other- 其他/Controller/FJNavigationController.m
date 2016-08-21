//
//  FJNavigationController.m
//  02-百思不得姐
//
//  Created by mac123 on 16/8/19.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJNavigationController.h"

@interface FJNavigationController ()

@end

@implementation FJNavigationController

/**
 
 第一次使用这个类的时候调用一次
 */
+ (void)initialize{
    
    
    //当导航栏用在FJNavigationController才会生效
//    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];

    //全世界都是自定义的UINavigationBar
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
//    NSLog(@"%s",__func__);

}

- (void)viewDidLoad {
    [super viewDidLoad];

}
/**
 
 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count >0) {//如果push进来的不是第一个控制器
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        //button的contentHorizontalAlignment 设置按钮的位置
        //设置按钮内部使用属性左对齐
//        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        button.size = CGSizeMake(100, 30);
//        button.backgroundColor = [UIColor redColor];
        //自适应
        [button sizeToFit];
        //设置contentEdgeInsets 左边的边距
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        //隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //这句super的push要放在后面，让ViewController覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];

}
- (void)back{
    [self popViewControllerAnimated:YES];
}

@end
