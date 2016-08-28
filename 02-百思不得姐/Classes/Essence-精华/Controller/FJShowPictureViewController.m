//
//  FJShowPictureViewController.m
//  02-百思不得姐
//
//  Created by mac123 on 16/8/27.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJShowPictureViewController.h"
#import "FJProgressView.h"
#import "FJTopic.h"

@interface FJShowPictureViewController ()
/** UIScrollView*/
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/** UIImageView */
@property (nonatomic,strong) UIImageView *imageView;

@property (weak, nonatomic) IBOutlet FJProgressView *progressView;

@end

@implementation FJShowPictureViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)]];
    self.imageView = imageView;
    
    [self.scrollView addSubview:imageView];
    
    //图片尺寸
    CGFloat pictureW =SCREEN_WIDTH;
    CGFloat pictureH = pictureW *self.topic.height /self.topic.width;
    
    if (pictureH > SCREEN_HEIGHT) { //图片显示超过一个屏幕，需要滚动查看
    
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }else{
       imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = SCREEN_HEIGHT *0.5;
    }
    
    //马上显示当前图片最新的下载进度
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    
    //图片下载
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        [self.progressView setProgress:1.0 *receivedSize /expectedSize animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];

    
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)save:(id)sender {
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片没有下载完毕"];
        return;
    }
    
    //将图片保存到相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{

    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];

    }
    
}
@end
