//
//  FJMeViewController.m
//  01-百思不得姐
//
//  Created by mac123 on 16/8/18.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJMeViewController.h"

@interface FJMeViewController ()

@end

@implementation FJMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏左边的标题
    self.navigationItem.title= @"我的";
    //设置导航栏右边的按钮
    
    UIBarButtonItem *settingButton = [UIBarButtonItem itemWithImage:@"mine-setting-icon" hightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    UIBarButtonItem *moonButton = [UIBarButtonItem itemWithImage:@"mine-moon-icon" hightImage:@"mine-moon-icon-click" target:self action:@selector(nightModeClick)];

    self.navigationItem.rightBarButtonItems = @[settingButton,
                                                moonButton
    
                                                ];
    self.view.backgroundColor = FJRGBColor(223, 223, 223);

    
}

- (void)nightModeClick{
    
    FJLog(@"%s",__func__);
}

- (void)settingClick{
    
    FJLog(@"%s",__func__);
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
