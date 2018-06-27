//
//  UITextField+Extension.h
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/11.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)

/**
 *  占位文字颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;

/**
 *  文本最大支持多少个字符，设置后会自动根据该属性截取文本字符长度
 */
@property (nonatomic, assign) NSInteger maximumLimit;

@end
