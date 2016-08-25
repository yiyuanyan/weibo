//
//  IWNavigationController.m
//  weibo
//
//  Created by 何建新 on 16/8/23.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWNavigationController.h"

@interface IWNavigationController ()

@end

@implementation IWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //统一设置返回按钮
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//重写方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    NSString *title = @"返回";
    if(self.childViewControllers.count == 1){
        title = [[self.childViewControllers firstObject] title];
    }
    if(self.childViewControllers.count){
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back_withtext" target:self action:@selector(back) title:title];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}
-(void)back{
    [self popViewControllerAnimated:YES];
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
