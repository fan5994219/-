//
//  FJTopicViewController.m
//  02-百思不得姐
//
//  Created by mac123 on 16/8/24.
//  Copyright © 2016年 Faniew. All rights reserved.
//   段子

#import "FJTopicViewController.h"
#import "FJTopic.h"
#import "FJTopicCell.h"
#import "FJCommentViewController.h"

static NSString *FJTopicCellId = @"topic";

@interface FJTopicViewController ()

/** 帖子数据 */
@property (nonatomic,strong) NSMutableArray *topics;

/** 当前页码 */
@property (nonatomic,assign) NSInteger page;

/** 当加载下一页数据时需要的参数 */
@property (nonatomic,copy) NSString *maxtime;

/** 上一次的请求参数 */
@property (nonatomic,strong) NSDictionary *parans;


@end

@implementation FJTopicViewController


- (NSMutableArray *)topics{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //初始化表格
    [self setupTableView];
    
    //加载刷新控件
    [self setupRefresh];
    
}
/**
 * 初始化表格
 */
- (void)setupTableView
{
    
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = FJTitlesViewH +FJTitlesViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //去掉颜色
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //注册
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FJTopicCell class]) bundle:nil] forCellReuseIdentifier:FJTopicCellId];
    
    
}

#pragma mark - 加载刷新控件

- (void)setupRefresh{
    //上拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    //根据拖拽比例自动切换透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //立即刷新
    [self.tableView.mj_header beginRefreshing];
    
    
    //下拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopices)];
    
}
/**
 * 加载更多的网络数据
 */
- (void)loadMoreTopices
{
    [self.tableView.mj_footer endRefreshing];
    
    self.page ++;
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.parans = params;
    
    //发送请求给服务器，加载左侧数据
    [[AFHTTPSessionManager manager] GET:urlLeftString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  responseObject) {
        if (self.parans !=params) return ;
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典-->模型
        NSArray *newTopics = [FJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:newTopics];
        //刷新表格
        [self.tableView reloadData];
        
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parans !=params) return ;
        
        //结束下拉刷新
        [self.tableView.mj_header endRefreshing];
        //恢复页码
        self.page--;
        
    }];
}

#pragma mark - 加载数据

/**
 * 加载网络帖子数据
 */
- (void)loadNewTopics
{
    [self.tableView.mj_header endRefreshing];
    
    //页码
    self.page = 0;
    
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.parans = params;
    
    
    //发送请求给服务器，加载左侧数据
    [[AFHTTPSessionManager manager] GET:urlLeftString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  responseObject) {
        if (self.parans !=params) return ;
        
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典-->模型
        self.topics = [FJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
        //刷新表格
        [self.tableView reloadData];
        
        self.tableView.mj_footer.hidden = NO;
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
        //恢复页码
        self.page = 0;
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parans !=params) return ;
        
        //结束下拉刷新
        [self.tableView.mj_header endRefreshing];
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    FJTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:FJTopicCellId];
    
    cell.topices = self.topics[indexPath.row];
    //    cell.textLabel.text = topices.name;
    //    cell.detailTextLabel.text = topices.text;
    //    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topices.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    return cell;
}

#pragma mark - tableView的代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //取出模型数据
    FJTopic *topic = self.topics[indexPath.row];
    //返回这个模型对应的cell高度
    return topic.cellHeight;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    FJCommentViewController *commentVC = [[FJCommentViewController alloc]init];
    [self.navigationController pushViewController:commentVC animated:YES];
    
}

@end
