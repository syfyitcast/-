//
//  NewsDetailViewController.m
//  ZXProject
//
//  Created by Me on 2018/2/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "GobHeaderFile.h"

@interface NewsDetailViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻详情";
    self.view.backgroundColor = WhiteColor;
    self.webView.backgroundColor = WhiteColor;
    self.webView = [[UIWebView alloc] init];
    self.webView.frame = self.view.bounds;
    [self.view addSubview:self.webView];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
    self.webView.delegate = self;
    ZXSHOW_LOADING(self.view, @"加载中...");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    ZXHIDE_LOADING;
}


@end
