//
//  IWHomeViewCtrl.m
//  weibo
//
//  Created by 何建新 on 16/8/12.
//  Copyright © 2016年 何建新. All rights reserved.
// 首页控制器

#import "IWHomeViewCtrl.h"
#import "IWTemp2ViewCtrl.h"
#import "IWPopView.h"
#import "IWHomeTitleButton.h"
#import "IWAccount.h"
#import "IWAccountTool.h"
#import "AFHTTPSessionManager.h"
#import "IWUser.h"
#import "MJExtension.h"
#import "IWStatus.h"
#import "IWLoadMoreView.h"
#import "IWUnReadCount.h"
#import "IWStatusCell.h"
#import "IWStatusFrame.h"
#import <objc/runtime.h>
//默认加载条数
#define LOAD_COUNT 20
#define identifier @"IWStatusCell"
@interface IWHomeViewCtrl ()
@property(nonatomic, strong)NSMutableArray *statusFrames;
@property(nonatomic,assign) BOOL isLoadMore;
@end

@implementation IWHomeViewCtrl
-(NSMutableArray *)statusFrames{
    if(!_statusFrames){
        self.statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *footerView = [UIView new];
    //footerView.height = 0.1;
    [self.tableView registerClass:[IWStatusCell class] forCellReuseIdentifier:identifier];
    self.tableView.tableFooterView = footerView;
    [self setSeparatorInsetZeroWithTableView:self.tableView];
    [self setupNav];
    [self getUserInfo];
    //[self loadNewStatues];
    
    [self setRefreshView];
    //self.tabBarItem.badgeValue = @"10";
    
    
    //定时执行
//    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(loadUnReadCount) userInfo:nil repeats:YES];
//    //激活定时执行
//    [time fire];
//    NSRunLoop *runloop = [NSRunLoop mainRunLoop];
//    [runloop addTimer:time forMode:NSRunLoopCommonModes];
    
}
-(void)setRefreshView{
    //创建刷新空间
    UIRefreshControl *refreshCtrl = [[UIRefreshControl alloc] init];
    //给刷新空间添加改变的监听事件，loadNewStatues:为加载数据方法，并且将refreshCtrl传递过去
    [refreshCtrl addTarget:self action:@selector(loadNewStatues:) forControlEvents:UIControlEventValueChanged];
    
    //将刷新控件添加到tableView中，下拉就可刷新数据
    [self.tableView addSubview:refreshCtrl];
    [refreshCtrl beginRefreshing];
    [self loadNewStatues:refreshCtrl];
    //要在数据加载完成后结束刷新状态,这里在loadNewStatues方法中结束[refreshCtrl endRefreshing]
    
    //设置加载更多的view
    IWLoadMoreView *loadMoreView = [IWLoadMoreView loadMoreView];
    loadMoreView.hidden = YES;
    self.tableView.tableFooterView = loadMoreView;
}
- (void)temp{
    for (UIView *tabBarChild in self.tabBarController.tabBar.subviews) {
        if ([tabBarChild isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            for (UIView *tabBarButtonChild in tabBarChild.subviews) {
                if ([tabBarButtonChild isKindOfClass:NSClassFromString(@"_UIBadgeView")]) {
                    for (UIView * badgeViewChild in tabBarButtonChild.subviews) {
                        if ([badgeViewChild isKindOfClass:NSClassFromString(@"_UIBadgeBackground")]) {
                            NSLog(@"终于找到你，还好没放弃");
                            NSLog(@"%@",badgeViewChild);
                            unsigned int count;
                            //获取某个类身上的所有属性
                            Ivar *ivars = class_copyIvarList([badgeViewChild class], &count);
                            
                            for (int i = 0; i < count; i++) {
                                Ivar ivar = ivars[i];
                                
                                //获取属性的名字
                                NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
                                //获取属性的类型
                                NSString *ivarType = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
                                //判断如果当前是_image属性
                                if ([ivarName isEqualToString:@"_image"]) {
                                    
                                    UIImage *image = [UIImage imageNamed:@"main_badge"];
                                    //通过kvc去设置某个对象身上的某个属性的值
                                    [badgeViewChild setValue:image forKeyPath:@"image"];
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}
//设置顶部导航栏的内容
-(void)setupNav{
    //设置顶部导航栏titleView
    IWHomeTitleButton *titleBtn = [IWHomeTitleButton new];
    [titleBtn setTitle:@"我叫首页" forState:UIControlStateNormal];
    
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [titleBtn sizeToFit];
    [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
    
    
    
    //自定义类方法itemWithImageName:  用分类形式创建UIBarButtonItem+Extension
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" target:self action:@selector(friendsearch)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" target:self action:@selector(pop)];
  
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    IWHomeTitleButton *titleBtn = (IWHomeTitleButton *)self.navigationItem.titleView;
    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IWStatusCell *cell = [IWStatusCell cellWithTableView:tableView];
    [cell setStatusFrame:self.statusFrames[indexPath.row]];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.statusFrames[indexPath.row] cellHeight];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if(self.statusFrames.count == 0 || self.tableView.tableFooterView.hidden==NO){
        return;
    }
    if(self.statusFrames.count == 0){
        return ;
    }
    CGFloat result = scrollView.contentSize.height - SCREENH;
    //判断是否滑动到底部
    if(result <= scrollView.contentOffset.y - self.tabBarController.tabBar.height){
        self.tableView.tableFooterView.hidden = NO;

        [self loadMoreStatues];
    }
}

#pragma mark - 私有方法
-(void)loadUnReadCount{
    IWAccount *account = [IWAccountTool account];
    NSString *urlStr = @"https://rm.api.weibo.com/2/remind/unread_count.json";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        IWUnReadCount *unReadCount = [IWUnReadCount new];
        [unReadCount mj_setKeyValues:responseObject];
        //unReadCount.status = 1;
        if(unReadCount.status){
            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",unReadCount.status];
            NSInteger number = unReadCount.status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = number;
        }else{
            self.tabBarItem.badgeValue = nil;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
//加载更多微博
-(void)loadMoreStatues{
    IWAccount *account = [IWAccountTool account];
    NSString *urlStr = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"count"] = @(LOAD_COUNT);
    if([self.statusFrames lastObject]){
        IWStatusFrame *frame = [self.statusFrames firstObject];
        params[@"max_id"] = @(frame.status.id - 1);
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *statuesDic = responseObject[@"statuses"];
        NSArray *statues = [IWStatus objectArrayWithKeyValuesArray:statuesDic];
        NSArray *statuesFrames = [self converToFrameWithStatises:statues];
        
        
        [self.statusFrames addObjectsFromArray:statuesFrames];
        //self.statusArray = statues;
        [self.tableView reloadData];
        //结束刷新状态
        self.isLoadMore = NO;
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新状态
        //self.isLoadMore = NO;
        self.tableView.tableFooterView.hidden = YES;
    }];
}
//获取首页信息
-(void)loadNewStatues:(UIRefreshControl *)refreshControl{
    IWAccount *account = [IWAccountTool account];
    
    NSString *urlStr = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"count"] = @(LOAD_COUNT);
    if([self.statusFrames firstObject]){
        IWStatusFrame *frame = [self.statusFrames firstObject];
        params[@"since_id"] = @(frame.status.id);
    }
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *statuesDic = responseObject[@"statuses"];
        NSArray *statues = [IWStatus objectArrayWithKeyValuesArray:statuesDic];
        //TODO 把statues模型转Frame模型
        NSArray *statuesFrames = [self converToFrameWithStatises:statues];
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statues.count)];
        [self.statusFrames insertObjects:statuesFrames atIndexes:set];
        
        [self.tableView reloadData];
        //结束刷新状态
        [refreshControl endRefreshing];
        [self showLoadCountLabelWithCount:statues.count];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新状态
        [refreshControl endRefreshing];
    }];
}
-(NSArray *)converToFrameWithStatises:(NSArray *)statues{
    NSMutableArray *statusArray = [NSMutableArray array];
    for (IWStatus *status in statues) {
        IWStatusFrame *frame = [[IWStatusFrame alloc]init];
        frame.status = status;
        [statusArray addObject:frame];
    }
    return [statusArray copy];
}
//显示加载条数
-(void)showLoadCountLabelWithCount:(NSInteger)count{
    //根据下拉刷新的条数显示
    UILabel *textLabel = [UILabel new];
    NSString *string = @"没有最新微博数据";
    if(count){
        string = [NSString stringWithFormat:@"共加载出%zd条数据",count];
    }
    textLabel.text = string;
    textLabel.backgroundColor = [UIColor orangeColor];
    textLabel.font = SYS_FONT(15);
    textLabel.textColor = [UIColor whiteColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.size = CGSizeMake(SCREENW, 35);
    textLabel.y = 64-textLabel.height;
    [self.navigationController.view insertSubview:textLabel belowSubview:self.navigationController.navigationBar];
    [UIView animateWithDuration:1 animations:^{
        //textLabel.y = 64;
        textLabel.transform = CGAffineTransformMakeTranslation(0, textLabel.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:1 options:0 animations:^{
            textLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [textLabel removeFromSuperview];
        }];
    }];
}
//获取个人信息
-(void)getUserInfo{
    IWAccount *account = [IWAccountTool account];
    NSString *urlStr = @"https://api.weibo.com/2/users/show.json";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        IWUser *user = [[IWUser alloc] init];
        [user setKeyValues:responseObject];
        IWHomeTitleButton *button = (IWHomeTitleButton *)self.navigationItem.titleView;
        [button setTitle:user.screen_name forState:UIControlStateNormal];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败：%@",error);
    }];
}

-(void)titleBtnClick:(UIButton *)btn{
    UIView *customView = [[UIView alloc] init];
    customView.backgroundColor = [UIColor redColor];
    customView.size = CGSizeMake(100, 100);
    IWPopView *popView = [[IWPopView alloc] initWithCustomsView:customView];

    [popView showFromView:btn];
}


-(void)friendsearch{
    NSLog(@"%s",__func__);
    IWTemp2ViewCtrl *temp2 = [IWTemp2ViewCtrl new];
    [self.navigationController pushViewController:temp2 animated:YES];
}
-(void)pop{
    NSLog(@"%s",__func__);
}

@end
