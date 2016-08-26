//
//  IWOAuthViewCtrl.m
//  weibo
//
//  Created by 何建新 on 16/8/25.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWOAuthViewCtrl.h"
#import "AFNetworking.h"
#import "IWTabBarController.h"
#import "IWAccount.h"
#define Client_id @"3747445191"
#define Client_secret @"5f1c562002281f9de59e8580cd7fba46"
//授权回调
#define Redirect_uri @"http://www.hejianxin.com/callback.php"

@interface IWOAuthViewCtrl ()<UIWebViewDelegate>

@end

@implementation IWOAuthViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",Client_id,Redirect_uri];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    webView.delegate = self;
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - webViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = request.URL.absoluteString;
    //判断是否调用回调页面
    if([urlStr hasPrefix:Redirect_uri]){
        NSString *suStr = @"code=";
        NSRange range = [urlStr rangeOfString:suStr];
        //判断是否找到
        if(range.location != NSNotFound){
            //开始截取字符串，拿到授权码
            NSString *code = [urlStr substringFromIndex:range.location + range.length];
            [self getAccessTokenWithCode:code];
        }
    }
    
    return YES;
}
-(void)getAccessTokenWithCode:(NSString *)code{
    NSString *urlStr = @"https://api.weibo.com/oauth2/access_token";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = Client_id;
    params[@"client_secret"] = Client_secret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = Redirect_uri;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        //创建模型
        IWAccount *acount = [IWAccount new];
        //将返回来的数据转入模型
        [acount setValuesForKeysWithDictionary:responseObject];
        //获取保存路径
        NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        //拼接保存路径文件路径
        filePath = [filePath stringByAppendingString:@"account.archiver"];
        //归档保存数据
        [NSKeyedArchiver archiveRootObject:acount toFile:filePath];
        //密码归档登录成功跳转页面
        IWTabBarController *ctrl = [IWTabBarController new];
        //切换window的控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = ctrl;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误=%@",error);
    }];
}
@end
