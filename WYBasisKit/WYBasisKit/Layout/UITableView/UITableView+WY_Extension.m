//
//  UITableView+WY_Extension.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/11/27.
//  Copyright © 2018 jacke-xu. All rights reserved.
//

#import "UITableView+WY_Extension.h"

@implementation UITableView (WY_Extension)

- (void)wy_rendererHeaderFooterViewBackgroundColor:(UIView *)view color:(UIColor *)color {
    
    UITableViewHeaderFooterView *headerFooterView = (UITableViewHeaderFooterView *)view;
    headerFooterView.tintColor = color;
}

- (void)wy_scrollWithoutPasting:(UIScrollView *)scrollView height:(CGFloat)height {
    
    if (scrollView == self)
    {
        if (scrollView.contentOffset.y <= height&&scrollView.contentOffset.y >= 0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y >= height) {
            scrollView.contentInset = UIEdgeInsetsMake(-height, 0, 0, 0);
        }
    }
}

- (void)wy_forbiddenSelfSizing {
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
        
        //关闭高度估算
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        
        if ([self respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            if (@available(iOS 11.0, *)) {
                self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

@end
