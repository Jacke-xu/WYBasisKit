//
//  UILabel+WY_Extension.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/11/27.
//  Copyright © 2018 jacke-xu. All rights reserved.
//

#import "UILabel+WY_Extension.h"

@implementation UILabel (WY_Extension)

- (CGFloat)wy_lineHeight {return self.font.lineHeight;}

- (void)wy_leftAlignment {self.textAlignment = NSTextAlignmentLeft;}

- (void)wy_centerAlignment {self.textAlignment = NSTextAlignmentCenter;}

- (void)wy_rightAlignment {self.textAlignment = NSTextAlignmentRight;}

+ (UILabel *)wy_createLabWithFrame:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font {
    
    UILabel *lab = [[UILabel alloc]initWithFrame:frame];
    lab.textColor = textColor;
    lab.font = font;
    
    return lab;
}

@end
