//
//  IWAccount.h
//  weibo
//
//  Created by 何建新 on 16/8/26.
//  Copyright © 2016年 何建新. All rights reserved.
//
//创建一个类，属性必名称必须和传递过来的字典key一致，而且要继承NSCoding
#import <Foundation/Foundation.h>
@interface IWAccount : NSObject<NSCoding>
@property(nonatomic, copy)NSString *access_token;
@property(nonatomic, assign)NSInteger expires_in;
@property(nonatomic, copy)NSString *remind_in;
@property(nonatomic, copy)NSString *uid;
@end
