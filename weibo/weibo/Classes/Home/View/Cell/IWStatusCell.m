//
//  IWStatusCell.m
//  weibo
//
//  Created by 何建新 on 2016/9/1.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWStatusCell.h"
#import "IWStatus.h"
#import "IWStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "IWUser.h"
#import "IWStatusToolBar.h"
@interface IWStatusCell()
@property(nonatomic, weak)UIImageView *headImage;
@property(nonatomic, weak)UILabel *nameLabel;
@property(nonatomic, weak)UILabel *createLabel;
//微博内容
@property(nonatomic, weak)UILabel *contentLabel;
//来源
@property(nonatomic, weak)UILabel *sourceLabel;
//原创微博的图片
@property(nonatomic, weak)UIImageView *photoView;
//微博工具条
@property(nonatomic, weak)IWStatusToolBar *statusToolBar;
@end


@implementation IWStatusCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    IWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (!cell) {
//        cell = [[IWStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
    
    return cell;
    
}
//重写cell的初始化方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        //在这里添加子控件
        //添加头像
        UIImageView *headImage = [[UIImageView alloc] init];
        [self.contentView addSubview:headImage];
        self.headImage = headImage;
        //昵称
        UILabel *nameLabel = [UILabel new];
        nameLabel.font = SYS_FONT(NAME_LABEL_SIZE);
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        //添加原创微博内容
        UILabel *contentLabel = [UILabel new];
        contentLabel.numberOfLines = 0;
        contentLabel.font = SYS_FONT(CONTENT_LABEL_SIZE);
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        //添加时间label
        UILabel *createLabel = [[UILabel alloc] init];
        createLabel.numberOfLines = 0;
        createLabel.font = SYS_FONT(10);
        [self.contentView addSubview:createLabel];
        self.createLabel = createLabel;
        //来源
        UILabel *sourceLabel = [UILabel new];
        sourceLabel.font = SYS_FONT(10);
        sourceLabel.numberOfLines = 1;
        [self.contentView addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        UIImageView *photoView = [[UIImageView alloc] init];
        [self.contentView addSubview:photoView];
        self.photoView = photoView;
        
        IWStatusToolBar *statusToolBar = [IWStatusToolBar new];
        [self.contentView addSubview:statusToolBar];
        self.statusToolBar = statusToolBar;
        
        
    }
    return self;
}


-(void)setStatusFrame:(IWStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    //1给子控件设置大小
    //头像
    self.headImage.frame = statusFrame.headImageF;
    NSString *userProfile = statusFrame.status.user.profile_image_url;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:userProfile] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //昵称
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = statusFrame.status.user.screen_name;
    //内容
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = statusFrame.status.text;
    //2给子控件设置数据
    
    self.createLabel.text = statusFrame.status.created_at;
    self.createLabel.frame = statusFrame.createLabelF;
    
    self.sourceLabel.text = statusFrame.status.source;
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    
    if(statusFrame.status.thumbnail_pic){
        self.photoView.hidden = NO;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:self.statusFrame.status.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.frame = statusFrame.photoViewF;
    }else{
        self.photoView.hidden = YES;
    }
    //工具条
    self.statusToolBar.frame = statusFrame.statusToolBarF;
}
@end
