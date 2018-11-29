//
//  WKWebView+WY_Extension.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/11/27.
//  Copyright © 2018 jacke-xu. All rights reserved.
//

#import "WKWebView+WY_Extension.h"
#include <objc/runtime.h>

@interface WKWebView ()<WKNavigationDelegate>

@property (nonatomic, strong) UIProgressView *wy_progressView;

@end

@implementation WKWebView (WY_Extension)

- (void)wy_showProgressWithColor:(UIColor *)color {
    
    //进度条初始化
    self.wy_progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    //设置进度条上进度的颜色
    self.wy_progressView.progressTintColor = (color != nil) ? color : [UIColor wy_hexColor:@"68ccf4"];
    //设置进度条背景色
    self.wy_progressView.trackTintColor = [UIColor lightGrayColor];
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.wy_progressView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [self addSubview:self.wy_progressView];
    
    [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    self.navigationDelegate = self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if(self.wy_progressView != nil) {
        
        if (object == self && [keyPath isEqualToString:@"estimatedProgress"])
        {
            CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
            if (newprogress == 1)
            {
                self.wy_progressView.hidden = YES;
                [self.wy_progressView setProgress:0 animated:NO];
            }
            else
            {
                self.wy_progressView.hidden = NO;
                [self.wy_progressView setProgress:newprogress animated:YES];
            }
        }
    }
}

//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    //开始加载网页时展示出progressView
    if(self.wy_progressView != nil) {
        
        self.wy_progressView.hidden = NO;
        //开始加载网页的时候将progressView的Height恢复为1.5倍
        self.wy_progressView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        //防止progressView被网页挡住
        [self bringSubviewToFront:self.wy_progressView];
    }
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    //加载完成后隐藏progressView
    if(self.wy_progressView != nil) {
        
        self.wy_progressView.hidden = YES;
    }
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    //加载失败同样需要隐藏progressView
    if(self.wy_progressView != nil) {
        
        self.wy_progressView.hidden = YES;
    }
}

- (void)setWy_progressView:(UIProgressView *)wy_progressView {
    
    objc_setAssociatedObject(self, &@selector(wy_progressView), wy_progressView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIProgressView *)wy_progressView {
    
    UIProgressView *obj = objc_getAssociatedObject(self, &@selector(wy_progressView));
    return obj;
}

- (void)dealloc {
    
    if(self.wy_progressView != nil) {
        
        [self removeObserver:self forKeyPath:@"estimatedProgress"];
    }
}

@end
