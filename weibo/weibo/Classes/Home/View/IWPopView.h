//
//  IWPopView.h
//  weibo
//
//  Created by 何建新 on 16/8/24.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWPopView : UIButton
-(instancetype)initWithCustomsView:(UIView *)customsView;

-(void)showFromView:(UIView *)showView;
@end
