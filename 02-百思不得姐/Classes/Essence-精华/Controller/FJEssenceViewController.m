//
//  FJEssenceViewController.m
//  01-百思不得姐
//
//  Created by mac123 on 16/8/18.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJEssenceViewController.h"
#import "FJRecommendTagesController.h"
#import "FJTopicViewController.h"
@interface FJEssenceViewController ()<UIScrollViewDelegate>

/** 标签栏底部的红色指示器 */
@property (nonatomic,weak) UIView *indictorView;

/** 当前选中的按钮 */
@property (nonatomic,weak) UIButton *selectedButton;

/** 顶部的所有标签 */
@property (nonatomic,weak) UIView *titleView;

/** 底部的所有内容 */
@property (nonatomic,weak) UIScrollView *contentView;


@end

@implementation FJEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //设置导航栏内容
    [self setupNav];
    
    //初始化子控制器
    [self setupChildVces];

    //设置顶部标签
    [self setupTitlesView];

    //设置contentView
    [self setupContentView];

    
}

/**
 * 初始化子控制器
 */
- (void)setupChildVces
{
    
    FJTopicViewController *picture = [[FJTopicViewController alloc] init];
    picture.title =@"图片";
    picture.type = FJTopicTypePicture;
    [self addChildViewController:picture];

    
    FJTopicViewController *word = [[FJTopicViewController alloc] init];
    word.title =@"段子";
    word.type = FJTopicTypeWord;
    [self addChildViewController:word];

    
    FJTopicViewController *all = [[FJTopicViewController alloc] init];
    all.title =@"全部";
    all.type = FJTopicTypeAll;
    [self addChildViewController:all];
    

    FJTopicViewController *video= [[FJTopicViewController alloc] init];
    video.title =@"视频";
    video.type = FJTopicTypeVideo;
    [self addChildViewController:video];
    
    FJTopicViewController *voice = [[FJTopicViewController alloc] init];
    voice.title =@"声音";
    voice.type = FJTopicTypeVoice;
    [self addChildViewController:voice];
    

    
}
/**
 * 底部的scrollView
 */
- (void)setupContentView
{
    
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
    
    
}

/**
 * 设置顶部的标签栏
 */
- (void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = FJTitlesViewH;
    titlesView.y = FJTitlesViewY;
    [self.view addSubview:titlesView];
    self.titleView= titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indictorView = indicatorView;
    
    // 内部的子标签
    CGFloat width = titlesView.width / self.childViewControllers.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        //[button layoutIfNeeded]; // 强制布局(强制更新子控件的frame)
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indictorView.width = button.titleLabel.width;
            self.indictorView.centerX = button.centerX;
        }
    }
    
    [titlesView addSubview:indicatorView];
}

- (void)titleClick:(UIButton *)button
{
    
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indictorView.width = button.titleLabel.width;
        self.indictorView.centerX = button.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
    
    
}


/**
 * 设置导航栏
 */
- (void)setupNav
{
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏左边的标题
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" hightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = FJRGBColor(223, 223, 223);

}


- (void)tagClick
{
    
    FJRecommendTagesController *tagesVC =[[FJRecommendTagesController alloc] init];

    [self.navigationController pushViewController:tagesVC animated:YES];
    
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    [scrollView addSubview:vc.view];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //点击按钮
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    [self titleClick:self.titleView.subviews[index]];
    
}

@end
