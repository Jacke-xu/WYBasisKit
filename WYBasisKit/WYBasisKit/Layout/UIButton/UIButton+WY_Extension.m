//
//  UIButton+WY_Extension.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/11/27.
//  Copyright © 2018 jacke-xu. All rights reserved.
//

#import "UIButton+WY_Extension.h"

@implementation UIButton (WY_Extension)

- (void)setWy_nTitle:(NSString *)wy_nTitle {
    
    [self setTitle:wy_nTitle forState:UIControlStateNormal];
}

- (NSString *)wy_nTitle {
    
    return [self titleForState:UIControlStateNormal];
}

- (void)setWy_hTitle:(NSString *)wy_hTitle {
    
    [self setTitle:wy_hTitle forState:UIControlStateHighlighted];
}

- (NSString *)wy_hTitle {
    
    return [self titleForState:UIControlStateHighlighted];
}

- (void)setWy_sTitle:(NSString *)wy_sTitle {
    
    [self setTitle:wy_sTitle forState:UIControlStateSelected];
}

- (NSString *)wy_sTitle {
    
    return [self titleForState:UIControlStateSelected];
}

- (void)setWy_title_nColor:(UIColor *)wy_title_nColor {
    
    [self setTitleColor:wy_title_nColor forState:UIControlStateNormal];
}

- (UIColor *)wy_title_nColor {
    
    return [self titleColorForState:UIControlStateNormal];
}

- (void)setWy_title_hColor:(UIColor *)wy_title_hColor {
    
    [self setTitleColor:wy_title_hColor forState:UIControlStateHighlighted];
}

- (UIColor *)wy_title_hColor {
    
    return [self titleColorForState:UIControlStateHighlighted];
}

- (void)setWy_title_sColor:(UIColor *)wy_title_sColor {
    
    [self setTitleColor:wy_title_sColor forState:UIControlStateSelected];
}

- (UIColor *)wy_title_sColor {
    
    return [self titleColorForState:UIControlStateSelected];
}

- (void)setWy_nImage:(UIImage *)wy_nImage {
    
    [self setImage:wy_nImage forState:UIControlStateNormal];
}

- (UIImage *)wy_nImage {
    
    return [self imageForState:UIControlStateNormal];
}

- (void)setWy_hImage:(UIImage *)wy_hImage {
    
    [self setImage:wy_hImage forState:UIControlStateHighlighted];
}

- (UIImage *)wy_hImage {
    
    return [self imageForState:UIControlStateHighlighted];
}

- (void)setWy_sImage:(UIImage *)wy_sImage {
    
    [self setImage:wy_sImage forState:UIControlStateSelected];
}

- (UIImage *)wy_sImage {
    
    return [self imageForState:UIControlStateSelected];
}

- (void)setWy_titleFont:(UIFont *)wy_titleFont {
    
    self.titleLabel.font = wy_titleFont;
}

- (UIFont *)wy_titleFont {
    
    return self.titleLabel.font;
}

- (void)wy_radius:(CGFloat)radius {
    
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;
}

- (void)wy_leftAlignment {
    
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}

- (void)wy_centerAlignment {
    
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
}

- (void)wy_rightAlignment {
    
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
}

- (void)wy_topAlignment {
    
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
}

- (void)wy_bottomAlignment {
    
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
}

- (instancetype)wy_initWithFrame:(CGRect)frame target:(id)target selector:(SEL)selector {
    
    if(self == [super initWithFrame:frame]) {
        
        [self addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)wy_addTarget:(id)target selector:(SEL)selector {
    
    [self addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

@end
