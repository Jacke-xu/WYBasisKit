//
//  UITextView+WYExtension.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/10/23.
//  Copyright © 2018 jacke-xu. All rights reserved.
//

#import "UITextView+WYExtension.h"
#include <objc/runtime.h>

@interface UITextView ()

@property (nonatomic, assign) BOOL addNoti;

@property (nonatomic, copy) NSString *lastTextStr;

@property (nonatomic, copy) void(^textHandle) (NSString *textStr);

@property (nonatomic, weak) UILabel *placeholderLable;

@property (nonatomic, weak) UILabel *charactersLengthLable;

@end

@implementation UITextView (WYExtension)

- (void)setAddNoti:(BOOL)addNoti {
    
    objc_setAssociatedObject(self, &@selector(addNoti), [NSNumber numberWithBool:addNoti], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)addNoti {
    
    BOOL obj = [objc_getAssociatedObject(self, &@selector(addNoti)) boolValue];
    return obj;
}

- (void)setWy_placeholderStr:(NSString *)wy_placeholderStr {
    
    objc_setAssociatedObject(self, &@selector(wy_placeholderStr), wy_placeholderStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self addTextChangeNoti];
    self.placeholderLable.backgroundColor = [UIColor clearColor];
}

- (NSString *)wy_placeholderStr {
    
    NSString *obj = objc_getAssociatedObject(self, &@selector(wy_placeholderStr));
    return obj;
}

- (void)setWy_placeholderColor:(UIColor *)wy_placeholderColor {
    
    objc_setAssociatedObject(self, &@selector(wy_placeholderColor), wy_placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addTextChangeNoti];
    self.placeholderLable.backgroundColor = [UIColor clearColor];;
}

- (UIColor *)wy_placeholderColor {
    
    UIColor *obj = objc_getAssociatedObject(self, &@selector(wy_placeholderColor));
    return obj;
}

- (void)setWy_placeholderFont:(UIFont *)wy_placeholderFont {
    
    objc_setAssociatedObject(self, &@selector(wy_placeholderFont), wy_placeholderFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.placeholderLable.backgroundColor = [UIColor clearColor];
}

- (UIFont *)wy_placeholderFont {
    
    UIFont *obj = objc_getAssociatedObject(self, &@selector(wy_placeholderFont));
    return obj;
}

- (void)setWy_maximumLimit:(NSInteger)wy_maximumLimit {
    
    objc_setAssociatedObject(self, &@selector(wy_maximumLimit), [NSNumber numberWithInteger:wy_maximumLimit], OBJC_ASSOCIATION_ASSIGN);
    [self addTextChangeNoti];
}

- (NSInteger)wy_maximumLimit {
    
    id obj = objc_getAssociatedObject(self, &@selector(wy_maximumLimit));
    return [obj integerValue];
}

- (void)setWy_characterLengthPrompt:(BOOL)wy_characterLengthPrompt {
    
    objc_setAssociatedObject(self, &@selector(wy_characterLengthPrompt), [NSNumber numberWithBool:wy_characterLengthPrompt], OBJC_ASSOCIATION_ASSIGN);
    [self addTextChangeNoti];
    
    self.height = (wy_characterLengthPrompt == YES) ? self.height-25 : self.height+25;
    self.charactersLengthLable.text = [NSString stringWithFormat:@"%lu/%ld\t",(unsigned long)self.text.length > (long)self.wy_maximumLimit ? (long)self.wy_maximumLimit : (unsigned long)self.text.length ,(long)self.wy_maximumLimit];
    self.charactersLengthLable.hidden = !wy_characterLengthPrompt;
}

- (BOOL)wy_characterLengthPrompt {
    
    id obj = objc_getAssociatedObject(self, &@selector(wy_characterLengthPrompt));
    return [obj boolValue];
}

- (UILabel *)placeholderLable {
    
    UILabel *obj = objc_getAssociatedObject(self, @selector(placeholderLable));
    if(obj == nil) {
        
        obj = [[UILabel alloc]init];
        obj.left = 5.0f;
        obj.top = 8.0f;
        obj.width = self.width-(obj.left*2);
        obj.numberOfLines = 0;
        obj.userInteractionEnabled = NO;
        [self insertSubview:obj atIndex:0];
        
        objc_setAssociatedObject(self, @selector(placeholderLable), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    obj.font = self.wy_placeholderFont ? self.wy_placeholderFont : self.font;
    obj.textColor = self.wy_placeholderColor ? self.wy_placeholderColor : [UIColor lightGrayColor];
    obj.text = self.wy_placeholderStr;
    [obj sizeToFit];
    
    return obj;
}

- (UILabel *)charactersLengthLable {
    
    UILabel *obj = objc_getAssociatedObject(self, @selector(charactersLengthLable));
    if(obj == nil) {
        
        obj = [[UILabel alloc]initWithFrame:CGRectMake(self.left, self.bottom, self.width, 25)];
        obj.backgroundColor = self.backgroundColor;
        obj.textAlignment = NSTextAlignmentRight;
        obj.userInteractionEnabled = YES;
        
        objc_setAssociatedObject(self, @selector(charactersLengthLable), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    obj.font = self.wy_placeholderFont ? self.wy_placeholderFont : self.font;
    obj.textColor = self.wy_placeholderColor ? self.wy_placeholderColor : [UIColor lightGrayColor];
    
    return obj;
}

- (void)setTextHandle:(void (^)(NSString *))textHandle {
    
    objc_setAssociatedObject(self, &@selector(textHandle), textHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(NSString *))textHandle {
    
    id handle = objc_getAssociatedObject(self, &@selector(textHandle));
    if (handle) {
        
        return (void(^)(NSString *textStr))handle;
    }
    return nil;
}

- (void)setLastTextStr:(NSString *)lastTextStr {
    
    objc_setAssociatedObject(self, @selector(lastTextStr), lastTextStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lastTextStr {
    
    return [NSString emptyStr:objc_getAssociatedObject(self, _cmd)];
}

- (void)wy_textDidChange:(void (^)(NSString * _Nonnull))handle {
    
    self.textHandle = handle;
    [self addTextChangeNoti];
}

- (void)wy_fixMessyDisplay {
    
    if(self.wy_maximumLimit <= 0) {self.wy_maximumLimit = MAXFLOAT;}
    [self addTextChangeNoti];
}

- (void)textDidChange {
    
    [self characterTruncation];
}

- (void)characterTruncation {
    
    //字符截取
    if(self.wy_maximumLimit > 0) {
        
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制,如果有高亮待选择的字，则暂不对文字进行统计和限制
        if ((position == nil) && (self.text.length > self.wy_maximumLimit)) {
            
            const char *res = [self.text substringToIndex:self.wy_maximumLimit].UTF8String;
            if (res == NULL) {
                self.text = [self.text substringToIndex:self.wy_maximumLimit - 1];
            }else{
                self.text = [self.text substringToIndex:self.wy_maximumLimit];
            }
        }
    }
    
    if((self.textHandle) && (![self.text isEqualToString:self.lastTextStr])) {
        
        self.textHandle(self.text);
    }
    self.lastTextStr = self.text;
    
    self.placeholderLable.hidden = (self.text.length > 0) ? YES : NO;
    self.charactersLengthLable.text = [NSString stringWithFormat:@"%lu/%ld\t",(unsigned long)self.text.length > (long)self.wy_maximumLimit ? (long)self.wy_maximumLimit : (unsigned long)self.text.length ,(long)self.wy_maximumLimit];
}

- (void)addTextChangeNoti {
    
    if(self.addNoti == NO) {
        
        // 当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    self.addNoti = YES;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if(self.wy_characterLengthPrompt == YES) {
        
        self.charactersLengthLable.layer.borderWidth = self.layer.borderWidth;
        self.charactersLengthLable.layer.borderColor = self.layer.borderColor;
        if(self.charactersLengthLable.superview == nil) {
            [self.superview addSubview:self.charactersLengthLable];
        }
    }
}

- (void)dealloc {
    
    if(self.addNoti == YES) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    }
    if(self.placeholderLable != nil) {
        
        [self.placeholderLable removeFromSuperview];
        self.placeholderLable = nil;
    }
    if(self.charactersLengthLable != nil) {
        
        [self.charactersLengthLable removeFromSuperview];
        self.charactersLengthLable = nil;
    }
}

@end
