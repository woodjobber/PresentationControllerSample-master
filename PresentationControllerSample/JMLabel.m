//
//  JMLabel.m
//  JuMei
//
//  Created by chengbin on 12/05/2017.
//  Copyright © 2017 Jumei Inc. All rights reserved.
//

#import "JMLabel.h"

@implementation JMLabel

-(instancetype)init {
    if (self = [super init]) {
        self.edgeInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.edgeInsets = UIEdgeInsetsZero;
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
       self.edgeInsets = UIEdgeInsetsZero;
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.edgeInsets = UIEdgeInsetsZero;
}
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    _edgeInsets = edgeInsets;
    [self sizeToFit];
}
- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}
- (CGRect)textRectForBounds:(CGRect)bounds
     limitedToNumberOfLines:(NSInteger)numberOfLines {
    UIEdgeInsets insets = self.edgeInsets;
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets)
                    limitedToNumberOfLines:numberOfLines];
    
    rect.origin.x    -= insets.left;
    rect.origin.y    -= insets.top;
    rect.size.width  += (insets.left + insets.right);
    rect.size.height += (insets.top + insets.bottom);
    return rect;
}
@end
