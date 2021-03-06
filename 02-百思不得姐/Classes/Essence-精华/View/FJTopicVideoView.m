//
//  FJTopicVideoView.m
//  02-百思不得姐
//
//  Created by mac123 on 16/9/1.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJTopicVideoView.h"
#import "FJTopic.h"
#import "FJShowPictureViewController.h"

@interface FJTopicVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLable;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLable;

@end

@implementation FJTopicVideoView

+ (instancetype)videoView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}


- (void)awakeFromNib{ //防止Autoresizing自动修改frame
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
    
}

- (void)showPicture{
    FJShowPictureViewController *showPictureVC = [[FJShowPictureViewController alloc] init];
    showPictureVC.topic = self.topices;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPictureVC animated:YES completion:nil];
    
}

- (void)setTopices:(FJTopic *)topices{
    _topices = topices;
    
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topices.large_image]];
    
    //播放次数
    self.playcountLable.text = [NSString stringWithFormat:@"%zd播放",topices.playcount];
    
    //音频时长
    NSInteger minute = topices.videotime/60;
    
    NSInteger second = topices.videotime % 60;
    
    self.videotimeLable.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];

    
}


@end
