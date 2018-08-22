//
//  NSMutableAttributedString+Extension.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/15.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "NSMutableAttributedString+Extension.h"
#import "NSMutableParagraphStyle+Extension.h"
#include <objc/runtime.h>

@implementation NSMutableAttributedString (Extension)

+ (NSMutableAttributedString *)attributeWithStr:(NSString *)str {
    
    return [[NSMutableAttributedString alloc] initWithString:str];
}

- (void)setParagraphStyle:(NSMutableParagraphStyle *)paragraphStyle {
    
    if(paragraphStyle == nil) {paragraphStyle = [NSMutableParagraphStyle paragraphStyle];}
    objc_setAssociatedObject(self, &@selector(paragraphStyle), paragraphStyle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableParagraphStyle *)paragraphStyle {
    
    NSMutableParagraphStyle *obj = objc_getAssociatedObject(self, &@selector(paragraphStyle));
    return obj;
}

- (void)colorsOfRanges:(NSArray<NSDictionary *> *)colorsOfRanges {
    
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

- (void)fontsOfRanges:(NSArray<NSDictionary *> *)fontsOfRanges {
    
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

- (void)setLineSpacing:(CGFloat)lineSpacing string:(NSString *)string {
    
    if(self.paragraphStyle == nil) {self.paragraphStyle = [NSMutableParagraphStyle paragraphStyle];}
    [self.paragraphStyle setLineSpacing:lineSpacing];
    [self addAttribute:NSParagraphStyleAttributeName value:self.paragraphStyle range:[self.string rangeOfString:string]];
}

- (void)setWordsSpacing:(CGFloat)wordsSpacing string:(NSString *)string {
    
    [self addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:wordsSpacing] range:[self.string rangeOfString:string]];
}

- (void)addUnderlineWithString:(NSString *)string {
    
    [self addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:[self.string rangeOfString:string]];
}

- (void)addHorizontalLineWithString:(NSString *)string {
    
    [self addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:[self.string rangeOfString:string]];
}

@end
