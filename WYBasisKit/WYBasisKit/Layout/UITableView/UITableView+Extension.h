//
//  UITableView+Extension.h
//  WYBasisKit
//
//  Created by jacke－xu on 16/10/2.
//  Copyright © 2016年 jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Extension)

/** 设置tableView头部或尾部背景色 */
- (void)rendererHeaderFooterViewBackgroundColor:(UIView *)view color:(UIColor *)color;

/** 设置tableView滚动时无粘性 */
- (void)scrollWithoutPasting:(UIScrollView *)scrollView height:(CGFloat)height;

/** 设置tableViewCell分割线顶头 */
- (void)cellCutOffLineFromZeroPoint:(UITableViewCell *)cell;

/** 禁用 Self-Sizing */
- (void)forbiddenSelfSizing;

@end
