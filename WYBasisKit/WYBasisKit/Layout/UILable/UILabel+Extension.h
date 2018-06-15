//
//  UILabel+Extension.h
//  WYBasisKit
//
//  Created by jacke－xu on 16/9/4.
//  Copyright © 2016年 jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

//设置标签对齐方式
@property (nonatomic, assign) BOOL leftAlignment;//设置标签左对齐

@property (nonatomic, assign) BOOL centerAlignment;//设置标签中心对齐

@property (nonatomic, assign) BOOL rightAlignment;//设置标签右对齐

/** 创建无边框lab */
+ (UILabel *)createLabWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont*)font bgColor:(UIColor *)bgColor;

/** 创建无边框圆角lab */
+ (UILabel *)createCircularLabWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont*)font bgColor:(UIColor *)bgColor cornerRadius:(CGFloat)cornerRadius;

/** 创建带边框lab */
+ (UILabel *)createBorderLabWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont*)font bgColor:(UIColor *)bgColor borderWidth:(float)borderWidth borderColor:(UIColor *)borderColor;

/** 创建带边框圆角lab */
+ (UILabel *)createBorderCircularLabWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont*)font bgColor:(UIColor *)bgColor cornerRadius:(CGFloat)cornerRadius borderWidth:(float)borderWidth borderColor:(UIColor *)borderColor;

@end
