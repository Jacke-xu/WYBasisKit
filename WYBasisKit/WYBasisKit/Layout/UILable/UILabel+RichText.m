//
//  UILabel+RichText.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/21.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "UILabel+RichText.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>
#import <Foundation/Foundation.h>

@interface RichTextModel : NSObject

@property (nonatomic, copy) NSString *str;

@property (nonatomic, assign) NSRange range;

@end

@implementation RichTextModel

@end


@implementation UILabel (RichText)

#pragma mark - AssociatedObjects

- (NSMutableArray *)attributeStrings {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAttributeStrings:(NSMutableArray *)attributeStrings {
    
    objc_setAssociatedObject(self, @selector(attributeStrings), attributeStrings, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)effectDic {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEffectDic:(NSMutableDictionary *)effectDic {
    
    objc_setAssociatedObject(self, @selector(effectDic), effectDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isClickAction {
    
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsClickAction:(BOOL)isClickAction {
    
    objc_setAssociatedObject(self, @selector(isClickAction), @(isClickAction), OBJC_ASSOCIATION_ASSIGN);
}

- (void (^)(NSString *, NSRange, NSInteger))clickBlock {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setClickBlock:(void (^)(NSString *, NSRange, NSInteger))clickBlock {
    
    objc_setAssociatedObject(self, @selector(clickBlock), clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (id<RichTextDelegate>)delegate {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (BOOL)enabledClickEffect {
    
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setEnabledClickEffect:(BOOL)enabledClickEffect {
    
    objc_setAssociatedObject(self, @selector(enabledClickEffect), @(enabledClickEffect), OBJC_ASSOCIATION_ASSIGN);
    self.isClickEffect = enabledClickEffect;
}

- (UIColor *)clickEffectColor {
    
    UIColor *obj = objc_getAssociatedObject(self, _cmd);
    if(obj == nil) {obj = [UIColor lightGrayColor];}
    return obj;
}

- (void)setClickEffectColor:(UIColor *)clickEffectColor {
    
    objc_setAssociatedObject(self, @selector(clickEffectColor), clickEffectColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isClickEffect {
    
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsClickEffect:(BOOL)isClickEffect {
    
    objc_setAssociatedObject(self, @selector(isClickEffect), @(isClickEffect), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setDelegate:(id<RichTextDelegate>)delegate {
    
    objc_setAssociatedObject(self, @selector(delegate), delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - mainFunction
- (void)clickRichTextWithStrings:(NSArray<NSString *> *)strings clickAction:(void (^)(NSString *, NSRange, NSInteger))clickAction {
    
    __weak typeof(self) weakSelf = self;
    [weakSelf richTextRangesWithStrings:strings];
    
    if (weakSelf.clickBlock != clickAction) {
        weakSelf.clickBlock = clickAction;
    }
}

- (void)clickRichTextWithStrings:(NSArray<NSString *> *)strings delegate:(id<RichTextDelegate>)delegate {
    
    __weak typeof(self) weakSelf = self;
    [weakSelf richTextRangesWithStrings:strings];
    
    if (weakSelf.delegate != delegate) {
        weakSelf.delegate = delegate;
    }
}

#pragma mark - touchAction
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    __weak typeof(self) weakSelf = self;
    if (!weakSelf.isClickAction) {
        return;
    }
    
    if (objc_getAssociatedObject(weakSelf, @selector(enabledClickEffect))) {
        weakSelf.isClickEffect = weakSelf.enabledClickEffect;
    }
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:weakSelf];
    
    [weakSelf richTextFrameWithTouchPoint:point result:^(NSString *string, NSRange range, NSInteger index) {
        
        if (weakSelf.clickBlock) {
            weakSelf.clickBlock (string , range , index);
        }
        
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(didClickRichText:range:index:)]) {
            [weakSelf.delegate didClickRichText:string range:range index:index];
        }
        
        if (weakSelf.isClickEffect) {
            
            [weakSelf saveEffectDicWithRange:range];
            
            [weakSelf clickEffectWithStatus:YES];
        }
        
    }];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    __weak typeof(self) weakSelf = self;
    if (weakSelf.isClickAction) {
        if ([weakSelf richTextFrameWithTouchPoint:point result:nil]) {
            return weakSelf;
        }
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark - getClickFrame
- (BOOL)richTextFrameWithTouchPoint:(CGPoint)point result:(void (^) (NSString *string , NSRange range , NSInteger index))resultBlock
{
    __weak typeof(self) weakSelf = self;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)weakSelf.attributedText);
    
    CGMutablePathRef Path = CGPathCreateMutable();
    
    CGPathAddRect(Path, NULL, CGRectMake(0, 0, weakSelf.bounds.size.width, weakSelf.bounds.size.height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    
    CFRange range = CTFrameGetVisibleStringRange(frame);
    
    if (weakSelf.attributedText.length > range.length) {
        
        UIFont *font ;
        
        if ([weakSelf.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:nil]) {
            
            font = [weakSelf.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:nil];
            
        }else if (weakSelf.font){
            font = weakSelf.font;
            
        }else {
            font = [UIFont systemFontOfSize:17];
        }
        
        CGPathRelease(Path);
        
        Path = CGPathCreateMutable();
        
        CGPathAddRect(Path, NULL, CGRectMake(0, 0, weakSelf.bounds.size.width, weakSelf.bounds.size.height + font.lineHeight));
        
        frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    }
    
    CFArrayRef lines = CTFrameGetLines(frame);
    
    if (!lines) {
        CFRelease(frame);
        CFRelease(framesetter);
        CGPathRelease(Path);
        return NO;
    }
    
    CFIndex count = CFArrayGetCount(lines);
    
    CGPoint origins[count];
    
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    
    CGAffineTransform transform = [weakSelf transformForCoreText];
    
    CGFloat verticalOffset = 0;
    
    for (CFIndex i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        
        CGRect flippedRect = [weakSelf getLineBounds:line point:linePoint];
        
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        
        rect = CGRectInset(rect, 0, 0);
        
        rect = CGRectOffset(rect, 0, verticalOffset);
        
        NSParagraphStyle *style = [self.attributedText attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:nil];
        
        CGFloat lineSpace;
        
        if (style) {
            lineSpace = style.lineSpacing;
        }else {
            lineSpace = 0;
        }
        
        CGFloat lineOutSpace = (weakSelf.bounds.size.height - lineSpace * (count - 1) -rect.size.height * count) / 2;
        
        rect.origin.y = lineOutSpace + rect.size.height * i + lineSpace * i;
        
        if (CGRectContainsPoint(rect, point)) {
            
            CGPoint relativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
            
            CFIndex index = CTLineGetStringIndexForPosition(line, relativePoint);
            
            CGFloat offset;
            
            CTLineGetOffsetForStringIndex(line, index, &offset);
            
            if (offset > relativePoint.x) {
                index = index - 1;
            }
            
            NSInteger link_count = weakSelf.attributeStrings.count;
            
            for (int j = 0; j < link_count; j++) {
                
                RichTextModel *model = weakSelf.attributeStrings[j];
                
                NSRange link_range = model.range;
                if (NSLocationInRange(index, link_range)) {
                    if (resultBlock) {
                        resultBlock (model.str , model.range , (NSInteger)j);
                    }
                    CFRelease(frame);
                    CFRelease(framesetter);
                    CGPathRelease(Path);
                    return YES;
                }
            }
        }
    }
    CFRelease(frame);
    CFRelease(framesetter);
    CGPathRelease(Path);
    return NO;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    __weak typeof(self) weakSelf = self;
    if (weakSelf.isClickEffect) {
        
        [weakSelf performSelectorOnMainThread:@selector(clickEffectWithStatus:) withObject:nil waitUntilDone:NO];
        
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    __weak typeof(self) weakSelf = self;
    if (weakSelf.isClickEffect) {
        
        [weakSelf performSelectorOnMainThread:@selector(clickEffectWithStatus:) withObject:nil waitUntilDone:NO];
        
    }
}

- (CGAffineTransform)transformForCoreText
{
    return CGAffineTransformScale(CGAffineTransformMakeTranslation(0, self.bounds.size.height), 1.f, -1.f);
}

- (CGRect)getLineBounds:(CTLineRef)line point:(CGPoint)point
{
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + fabs(descent) + leading;
    
    return CGRectMake(point.x, point.y , width, height);
}

#pragma mark - clickEffect
- (void)clickEffectWithStatus:(BOOL)status
{
    __weak typeof(self) weakSelf = self;
    if (weakSelf.isClickEffect) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:weakSelf.attributedText];
        
        NSMutableAttributedString *subAtt = [[NSMutableAttributedString alloc] initWithAttributedString:[[weakSelf.effectDic allValues] firstObject]];
        
        NSRange range = NSRangeFromString([[weakSelf.effectDic allKeys] firstObject]);
        
        if (status) {
            [subAtt addAttribute:NSBackgroundColorAttributeName value:self.clickEffectColor range:NSMakeRange(0, subAtt.string.length)];
            
            [attStr replaceCharactersInRange:range withAttributedString:subAtt];
        }else {
            
            [attStr replaceCharactersInRange:range withAttributedString:subAtt];
        }
        weakSelf.attributedText = attStr;
    }
}

- (void)saveEffectDicWithRange:(NSRange)range
{
    __weak typeof(self) weakSelf = self;
    weakSelf.effectDic = [NSMutableDictionary dictionary];
    
    NSAttributedString *subAttribute = [self.attributedText attributedSubstringFromRange:range];
    
    [weakSelf.effectDic setObject:subAttribute forKey:NSStringFromRange(range)];
}

#pragma mark - getRange
- (void)richTextRangesWithStrings:(NSArray <NSString *>  *)strings
{
    __weak typeof(self) weakSelf = self;
    if (weakSelf.attributedText == nil) {
        weakSelf.isClickAction = NO;
        return;
    }
    
    weakSelf.isClickAction = YES;
    
    weakSelf.isClickEffect = YES;
    
    __block  NSString *totalStr = weakSelf.attributedText.string;
    
    weakSelf.attributeStrings = [NSMutableArray array];
    
    [strings enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSRange range = [totalStr rangeOfString:obj];
        
        if (range.length != 0) {
            
            totalStr = [totalStr stringByReplacingCharactersInRange:range withString:[weakSelf getStringWithRange:range]];
            
            RichTextModel *model = [[RichTextModel alloc]init];
            
            model.range = range;
            
            model.str = obj;
            
            [weakSelf.attributeStrings addObject:model];
        }
    }];
}

- (NSString *)getStringWithRange:(NSRange)range
{
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < range.length ; i++) {
        
        [string appendString:@" "];
    }
    return string;
}

@end
