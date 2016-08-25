//
//  IWPopView.m
//  weibo
//
//  Created by 何建新 on 16/8/24.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWPopView.h"
@interface IWPopView()
@property(nonatomic,weak) UIImageView *contentView;
@end
@implementation IWPopView

-(instancetype)initWithCustomsView:(UIView *)customsView{
    self = [super init];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREENW;
        self.height = SCREENH;
        //self.backgroundColor = RGBA(240, 240, 240, 0.7);
        
        [self addTarget:self action:@selector(coverBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //初始化灰色边框
        UIImageView *contentView = [[UIImageView alloc] init];
        contentView.image = [UIImage imageNamed:@"popover_background"];
        contentView.userInteractionEnabled = YES;
        
        
        contentView.width = customsView.width+10;
        contentView.height = customsView.height+20;
        
        
        [self addSubview:contentView];
        self.contentView = contentView;
        customsView.x = 5;
        customsView.y = 12;
        
        
        [contentView addSubview:customsView];
//        CGRect rect = [showView.superview convertRect:showView.frame toView:[UIApplication sharedApplication].keyWindow];
//        
//        
//        contentView.centerX = CGRectGetMidX(rect);
//        contentView.y = CGRectGetMaxY(rect);
        //contentView.y = CGRectGetMaxY(showView.frame) + 20;
        
        
    }
    return self;
}
-(void)showFromView:(UIView *)showView{
    CGRect rect = [showView convertRect:showView.bounds toView:nil];
    self.contentView.centerX = CGRectGetMidX(rect);
    self.contentView.y = CGRectGetMaxY(rect);
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
}
-(void)coverBtnClick:(UIButton *)btn{
    [self removeFromSuperview];
}
@end
