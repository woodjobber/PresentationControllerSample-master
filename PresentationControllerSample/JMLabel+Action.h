//
//  JMLabel+Action.h
//  JuMei
//
//  Created by chengbin on 07/09/2017.
//  Copyright © 2017 Jumei Inc. All rights reserved.
//

#import "JMLabel.h"
typedef void (^JMLabelActionHandler)(void);
@interface JMLabel (Action)
@property (assign, nonatomic) BOOL actionEnable;
- (void)addActionHandler:(JMLabelActionHandler)actionHandler;
@end
