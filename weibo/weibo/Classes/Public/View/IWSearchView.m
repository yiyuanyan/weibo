//
//  IWSearchView.m
//  weibo
//
//  Created by 何建新 on 16/8/24.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWSearchView.h"
@interface IWSearchView()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;




@end
@implementation IWSearchView
//返回一个通过xib加载的view
+(instancetype)searchView{
    return [[[NSBundle mainBundle] loadNibNamed:@"IWSearchView" owner:nil options:nil] lastObject];
}
-(void)awakeFromNib
{
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    //设置imageView的内容模式
    leftView.contentMode = UIViewContentModeCenter;
    leftView.width = self.height;
    self.searchField.leftView = leftView;
    self.searchField.leftViewMode = UITextFieldViewModeAlways;
    self.searchField.delegate = self;
}
//加载xib文件最先执行，此时控件连线还未执行所以self.searchField为nil
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        
    }
    return self;
}
- (IBAction)cancelBtnClick:(UIButton *)sender {
    //更新约束
    self.rightConstraint.constant = 0;
    //执行动画
    [UIView animateWithDuration:0.25 animations:^{
        //刷新，重新布局
        [self layoutIfNeeded];
    }];
    [self endEditing:YES];
    [self.searchField resignFirstResponder];
}
//开始编辑的时候回调这个方法
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //更新约束
    self.rightConstraint.constant = self.cancelButton.width;
    //执行动画
    [UIView animateWithDuration:0.25 animations:^{
        //刷新，重新布局
        [self layoutIfNeeded];
    }];
}
@end
