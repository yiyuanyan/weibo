//
//  IWOAuthViewCtrl.m
//  weibo
//
//  Created by 何建新 on 16/8/25.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWOAuthViewCtrl.h"
#define Client_id @"3747445191"
//授权回调
#define Redirect_uri @"http://www.hejianxin.com/callback.php"

@interface IWOAuthViewCtrl ()

@end

@implementation IWOAuthViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",Client_id,Redirect_uri];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
