//
//  UIButton+Extension.h
//  WYBasisKit
//
//  Created by jacke－xu on 16/9/4.
//  Copyright © 2016年 jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Layout.h"

@interface UIButton (Extension)

//设置按钮标题
@property (nonatomic, copy) NSString *nTitle;//按钮正常状态标题

@property (nonatomic, copy) NSString *hTitle;//按钮正常高亮标题

@property (nonatomic, copy) NSString *sTitle;//按钮选中状态标题


//设置按钮标题颜色
@property (nonatomic, strong) UIColor *title_nColor;//按钮正常状态文字颜色

@property (nonatomic, strong) UIColor *title_hColor;//按钮高亮状态文字颜色

@property (nonatomic, strong) UIColor *title_sColor;//按钮选中状态文字颜色


//设置按钮图片
@property (nonatomic, strong) UIImage *nImage;//按钮正常状态图片

@property (nonatomic, strong) UIImage *hImage;//按钮高亮状态图片

@property (nonatomic, strong) UIImage *sImage;//按钮选中状态图片


//设置按钮字号
@property (nonatomic, strong) UIFont *titleFont;


//设置按钮对齐方式
@property (nonatomic, assign) BOOL leftAlignment;//设置按钮左对齐

@property (nonatomic, assign) BOOL centerAlignment;//设置按钮中心对齐

@property (nonatomic, assign) BOOL rightAlignment;//设置按钮右对齐

@property (nonatomic, assign) BOOL topAlignment;//设置按钮上对齐

@property (nonatomic, assign) BOOL bottomAlignment;//设置按钮下对齐


//设置frame及点击事件
- (instancetype)initWithFrame:(CGRect)frame target:(id)target selector:(SEL)selector;

@end
