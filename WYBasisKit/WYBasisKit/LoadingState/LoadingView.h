//
//  LoadingView.h
//  WYBasisKit
//
//  Created by jacke-xu on 17/2/12.
//  Copyright © 2017年 com.jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

/** 自定义图片模式 */
+ (void)showMessage:(NSString *)message;

/** 自定义图片模式 */
+ (void)showMessage:(NSString *)message superView:(UIView *)superView;

/** 系统小菊花模式 */
+ (void)showInfo:(NSString *)message;

/** 系统小菊花模式 */
+ (void)showInfo:(NSString *)message  superView:(UIView *)superView;

/** 移除 */
+ (void)dismiss;

@end
