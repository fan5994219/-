//
//  FJFriendTrendsViewController.m
//  01-百思不得姐
//
//  Created by mac123 on 16/8/18.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJFriendTrendsViewController.h"

@interface FJFriendTrendsViewController ()

@end

@implementation FJFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏左边的标题
    self.navigationItem.title= @"我的关注";
    //设置导航栏左边的按钮    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" hightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsButton)];

    
}

- (void)friendsButton{

    NSLog(@"%s",__func__);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
