//
//  JMLabel.h
//  JuMei
//
//  Created by chengbin on 12/05/2017.
//  Copyright © 2017 Jumei Inc. All rights reserved.
//
// 调整 UILabel 文字的 内边距 // 调通 sizeToFit
#import <UIKit/UIKit.h>

@interface JMLabel : UILabel

@property (nonatomic, assign) UIEdgeInsets edgeInsets; // 控制文字与控件边界的间隙

@end
