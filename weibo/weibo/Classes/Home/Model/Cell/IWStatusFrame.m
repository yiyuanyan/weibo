//
//  IWStatusFrame.m
//  weibo
//
//  Created by 何建新 on 2016/9/1.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWStatusFrame.h"
#import "IWStatus.h"
#import "IWUser.h"
#define MARGIN 10

@implementation IWStatusFrame
-(void)setStatus:(IWStatus *)status
{
    _status = status;
    //计算头像大小
    CGFloat headImageX = MARGIN;
    CGFloat headImageY = MARGIN;
    CGFloat headImageWH = 30;
    self.headImageF = CGRectMake(headImageX, headImageY, headImageWH, headImageWH);
    
    //计算昵称大小
    CGFloat nameLabelX = CGRectGetMaxX(self.headImageF) + MARGIN;
    CGFloat nameLabelY = headImageY;
    CGSize nameLabelSize = [status.user.screen_name sizeWithFont:SYS_FONT(NAME_LABEL_SIZE)];
    //self.nameLabelF = CGRectMake(nameLabelX, nameLabelY, nameLabelSize.width, nameLabelSize.height);
    self.nameLabelF = (CGRect){{nameLabelX,nameLabelY},nameLabelSize};
    //创建时间
    CGFloat createLabelX = nameLabelX;
    CGFloat createLabelY = CGRectGetMaxY(self.nameLabelF) + MARGIN * 0.5;
    CGSize createLabelSize = [status.created_at sizeWithFont:SYS_FONT(10)];
    self.createLabelF = (CGRect){{createLabelX,createLabelY},createLabelSize};
    //正文
    CGFloat contentLabelX = headImageX;
    CGFloat contentLabelY = CGRectGetMaxY(self.headImageF) + MARGIN;
    CGSize contentLabelSize = [status.text sizeWithFont:SYS_FONT(CONTENT_LABEL_SIZE) constrainedToSize:CGSizeMake(SCREENH - 2 * MARGIN, MAXFLOAT)];
    self.contentLabelF = (CGRect){{contentLabelX,contentLabelY},contentLabelSize};
    
    
    
    
    //来源
    CGFloat sourceLabelX = CGRectGetMaxX(self.createLabelF) + MARGIN;
    CGFloat sourceLabelY = createLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:SYS_FONT(10)];
    self.sourceLabelF = (CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
    
    self.contentLabelF = (CGRect){{contentLabelX,contentLabelY},contentLabelSize};
    
    
    CGFloat statusToolBarY = CGRectGetMaxY(self.contentLabelF) + MARGIN;
    //图片
    if(status.thumbnail_pic){
        //计算imageView的大小
        CGFloat photoViewX = headImageX;
        CGFloat photoViewY = CGRectGetMaxY(self.contentLabelF) + MARGIN;
        CGSize photoViewSize = CGSizeMake(70, 70);
        self.photoViewF = (CGRect){{photoViewX,photoViewY},photoViewSize};
        statusToolBarY = CGRectGetMaxY(self.photoViewF) + MARGIN;
    }
    
    CGFloat statusToolBarX = 0;
    CGSize statusToolBarSize = CGSizeMake(SCREENW, 35);
    self.statusToolBarF = (CGRect){{statusToolBarX,statusToolBarY},statusToolBarSize};
    
    
    self.cellHeight = CGRectGetMaxY(self.statusToolBarF);
}
@end
