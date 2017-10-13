//
//  RoundRectPresentationController.m
//  PresentationControllerSample
//
//  Created by Shinichiro Oba on 2014/10/08.
//  Copyright (c) 2014年 bricklife.com. All rights reserved.
//

#import "RoundRectPresentationController.h"

@interface RoundRectPresentationController ()

@property (nonatomic, readonly) UIView *dimmingView;

@end

@implementation RoundRectPresentationController
- (UIView *)dimmingView {
    static UIView *instance = nil;
    if (instance == nil) {
        instance = [[UIView alloc] initWithFrame:self.containerView.bounds];
        instance.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    }
    return instance;
}

- (void)presentationTransitionWillBegin {
    self.dimmingView.frame = self.containerView.bounds;
    self.dimmingView.backgroundColor =  [UIColor colorWithWhite:0 alpha:0];
    [self.containerView addSubview:self.dimmingView];
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [UIView animateWithDuration:context.transitionDuration animations:^{
            self.dimmingView.backgroundColor = self.backgroundColor?self.backgroundColor:[UIColor colorWithWhite:0 alpha:0.6];
        }];
    } completion:nil];
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        [self.dimmingView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin {
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [UIView animateWithDuration:context.transitionDuration animations:^{
            self.dimmingView.backgroundColor = self.backgroundColor?self.backgroundColor:[UIColor colorWithWhite:0 alpha:0.0];
        }];
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [self.dimmingView removeFromSuperview];
    }
}

- (void)containerViewWillLayoutSubviews {
    self.dimmingView.frame = self.containerView.bounds;
    self.presentedView.frame = self.containerView.bounds;
}
- (UIView *)presentedView {
    UIView *view = self.presentedViewController.view;
    view.backgroundColor = [UIColor clearColor];
    return view;
}
@end
