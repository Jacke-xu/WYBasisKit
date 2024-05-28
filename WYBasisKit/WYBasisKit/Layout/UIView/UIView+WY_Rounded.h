//
//  UIView+Rounded.h
//  WYBasisKit
//
//  Created by jacke-xu on 2017/4/25.
//  Copyright © 2017年 jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WY_Rounded)

/**
 设置一个四角圆角
 
 @param radius 圆角半径
 @param color  圆角背景色
 */
- (void)wy_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color;

/**
 设置一个普通圆角
 
 @param radius  圆角半径
 @param color   圆角背景色
 @param corners 圆角位置
 */
- (void)wy_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners;

/**
 设置一个带边框的圆角
 
 @param cornerRadii 圆角半径cornerRadii
 @param color       圆角背景色
 @param corners     圆角位置
 @param borderColor 边框颜色
 @param borderWidth 边框线宽
 */
- (void)wy_cornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end

@interface CALayer (WY_Rounded)

@property (nonatomic, strong) UIImage *wy_contentImage;//contents的便捷设置

/**如下分别对应UIView的相应API*/

- (void)wy_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color;

- (void)wy_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners;

- (void)wy_cornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end
