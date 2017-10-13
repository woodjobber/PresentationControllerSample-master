//
//  NSArray+Extra.h
//  JuMei
//
//  Created by chengbin on 16/9/28.
//  Copyright © 2016年 Jumei Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extra)
- (BOOL)hasValue;

- (NSMutableArray *)transform;

- (BOOL)containsClass:(Class)aClass;

- (NSArray *)filteredArrayUsingOtherArray:(NSArray *)otherArray;
- (NSArray *)distinct;//按现在顺序 去重:效率最高
- (NSArray *)distinctOrderedOfObjects;//同上：效率较差
- (NSArray *)distinctUnionOfObjects;//无序 去重 :效率较好
@end

@interface NSMutableArray (Extra)

- (void)safeAddObjectsFromArray:(NSArray *)otherArray;
- (void)safeReplaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray;
- (void)filterUsingOtherArray:(NSArray *)otherArray;
@end
