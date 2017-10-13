//
//  KACollectionViewCell.m
//  PresentationControllerSample
//
//  Created by chengbin on 29/09/2017.
//  Copyright © 2017 bricklife.com. All rights reserved.
//

#import "KACollectionViewCell.h"

@implementation KACollectionViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.label.layer.cornerRadius = 5;
    if (@available(iOS 11.0, *)) {
        self.label.layer.maskedCorners = YES;
    } else {
        // Fallback on earlier versions
    }
    self.label.layer.masksToBounds = YES;
    self.label.backgroundColor = [UIColor redColor];
    self.label.textColor = [UIColor whiteColor];
}
- (void)prepareForReuse {
    [super prepareForReuse];
    self.label.text = @"";
}
@end
