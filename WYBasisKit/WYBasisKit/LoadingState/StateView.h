//
//  StateView.h
//  WYBasisKit
//
//  Created by jacke－xu on 17/2/12.
//  Copyright © 2017年 com.jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StateView : UIView

/** 手动移除 */
+ (void)showSuccessMessage:(NSString *)message;

/** 手动移除 */
+ (void)showErrorMessage:(NSString *)message;

/** 手动移除 */
+ (void)showWarningMessage:(NSString *)message;

/** 手动移除 */
+ (void)showSuccessMessage:(NSString *)message superView:(UIView *)superView;

/** 手动移除 */
+ (void)showErrorMessage:(NSString *)message superView:(UIView *)superView;

/** 手动移除 */
+ (void)showWarningMessage:(NSString *)message superView:(UIView *)superView;

/** 自动移除 */
+ (void)showSuccessInfo:(NSString *)message;

/** 自动移除 */
+ (void)showErrorInfo:(NSString *)message;

/** 自动移除 */
+ (void)showWarningInfo:(NSString *)message;

/** 移除 */
+ (void)dismiss;

@end
