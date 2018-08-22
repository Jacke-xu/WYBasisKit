//
//  UILabel+Extension.m
//  WYBasisKit
//
//  Created by jacke－xu on 16/9/4.
//  Copyright © 2016年 jacke-xu. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

- (void)leftAlignment {self.textAlignment = NSTextAlignmentLeft;}

- (void)centerAlignment {self.textAlignment = NSTextAlignmentCenter;}

- (void)rightAlignment {self.textAlignment = NSTextAlignmentRight;}

+ (UILabel *)createLabWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont*)font bgColor:(UIColor *)bgColor {
    
    UILabel *lab = [[UILabel alloc]initWithFrame:frame];
    lab.backgroundColor = bgColor;
    lab.text = text;
    lab.textColor = textColor;
    lab.font = font;
    
    return lab;
}

+ (UILabel *)createCircularLabWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont*)font bgColor:(UIColor *)bgColor cornerRadius:(CGFloat)cornerRadius {
    
    UILabel *lab = [self createLabWithFrame:frame text:text textColor:textColor font:font bgColor:bgColor];
    lab.layer.cornerRadius = cornerRadius;
    lab.clipsToBounds = YES;
    
    return lab;
}

+ (UILabel *)createBorderLabWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont*)font bgColor:(UIColor *)bgColor borderWidth:(float)borderWidth borderColor:(UIColor *)borderColor {
    
    UILabel *lab = [self createLabWithFrame:frame text:text textColor:textColor font:font bgColor:bgColor];
    lab.layer.borderColor = borderColor.CGColor;
    lab.layer.borderWidth = borderWidth;
    
    return lab;
}

+ (UILabel *)createBorderCircularLabWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont*)font bgColor:(UIColor *)bgColor cornerRadius:(CGFloat)cornerRadius borderWidth:(float)borderWidth borderColor:(UIColor *)borderColor {
    
    UILabel *lab = [self createCircularLabWithFrame:frame text:text textColor:textColor font:font bgColor:bgColor cornerRadius:cornerRadius];
    lab.layer.borderColor = borderColor.CGColor;
    lab.layer.borderWidth = borderWidth;
    
    return lab;
}

@end
