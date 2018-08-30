//
//  UIButton+EdgeInsetsLayout.h
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/7/11.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ButtonPosition) {
    
    /** 图片在左，文字在右，默认 */
    ButtonPositionImageLeft_titleRight = 0,
    /** 图片在右，文字在左 */
    ButtonPositionImageRight_titleLeft = 1,
    /** 图片在上，文字在下 */
    ButtonPositionImageTop_titleBottom = 2,
    /** 图片在下，文字在上 */
    ButtonPositionImageBottom_titleTop = 3,
};

@interface UIButton (EdgeInsetsLayout)

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)layouEdgeInsetsPosition:(ButtonPosition)postion spacing:(CGFloat)spacing;





/**
 *  利用运行时自由设置UIButton的titleLabel和imageView的显示位置
 */

//设置按钮图片控件位置
@property (nonatomic, assign) CGRect imageRect;

//设置按钮文本控件位置
@property (nonatomic, assign) CGRect titleRect;

@end
