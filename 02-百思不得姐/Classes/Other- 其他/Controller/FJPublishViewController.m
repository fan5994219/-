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

/**
 
 cocoapods-core (1.0.1)
 cocoapods-deintegrate (1.0.0)
 cocoapods-downloader (1.1.0)
 cocoapods-plugins (1.0.0)
 cocoapods-search (1.0.0)
 cocoapods-stats (1.0.0)
 cocoapods-trunk (1.0.0)
 cocoapods-try (1.1.0)
 TOM:~ mac1$

 */
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
    
//    // 不能被点击
//    self.view.userInteractionEnabled = NO;
//    
//    int beginIndex = 1;
//    
//    for (int i = beginIndex; i<self.view.subviews.count; i++) {
//        UIView *subview = self.view.subviews[i];
//        
//        // 基本动画
//        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
//        CGFloat centerY = subview.centerY + SCREEN_HEIGHT;
//        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
//        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * XMGAnimationDelay;
//        [subview pop_addAnimation:anim forKey:nil];
//        
//        // 监听最后一个动画
//        if (i == self.view.subviews.count - 1) {
//            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
//                // 销毁窗口
//                window_ = nil;
//                
//                // 执行传进来的completionBlock参数
//                !completionBlock ? : completionBlock();
//            }];
//        }
//    }
    
    
}
/**
 pop和Core animation 的区别
 1.Core animation 的动画只能添加到layer上
 2.pop的动画能添加到任意对象
 3.pop的底层并非基于Core animation,而是基于CADisplayLink
 4.Core animation的动画仅仅是表象，并不会真正修改对象的frame\size等值
 5.pop的动画会时时修改对象的属性，是真正的修改了对象的属性
 
 */


//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self cancelWithCompletionBlock:nil];
//}

@end
