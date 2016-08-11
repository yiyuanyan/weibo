//
//  IWTabBarController.m
//  weibo
//
//  Created by 何建新 on 16/8/11.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWTabBarController.h"

@interface IWTabBarController ()

@end

@implementation IWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加4个自控制器
    UITableViewController *homeCtrl = [UITableViewController new];
    [self addChildViewCtrl:homeCtrl imageName:@"tabbar_home" title:@"首页"];
    
    UITableViewController *messageCtrl = [UITableViewController new];
    [self addChildViewCtrl:messageCtrl imageName:@"tabbar_message_center" title:@"消息"];
    
    UITableViewController *discoverCtrl = [UITableViewController new];
    [self addChildViewCtrl:discoverCtrl imageName:@"tabbar_discover" title:@"发现"];
    
    UITableViewController *profileCtrl = [UITableViewController new];
    [self addChildViewCtrl:profileCtrl imageName:@"tabbar_profile" title:@"我"];
}
//自定义方法，设置tabbaritem的标题与图片
-(void)addChildViewCtrl:(UIViewController *)ctrl imageName:(NSString *)imageName title:(NSString *)title{
    //按钮文字
    ctrl.tabBarItem.title = title;
    //按钮图片，imageWithRenderingMode:状态 为取消默认渲染图片颜色
    ctrl.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //按钮选中状态下的图片
    ctrl.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //添加文字属性，字典形式
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //把文字属性添加到tabbaritem的titleTextAttributes属性中
    [ctrl.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    [self addChildViewController:ctrl];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
