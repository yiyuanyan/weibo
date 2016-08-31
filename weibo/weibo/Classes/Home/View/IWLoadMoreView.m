//
//  IWLoadMoreView.m
//  weibo
//
//  Created by 何建新 on 16/8/30.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWLoadMoreView.h"

@implementation IWLoadMoreView

+(instancetype)loadMoreView{
    return [[[NSBundle mainBundle] loadNibNamed:@"IWLoadMoreView" owner:nil options:nil] lastObject];
}

@end
