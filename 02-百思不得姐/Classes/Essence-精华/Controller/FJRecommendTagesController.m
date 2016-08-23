//
//  FJRecommendTagesController.m
//  02-百思不得姐
//
//  Created by mac123 on 16/8/21.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJRecommendTagesController.h"
#import "FJRecommendTage.h"
#import "FJRecommendTageCell.h"
@interface FJRecommendTagesController ()

/** 标签数据 */
@property (nonatomic,strong) NSArray *tages;

@end

static NSString * const FJTagesId = @"tag";

@implementation FJRecommendTagesController


#pragma mark - 生命周期方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化tableView
    [self setupTableView];
    
    //加载数据
    [self loadTages];
    
}
/**
 * 初始化tableView
 */
- (void)setupTableView
{
    
    //设置标题
    self.title = @"推荐标签";
    
    self.tableView.rowHeight = 70;
    //去除分割线
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    //去掉背景色
    self.tableView.backgroundColor = FJRGBGlobalBC;

    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FJRecommendTageCell class]) bundle:nil] forCellReuseIdentifier:FJTagesId];

}
/**
 * 加载数据
 */
- (void)loadTages{
    //显示指示器
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    //请求参数
    NSDictionary *paras = @{@"a":@"tag_recommend",
                            @"action":@"sub",
                            @"c":@"topic"
                            };
    //发送请求给服务器,获得数据
    [[AFHTTPSessionManager manager] GET:urlTagesString parameters:paras progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典-->模型
        self.tages = [FJRecommendTage mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
        //隐藏指示器
        [SVProgressHUD dismiss];
        FJLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //隐藏指示器
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"加载请求失败"];
        FJLog(@"%@",error);
    }];

}


#pragma mark - <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tages.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FJRecommendTageCell *cell = [tableView dequeueReusableCellWithIdentifier:FJTagesId];
    
    cell.recommendTag = self.tages[indexPath.row];
    
    return cell;
    
}

@end
