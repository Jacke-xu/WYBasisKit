//
//  WKWebView+WY_Extension.h
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/11/27.
//  Copyright © 2018 jacke-xu. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (WY_Extension)

//显示加载网页的进度条
- (void)wy_showProgressWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
