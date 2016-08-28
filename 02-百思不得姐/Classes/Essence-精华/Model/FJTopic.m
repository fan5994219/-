//
//  FJTopic.m
//  02-百思不得姐
//
//  Created by mac123 on 16/8/24.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJTopic.h"
@implementation FJTopic

{
    CGFloat _cellHeight;
    CGRect _pictureF;
}

+(NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"small_image":@"image0",
             @"middle_image":@"image2",
             @"large_image":@"image1"
             
             };
    
}
- (NSString *)create_time
{
    
    
    
        //格式化日期类  //自定义时间
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        //设置日期格式(y:年，M:月，d:日，H:时，m:分，s:秒)
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
        //发帖时间   NSString -->Date
        NSDate *creat =[fmt dateFromString:_create_time];
    
        if (creat.isThisYear) { //今年
            if (creat.isThisDay) { //今天
               NSDateComponents *cmps= [[NSDate date] deltaFrom:creat];
    
                if (cmps.hour >= 1) { //时间差距 大于1小时
    
                    return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
    
                }else if (cmps.minute >=1){ //时间差距 大于1分钟 小于1小时
    
                    return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
    
    
                } //时间差距 不到一分钟 刚刚
    
          return @"刚刚";
    
    
            }else if (creat.isYesterDay){ //昨天
                fmt.dateFormat = @"昨天 HH:mm:ss";
                return [fmt stringFromDate:creat];
    
            } //其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
    
            return [fmt stringFromDate:creat];
    
            
        }else{ //其他
            
           return _create_time;
    
        }

}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        
        
//        FJLog(@"\nbegin----\n%@\n%@\n%@\nend--",self.small_image,self.middle_image,self.large_image);
        
        CGSize maxsize = CGSizeMake([UIScreen mainScreen].bounds.size.width -4 *FJTopicCellMargin, MAXFLOAT);
        
        //    CGFloat textH = [topic.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxsize].height;  //经典求高度 （过期）
        
        CGFloat textH = [self.text boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        //文字的高度
        _cellHeight= FJTopicCellTextY +textH + FJTopicCellMargin;

        if (self.type == FJTopicTypePicture) { //图片帖子

            //图片显示的宽高
            CGFloat pictureW = maxsize.width;
            CGFloat pictureH = pictureW *self.height /self.width;
            //超出最大高度，显示固定高度
            if (pictureH >= FJTopicCellPictureMaxH) {
                pictureH = FJTopicCellPictureBreakH;
                self.bigPicture = YES;//大图
            }
            
            //计算图片控件的frame
            CGFloat pictureX = FJTopicCellMargin;
            CGFloat pictureY = FJTopicCellMargin +FJTopicCellTextY +textH;
            
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
           
            _cellHeight += pictureH + FJTopicCellMargin;
            
            
        }
         //底部工具条
        _cellHeight += FJTopicCellBottonBarH +FJTopicCellMargin;
        
    }
    
    
    return _cellHeight;

}

@end

