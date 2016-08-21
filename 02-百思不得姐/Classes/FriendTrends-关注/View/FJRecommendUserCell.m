//
//  FJRecommendUserCell.m
//  02-百思不得姐
//
//  Created by mac123 on 16/8/20.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJRecommendUserCell.h"
#import "FJRecommendUser.h"

@interface FJRecommendUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLable;

@property (weak, nonatomic) IBOutlet UILabel *fansCountLable;

@end

@implementation FJRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];


}

- (void)setUser:(FJRecommendUser *)user{
    
    _user = user;
    
    self.screenNameLable.text = self.user.screen_name;
    self.fansCountLable.text = [NSString stringWithFormat:@"%zd",self.user.fans_count];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
