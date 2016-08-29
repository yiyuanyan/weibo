//
//  IWAccountTool.h
//  weibo
//
//  Created by 何建新 on 16/8/29.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IWAccount;
@interface IWAccountTool : NSObject
+(void)saveAccount:(IWAccount *)account;
+(IWAccount *)account;
@end
