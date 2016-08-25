//
//  UIBarButtonItem+Extension.h
//  weibo
//
//  Created by 何建新 on 16/8/12.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+(instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;

+(instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action title:(NSString *)title;
@end
