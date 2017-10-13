//
//  CALayerLabel.m
//  PresentationControllerSample
//
//  Created by chengbin on 29/09/2017.
//  Copyright © 2017 bricklife.com. All rights reserved.
//

#import "CALayerLabel.h"

@implementation CALayerLabel

+ (Class)layerClass {
    return  [CATextLayer class];
}
- (CATextLayer *)textLayer {
    return (CATextLayer *)self.layer;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //set defaults from UILabel settings
        self.text = self.text;
        self.textColor = self.textColor;
        self.font = self.font;
        
        //we should really derive these from the UILabel settings too
        //but that's complicated, so for now we'll just hard-code them
        [self textLayer].alignmentMode = kCAAlignmentCenter;
        [self textLayer].contentsScale = [UIScreen mainScreen].scale;
        [self textLayer].wrapped = NO;
        [self.layer setNeedsDisplay];
    }
    return self;
}
- (void)setText:(NSString *)text {
    super.text = text;
    self.textLayer.string = text;
}
- (void)setTextColor:(UIColor *)textColor
{
    super.textColor = textColor;
    //set layer text color
    [self textLayer].foregroundColor = textColor.CGColor;
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    super.textAlignment = textAlignment;
    [self textLayer].alignmentMode = kCAAlignmentCenter;
}
- (void)setFont:(UIFont *)font
{
    super.font = font;
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    [self textLayer].font = fontRef;
    [self textLayer].fontSize = font.pointSize;
    CGFontRelease(fontRef);
}
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    super.backgroundColor = backgroundColor;
    [self textLayer].backgroundColor = (__bridge CGColorRef _Nullable)(backgroundColor);
}
@end
