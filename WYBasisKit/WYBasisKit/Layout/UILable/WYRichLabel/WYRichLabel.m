//
//  WYRichLabel.m
//  WYBasisKit
//
//  Created by jacke-xu on 2017/3/25.
//  Copyright © 2017年 com.jacke-xu. All rights reserved.
//

#import "WYRichLabel.h"

@interface WYRichLabel ()//该类是NSMutableAttributedString的子类，由于可以灵活地往文字添加或修改属性，所以非常适用于保存并修改文字属性。
@property (nonatomic , strong ) NSTextStorage *textStorage;//保存并管理要展示的文字内容，

@property (nonatomic , strong ) NSLayoutManager *layoutManager;//用于管理NSTextStorage其中的文字内容的排版布局

@property (nonatomic , strong ) NSTextContainer *textContainer;//定义了一个矩形区域用于存放已经进行了排版并设置好属性的文字

@property (nonatomic , strong ) NSMutableArray <NSString *>*linkRangeStrings;

@property (nonatomic , assign ) NSRange selectedRange;

@property (nonatomic , strong ) NSMutableArray <NSString *>*regularPatterns;

@property (nonatomic , assign ) double count;

@property (nonatomic , strong ) NSTimer *timer;

@end


@interface WYRichLabelModel ()

@property (nonatomic ,assign) BOOL isLink;//是否添加点击事件

//用于添加图片
@property (nonatomic ,assign) NSRange imageRange;//图片影响的区域

@property (nonatomic , copy ) NSString *imageLinkUrl;//图片对应需要响应的链接


//用于网址链接
@property (nonatomic ,strong) NSMutableDictionary *inRangeLinkUrls;//inRangeString : linkUrl;

@property (nonatomic ,strong) NSMutableArray *inRangeStrings;//所有内部链接range字符串

@property (nonatomic ,strong) NSMutableDictionary *outRangeLinkUrls;//inRangeString : linkUrl;

@property (nonatomic ,strong) NSMutableArray *outRangeStrings;//所有内部链接range字符串

@end

@implementation WYRichLabel

-(void)setMessageModels:(NSArray<WYRichLabelModel *> *)messageModels {
    
    _messageModels = messageModels;
    
    NSMutableAttributedString *attrStringM = [[NSMutableAttributedString alloc]init];
    for (WYRichLabelModel *messageModel in messageModels) {
        // 添加表情
        NSInteger location = attrStringM.length;
        if (messageModel.image) {
            UIImage *image = messageModel.image;
            NSTextAttachment *textAttachment = [[NSTextAttachment alloc]init];
            textAttachment.image = image;
            textAttachment.bounds = messageModel.imageShowSize.width && messageModel.imageShowSize.height ? CGRectMake(0, -0.15 * messageModel.imageShowSize.height, messageModel.imageShowSize.width, messageModel.imageShowSize.height) : CGRectMake(0, -0.15 * self.font.pointSize, self.font.pointSize, self.font.pointSize);
            NSAttributedString *attributeString = [NSAttributedString attributedStringWithAttachment:textAttachment];
            [attrStringM appendAttributedString:attributeString];
        }
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        attributes[NSFontAttributeName] = self.font;
        
        //添加链接信息
        if (messageModel.isLink) {
            
            attributes[NSForegroundColorAttributeName] = self.linkTextColor;
            if (messageModel.image) {
                messageModel.imageRange = NSMakeRange(location, messageModel.message.length + 1);
            }
            if (messageModel.inRangeStrings.count) {
                
                for (NSString *inRangeString in messageModel.inRangeStrings) {
                    NSRange inRange = NSRangeFromString(inRangeString);
                    NSRange outRange = NSMakeRange(location + inRange.location, inRange.length);
                    [messageModel.outRangeStrings addObject:NSStringFromRange(outRange)];
                    messageModel.outRangeLinkUrls[NSStringFromRange(outRange)] = messageModel.inRangeLinkUrls[inRangeString];
                }
            }
        }
        NSString *message = messageModel.message;
        [attrStringM appendAttributedString: [[NSAttributedString alloc]initWithString:message attributes:attributes]];
    }
    [super setAttributedText:attrStringM];
    [self updateTextStorage];
}

- (void)setRegularType:(WYRichLabelType)regularType {
    
    _regularType = regularType;
    self.regularPatterns = nil;
    NSArray *patterns = @[ @"@[\\u4e00-\\u9fa5a-zA-Z0-9_-]*",
                           @"#.*?#",
                           @"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?"];
    
    
    
    for (NSInteger i = 0; i < 3; i++) {
        if (regularType & 1<<i) {
            [self.regularPatterns addObject:patterns[i]];
        }
    }
    [self updateTextStorage];
}

