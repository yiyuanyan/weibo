//
//  IWTabBarController.m
//  weibo
//
//  Created by 何建新 on 16/8/11.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWTabBarController.h"
#import "IWHomeViewCtrl.h"
#import "IWTabBar.h"
#import "IWNavigationController.h"
#import "IWDiscoverViewCtrl.h"
#import "IWTabBarItem.h"
@interface IWTabBarController ()<IWTabBarDelegate>

@end

@implementation IWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //初始化一个自己的tabbar
    IWTabBar *tabbar = [[IWTabBar alloc] init];
    tabbar.delegate = self;
    //通过KVC去设置只读的属性self.tabBar是只读的
    [self setValue:tabbar forKey:@"tabBar"];
    
    //添加4个自控制器
    IWHomeViewCtrl *homeCtrl = [IWHomeViewCtrl new];
    [self addChildViewCtrl:homeCtrl imageName:@"tabbar_home" title:@"首页"];
    
    UITableViewController *messageCtrl = [UITableViewController new];
    [self addChildViewCtrl:messageCtrl imageName:@"tabbar_message_center" title:@"消息"];
    
    IWDiscoverViewCtrl *discoverCtrl = [IWDiscoverViewCtrl new];
    [self addChildViewCtrl:discoverCtrl imageName:@"tabbar_discover" title:@"发现"];
    
    
    
    UITableViewController *profileCtrl = [UITableViewController new];
    [self addChildViewCtrl:profileCtrl imageName:@"tabbar_profile" title:@"我"];
    
}
//自定义方法，设置tabbaritem的标题与图片
-(void)addChildViewCtrl:(UIViewController *)ctrl imageName:(NSString *)imageName title:(NSString *)title{
    
    //按钮文字
    //ctrl.tabBarItem.title = title;
    ctrl.title = title;
    ctrl.tabBarItem = [IWTabBarItem new];
    //按钮图片，imageWithRenderingMode:状态 为取消默认渲染图片颜色
    ctrl.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //按钮选中状态下的图片
    ctrl.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置tabBar的文字颜色
    self.tabBar.tintColor = [UIColor orangeColor];
    IWNavigationController *navCtrl = [[IWNavigationController alloc] initWithRootViewController:ctrl];
    
    [self addChildViewController:navCtrl];
}

//其他类里面实现代理方法
-(void)tabBar:(IWTabBar *)tabbar plusBtnDidClicked:(UIButton *)btn{
    NSLog(@"%s",__func__);
}
@end
