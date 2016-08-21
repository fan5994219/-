//
//  FJRecommendViewController.m
//  02-百思不得姐
//
//  Created by mac123 on 16/8/19.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#define FJSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

#import "FJRecommendViewController.h"
#import "FJCommendCategoryTableViewCell.h"
#import "FJRecommendCategory.h"
#import "FJRecommendUserCell.h"
#import "FJRecommendUser.h"

static NSString *const FJCategoryId = @"category";
static NSString *const FJUserId = @"user";


@interface FJRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>



/** 左边的类别数据 */
@property (nonatomic,strong) NSArray *categories;

/** 右边的用户数据 */
@property (nonatomic,strong) NSArray *users;

/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边的用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;


/** 请求参数 */
@property (nonatomic,strong) NSMutableDictionary *params;

/** AFN的请求管理者 */
@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation FJRecommendViewController

#pragma mark -
#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化tableView
    [self setupTableView];
    
    //加载刷新控件
    [self setupRefresh];
    
    
    //加载左侧类别数据
    [self loadCategories];
    
}

/** 加载左侧类别数据 */
- (void)loadCategories
{
    //显示指示器
    [SVProgressHUD show];
    
    
    //发送请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    //发送请求给服务器，加载左侧数据
    [self.manager GET:urlLeftString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //服务器返回的JOSN数据
        self.categories = [FJRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        //刷新表格
        [self.categoryTableView reloadData];
        
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        //让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载信息失败"];
        
        FJLog(@"%@",error);
        
    }];

}

/** 
  初始化tableView
 */
- (void)setupTableView
{
    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([FJCommendCategoryTableViewCell class]) bundle:nil] forCellReuseIdentifier:FJCategoryId];
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([FJRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:FJUserId];
    
    
    self.title = @"推荐关注";
    //设置背景色
    self.view.backgroundColor = FJRGBColor(223, 223, 223);
    
    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    
    //默认行高
    self.userTableView.rowHeight = 70;

}

/** 
 加载上拉，下拉刷新控件
 */
- (void)setupRefresh
{
    //header
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    //footer
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
   self.userTableView.mj_footer.hidden = YES;
        
}
#pragma mark - 加载用户数据
/** 下拉刷新 */
- (void)loadNewUsers
{
    FJRecommendCategory *cate = FJSelectedCategory;
    
    //设置当前页码为第一页
    cate.current_page = 1;
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(cate.id);
    params[@"page"] = @(cate.current_page);
    //存储请求参数
    self.params = params;
    
    //发送请求给服务器，加载右侧数据
    [self.manager GET:urlRightString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典数组-->模型数组
        NSArray *users = [FJRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //先清除所有的旧数据
        [cate.users removeAllObjects];
        
        //添加到当前类别的用户数组中
        [cate.users addObjectsFromArray:users];
#pragma mark - 记得写保存总数
        //保存总数
        cate.total = [responseObject[@"total"] integerValue];
#pragma mark - 记得写保存总数
        //不是最后一次请求
        if (self.params != params) return;
        
        //刷新右边的表格数据
        [self.userTableView reloadData];
        
        //结束下拉刷新
        [self.userTableView.mj_header endRefreshing];
        
        //让底部控件结束刷新
        [self clickFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return ;

    //提醒
    [SVProgressHUD showErrorWithStatus:@"加载用户刷新失败"];
    
    //结束下拉刷新
    [self.userTableView.mj_header endRefreshing];
    }];


}
/** 上拉加载 （加载更多数据） */
- (void)loadMoreUsers
{
    
    FJRecommendCategory *category = FJSelectedCategory;
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"]= @(category.id);
    params[@"page"] = @(++category.current_page);
    //存储请求参数
    self.params = params;

    //发送请求给服务器，加载右侧数据
    [self.manager GET:urlRightString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典数组-->模型数组
        NSArray *users = [FJRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //添加到当前类别的用户数组中（最后）
        [category.users addObjectsFromArray:users];
        
        //不是最后一次请求
        if (self.params != params) return;
        
        //刷新右边数据
        [self.userTableView reloadData];
        
        //让底部控件结束刷新
        [self clickFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return ;
        //提醒
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        //让底部结束刷新
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];

    }];

}
/** 时刻检测footer的状态 */
- (void)clickFooterState
{
    
    FJRecommendCategory *cate = FJSelectedCategory;
    
    //每次刷新右边数据时，都控制footer显示或隐藏
    self.userTableView.mj_footer.hidden = (cate.users.count== 0);
    
    //让底部控件结束刷新
    if (cate.users.count == cate.total) { //全部加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{  //还没有加载完毕
        [self.userTableView.mj_footer endRefreshing];
    }

}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //左边的类别表格
    if (tableView == self.categoryTableView) return self.categories.count;
    
    //检测footer的状态
    [self clickFooterState];
    
    //右边的用户表格
    return [FJSelectedCategory users].count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {    //左边的类别表格
        FJCommendCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FJCategoryId];
        cell.category = self.categories[indexPath.row];
        
        return cell;

    }
    else{  //右边的用户表格
        
        FJRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:FJUserId];
        cell.user = [FJSelectedCategory users][indexPath.row];
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FJRecommendCategory *cate= self.categories[indexPath.row];
    
    //防止用户交叉点击刷新数据
    [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    
    //判断是否有缓存好的数据
    if (cate.users.count) {
        //刷新tableView加载数据
        [self.userTableView reloadData];
    }
    else{
        //赶紧刷新表格，目的是：马上显示category的数据，不让用户看见上一份的残留数据
        [self.userTableView reloadData];
        
        //进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
     }
    
}

#pragma mark - 控制器的销毁
- (void)dealloc
{
    
    //停止所有的操作
    [self.manager.operationQueue cancelAllOperations];
}

@end
