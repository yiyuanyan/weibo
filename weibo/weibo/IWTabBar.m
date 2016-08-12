//
//  IWTabBar.m
//  weibo
//
//  Created by 何建新 on 16/8/12.
//  Copyright © 2016年 何建新. All rights reserved.
//  自定义tabBar的按钮

#import "IWTabBar.h"
@interface IWTabBar()
//加号按钮
@property(nonatomic, weak)UIButton *plusBtn;
@end;


@implementation IWTabBar
//设置这个后告诉代理，协议不在自身类中实现而在其他类中，如父类中实现
@dynamic delegate;
//初始化按钮
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        //添加加号按钮
        UIButton *plusBtn = [UIButton new];
        //设置button不同状态的背景图片
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        //设置button不同状态的image
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        //添加点击事件
        [plusBtn addTarget:self action:@selector(plusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //按钮的size使用分类进行了设置
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        //添加到视图
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}
//调整位置一般都在这个方法中
-(void)layoutSubviews{
    [super layoutSubviews];
    //调整加号按钮的位置
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    
    //调账UITabBarButton的大小和位置
    CGFloat tabbarBtnW = self.width * 0.2;
    //遍历子控件
    NSInteger index = 0;
    for (int i=0;i<self.subviews.count;i++) {
        UIView *view = self.subviews[i];
        //判断一个view是否是UITabBarButton控件
        if([view isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            view.width = tabbarBtnW;
            view.x = index * tabbarBtnW;
            
            if(index == 1){
                index++;
            }
            index++;
        }
    }
}
-(void)plusBtnClick:(UIButton *)btn{
    //判断其他类是否响应了代理方法
    if([self.delegate respondsToSelector:@selector(tabBar:plusBtnDidClicked:)]){
        //把参数传递给调用类
        [self.delegate tabBar:self plusBtnDidClicked:btn];
    }
}
@end
