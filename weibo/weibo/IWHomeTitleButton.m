//
//  IWHomeTitleButton.m
//  weibo
//
//  Created by 何建新 on 16/8/12.
//  Copyright © 2016年 何建新. All rights reserved.
//  首页导航栏按钮自定义

#import "IWHomeTitleButton.h"

@implementation IWHomeTitleButton

-(void)layoutSubviews{
    [super layoutSubviews];
    //调整title的位置
    self.titleLabel.x = 0;
    //再根据titleLabel的位置设置图片的x值
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
    //[self sizeToFit] 这里调用sizeToFit会死循环;
    //根据imageView的位置去设置自己的宽度
    self.width = CGRectGetMaxX(self.imageView.frame) + 5;
    
    self.centerX = self.superview.centerX;
}

@end
