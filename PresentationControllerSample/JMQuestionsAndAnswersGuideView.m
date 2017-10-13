//
//  JMQuestionsAndAnswersGuideView.m
//  JuMei
//
//  Created by chengbin on 11/08/2017.
//  Copyright © 2017 Jumei Inc. All rights reserved.
//

#import "JMQuestionsAndAnswersGuideView.h"


@interface JMQuestionsAndAnswersGuideView ()

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation JMQuestionsAndAnswersGuideView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    [self.cancelButton setImage:[UIImage imageNamed:@"关闭_icon"] forState:UIControlStateNormal];
    [self.confirmButton setBackgroundImage:[UIImage imageNamed:@"我知道了_icon"] forState:UIControlStateNormal];
    [self.confirmButton setTitle:@"我知道了" forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(jm_didTapCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmButton addTarget:self action:@selector(jm_didTapConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (instancetype)init {
    self = [super init];
    JMQuestionsAndAnswersGuideView *view = [[self class] instantiateInitialJMPickerViewFromNib];
    view.frame = self.frame;
    return view;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    JMQuestionsAndAnswersGuideView *view = [[self class] instantiateInitialJMPickerViewFromNib];
    view.frame = self.frame;
    return view;
}
+ (instancetype)instantiateInitialJMPickerViewFromNib {
    return [[NSBundle mainBundle] loadNibNamed:@"JMQuestionsAndAnswersGuideView" owner:nil options:nil].lastObject;
}


- (void)jm_didTapConfirmButton:(id)sender {
    if (self.confirmCompletion) {
        self.confirmCompletion();
    }
}

- (void)jm_didTapCancelButton:(id)sender {
    if (self.cancelCompletion) {
        self.cancelCompletion();
    }
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
