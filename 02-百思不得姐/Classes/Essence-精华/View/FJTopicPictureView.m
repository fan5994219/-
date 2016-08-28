//
//  FJTopicPictureView.m
//  02-百思不得姐
//
//  Created by mac123 on 16/8/26.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJTopicPictureView.h"
#import "FJTopic.h"
#import "FJShowPictureViewController.h"
#import "FJProgressView.h"

@interface FJTopicPictureView ()

/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** git标示 */
@property (weak, nonatomic) IBOutlet UIImageView *gitView;
/** 点击查看全图按钮*/
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
/** 进度条控件*/
@property (weak, nonatomic) IBOutlet FJProgressView *progressView;

@end

@implementation FJTopicPictureView

+ (instancetype)pictureView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (void)awakeFromNib{ //防止Autoresizing自动修改frame
    self.autoresizingMask = UIViewAutoresizingNone;
    self.progressView.roundedCorners = 2;
    
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
    
    
    //立马显示最新的进度值(防止网速慢，显示其他cell)
    [self.progressView setProgress:topices.pictureProgress animated:YES];
    
    
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topices.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        topices.pictureProgress= 1.0 *receivedSize /expectedSize;
        [self.progressView setProgress:topices.pictureProgress animated:YES];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        //如果是大图片才需要绘图的处理
        if (topices.isBigPicture == NO) return ;
        
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topices.pictureF.size, YES, 0.0);
        
        //将下载完的image对象绘制到图形上下文中
        
        CGFloat width =topices.pictureF.size.width;
        CGFloat height =width *image.size.height/image.size.width;
        
        [image drawInRect:CGRectMake(0, 0,width,height)];
        
        //获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        
        //结束图形上下文
        
        UIGraphicsEndImageContext();
        
    }];
    
    //判断是否为gif   /*SDWebImage 取出图片数据的第一个字节，就可以判断出图片的真实类型   */
    NSString *extention = topices.large_image.pathExtension;
    self.gitView.hidden =![extention.lowercaseString isEqualToString:@"gif"];
    //判断是否显示“点击查看全图按钮”
    
    if (topices.isBigPicture) {  //大图
    self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill; //只显示上部分
    }else{  //非大图
    self.seeBigButton.hidden = YES;
        
    self.imageView.contentMode = UIViewContentModeScaleToFill; //默认填充
    }
    
    
    
    
    
}

@end
