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
#import "FJNavigationController.h"

@interface FJTabBarController ()

@end

@implementation FJTabBarController

//只调用一次
+ (void)initialize{
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

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**颜色小常识 RGB 24bit颜色 （颜色通道常识）
     
     * #ff0000 红色
     * #00ff00 绿色
     * #0000ff 蓝色
     * #000000 黑色
     * #ffffff 白色
     
     特殊色：灰色 RGB相同
     
     1024*1024像素 32bit颜色的文件大小
     
     1024*1024*32/8 = 1024*1024*4
     
     1024*1024*24/8 = 1024*1024*3
     
     */
    
    
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
    //设置统一色
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:seletedImage];

    //包装一个导航控制器，添加导航控制器为tabBarController的子控制器
    FJNavigationController *navVC = [[FJNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:navVC];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
