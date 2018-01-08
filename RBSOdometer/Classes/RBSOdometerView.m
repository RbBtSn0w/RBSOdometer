//
//  RBSOdometerView.m
//
// Copyright (c) 2018 RbBtSn0w
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "RBSOdometerView.h"

static NSString *const kAnimationKey = @"RBSOdometerAnimationKey";

@implementation RBSOdometerView
{
    NSMutableArray *_numbersText;
    NSMutableArray *_scrollLayers;
    NSMutableArray *_scrollLabels;
    NSCache *_fontSizeCache;
    NSDictionary<NSAttributedStringKey,id> *_attributes;
    NSString *_value;
    CGFloat _mainScreenScale;
    NSUInteger _lastNumber;
    NSInteger _animates;
}

- (void)setFont:(UIFont *)font {
    if (_font != font) {
        _font = font;
        _attributes = @{NSFontAttributeName: self.font};
        [_fontSizeCache removeAllObjects];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self){
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.duration = 1.5;
    self.durationOffset = .2;
    self.density = 9;
    
    self.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    self.textColor = [UIColor blackColor];
    
    _numbersText = [NSMutableArray arrayWithCapacity:10];
    _scrollLayers = [NSMutableArray arrayWithCapacity:10];
    _scrollLabels = [NSMutableArray arrayWithCapacity:10];
    _fontSizeCache = [[NSCache alloc] init];
    _mainScreenScale = [UIScreen mainScreen].scale;
    _lastNumber = 0;
    _animates = 0;
}

- (void)setupNumber:(NSUInteger)number {
    if ([self allAnimateFinish] == NO) {
        return;
    }
    if (number <= self.number) {
        return;
    }
    
    NSLog(@"[Odometer] %tu", number);
    _number = number;
    [self prepareAnimations:YES];
    if ([self isGrowNumberTextLength]) {
        [self invalidateIntrinsicContentSize];
    }
    [self createAnimations];
}

- (BOOL)isGrowNumberTextLength{
    if (@(self.number).stringValue.length > @(_lastNumber).stringValue.length) {
        return YES;
    }
    return NO;
}

- (void)stopAnimation {
    for(CALayer *layer in _scrollLayers){
        [layer removeAnimationForKey:kAnimationKey];
    }
}

- (void)prepareAnimations:(BOOL)animate {
    
    for(CALayer *layer in _scrollLayers){
        [layer removeFromSuperlayer];
    }
    
    [_numbersText removeAllObjects];
    [_scrollLayers removeAllObjects];
    [_scrollLabels removeAllObjects];
    
    NSString *endingNumberString = [self formatterNumberString:self.number];
    NSString *startNumberString = [self formatterNumberString:_lastNumber];
    _value = endingNumberString;
    
    NSInteger fillZeroLength = endingNumberString.length - startNumberString.length;
    for (NSUInteger i = 0; i < fillZeroLength; i++) {
        startNumberString = [NSString stringWithFormat:@"0%@",startNumberString];
    }
    
    NSLog(@"[Odometer] startNumberString:%@, endingNumberString:%@", startNumberString, endingNumberString);
    
    CGRect lastFrame = CGRectZero;
    for(NSUInteger i = 0; i < [endingNumberString length]; ++i){
        NSString *startDigitsString = [startNumberString substringWithRange:NSMakeRange(i, 1)];
        NSString *endingDigitsString = [endingNumberString substringWithRange:NSMakeRange(i, 1)];
        
        CGSize stringSize = [self sizeWithText:endingDigitsString];
        CGFloat width = stringSize.width;
        CGFloat height = stringSize.height;
        CAScrollLayer *layer = [CAScrollLayer layer];
        layer.frame = CGRectMake(CGRectGetMaxX(lastFrame), CGRectGetMinY(lastFrame), width, height);
        lastFrame = layer.frame;
        [_scrollLayers addObject:layer];
        [self.layer addSublayer:layer];
        
        [self createContentForLayer:layer withStartDigitsString:startDigitsString withEndingDigitsString:endingDigitsString];
        
        [_numbersText addObject:endingDigitsString];
    }
}

- (void)createContentForLayer:(CAScrollLayer *)scrollLayer withStartDigitsString:(nullable NSString *)startDigitsString withEndingDigitsString:(NSString *)endingDigitsString {
    NSMutableArray<NSString*> *textForScroll = [NSMutableArray array];
    
    void (^createRandByDensity)(NSString *digitsString) = ^void(NSString *digitsString) {
        BOOL isNumber = [self isNumberOfString:digitsString];
        if (isNumber == NO) {
            return;
        }
        NSInteger number =  isNumber ? [digitsString integerValue] : 10;//0～9
        
        NSInteger maxDensity = isNumber ? self.density + 1 : self.density;
        for(NSUInteger i = 0; i < maxDensity; ++i){
            if (isNumber) {
                [textForScroll addObject:[NSString stringWithFormat:@"%lu", (number + i) % 10]];
            }else {
                [textForScroll addObject:[NSString stringWithFormat:@"%lu", i]];
            }
        }
    };
    
    BOOL needAddDigitsForScroll = YES;
    BOOL endingDigitIsNumber = [self isNumberOfString:endingDigitsString];
    if (startDigitsString) {
        BOOL startDigitIsNumber = [self isNumberOfString:startDigitsString];
        if (startDigitIsNumber && endingDigitIsNumber) {
            if (startDigitsString == endingDigitsString) {
                //not change
                [textForScroll addObject:startDigitsString];
                needAddDigitsForScroll = NO;
            } else if (startDigitsString > endingDigitsString){
                for(NSUInteger i = 0; i < self.density + 1; ++i){
                    int currentValue = (startDigitsString.intValue + i) % 10;
                    [textForScroll addObject:[NSString stringWithFormat:@"%d", currentValue]];
                    if (currentValue == endingDigitsString.intValue) {
                        break;
                    }
                }
                needAddDigitsForScroll = NO;
            } else {
                for(NSUInteger i = 0; i < self.density + 1; ++i){
                    int currentValue = (startDigitsString.intValue + i) % 10;
                    [textForScroll addObject:[NSString stringWithFormat:@"%d", currentValue]];
                    if (currentValue == endingDigitsString.intValue) {
                        break;
                    }
                }
                needAddDigitsForScroll = NO;
            }
        }
    }
    
    if (needAddDigitsForScroll) {
        createRandByDensity(endingDigitsString);
        [textForScroll addObject:endingDigitsString];
    }
    
    CGFloat offSetY = 0;
    for(NSString *text in textForScroll){
        CGRect frame = CGRectMake(0, offSetY, CGRectGetWidth(scrollLayer.frame), CGRectGetHeight(scrollLayer.frame));
        CATextLayer *layer = [self createTextLayer:text];
        layer.contentsScale = _mainScreenScale;
        layer.frame = frame;
        [scrollLayer addSublayer:layer];
        [_scrollLabels addObject:layer];
        offSetY = CGRectGetMaxY(frame);
    }
}


- (CGSize)sizeWithText:(NSString*)text {
    
    if ([self isNumberOfString:text]){
        text = @"8";//max width and height
    }
    
    NSValue *value = [_fontSizeCache objectForKey:text];
    if (value){
        return value.CGSizeValue;
    } else {
        CGSize size = [text sizeWithAttributes:_attributes];
        CGFloat width = ceilf(size.width*10)/10;
        CGFloat height = ceilf(size.height*10)/10;
        size.width = width;
        size.height = height;
        [_fontSizeCache setObject:[NSValue valueWithCGSize:size] forKey:text];
        return size;
    }
}

- (BOOL)isNumberOfString:(NSString*)string {
    int intNumber = 0;
    NSScanner *scanNumber = [NSScanner scannerWithString:string];
    BOOL result = [scanNumber scanInt:&intNumber] && [scanNumber isAtEnd];
    return result;
}

- (CATextLayer *)createTextLayer:(NSString *)text {
    CATextLayer *textlayer = [[CATextLayer alloc] init];
    textlayer.foregroundColor = self.textColor.CGColor;
    
    CGFontRef fontRef = CGFontCreateWithFontName((__bridge CFStringRef)self.font.fontName);
    textlayer.font = fontRef;
    CGFontRelease(fontRef);
    
    textlayer.fontSize = self.font.pointSize;
    textlayer.alignmentMode = kCAAlignmentCenter;
    textlayer.string = text;
    
    return textlayer;
}

- (void)createAnimations {
    
    CFTimeInterval duration = self.duration - ([_numbersText count] * self.durationOffset);
    CFTimeInterval offset = 0;
    
    for(CALayer *scrollLayer in _scrollLayers){
        CGFloat maxY = [[scrollLayer.sublayers lastObject] frame].origin.y;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.translation.y"];
        animation.duration = duration + offset;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        
        animation.fromValue = @0;
        animation.toValue = [NSNumber numberWithFloat:-maxY];
        
        [scrollLayer addAnimation:animation forKey:kAnimationKey];
        
        offset += self.durationOffset;
        
        [self beginAnimate];
        [self performSelector:@selector(finishAnimate) withObject:nil afterDelay:animation.duration];
    }
}

- (void)beginAnimate{
    _animates++;
}
- (void)finishAnimate{
    _animates--;
    if ([self allAnimateFinish]) {
        [self completeUpdate];
    }
}

- (void)completeUpdate{
    _lastNumber = self.number;
}
- (BOOL)allAnimateFinish{
    if (_animates <= 0) {
        return YES;
    }
    return NO;
}

- (CGSize)intrinsicContentSize {
    CGSize superSize = [super intrinsicContentSize];
    
    CGFloat height = 0;
    CGFloat widht = 0;
    for(NSUInteger i = 0; i < [_value length]; ++i){
        NSString *singString = [_value substringWithRange:NSMakeRange(i, 1)];
        CGSize stringSize = [self sizeWithText:singString];
        height = MAX(height, stringSize.height);
        widht = widht + stringSize.width;
    }
    
    superSize.width = widht;
    superSize.height = height;
    return superSize;
}

- (NSString *)formatterNumberString:(NSUInteger)aNumber {
    NSString *paddedNumber;
    if (self.formatter) {
        paddedNumber = [self.formatter stringFromNumber:@(aNumber)];
    } else {
        paddedNumber = @(aNumber).stringValue;
    }
    return paddedNumber;
}
@end