- (void)addRegularString:(NSString *)regularString {
    
    if (regularString) {
        [self.regularPatterns addObject:regularString];
        [self updateTextStorage];
    }
}

//MARK: - override properties
//对外文本属性有任何变化更新富文本
- (void)setText:(NSString *)text {
    
    [super setText:text];
    _messageModels = nil;
    [self updateTextStorage];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    
    _messageModels = nil;
    [super setAttributedText:attributedText];
    [self updateTextStorage];
}

- (void)setFont:(UIFont *)font {
    
    [super setFont:font];
    [self updateTextStorage];
}

- (void)setTextColor:(UIColor *)textColor {
    
    [super setTextColor:textColor];
    [self updateTextStorage];
}

- (void)updateTextStorage {
    
    
    if (self.attributedText == nil) {
        return;
    }
    
    NSMutableAttributedString *attrStringM = [self addLineBreak:self.attributedText];  //添加行中断模式  就是设置段落模式
    
    [self regularLinkRanges:attrStringM]; //使用正则表达式检查所有链接的范围
    [self addLinkAttribute:attrStringM]; //添加链接属性
    
    [self.textStorage setAttributedString:attrStringM];
    
    [self setNeedsDisplay];
}

- (void)addLinkAttribute:(NSMutableAttributedString *)attrStringM {
    
    if (attrStringM.length == 0 ) {
        return;
    }
    
    NSRange range = NSMakeRange(0, 0);
    if (self.selectedRange.length && self.selectedRange.location) {
        range = self.selectedRange;
    }
    NSDictionary *dict = [attrStringM attributesAtIndex:0 effectiveRange:&range];
    dict = nil;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    attributes[NSFontAttributeName] = self.font;
    attributes[NSForegroundColorAttributeName] = self.textColor;
    [attrStringM addAttributes:attributes range:range];
    
    attributes[NSForegroundColorAttributeName] = self.linkTextColor;
    
    for (NSString *rangeString in self.linkRangeStrings) {
        NSRange range = NSRangeFromString(rangeString);
        [attrStringM addAttributes:attributes range:range];
    }
}


- (void)regularLinkRanges:(NSMutableAttributedString *)attrStringM {
    
    
    NSArray *patterns = [self.regularPatterns copy];
    
    [self.linkRangeStrings removeAllObjects];
    
    NSRange regularRange = NSMakeRange(0, attrStringM.string.length);
    
    for (NSString *pattern in patterns) {
        
        NSRegularExpression *regular = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionDotMatchesLineSeparators error:nil];
        NSArray *results = [regular matchesInString:attrStringM.string options:0 range:regularRange];
        
        for (NSTextCheckingResult *r in results) {
            
            [self.linkRangeStrings addObject:NSStringFromRange(r.range)];
        }
    }
    for (WYRichLabelModel *model in self.messageModels) {
        
        if (model.imageRange.length) {
            [self.linkRangeStrings addObject:NSStringFromRange(model.imageRange)];
        }
        
        for (NSString *outRangeString in model.outRangeStrings) {
            NSRange outRange = NSRangeFromString(outRangeString);
            [self.linkRangeStrings addObject:NSStringFromRange(outRange)];
        }
    }
}


- (NSMutableAttributedString *)addLineBreak:(NSAttributedString *)attributedText {
    
    NSMutableAttributedString *attrStringM = [[NSMutableAttributedString alloc]initWithAttributedString:attributedText];
    
    if (attrStringM.length == 0) {
        return attrStringM;
    }
    
    NSRange range = NSMakeRange(0, 0);
    NSDictionary *dict = [attrStringM attributesAtIndex:0 effectiveRange:&range];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    NSMutableParagraphStyle *oldParagraphStyle = attributes[NSParagraphStyleAttributeName];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    if (oldParagraphStyle) {
        [paragraphStyle setParagraphStyle:oldParagraphStyle];
    }
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    attributes[NSParagraphStyleAttributeName] = paragraphStyle;
    [attrStringM setAttributes:attributes range:range];
    return attrStringM;
    
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
}

- (void)drawTextInRect:(CGRect)rect {
    
    NSRange range = [self glyphsRange];
    CGPoint offset = [self glyphsOffset:range];
    [self.layoutManager drawBackgroundForGlyphRange:range atPoint:offset];
    [self.layoutManager drawGlyphsForGlyphRange:range atPoint:offset];
}

- (CGPoint )glyphsOffset:(NSRange )glyphsRange {
    
    CGRect rect = [self.layoutManager boundingRectForGlyphRange:glyphsRange inTextContainer:self.textContainer];
    CGFloat height = (self.bounds.size.height - rect.size.height) * 0.5;
    return CGPointMake(0, height);
}
//获取显示范围 glyphs
- (NSRange)glyphsRange {
    return NSMakeRange(0, self.textStorage.length);
}

