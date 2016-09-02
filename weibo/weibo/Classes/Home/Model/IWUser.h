//
//  IWUser.h
//  weibo
//
//  Created by 何建新 on 16/8/29.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWUser : NSObject
//用户昵称
@property(nonatomic, copy)NSString *screen_name;
@property(nonatomic, copy)NSString *profile_image_url;
@end
