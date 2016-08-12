//
//  IWTabBar.h
//  weibo
//
//  Created by 何建新 on 16/8/12.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
//设置代理
@class IWTabBar;
@protocol IWTabBarDelegate<NSObject,UITabBarDelegate>
//要被实现的方法
-(void)tabBar:(IWTabBar *)tabbar plusBtnDidClicked:(UIButton *)btn;
@end
@interface IWTabBar : UITabBar
//设置代理协议,因为UITabBar已经有了delegate所以上面的代理必须继承系统自身的代理
@property(nonatomic, weak)id<IWTabBarDelegate>delegate;
@end
