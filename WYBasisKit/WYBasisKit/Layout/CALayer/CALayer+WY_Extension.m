//
//  CALayer+WY_Extension.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/11/27.
//  Copyright © 2018 jacke-xu. All rights reserved.
//

#import "CALayer+WY_Extension.h"

@implementation CALayer (WY_Extension)

+ (CALayer *)wy_lawyerWithFrame:(CGRect)frame color:(UIColor *)color {
    
    CALayer *calawyer = [[CALayer alloc]init];
    calawyer.frame = frame;
    calawyer.backgroundColor = color.CGColor;
    
    return calawyer;
}

@end