// MARK: - touch events
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self timerBegin];
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self];
    self.selectedRange = [self linkRangeAtLocation:location];
    [self modifySelectedAttribute:YES];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self timerEnd];
    [self timerBegin];
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self];
    NSRange range = [self linkRangeAtLocation:location];
    
    if (range.length != 0 || range.location != 0) {
        if (!(range.location == self.selectedRange.location && range.length == self.selectedRange.length)) {
            [self modifySelectedAttribute:NO];
            self.selectedRange = range;
            [self modifySelectedAttribute:YES];
        }
    }else {
        [self modifySelectedAttribute:NO];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self timerEnd];
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
    });
    if (![NSStringFromRange(self.selectedRange) isEqualToString:NSStringFromRange(NSMakeRange(0, 0))]) {
        
        //通过model传入链接  包括图片和 网络链接
        for (WYRichLabelModel *messageModel in self.messageModels) {
            //点击到图片
            if (self.selectedRange.location == messageModel.imageRange.location && self.selectedRange.length == messageModel.imageRange.length) {
                
                if ([self.delegate respondsToSelector:@selector(labelImageClickLinkInfo:)]) {
                    [self.delegate labelImageClickLinkInfo:messageModel];
                }
                if (self.imageClickBlock) {
                    self.imageClickBlock(messageModel);
                }
                //点击区域背景色变化
                [self modifySelectedAttribute:NO];
                return;
            }
            
            //点击到内部链接
            for (NSString *outRangeString in messageModel.outRangeStrings) {
                NSRange outRange = NSRangeFromString(outRangeString);
                if (self.selectedRange.location == outRange.location && self.selectedRange.length == outRange.length) {
                    
                    if ([self.delegate respondsToSelector:@selector(labelLinkClickLinkInfo:linkUrl:)]) {
                        [self.delegate labelLinkClickLinkInfo:messageModel linkUrl:messageModel.outRangeLinkUrls[outRangeString]];
                    }
                    if (self.linkClickBlock) {
                        self.linkClickBlock(messageModel,messageModel.outRangeLinkUrls[outRangeString]);
                    }
                    [self modifySelectedAttribute:NO];
                    return;
                }
            }
        }
        
        //通过正则 ##  @添加的
        NSString *string = [self.textStorage.string substringWithRange:self.selectedRange];
        
        //代理响应点击事件
        if ([self.delegate respondsToSelector:@selector(labelRegularLinkClickWithClickedString:)]) {
            [self.delegate labelRegularLinkClickWithClickedString:string];
        }
        if (self.regularLinkClickBlock) {
            self.regularLinkClickBlock(string);
        }
    }
    [self modifySelectedAttribute:NO];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self timerEnd];
    [self modifySelectedAttribute:NO];
}

//长按事件
-(void) timerBegin{
    //NSLog(@"长按开始");
    _count = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target: self selector: @selector(handleTimer) userInfo: nil repeats: YES];
    [_timer fire];
}

-(void) timerEnd{
    
    //NSLog(@"长按结束");
    if(_timer) {
        
        //关闭定时器
        [_timer invalidate];
        _timer = nil;
    }
    //NSLog(@"count = %f",_count);
}

-(void) handleTimer{
    _count = _count + 0.1;
    if (_count >= 0.8) {
        //通过model传入链接  包括图片和 网络链接
        for (WYRichLabelModel *messageModel in self.messageModels) {
            //点击到内部链接
            for (NSString *outRangeString in messageModel.outRangeStrings) {
                NSRange outRange = NSRangeFromString(outRangeString);
                if (self.selectedRange.location == outRange.location && self.selectedRange.length == outRange.length) {
                    
                    //代理方式响应事件
                    if ([self.delegate respondsToSelector:@selector(labelLinkLongPressLinkInfo:linkUrl:)]) {
                        [self.delegate labelLinkLongPressLinkInfo:messageModel linkUrl:messageModel.outRangeLinkUrls[outRangeString]];
                    }
                    //block方式响应事件
                    if (self.linkLongPressBlock) {
                        self.linkLongPressBlock(messageModel,messageModel.outRangeLinkUrls[outRangeString]);
                    }
                    
                    [self modifySelectedAttribute:NO];
                    self.selectedRange = NSMakeRange(0, 0);
                }
            }
        }
        [self timerEnd];
    }
}

- (NSRange)linkRangeAtLocation:(CGPoint)location {
    if (self.textStorage.length == 0) {
        return NSMakeRange(0, 0);
    }
    NSRange glyphsRange = [self glyphsRange];
    CGPoint offset = [self glyphsOffset:glyphsRange];
    CGPoint point = CGPointMake(offset.x + location.x, offset.y + location.y);
    NSUInteger index = [self.layoutManager glyphIndexForPoint:point inTextContainer:self.textContainer];
    for (NSString *rangeString in self.linkRangeStrings) {
        NSRange range = NSRangeFromString(rangeString);
        if (index >= range.location && index < range.location + range.length) {
            return range;
        }
    }
    return NSMakeRange(0, 0);
}

