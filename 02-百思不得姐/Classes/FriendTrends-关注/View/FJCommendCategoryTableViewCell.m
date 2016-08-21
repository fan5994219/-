//
//  FJCommendCategoryTableViewCell.m
//  02-百思不得姐
//
//  Created by mac123 on 16/8/19.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJCommendCategoryTableViewCell.h"
#import "FJRecommendCategory.h"

@interface FJCommendCategoryTableViewCell ()
/** 选中时显示的指示器控件 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;



@end

@implementation FJCommendCategoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];


    self.backgroundColor = FJRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor =FJRGBColor(219, 21, 26);
    //当cell的selection为nine时，即使cell被选中时，内部的子控件也不会进入高亮状态
//    self.textLabel.textColor =FJRGBColor(78, 78, 78);
//    self.textLabel.highlightedTextColor = FJRGBColor(219, 21, 26);
}


- (void)setCategory:(FJRecommendCategory *)category{
    
    _category = category;
    
    self.textLabel.text = category.name;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //重新调整内部textLable的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height-2*self.textLabel.y;
}
/**
 可以在这个方法中监听cell的选中和取消选中；
 
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    

    self.selectedIndicator.hidden = !selected;
    //设置选中状态的颜色
    self.textLabel.textColor = selected? self.selectedIndicator.backgroundColor :FJRGBColor(78, 78, 78);
    

}


@end
