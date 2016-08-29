//
//  IWAccountTool.m
//  weibo
//
//  Created by 何建新 on 16/8/29.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWAccountTool.h"
#import "IWAccount.h"

#define AccountArchivePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"account.archiver"]

@implementation IWAccountTool
+(void)saveAccount:(IWAccount *)account{
    //归档保存数据
    [NSKeyedArchiver archiveRootObject:account toFile:AccountArchivePath];
}

+(IWAccount *)account{
    IWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountArchivePath];
    
    //判断是否过期
    //计算过期时间
    NSDate *expiresDate = [account.create_at dateByAddingTimeInterval:account.expires_in];
    NSDate *currentDate = [NSDate date];
    NSComparisonResult result = [currentDate compare:expiresDate];
    if(result == NSOrderedAscending){
        //不过期
        return account;
    }
    
    
    return nil;
}
@end
