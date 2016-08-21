//
//  FJNewViewController.m
//  01-百思不得姐
//
//  Created by mac123 on 16/8/18.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJNewViewController.h"

@interface FJNewViewController ()

@end

@implementation FJNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置导航栏内容
    //设置导航栏左边的标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" hightImage:@"MainTagSubIconClick" target:self  action:@selector(tagClick)];
    
}

- (void)tagClick{
    
    NSLog(@"%s",__func__);
    
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
