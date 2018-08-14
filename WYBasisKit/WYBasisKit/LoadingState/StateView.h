//
//  StateView.h
//  WYBasisKit
//
//  Created by jacke－xu on 17/2/12.
//  Copyright © 2017年 com.jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StateView : UIView

/** 自动移除 */
+ (void)showSuccessInfo:(NSString *)message;

/** 自动移除 */
+ (void)showErrorInfo:(NSString *)message;

/** 自动移除 */
+ (void)showWarningInfo:(NSString *)message;

/** 移除 */
+ (void)dismiss;

@end
