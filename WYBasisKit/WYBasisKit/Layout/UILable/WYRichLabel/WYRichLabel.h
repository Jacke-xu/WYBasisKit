//
//  WYRichLabel.h
//  WYBasisKit
//
//  Created by jacke-xu on 2017/3/25.
//  Copyright © 2017年 com.jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, WYRichLabelType) {
    WYRichLabelTypeNone      = 0,
    WYRichLabelTypeAboat     = 1 << 0,//@类型
    WYRichLabelTypeTopic     = 1 << 1,//##类型  话题
    WYRichLabelTypeUrl       = 1 << 2,//url类型
};

@class WYRichLabel,WYRichLabelModel;

@protocol WYRichLabelDelegate <NSObject>

//model图片被点击
- (void)labelImageClickLinkInfo:(WYRichLabelModel *)linkInfo;

//http链接点击   model内设置链接的对应点击
- (void)labelLinkClickLinkInfo:(WYRichLabelModel *)linkInfo linkUrl:(NSString *)linkUrl;

//http链接长按点击   model内设置链接的对应长按
- (void)labelLinkLongPressLinkInfo:(WYRichLabelModel *)linkInfo linkUrl:(NSString *)linkUrl;

//正则文字点击
- (void)labelRegularLinkClickWithClickedString:(NSString *)clickedString;

@end

@interface WYRichLabel : UILabel

@property (nonatomic ,strong) NSArray<WYRichLabelModel *> *messageModels;

@property (nonatomic ,assign) WYRichLabelType regularType;

@property (nonatomic ,strong) UIColor *linkTextColor;

@property (nonatomic ,strong) UIColor *selectedBGColor;

@property (nonatomic , weak ) id delegate;

//model图片被点击
@property (nonatomic, copy) void (^imageClickBlock)(WYRichLabelModel *linkInfo);

//http链接点击   model内设置链接的对应点击
@property (nonatomic, copy) void (^linkClickBlock)(WYRichLabelModel *linkInfo, NSString *linkUrl);

//http链接长按   model内设置链接的对应长按
@property (nonatomic, copy) void (^linkLongPressBlock)(WYRichLabelModel *linkInfo, NSString *linkUrl);

//正则文字点击
@property (nonatomic, copy) void (^regularLinkClickBlock)(NSString *clickedString);

//添加正则表达式规则
- (void)addRegularString:(NSString *)regularString;

@end

@interface WYRichLabelModel : NSObject

@property (nonatomic , copy) NSString *message;//显示的文字

//用于添加图片
@property (nonatomic ,strong) UIImage *image;//富文本图片

@property (nonatomic , copy) NSString *imageName;//富文本图片名称

@property (nonatomic ,assign) CGSize imageShowSize;//富文本图片要显示的大小  默认17*17

@property (nonatomic , copy) NSString *imageClickBackStr;//图片点击反馈字符串

@property (nonatomic ,strong) id extend;//扩展参数提供传递任意类型属性

- (void)replaceUrlWithString:(NSString *)string;//替换网络链接为指定文案

@end
