//
//  AppDelegate.m
//  weibo
//
//  Created by 何建新 on 16/8/11.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "AppDelegate.h"
#import "IWTabBarController.h"
#import "IWOAuthViewCtrl.h"
#import "IWNewFeatureCtrl.h"
#import "IWAccount.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.取消了Main interface所以要创建一个window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self switchRootViewCtrl];
    
    if([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0){
        //初始化一个图标数字通知
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        //注册通知
        [application registerUserNotificationSettings:setting];
    }
    
    
    

    //3.成为主window并显示
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)switchRootViewCtrl{
    //当前版本号
    NSString *currentshortVersionStr = [NSBundle mainBundle].infoDictionary[kShortVersionStr];
    //存储的版本号
    NSString *saveVersionStr = [[NSUserDefaults standardUserDefaults] stringForKey:kShortVersionStr];
    //2.设置根控制器为UITabBarController
    //封装自控制器的代码放在自定义的IWTabBarController.h中
    //判断字符串大小，返回的是降序（大于）、升序（小于）、相等
    NSComparisonResult result = [saveVersionStr compare:currentshortVersionStr];
    if (!saveVersionStr || result == NSOrderedAscending) {
        self.window.rootViewController = [IWNewFeatureCtrl new];
        //保存当前版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentshortVersionStr forKey:kShortVersionStr];
    }else{
        [self.window switchRootViewCtrl];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
//APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    //允许APP在后台短期运行，可以执行NSTimer
    UIBackgroundTaskIdentifier identifier = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:identifier];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
