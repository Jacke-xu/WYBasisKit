//
//  WYSegmentedView.h
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/14.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYSegmentedView : UIView

/**
 初始化方法
 
 @param frame 控件frame
 @param superViewController 父控制器
 @return 返回一个实例化好的对象
 */
- (instancetype)initWithFrame:(CGRect)frame superViewController:(UIViewController *)superViewController;


/**
 调用后开始布局,标签下面没有图标
 
 @param controllerAry 控制器数组
 @param titleAry 标题数组
 */
- (void)layoutWithControllerAry:(NSArray <UIViewController *> *)controllerAry TitleAry:(NSArray<NSString *> *)titleAry;


/**
 调用后开始布局,标签下面有图标
 
 @param controllerAry 控制器数组
 @param titleAry 标题数组
 @param normalImageAry 未选中状态图片数组，可以是NSString,也可以是UIImage
 @param selectedImageAry 选中状态图片数组，可以是NSString,也可以是UIImage
 */
- (void)layoutWithControllerAry:(NSArray <UIViewController *> *)controllerAry TitleAry:(NSArray<NSString *> *)titleAry normalImageAry:(NSArray *)normalImageAry selectedImageAry:(NSArray *)selectedImageAry;



/***********************  以下为选传项，如果传入请在调用布局方法前传入  *****************/

@property (nonatomic, assign) CGFloat headerHeight;//item栏的高度 默认45;

@property (nonatomic, strong) UIColor *bg_no_Color;//item栏默认背景色 默认白色

@property (nonatomic, strong) UIColor *bg_sl_Color;//item栏选中背景色 默认白色

@property (nonatomic, strong) UIColor *item_no_Color;//item文字默认颜色 默认9b9b9b

@property (nonatomic, strong) UIColor *item_sl_Color;//item文字默认颜色 默认000000

@property (nonatomic, strong) UIColor *dividingStripColor;//分隔条颜色 默认fad961

@property (nonatomic, strong) UIColor *control_dividingStripColor;//上下控件分隔条颜色 RGB(244, 244, 244);

@property (nonatomic, assign) CGFloat dividingStripHeight;//分隔条高度 默认2像素

@property (nonatomic, assign) CGFloat itemWidth;//item的宽度，controllerAry > 5 ? 5 : width/controllerAry.count

@property (nonatomic, assign) UIFont *item_no_Font;//item默认字号 默认15；

@property (nonatomic, assign) UIFont *item_sl_Font;//item选中字号 默认15；

@property (nonatomic, assign) NSInteger selectedIndex;//初始选中第几项  默认0；

/************************************  选传项  ***********************************/


/**
 点击事件
 
 @param itemIndex 返回一个点击事件的block
 */
- (void)clickItemAtIndex:(void(^)(NSInteger itemIndex))itemIndex;

@end
