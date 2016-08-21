//
//  FJFriendTrendsViewController.m
//  01-百思不得姐
//
//  Created by mac123 on 16/8/18.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJFriendTrendsViewController.h"
#import "FJRecommendViewController.h"

@interface FJFriendTrendsViewController ()

@end

@implementation FJFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏左边的标题
    self.navigationItem.title= @"我的关注";
    //设置导航栏左边的按钮    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" hightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsButton)];
    self.view.backgroundColor = FJRGBColor(223, 223, 223);



}


- (void)friendsButton{

    FJRecommendViewController *vc = [[FJRecommendViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
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
