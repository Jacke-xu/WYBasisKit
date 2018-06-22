//
//  UITableView+Extension.m
//  WYBasisKit
//
//  Created by jacke－xu on 16/10/2.
//  Copyright © 2016年 jacke-xu. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)

- (void)rendererHeaderFooterViewBackgroundColor:(UIView *)view color:(UIColor *)color {
    
    UITableViewHeaderFooterView *headerFooterView = (UITableViewHeaderFooterView *)view;
    headerFooterView.tintColor = color;
}

- (void)scrollWithoutPasting:(UIScrollView *)scrollView height:(CGFloat)height {
    
    if (scrollView == self)
    {
        if (scrollView.contentOffset.y <= height&&scrollView.contentOffset.y >= 0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y >= height) {
            scrollView.contentInset = UIEdgeInsetsMake(-height, 0, 0, 0);
        }
    }
}

- (void)cellCutOffLineFromZeroPoint:(UITableViewCell *)cell {
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)forbiddenSelfSizing {
    
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
