//
//  IWStatusFrame.h
//  weibo
//
//  Created by 何建新 on 2016/9/1.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NAME_LABEL_SIZE 14
#define CONTENT_LABEL_SIZE 12
@class IWStatus;
@interface IWStatusFrame : NSObject
//1要包含其对应的cell里面的子控件的frmae
@property(nonatomic, assign)CGRect headImageF;
@property(nonatomic, assign)CGRect nameLabelF;
@property(nonatomic, assign)CGRect contentLabelF;
@property(nonatomic, assign)CGRect createLabelF;
@property(nonatomic, assign)CGRect sourceLabelF;
//2数据模型
@property(nonatomic,strong)IWStatus *status;
//CELL的高度
@property(nonatomic, assign)CGFloat cellHeight;
@property(nonatomic, assign)CGRect photoViewF;
//cell底部工具条
@property(nonatomic, assign) CGRect statusToolBarF;
@end
