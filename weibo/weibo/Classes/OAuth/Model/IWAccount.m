//
//  IWAccount.m
//  weibo
//
//  Created by 何建新 on 16/8/26.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWAccount.h"

@implementation IWAccount
//将IWAccount类的属性进行归档
-(void)encodeWithCoder:(NSCoder *)enCoder{
    [enCoder encodeObject:self.access_token forKey:@"access_token"];
    [enCoder encodeInteger:self.expires_in forKey:@"expires_in"];
    [enCoder encodeObject:self.remind_in forKey:@"remind_in"];
    [enCoder encodeObject:self.uid forKey:@"uid"];
}
//初始化类时自动解档
-(instancetype)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if(self){
        self.expires_in = [decoder decodeIntegerForKey:@"expires_in"];
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.remind_in = [decoder decodeObjectForKey:@"remind_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
    }
    
    return self;
}

@end
