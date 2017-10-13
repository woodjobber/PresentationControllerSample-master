//
//  RoundRectPresentationController.h
//  PresentationControllerSample
//
//  Created by Shinichiro Oba on 2014/10/08.
//  Copyright (c) 2014年 bricklife.com. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface RoundRectPresentationController : UIPresentationController<UIViewControllerTransitioningDelegate>
@property (strong, nonatomic,nullable) UIColor *backgroundColor;
@end
NS_ASSUME_NONNULL_END
