//
//  FJPublishViewController.m
//  02-百思不得姐
//
//  Created by mac123 on 16/8/28.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJPublishViewController.h"
#import "FJVerticalButton.h"
@interface FJPublishViewController ()

@end

@implementation FJPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.y = SCREEN_HEIGHT *0.2;
    sloganView.centerX = SCREEN_WIDTH *0.5;
    
    [self.view addSubview:sloganView];
    
    
    //数据
    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审贴",@"离线下载"];

    
    //中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartX = 15;
    CGFloat buttonStartY = (SCREEN_HEIGHT - 2*buttonH) *0.5;
    CGFloat margin =(SCREEN_WIDTH - 2*buttonStartX -buttonW *maxCols)/(maxCols -1);
    for (int i = 0; i<images.count; i++) {
        FJVerticalButton *button = [[FJVerticalButton alloc] init];
        
        //设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        int row = i/maxCols;
        int col = i%maxCols;
        button.x = buttonStartX + col *(margin +buttonW);
        button.y = buttonStartY + row *(buttonH + buttonStartX);
        button.width = buttonW;
        button.height = buttonH;

        [self.view addSubview:button];
    }
    
    

}
- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}


@end
