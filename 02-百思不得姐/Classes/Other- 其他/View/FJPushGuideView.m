//
//  FJPushGuideView.m
//  02-百思不得姐
//
//  Created by mac123 on 16/8/23.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJPushGuideView.h"

@implementation FJPushGuideView


+ (void)show{
    static  NSString *key = @"CFBundleShortVersionString";
    
    
    //获得当前软件的版本号
    NSString *currentVersion= [NSBundle mainBundle].infoDictionary[key];
    //获取沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        FJPushGuideView *guideView = [FJPushGuideView guideView];
        guideView.frame =window.bounds;
        [window addSubview:guideView];
        
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        //立即存储
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
    }

}

+ (instancetype)guideView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FJPushGuideView class]) owner:nil options:nil] lastObject];
}
- (IBAction)close:(id)sender {
    
    [self removeFromSuperview];
    
}
@end
