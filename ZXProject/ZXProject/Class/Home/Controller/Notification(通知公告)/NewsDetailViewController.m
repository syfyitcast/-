//
//  NewsDetailViewController.m
//  ZXProject
//
//  Created by Me on 2018/2/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "GobHeaderFile.h"
#import <WebKit/WebKit.h>

@interface NewsDetailViewController ()<WKNavigationDelegate>

@property (nonatomic, strong)  WKWebView*webView;

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻详情";
    self.view.backgroundColor = WhiteColor;
    self.webView.backgroundColor = WhiteColor;
    self.webView = [[WKWebView alloc] init];
    self.webView.frame = self.view.bounds;
    [self.view addSubview:self.webView];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
    self.webView.navigationDelegate = self;
    ZXSHOW_LOADING(self.view, @"加载中...");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    ZXHIDE_LOADING;
}


@end
