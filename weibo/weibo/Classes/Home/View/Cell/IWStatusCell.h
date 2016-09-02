//
//  IWStatusCell.h
//  weibo
//
//  Created by 何建新 on 2016/9/1.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#define identifier @"IWStatusCell"
@class IWStatusFrame;
@interface IWStatusCell : UITableViewCell
//通过tableView返回cell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic, strong) IWStatusFrame *statusFrame;
@end
