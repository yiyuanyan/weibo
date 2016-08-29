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

@interface IWHomeViewCtrl ()
@property(nonatomic, strong)NSMutableArray *statusArray;
@end

@implementation IWHomeViewCtrl
-(NSMutableArray *)statusArray{
    if(!_statusArray){
        self.statusArray = [NSMutableArray array];
    }
    return _statusArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *footerView = [UIView new];
    //footerView.height = 0.1;
    self.tableView.tableFooterView = footerView;
    [self setSeparatorInsetZeroWithTableView:self.tableView];
    [self setupNav];
    [self getUserInfo];
    //[self loadNewStatues];
    
    [self setRefreshView];
    
}
-(void)setRefreshView{
    //创建刷新空间
    UIRefreshControl *refreshCtrl = [[UIRefreshControl alloc] init];
    //给刷新空间添加改变的监听事件，loadNewStatues:为加载数据方法，并且将refreshCtrl传递过去
    [refreshCtrl addTarget:self action:@selector(loadNewStatues:) forControlEvents:UIControlEventValueChanged];
    
    //将刷新控件添加到tableView中，下拉就可刷新数据
    [self.tableView addSubview:refreshCtrl];
    [self loadNewStatues:refreshCtrl];
    //要在数据加载完成后结束刷新状态,这里在loadNewStatues方法中结束[refreshCtrl endRefreshing]
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
    return self.statusArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    // Configure the cell...
    cell.textLabel.text = [self.statusArray[indexPath.row] text];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 私有方法
//获取首页信息
-(void)loadNewStatues:(UIRefreshControl *)refreshControl{
    IWAccount *account = [IWAccountTool account];
    
    NSString *urlStr = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"count"] = @(5);
    if([self.statusArray firstObject]){
        params[@"since_id"] = @([[self.statusArray firstObject] id]);
    }
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *statuesDic = responseObject[@"statuses"];
        NSArray *statues = [IWStatus objectArrayWithKeyValuesArray:statuesDic];
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statues.count)];
        [self.statusArray insertObjects:statues atIndexes:set];
        //self.statusArray = statues;
        [self.tableView reloadData];
        //结束刷新状态
        [refreshControl endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新状态
        [refreshControl endRefreshing];
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
