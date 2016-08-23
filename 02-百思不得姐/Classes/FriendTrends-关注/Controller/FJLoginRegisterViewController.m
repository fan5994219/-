//
//  FJLoginRegisterViewController.m
//  02-百思不得姐
//
//  Created by mac123 on 16/8/22.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJLoginRegisterViewController.h"

@interface FJLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *showLoginOrRegister;
/** 登录框距离左边的间隙 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation FJLoginRegisterViewController
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showLoginOrRegister:(UIButton *)button {
    
    //退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) { //显示注册界面
        self.loginViewLeftMargin.constant = - self.view.width;
        
        button.selected = YES;
    }else{// 显示登陆界面
        button.selected = NO;

        self.loginViewLeftMargin.constant = 0;
    }
    

    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
        
    }];
}


/**
 *当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


//
//    NSDictionary *dict = @{
//                           NSForegroundColorAttributeName:[UIColor whiteColor],
//
//                           };
//    //NSAttributedString带有属性的文字（富文本）
//    NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:dict];
//
//    self.phoneField.attributedPlaceholder = placeholder;


//    NSDictionary *dict1 = @{
//                            NSForegroundColorAttributeName:[UIColor redColor],
//
//                            };
//
//    NSMutableAttributedString *place = [[NSMutableAttributedString alloc] initWithString:@"手机号" attributes:dict1];
//    NSRange range = {0,1};
//    NSRange range1 = {1,2};
//
//    [place setAttributes:dict range:range];
//    [place setAttributes:dict1 range:range1];


@end
