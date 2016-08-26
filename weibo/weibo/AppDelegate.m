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

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
