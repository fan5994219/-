//
//  FJProgressView.m
//  02-百思不得姐
//
//  Created by mac123 on 16/8/27.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJProgressView.h"

@implementation FJProgressView


- (void)awakeFromNib{
    self.roundedCorners = 2;

    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%",progress *100];
    
    text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    self.progressLabel.text = text;
}

@end
