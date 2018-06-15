//
//  CALayer+Extension.m
//  WYBasisKit
//
//  Created by jacke-xu on 17/2/12.
//  Copyright © 2017年 com.jacke-xu. All rights reserved.
//

#import "CALayer+Extension.h"

@implementation CALayer (Extension)

+ (CALayer *)lawyerWithFrame:(CGRect)frame color:(UIColor *)color {
    
    CALayer *calawyer = [[CALayer alloc]init];
    calawyer.frame = frame;
    calawyer.backgroundColor = color.CGColor;
    
    return calawyer;
}

@end
