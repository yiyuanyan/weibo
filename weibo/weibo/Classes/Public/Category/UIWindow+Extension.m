//
//  UIWindow+Extension.m
//  weibo
//
//  Created by 何建新 on 16/8/26.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "IWTabBarController.h"
#import "IWOAuthViewCtrl.h"
#import "IWAccount.h"
#import "IWAccountTool.h"
@implementation UIWindow (Extension)
-(void)switchRootViewCtrl{
    
    IWAccount *account = [IWAccountTool account];
    if(!account){
        self.rootViewController = [IWOAuthViewCtrl new];
    }else{
        IWTabBarController *tabbar = [[IWTabBarController alloc] init];
        self.rootViewController = tabbar;
    }
}
@end
