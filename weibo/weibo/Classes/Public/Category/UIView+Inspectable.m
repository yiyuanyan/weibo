//
//  UIView+Inspectable.m
//  weibo
//
//  Created by 何建新 on 16/8/24.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "UIView+Inspectable.h"

@implementation UIView (Inspectable)
-(void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}
-(CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}
@end
