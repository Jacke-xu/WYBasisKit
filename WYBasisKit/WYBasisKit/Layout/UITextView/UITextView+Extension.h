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
 *  占位文字颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;


/**
 *  右下角字符限制文本最大支持多少个字符，与占位文本颜色、字号一致  默认是不显示的，设置后显示，并且会自动根据该属性截取文本字符长度
 */
@property (nonatomic, assign) NSInteger maximumLimit;

/**
 *  文本发生改变时回调
 */
- (void)textDidChange:(void(^)(NSString *textStr))handle;

/**
 *  处理系统输入法导致的乱码,如果调用了maximumLimit属性，内部会默认处理乱码
 */
- (void)fixMessyDisplay;


@end
