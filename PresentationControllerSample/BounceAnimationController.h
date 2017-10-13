//
//  BounceAnimationController.h
//  PresentationControllerSample
//
//  Created by Shinichiro Oba on 2014/10/08.
//  Copyright (c) 2014年 bricklife.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, BounceAnimationControllerAnimation) {
    BounceAnimationControllerAnimationScale,// 消失动画 - 缩小
    BounceAnimationControllerAnimationFade,// 消失动画 - 变暗, Default
};
@interface BounceAnimationController : NSObject <UIViewControllerAnimatedTransitioning,CAAnimationDelegate>
@property(nonatomic,assign)BOOL isPresenting;
@property (nonatomic , strong) id <UIViewControllerContextTransitioning>transitionContext;
@property (assign, nonatomic) BounceAnimationControllerAnimation animation;
-(id)initWithBool:(BOOL)ispresenting;
@end
