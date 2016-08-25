//
//  IWNewFeatureCtrl.m
//  weibo
//
//  Created by 何建新 on 16/8/25.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWNewFeatureCtrl.h"

@interface IWNewFeatureCtrl ()<UIScrollViewDelegate>
@property(nonatomic, weak)UIPageControl *pageControl;
@end

@implementation IWNewFeatureCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    //监听scrollView滚动
    scrollView.delegate = self;
    NSUInteger count = 4;
    //pageControl
    UIPageControl *control = [UIPageControl new];
    control.numberOfPages = count;
    control.size = CGSizeMake(SCREENW, 30);
    control.centerX = SCREENW * 0.5;
    control.y = SCREENH - 100;
    control.currentPageIndicatorTintColor = [UIColor blueColor];
    control.pageIndicatorTintColor = [UIColor redColor];
    [self.view addSubview:control];
    self.pageControl = control;
    
    [self.view insertSubview:scrollView belowSubview:control];
    //[self.view addSubview:scrollView];
    for(int i = 0; i<count;i++){
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%zd",i+1]];
        imageView.size = scrollView.size;
        imageView.x = i * scrollView.width;
        imageView.y = 0;
        [scrollView addSubview:imageView];
        if(i == count-1){
            [self setupLastPage:imageView];
        }
    }
    
    
    scrollView.contentSize = CGSizeMake(count * scrollView.width, 0);
    
    
}
-(void)setupLastPage:(UIImageView *)imageView{
    imageView.userInteractionEnabled = YES;
    UIButton *enterBtn = [[UIButton alloc] init];
    [enterBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [enterBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    enterBtn.size = enterBtn.currentBackgroundImage.size;
    enterBtn.centerX = imageView.width * 0.5;
    enterBtn.y = imageView.height - 150;
    [enterBtn setTitle:@"进入微博" forState:UIControlStateNormal];
    [imageView addSubview:enterBtn];
    
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享到微博" forState:UIControlStateNormal];
    [shareBtn sizeToFit];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.centerX = enterBtn.centerX;
    shareBtn.y = enterBtn.y - 50;
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - scrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat page = scrollView.contentOffset.x / scrollView.width;
    NSInteger pageNum = (int)(page + 0.5);
    self.pageControl.currentPage = pageNum;
}
//点击后让按钮状态取反
-(void)shareBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
}
@end
