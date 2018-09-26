//
//  UITextView+Extension.h
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/11.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)

/**
 *  占位文字
 */
@property (nonatomic, copy) NSString *placeholderStr;

/**
 *  占位文字字号
 */
@property (nonatomic, strong) UIFont *placeholderFont;

/**
 *  占位文字颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;

/**
 *  最大显示字符限制(会自动根据该属性截取文本字符长度)
 */
@property (nonatomic, assign) NSInteger maximumLimit;

/**
 *  右下角字符长度提示(需要设置maximumLimit属性)  默认NO
 */
@property (nonatomic, assign) BOOL characterLengthPrompt;

/**
 *  文本发生改变时回调
 */
- (void)textDidChange:(void(^)(NSString *textStr))handle;

/**
 *  处理系统输入法导致的乱码,如果调用了maximumLimit属性，内部会默认处理乱码
 */
- (void)fixMessyDisplay;


@end
