//
//  IWHomeViewCtrl.m
//  weibo
//
//  Created by 何建新 on 16/8/12.
//  Copyright © 2016年 何建新. All rights reserved.
// 首页控制器

#import "IWHomeViewCtrl.h"
#import "IWTemp2ViewCtrl.h"

#import "IWHomeTitleButton.h"
@interface IWHomeViewCtrl ()

@end

@implementation IWHomeViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
}
//设置顶部导航栏的内容
-(void)setupNav{
    //设置顶部导航栏titleView
    IWHomeTitleButton *titleBtn = [IWHomeTitleButton new];
    [titleBtn setTitle:@"我叫首页" forState:UIControlStateNormal];
    
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [titleBtn sizeToFit];
    self.navigationItem.titleView = titleBtn;
    
    
    
    //自定义类方法itemWithImageName:  用分类形式创建UIBarButtonItem+Extension
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" target:self action:@selector(friendsearch)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" target:self action:@selector(pop)];
  
}

-(void)friendsearch{
    NSLog(@"%s",__func__);
    IWTemp2ViewCtrl *temp2 = [IWTemp2ViewCtrl new];
    [self.navigationController pushViewController:temp2 animated:YES];
}
-(void)pop{
    NSLog(@"%s",__func__);
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    IWHomeTitleButton *titleBtn = (IWHomeTitleButton *)self.navigationItem.titleView;
    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

@end
