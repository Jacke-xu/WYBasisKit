//
//  UILabel+WY_Extension.h
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/11/27.
//  Copyright © 2018 jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (WY_Extension)

/** 获取UILable的行高(根据UILable的字号获取的，系统默认字号：17) */
@property (nonatomic, assign, readonly) CGFloat wy_lineHeight;

/** 设置标签左对齐 */
- (void)wy_leftAlignment;

/** 设置标签中心对齐 */
- (void)wy_centerAlignment;

/** 设置标签右对齐 */
- (void)wy_rightAlignment;

/** 创建lable */
+ (UILabel *)wy_createLabWithFrame:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
