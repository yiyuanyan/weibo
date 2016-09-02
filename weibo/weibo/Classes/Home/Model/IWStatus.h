//
//  IWStatus.h
//  weibo
//
//  Created by 何建新 on 16/8/29.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IWUser;
@interface IWStatus : NSObject
@property(nonatomic, copy)NSString *text;

@property(nonatomic, assign)long long id;
//发布者用户信息
@property(nonatomic, strong)IWUser *user;
//创建时间
@property(nonatomic, copy)NSString *created_at;
//来源
@property(nonatomic, copy)NSString *source;
//单张缩略图
@property(nonatomic, copy)NSString *thumbnail_pic;
@end
