//
//  YJYOAuthViewController.m
//  Weibo
//
//  Created by yaojinye on 16/7/5.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"

#import "YJYAccount.h"
#import "YJYAccountTool.h"
#include "YJYRootTool.h"
#import "YJYHttpTool.h"



@interface YJYOAuthViewController ()<UIWebViewDelegate>

@end

@implementation YJYOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
     //    一个完整的URL：基本的URL+参数
//    https://api.weibo.com/oauth2/authorize
    NSString *baseUrl = YJYAuthorizeBaseUrl;
    NSString *client_id = YJYClient_id;
    NSString *redirect_uri = YJYRedirect_uri;
    //
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@", baseUrl, client_id, redirect_uri];
    //
    NSURL *url = [NSURL URLWithString:urlStr];
    //
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //
    [webView loadRequest:request];
    
    //
    webView.delegate = self;
    
}

#pragma mark --WebViewDelegate--
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在加载..."];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = request.URL.absoluteString;
    NSLog(@"%@", urlStr);
    
    NSRange rang = [urlStr rangeOfString:@"code="];
    if (rang.length) {
        NSString *code = [urlStr substringFromIndex:rang.location+rang.length];
        NSLog(@"code::::%@", code);
        [self accessTokenWithCode:code];
//        [self accesstoken];
        
        
        return NO;
    }
    
    return YES;
}

-(void)accesstoken{
    
}

#pragma mark --Get accessToken--
-(void)accessTokenWithCode:(NSString *)code{
    /**
     client_id	true	string	申请应用时分配的AppKey。
     client_secret	true	string	申请应用时分配的AppSecret。
     grant_type	true	string	请求的类型，填写authorization_code
     
     grant_type为authorization_code时
     必选	类型及范围	说明
     code	true	string	调用authorize获得的code值。
     redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
*/
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"client_id"] = YJYClient_id;
    param[@"client_secret"] =YJYClient_secret;
    param[@"grant_type"] = @"authorization_code";
    param[@"code"] = code;
    param[@"redirect_uri"] =YJYRedirect_uri;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"%@", responseObject);
        
        YJYAccount *account = [YJYAccount accountWithDict:responseObject];
        //Save The Account Information
        [YJYAccountTool saveAccount:account];

        [YJYRootTool chooseRootViewController:YJYKeyWindow];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
//    [YJYAccountTool accessWithCode:code success:^{
//        
//        [YJYRootTool chooseRootViewController:YJYKeyWindow];
//
//    } failure:^{
//        
//        WBLog(@"%s\nFailure accessToken", __func__);
//        
//    }];
    
        
    
}
/*
 content-type: text/plain
 */
@end
