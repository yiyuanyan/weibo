//
//  IWTemp2ViewCtrl.m
//  weibo
//
//  Created by 何建新 on 16/8/23.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWTemp2ViewCtrl.h"
#import "IWTemp3ViewCtrl.h"
@interface IWTemp2ViewCtrl ()

@end

@implementation IWTemp2ViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"IWemp2ViewCtrl";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back_withtext" target:self action:@selector(back) title:@"首页"];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[IWTemp3ViewCtrl new] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
