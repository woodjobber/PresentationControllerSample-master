//
//  JMQuestionsAndAnswersGuideView.h
//  JuMei
//
//  Created by chengbin on 11/08/2017.
//  Copyright © 2017 Jumei Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^JMQuestionsAndAnswersGuideViewConfirmCompletion)(void);
typedef void (^JMQuestionsAndAnswersGuideViewCancelCompletion)(void);

@interface JMQuestionsAndAnswersGuideView : UIView

@property (strong, nonatomic) JMQuestionsAndAnswersGuideViewCancelCompletion cancelCompletion;

@property (strong, nonatomic) JMQuestionsAndAnswersGuideViewConfirmCompletion confirmCompletion;

+ (instancetype)instantiateInitialJMPickerViewFromNib;

@end
