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

- (void)setBg_nColor:(UIColor *)bg_nColor {
    
    if(self.state == UIControlStateNormal) {
        
        [self setBackgroundColor:bg_nColor];
    }
}

- (UIColor *)bg_nColor {
    
    return self.bg_nColor;
}

- (void)setBg_hColor:(UIColor *)bg_hColor {
    
    if(self.state == UIControlStateHighlighted) {
        
        [self setBackgroundColor:bg_hColor];
    }
}

- (UIColor *)bg_hColor {
    
    return self.bg_hColor;
}

- (void)setBg_sColor:(UIColor *)bg_sColor {
    
    if(self.state == UIControlStateSelected) {
        
        [self setBackgroundColor:bg_sColor];
    }
}

- (UIColor *)bg_sColor {
    
    return self.bg_sColor;
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

- (void)setLeftAlignment:(BOOL)leftAlignment {
    
    if(leftAlignment == YES) {
        
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
}

- (BOOL)leftAlignment {
    
    return self.contentHorizontalAlignment;
}

- (void)setCenterAlignment:(BOOL)centerAlignment {
    
    if(centerAlignment == YES) {
        
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
}

- (BOOL)centerAlignment {
    
    return self.contentHorizontalAlignment;
}

- (void)setRightAlignment:(BOOL)rightAlignment {
    
    if(rightAlignment == YES) {
        
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
}

- (BOOL)rightAlignment {
    
    return self.contentHorizontalAlignment;
}

- (void)setTopAlignment:(BOOL)topAlignment {
    
    if(topAlignment == YES) {
        
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    }
}

- (BOOL)topAlignment {
    
    return self.contentVerticalAlignment;
}

- (void)setBottomAlignment:(BOOL)bottomAlignment {
    
    if(bottomAlignment == YES) {
        
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    }
}

- (BOOL)bottomAlignment {
    
    return self.contentVerticalAlignment;
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

@end
