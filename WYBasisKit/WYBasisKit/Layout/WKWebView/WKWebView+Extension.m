//
//  WKWebView+Extension.m
//  WYBasisKit
//
//  Created by jacke-xu on 2017/6/6.
//  Copyright © 2017年 jacke-xu. All rights reserved.
//

#import "WKWebView+Extension.h"
#include <objc/runtime.h>

@interface WKWebView ()<WKNavigationDelegate>

@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation WKWebView (Extension)

- (void)showProgressWithColor:(UIColor *)color {
    
    //进度条初始化
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    //设置进度条上进度的颜色
    self.progressView.progressTintColor = (color != nil) ? color : [UIColor hexColor:@"68ccf4"];
    //设置进度条背景色
    self.progressView.trackTintColor = [UIColor lightGrayColor];
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [self addSubview:self.progressView];
    
    [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    self.navigationDelegate = self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if(self.progressView != nil) {
        
        if (object == self && [keyPath isEqualToString:@"estimatedProgress"])
        {
            CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
            if (newprogress == 1)
            {
                self.progressView.hidden = YES;
                [self.progressView setProgress:0 animated:NO];
            }
            else
            {
                self.progressView.hidden = NO;
                [self.progressView setProgress:newprogress animated:YES];
            }
        }
    }
}

//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    //开始加载网页时展示出progressView
    if(self.progressView != nil) {
        
        self.progressView.hidden = NO;
        //开始加载网页的时候将progressView的Height恢复为1.5倍
        self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        //防止progressView被网页挡住
        [self bringSubviewToFront:self.progressView];
    }
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

    //加载完成后隐藏progressView
    if(self.progressView != nil) {
        
        self.progressView.hidden = YES;
    }
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {

    //加载失败同样需要隐藏progressView
    if(self.progressView != nil) {
        
        self.progressView.hidden = YES;
    }
}

- (void)setProgressView:(UIProgressView *)progressView {
    
    objc_setAssociatedObject(self, &@selector(progressView), progressView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIProgressView *)progressView {
    
    UIProgressView *obj = objc_getAssociatedObject(self, &@selector(progressView));
    return obj;
}

- (void)dealloc {
    
    if(self.progressView != nil) {
        
        [self removeObserver:self forKeyPath:@"estimatedProgress"];
    }
}

@end
