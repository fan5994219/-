//
//  FJRecommendTageCell.m
//  02-百思不得姐
//
//  Created by mac123 on 16/8/21.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJRecommendTageCell.h"
#import "FJRecommendTage.h"

@interface FJRecommendTageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLable;


@end

@implementation FJRecommendTageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setRecommendTag:(FJRecommendTage *)recommendTag{
    
    _recommendTag = recommendTag;
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLable.text = recommendTag.theme_name;
    
    NSString *subNumber = nil;
    
    if (recommendTag.sub_number < 10000){
      subNumber =[NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    }else{  //大于等于10000
        subNumber= [NSString stringWithFormat:@"%.1f万人订阅",recommendTag.sub_number/10000.0];
    }
    self.subNumberLable.text = subNumber;
    
    
}
//重写setFrame
- (void)setFrame:(CGRect)frame{
    
    frame.origin.x = 10;
    frame.size.width -= 2 *frame.origin.x;
    frame.size.height -=1;

    [super setFrame:frame];
    
}

@end
