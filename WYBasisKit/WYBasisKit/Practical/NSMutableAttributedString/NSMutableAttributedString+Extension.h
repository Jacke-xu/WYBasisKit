//
//  NSMutableAttributedString+Extension.h
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/15.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Extension)

/** 返回AttributedString属性 */
+ (NSMutableAttributedString *)attributeWithStr:(NSString *)str;

@property (nonatomic, strong) NSMutableParagraphStyle *paragraphStyle;

/**
 
 *  需要修改的字符颜色数组及量程，由字典组成  key = 颜色   value = 量程  例：NSArray *colorsOfRanges = @[@{color:@[@"0",@"1"]},@{color:@[@"1",@"2"]}]
 
 */
- (void)colorsOfRanges:(NSArray <NSDictionary *>*)colorsOfRanges;

/**
 
 *  需要修改的字符字体数组及量程，由字典组成  key = 颜色   value = 量程  例：NSArray *fontsOfRanges = @[@{font:@[@"0",@"1"]},@{font:@[@"1",@"2"]}]
 
 */
- (void)fontsOfRanges:(NSArray <NSDictionary *>*)fontsOfRanges;

/** 设置行间距 */
- (void)setLineSpacing:(NSInteger)lineSpacing;

/** 添加下划线 */
- (void)addUnderline;

/** 添加中划线 */
- (void)addHorizontalLine;

@end
