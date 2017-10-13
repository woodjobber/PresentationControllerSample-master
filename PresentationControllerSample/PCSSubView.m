


//
//  PCSSubView.m
//  PresentationControllerSample
//
//  Created by chengbin on 18/09/2017.
//  Copyright © 2017 bricklife.com. All rights reserved.
//

#import "PCSSubView.h"

@implementation PCSSubView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews{
    [super layoutSubviews];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, CGRectGetWidth(self.frame) + 22, CGRectGetHeight(self.frame)+200);
}
@end
