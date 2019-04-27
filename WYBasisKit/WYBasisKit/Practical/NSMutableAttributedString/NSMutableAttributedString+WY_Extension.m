//
//  NSMutableAttributedString+WY_Extension.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/15.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "NSMutableAttributedString+WY_Extension.h"
#import "NSMutableParagraphStyle+WY_Extension.h"
#include <objc/runtime.h>

@implementation NSMutableAttributedString (WY_Extension)

+ (NSMutableAttributedString *)wy_attributeWithStr:(NSString *)str {
    
    return [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",str]];
}

- (void)setWy_paragraphStyle:(NSMutableParagraphStyle *)wy_paragraphStyle {
    
    if(wy_paragraphStyle == nil) {wy_paragraphStyle = [NSMutableParagraphStyle wy_paragraphStyle];}
    objc_setAssociatedObject(self, &@selector(wy_paragraphStyle), wy_paragraphStyle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableParagraphStyle *)wy_paragraphStyle {
    
    NSMutableParagraphStyle *obj = objc_getAssociatedObject(self, &@selector(wy_paragraphStyle));
    return obj;
}

- (void)wy_colorsOfRanges:(NSArray<NSDictionary *> *)colorsOfRanges {
    
    if(colorsOfRanges == nil) return;
    
    for (NSDictionary *dic in colorsOfRanges) {
        
        UIColor *color = (UIColor *)[dic.allKeys firstObject];
        if([[dic.allValues firstObject] isKindOfClass:[NSString class]]) {
            
            NSString *rangeStr = (NSString *)[dic.allValues firstObject];
            [self addAttribute:NSForegroundColorAttributeName value:color range:[self.string rangeOfString:rangeStr]];
            
        }else {
            
            NSArray *rangeAry = (NSArray *)[dic.allValues firstObject];
            [self addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange([[rangeAry firstObject] integerValue], [[rangeAry lastObject] integerValue])];
        }
    }
}

- (void)wy_fontsOfRanges:(NSArray<NSDictionary *> *)fontsOfRanges {
    
    if(fontsOfRanges == nil) return;
    
    for (NSDictionary *dic in fontsOfRanges) {
        
        UIFont *font = (UIFont *)[dic.allKeys firstObject];
        if([[dic.allValues firstObject] isKindOfClass:[NSString class]]) {
            
            NSString *rangeStr = (NSString *)[dic.allValues firstObject];
            [self addAttribute:NSFontAttributeName value:font range:[self.string rangeOfString:rangeStr]];
            
        }else {
            
            NSArray *rangeAry = (NSArray *)[dic.allValues firstObject];
            [self addAttribute:NSFontAttributeName value:font range:NSMakeRange([[rangeAry firstObject] integerValue], [[rangeAry lastObject] integerValue])];
        }
    }
}

- (void)wy_setLineSpacing:(CGFloat)lineSpacing string:(NSString *)string {
    
    if(self.wy_paragraphStyle == nil) {self.wy_paragraphStyle = [NSMutableParagraphStyle wy_paragraphStyle];}
    [self.wy_paragraphStyle setLineSpacing:lineSpacing];
    [self addAttribute:NSParagraphStyleAttributeName value:self.wy_paragraphStyle range:[[NSString stringWithFormat:@"%@",self.string] rangeOfString:[NSString stringWithFormat:@"%@",string]]];
}

- (void)wy_setWordsSpacing:(CGFloat)wordsSpacing string:(NSString *)string {
    
    [self addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:wordsSpacing] range:[self.string rangeOfString:string]];
}

- (void)wy_addUnderlineWithString:(NSString *)string {
    
    [self addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:[self.string rangeOfString:string]];
}

- (void)wy_addHorizontalLineWithString:(NSString *)string {
    
    [self addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:[self.string rangeOfString:string]];
}

@end
