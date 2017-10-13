//
//  BounceAnimationController.m
//  PresentationControllerSample
//
//  Created by Shinichiro Oba on 2014/10/08.
//  Copyright (c) 2014年 bricklife.com. All rights reserved.
//

#import "BounceAnimationController.h"

@implementation BounceAnimationController

-(id)initWithBool:(BOOL)ispresenting{
    self = [super init];
    if (self) {
        self.isPresenting = ispresenting;
        self.animation = BounceAnimationControllerAnimationScale;
    }
    return self;
}
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return transitionContext.isAnimated?0.5:0.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    if (self.isPresenting) {
        UIView *containerView = [transitionContext containerView];
        UIView *presentedView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        presentedView.frame = containerView.bounds;
        [containerView addSubview:presentedView];
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = [self transitionDuration:transitionContext];
        NSMutableArray *values = [NSMutableArray array];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        animation.values = values;
        animation.delegate = self;
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO; 
        [presentedView.layer addAnimation:animation forKey:nil];
        
    }else {
         UIView *presentedView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
        if (self.animation == BounceAnimationControllerAnimationFade) {
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                presentedView.alpha = .0;
            } completion:^(BOOL finished) {
                if (finished) {
                    [transitionContext completeTransition:![transitionContext transitionWasCancelled] || ![transitionContext isInteractive]];
                }
            }];
        }else if (self.animation == BounceAnimationControllerAnimationScale) {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            animation.duration = [self transitionDuration:transitionContext];
            NSMutableArray *values = [NSMutableArray array];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 1.0)]];
            animation.values = values;
            animation.delegate = self;
            animation.fillMode = kCAFillModeForwards;
            animation.removedOnCompletion = NO;
            [presentedView.layer addAnimation:animation forKey:nil];
        }

    }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled] || ![self.transitionContext isInteractive]];
}
@end
