//
//  JMLabel+Action.m
//  JuMei
//
//  Created by chengbin on 07/09/2017.
//  Copyright © 2017 Jumei Inc. All rights reserved.
//

#import "JMLabel+Action.h"
#import <objc/runtime.h>
static const void *JMLabelActionEnableKey = &JMLabelActionEnableKey;
static const void *JMLabelActionHandlerKey = &JMLabelActionHandlerKey;
static const void *JMLabelActiontapGestureRecognizerKey = &JMLabelActiontapGestureRecognizerKey;
@interface JMLabel()
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@property (copy, nonatomic) JMLabelActionHandler actionHandler;
@end

@implementation JMLabel (Action)
@dynamic actionEnable;
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self _initTapGestureRecognizer];
    }
    return self;
}
- (void)addActionHandler:(JMLabelActionHandler)actionHandler {
    self.actionHandler = actionHandler;
    self.userInteractionEnabled = YES;
    [self removeGestureRecognizer:self.tapGestureRecognizer];
    [self _initTapGestureRecognizer];
    [self addGestureRecognizer:self.tapGestureRecognizer];
}
- (void)_initTapGestureRecognizer {
    if (!self.tapGestureRecognizer) {
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jm_didTapActionHandler:)];
        self.actionEnable = YES;
    }
}
- (BOOL)actionEnable {
    return self.tapGestureRecognizer.enabled;
}
- (void)setActionEnable:(BOOL)actionEnable {
    self.userInteractionEnabled = actionEnable;
    self.tapGestureRecognizer.enabled = actionEnable;
}
- (void)setActionHandler:(JMLabelActionHandler)actionHandler {
    objc_setAssociatedObject(self, JMLabelActionHandlerKey, actionHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (JMLabelActionHandler)actionHandler {
    return objc_getAssociatedObject(self, JMLabelActionHandlerKey);
}
- (void)setTapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer {
    objc_setAssociatedObject(self, JMLabelActiontapGestureRecognizerKey, tapGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UITapGestureRecognizer *)tapGestureRecognizer {
    return objc_getAssociatedObject(self, JMLabelActiontapGestureRecognizerKey);
}
- (void)jm_didTapActionHandler:(UITapGestureRecognizer *)tapGestureRecognizer {
    if (self.actionHandler) {
        self.actionHandler();
    }
}
- (void)dealloc {
    self.tapGestureRecognizer = nil;
    self.actionHandler = nil;
}
@end


