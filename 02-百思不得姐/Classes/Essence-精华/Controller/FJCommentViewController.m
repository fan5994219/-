//
//  FJCommentViewController.m
//  02-百思不得姐
//
//  Created by mac123 on 16/9/7.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJCommentViewController.h"

@interface FJCommentViewController ()<UITableViewDelegate>
/** 工具条底部间距*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;

@end

@implementation FJCommentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //基本设置
    [self setupBasic];
    
}

- (void)setupBasic{
    
    self.title =@"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" hightImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

}


- (void)keyboardWillChangeFrame:(NSNotification *)note{
    
    //键盘显示或隐藏最后的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomSapce.constant = SCREEN_HEIGHT - frame.origin.y;
    
    //动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - <UITableViewDelegate>

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
