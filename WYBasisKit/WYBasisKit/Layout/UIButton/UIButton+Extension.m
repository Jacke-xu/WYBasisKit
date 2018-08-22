//
//  UIButton+Extension.m
//  WYBasisKit
//
//  Created by jacke－xu on 16/9/4.
//  Copyright © 2016年 jacke-xu. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (void)setNTitle:(NSString *)nTitle {
    
    [self setTitle:nTitle forState:UIControlStateNormal];
}

- (NSString *)nTitle {
    
    return [self titleForState:UIControlStateNormal];
}

- (void)setHTitle:(NSString *)hTitle {
    
    [self setTitle:hTitle forState:UIControlStateHighlighted];
}

- (NSString *)hTitle {
    
    return [self titleForState:UIControlStateHighlighted];
}

- (void)setSTitle:(NSString *)sTitle {
    
    [self setTitle:sTitle forState:UIControlStateSelected];
}

- (NSString *)sTitle {
    
    return [self titleForState:UIControlStateSelected];
}

- (void)setTitle_nColor:(UIColor *)title_nColor {
    
    [self setTitleColor:title_nColor forState:UIControlStateNormal];
}

- (UIColor *)title_nColor {
    
    return [self titleColorForState:UIControlStateNormal];
}

- (void)setTitle_hColor:(UIColor *)title_hColor {
    
    [self setTitleColor:title_hColor forState:UIControlStateHighlighted];
}

- (UIColor *)title_hColor {
    
    return [self titleColorForState:UIControlStateHighlighted];
}

- (void)setTitle_sColor:(UIColor *)title_sColor {
    
    [self setTitleColor:title_sColor forState:UIControlStateSelected];
}

- (UIColor *)title_sColor {
    
    return [self titleColorForState:UIControlStateSelected];
}

- (void)setNImage:(UIImage *)nImage {
    
    [self setImage:nImage forState:UIControlStateNormal];
}

- (UIImage *)nImage {
    
    return [self imageForState:UIControlStateNormal];
}

- (void)setHImage:(UIImage *)hImage {
    
    [self setImage:hImage forState:UIControlStateHighlighted];
}

- (UIImage *)hImage {
    
    return [self imageForState:UIControlStateHighlighted];
}

- (void)setSImage:(UIImage *)sImage {
    
    [self setImage:sImage forState:UIControlStateSelected];
}

- (UIImage *)sImage {
    
    return [self imageForState:UIControlStateSelected];
}

- (void)setTitleFont:(UIFont *)titleFont {
    
    self.titleLabel.font = titleFont;
}

- (UIFont *)titleFont {
    
    return self.titleLabel.font;
}

- (void)leftAlignment {
    
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}

- (void)centerAlignment {
    
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
}

- (void)rightAlignment {
    
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
}

- (void)topAlignment {
    
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
}

- (void)bottomAlignment {
    
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
}

- (instancetype)initWithFrame:(CGRect)frame target:(id)target selector:(SEL)selector {
    
    if(self == [super initWithFrame:frame]) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = frame;
        [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        self = btn;
    }
    
    return self;
}

- (void)addTarget:(id)target selector:(SEL)selector {
    
    [self addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

@end
