//
//  UIFont+WY_Extension.m
//  WYBasisKit
//
//  Created by jacke－xu on 16/9/4.
//  Copyright © 2016年 jacke-xu. All rights reserved.
//

#import "UIFont+WY_Extension.h"

@implementation UIFont (WY_Extension)

+ (UIFont *)wy_adjustFont:(UIFont *)font {
    
    UIFont *newFont = nil;
    if ([[UIScreen mainScreen] currentMode].size.width/[UIScreen mainScreen].bounds.size.width == 3) {
        
        newFont = [UIFont fontWithName:font.fontName size:font.pointSize+2];
        
    }else {
        
        newFont = font;
    }
    
    return newFont;
}

@end
