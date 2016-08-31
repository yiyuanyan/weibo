//
//  IWUnReadCount.h
//  weibo
//
//  Created by 何建新 on 16/8/30.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWUnReadCount : NSObject
@property(nonatomic, assign) NSInteger invite;
@property(nonatomic, assign) NSInteger notice;
@property(nonatomic, assign) NSInteger follower;
@property(nonatomic, assign) NSInteger photo;
@property(nonatomic, assign) NSInteger metion_cmt;
@property(nonatomic, assign) NSInteger badge;
@property(nonatomic, assign) NSInteger mention_status;
@property(nonatomic, assign) NSInteger dm;
@property(nonatomic, assign) NSInteger group;
@property(nonatomic, assign) NSInteger msgbox;
@property(nonatomic, assign) NSInteger private_group;
@property(nonatomic, assign) NSInteger status;
@property(nonatomic, assign) NSInteger cmt;
@end
