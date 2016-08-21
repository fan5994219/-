//
//  FJTabBarController.m
//  01-百思不得姐
//
//  Created by mac123 on 16/8/18.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJTabBarController.h"
#import "FJEssenceViewController.h"
#import "FJNewViewController.h"
#import "FJFriendTrendsViewController.h"
#import "FJMeViewController.h"
#import "FJTabBar.h"

@interface FJTabBarController ()

@end

@implementation FJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

//    创建子控制
    
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                           NSForegroundColorAttributeName:[UIColor grayColor]
                           
                           };
    
    NSDictionary *selectDict = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                 NSForegroundColorAttributeName:[UIColor darkGrayColor]
                                 
                                 };
    //通过appearance统一设置UITabBarItem的文字属性
    //只要是后面带有UI_APPEARANCE_SELECTOR的方法都可以通过appearance统一设置
    UITabBarItem *item = [UITabBarItem appearance];
    
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectDict forState:UIControlStateSelected];
    
    [self setupChildVc:[[FJEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" seletedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVc:[[FJNewViewController alloc] init] title:@"最新" image:@"tabBar_new_icon" seletedImage:@"tabBar_new_click_icon"];
    
    [self setupChildVc:[[FJFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" seletedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVc:[[FJMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" seletedImage:@"tabBar_me_click_icon"];
    
    //自定义TabBar
    
    [self setValue:[[FJTabBar alloc] init] forKey:@"tabBar"];
    
    
}


/** 
  初始化控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image seletedImage:(NSString *)seletedImage{
    
    //设置文字图片
    vc.navigationItem.title = title;
    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:seletedImage];

    //包装一个导航控制器，添加导航控制器为tabBarController的子控制器
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:navVC];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
