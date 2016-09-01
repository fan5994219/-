//
//  FJTopicCell.m
//  02-百思不得姐
//
//  Created by mac123 on 16/8/24.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJTopicCell.h"
#import "FJTopic.h"
#import "FJTopicPictureView.h"
#import "FJTopicVoiceView.h"
#import "FJTopicVideoView.h"
@interface FJTopicCell ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLable;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享转发 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

/** 是否加如新浪V*/
@property (weak, nonatomic) IBOutlet UIImageView *sinaVview;
/** 帖子的文字内容*/
@property (weak, nonatomic) IBOutlet UILabel *text_lable;

/** 图片帖子中的内容 */
@property (nonatomic,weak) FJTopicPictureView *pictureView;

/** 声音帖子中的内容 */
@property (nonatomic,weak) FJTopicVoiceView *voiceView;

/** 视频帖子中的内容 */
@property (nonatomic,weak) FJTopicVideoView *videoView;



@end

@implementation FJTopicCell

#pragma mark -
#pragma mark - 懒加载

- (FJTopicPictureView *)pictureView
{
    if (!_pictureView) {
       FJTopicPictureView *pictureView = [FJTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (FJTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        FJTopicVoiceView *voiceView = [FJTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (FJTopicVideoView *)videoView
{
    if (!_videoView) {
        FJTopicVideoView *videoView = [FJTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}


- (void)awakeFromNib{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    
    self.backgroundView = bgView;
}

- (void)setTopices:(FJTopic *)topices{
    _topices = topices;
    
    //设置新浪加V
    
    self.sinaVview.hidden = !topices.sina_v;
    
    //设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topices.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置帖子创建时间
    self.createTimeLable.text = topices.create_time;
    //设置昵称
    self.nameLable.text = topices.name;

    //设置帖子的文字内容
    self.text_lable.text = topices.text;
    
    
    //设置按钮的文字
    [self setupButtonTitle:self.dingButton count:topices.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topices.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topices.repost   placeholder:@"转发"];
    [self setupButtonTitle:self.commentButton count:topices.comment placeholder:@"评论"];
    
    //根据帖子的内容添加对应的内容添加到帖子内
    
    if (topices.type == FJTopicTypePicture) { //图片帖子
        self.pictureView.hidden = NO;
        
        self.pictureView.topices = topices;
        self.pictureView.frame = topices.pictureF;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        
    }else if (topices.type == FJTopicTypeVoice){ //声音帖子
        self.voiceView.hidden = NO;

        self.voiceView.frame = topices.voiceViewF;
        self.voiceView.topices = topices;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    
    }else if (topices.type == FJTopicTypeVideo){  //视频帖子
        self.videoView.hidden = NO;
        
        self.videoView.frame = topices.videoViewF;
        self.videoView.topices = topices;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    }else{  //段子帖子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    
}
/*
 
今年：
 今天 
     1分钟前 ：刚刚
     1小时前 ：35分钟前
     其他 ：几小时前
 
 昨天：
      昨天 18:35分
 其他  
      06-25 16:55
 
 
 
不是今年：2015-05-17 18:45:35
 
 */


/**  
 * 学习时间比较date
 */
- (void)testDate:(NSString *)create_time
{
    
    //格式化日期类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期格式(y:年，M:月，d:日，H:时，m:分，s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //当前时间
    NSDate *nowDate = [NSDate date];
    //发帖时间   NSString -->Date
    NSDate *creat = [fmt dateFromString:create_time];
    
    FJLog(@"%@",[creat deltaFrom:nowDate]);
    
    
    //获得NSDate每一个元素
//   NSInteger year = [calendar component:NSCalendarUnitYear fromDate:nowDate];
//    NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:nowDate];
//    NSInteger day = [calendar component:NSCalendarUnitDay fromDate:nowDate];

//    FJLog(@"%zd,%zd,%zd",year,month,day);
   
//    
//    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:nowDate];
//    
//        FJLog(@"%@ \n%zd,%zd,%zd",cmps,cmps.year,cmps.month,cmps.day);

    
}

//- (void)testDate:(NSString *)create_time
//{
//    //当前时间
//    NSDate *nowDate = [NSDate date];
//    //NSString -->Date
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    //设置日期格式(y:年，M:月，d:日，H:时，m:分，s:秒)
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    //发帖时间
//    NSDate *creat = [fmt dateFromString:create_time];
//    //时间差
//    NSTimeInterval delta=[nowDate timeIntervalSinceDate:creat];
//    FJLog(@"%@  %f",create_time,delta);
//}


/** 设置按钮的文字*/
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger )count placeholder:(NSString *)placeholder
{
    if (count >10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }else if(count >0){
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}



- (void)setFrame:(CGRect)frame{

    
    frame.origin.x =FJTopicCellMargin;
    frame.size.width -=2 *frame.origin.x;
    frame.size.height -=FJTopicCellMargin;
    frame.origin.y += FJTopicCellMargin;
    
    
    [super setFrame:frame];
}

@end
