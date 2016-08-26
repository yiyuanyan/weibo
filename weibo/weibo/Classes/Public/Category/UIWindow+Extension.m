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
@implementation UIWindow (Extension)
-(void)switchRootViewCtrl{
    //获取保存路径
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    //拼接保存路径文件路径
    filePath = [filePath stringByAppendingString:@"account.archiver"];
    IWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if(!account){
        self.rootViewController = [IWOAuthViewCtrl new];
    }else{
        IWTabBarController *tabbar = [[IWTabBarController alloc] init];
        self.rootViewController = tabbar;
    }
}
@end
