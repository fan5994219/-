

#import <UIKit/UIKit.h>

typedef enum {
    FJTopicTypeAll = 1,
    FJTopicTypePicture = 10,
    FJTopicTypeWord = 29,
    FJTopicTypeVoice = 31,
    FJTopicTypeVideo = 41
}FJTopicType;

/** 精华-所有顶部标题高度*/
UIKIT_EXTERN CGFloat const FJTitlesViewH;
/** 精华-所有顶部标题的Y*/
UIKIT_EXTERN CGFloat const FJTitlesViewY;
/** 精华-Cell-间距*/
UIKIT_EXTERN CGFloat const FJTopicCellMargin;
/** 精华-Cell-BottonBarH*/
UIKIT_EXTERN CGFloat const FJTopicCellBottonBarH;
/** 精华-Cell-TextY*/
UIKIT_EXTERN CGFloat const FJTopicCellTextY;
/** 精华-Cell-图片帖子的最大高度*/
UIKIT_EXTERN CGFloat const FJTopicCellPictureMaxH;
/** 精华-Cell-图片帖子的超出后显示的固定高度*/
UIKIT_EXTERN CGFloat const FJTopicCellPictureBreakH;

/** FJUser模型-性别属性值*/
UIKIT_EXTERN NSString * const FJUserSexMale;
UIKIT_EXTERN NSString * const FJUserSexFemale;

/** 精华-Cell-最热评论标题文字的高度*/
UIKIT_EXTERN CGFloat const FJTopicCellTopCmtTitleH;
