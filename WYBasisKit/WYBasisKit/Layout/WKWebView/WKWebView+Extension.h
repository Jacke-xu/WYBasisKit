//
//  WKWebView+Extension.h
//  WYBasisKit
//
//  Created by jacke-xu on 2017/6/6.
//  Copyright © 2017年 jacke-xu. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebView (Extension)

//显示加载网页的进度条
- (void)showProgressWithColor:(UIColor *)color;

@end