- (void)modifySelectedAttribute:(BOOL)isSet {
    if (self.selectedRange.location == 0 && self.selectedRange.length == 0) {
        return;
    }
    NSRange range0 = NSMakeRange(self.selectedRange.location, self.selectedRange.length);
    
    NSDictionary *dict = [self.textStorage attributesAtIndex:0 effectiveRange:&range0];
    dict = nil;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    attributes[NSForegroundColorAttributeName] = self.linkTextColor;
    NSRange range = self.selectedRange;
    if (self.selectedRange.length > 0) {
        
        if (isSet) {
            attributes[NSBackgroundColorAttributeName] = self.selectedBGColor;
        } else {
            attributes[NSBackgroundColorAttributeName] = [UIColor clearColor];
            self.selectedRange = NSMakeRange(0, 0);
        }
    }
    [self.textStorage addAttributes:attributes range:range];
    [self setNeedsDisplay];
}

// MARK: - init functions  //创建方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareLabel]; //添加各种文本管理属性单元
        self.linkTextColor = [UIColor blueColor];
        self.selectedBGColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)prepareLabel {
    [self.textStorage addLayoutManager:self.layoutManager];
    [self.layoutManager addTextContainer:self.textContainer];
    
    self.textContainer.lineFragmentPadding = 0;  //是在设置行间距吧
    
    [self setUserInteractionEnabled:YES];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self prepareLabel]; //添加各种文本管理属性单元
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textContainer.size = self.bounds.size;
}

-(NSTextStorage *)textStorage {
    if (!_textStorage) {
        _textStorage = [[NSTextStorage alloc]init];
    }
    return _textStorage;
}

- (NSLayoutManager *)layoutManager {
    if (!_layoutManager) {
        _layoutManager = [[NSLayoutManager alloc]init];
    }
    return _layoutManager;
}

- (NSTextContainer *)textContainer {
    if (!_textContainer) {
        _textContainer = [[NSTextContainer alloc]init];
    }
    return _textContainer;
}

- (NSMutableArray<NSString *> *)linkRangeStrings {
    if (!_linkRangeStrings) {
        _linkRangeStrings = [NSMutableArray array];
    }
    return _linkRangeStrings;
}

- (NSMutableArray<NSString *> *)regularPatterns {
    if (!_regularPatterns) {
        _regularPatterns = [NSMutableArray array];
    }
    return _regularPatterns;
}

@end

@implementation WYRichLabelModel

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    _image = [UIImage imageNamed:imageName];
}

- (void)replaceUrlWithString:(NSString *)replaceString {
    
    if (!replaceString.length) {
        return;
    }
    NSArray *patterns = @[@"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?"];
    
    NSRange regularRange = NSMakeRange(0, _message.length);
    
    NSMutableString *resultString = [NSMutableString string];
    NSInteger nextLocation = 0;
    for (NSString *pattern in patterns) {
        
        NSRegularExpression *regular = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionDotMatchesLineSeparators error:nil];
        NSArray *results = [regular matchesInString:_message options:0 range:regularRange];
        
        for (NSTextCheckingResult *r in results) {
            
            [resultString appendString:[_message substringWithRange:NSMakeRange(nextLocation, r.range.location - nextLocation)]];
            NSString *inRangeString = NSStringFromRange(NSMakeRange(resultString.length, replaceString.length));
            [resultString appendString:replaceString];
            
            nextLocation = r.range.location + r.range.length;
            [self.inRangeStrings addObject:inRangeString];
            self.inRangeLinkUrls[inRangeString] = [_message substringWithRange:r.range];
        }
        
    }
    [resultString appendString:[_message substringFromIndex:nextLocation]];
    _message = resultString;
}

- (BOOL)isLink {
    return self.image || self.inRangeStrings.count;
}

- (NSMutableArray *)inRangeStrings {
    if (!_inRangeStrings) {
        _inRangeStrings = [NSMutableArray array];
    }
    return _inRangeStrings;
}

- (NSMutableDictionary *)inRangeLinkUrls {
    if (!_inRangeLinkUrls) {
        _inRangeLinkUrls = [NSMutableDictionary dictionary];
    }
    return _inRangeLinkUrls;
}

- (NSMutableArray *)outRangeStrings {
    if (!_outRangeStrings) {
        _outRangeStrings = [NSMutableArray array];
    }
    return _outRangeStrings;
}

- (NSMutableDictionary *)outRangeLinkUrls {
    if (!_outRangeLinkUrls) {
        _outRangeLinkUrls = [NSMutableDictionary dictionary];
    }
    return _outRangeLinkUrls;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
