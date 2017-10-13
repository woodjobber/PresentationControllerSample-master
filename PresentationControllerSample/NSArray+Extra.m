//
//  NSArray+Extra.m
//  JuMei
//
//  Created by chengbin on 16/9/28.
//  Copyright © 2016年 Jumei Inc. All rights reserved.
//

#import "NSArray+Extra.h"

@implementation NSArray (Extra)

- (BOOL)hasValue {
    if ([self isKindOfClass:[NSArray class]] &&self && self.count > 0 ) {
        return YES;
    }
    return NO;
}

- (NSMutableArray *)transform {
    if (self) {
        return self.mutableCopy;
    }
    return nil;
}

- (BOOL)containsClass:(Class)aClass {
    if (![self hasValue]) {
        return NO;
    }
    __block BOOL isContained = NO;
    [self enumerateObjectsWithOptions:NSEnumerationConcurrent
                           usingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
                               isContained = [obj isKindOfClass:aClass];
                               *stop = isContained;
                           }];
    return isContained;
}
- (NSArray *)filteredArrayUsingOtherArray:(NSArray *)otherArray {
    if (![self hasValue]) {
        return self;
    }
    if (![otherArray hasValue]) {
        return self;
    }
   NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT(SELF in %@)",otherArray];
   return [self filteredArrayUsingPredicate:predicate];
}
- (NSArray *)distinct{
    if (![self hasValue]) {
        return @[];
    }
    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:self];
    NSMutableArray *flatArray = [NSMutableArray arrayWithArray:orderedSet.array];
    [flatArray removeObject:[NSNull null]];
    return flatArray.copy;
}
- (NSArray *)distinctOrderedOfObjects {
    if (![self hasValue]) {
        return @[];
    }
    return [self valueForKeyPath:@"@distinctUnionOfNonNullObjects.self"];
}
- (NSArray *)distinctUnionOfObjects {
    if (![self hasValue]) {
        return @[];
    }
    NSArray *objects = [NSSet setWithArray:self].allObjects;
    NSMutableArray *flatArray = [NSMutableArray arrayWithArray:objects];
    [flatArray removeObject:[NSNull null]];
    return flatArray;
}
- (id) _distinctUnionOfNonNullObjectsForKeyPath:(NSString *)keyPath
{
    if ([keyPath length] <= 0) {return @[];}
    if ([keyPath isEqualToString:@"self"]) { return self.distinct;}
    NSMutableOrderedSet *orderedSet = [NSMutableOrderedSet orderedSet];
    for (id obj in self) {
        @try {
            id value = [obj valueForKeyPath:keyPath];
            if (value && value != [NSNull null] && ![orderedSet containsObject:value]) {
                [orderedSet addObject:value];
            }
        }@catch (id) {}
    }
    return orderedSet.array;
}
- (id)_unionOfNonNullArraysForKeyPath:(NSString *)keyPath {
    if ([keyPath length] <= 0) {return @[];}
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    for (id obj in self) {
        @try {
            id value = [obj valueForKeyPath:keyPath];
            if (value && value != [NSNull null]) {
                [array safeAddObjectsFromArray:value];
            }
        }@catch(id){}
    }
    return array;
}
@end


@implementation NSMutableArray (Extra)

- (void)safeAddObjectsFromArray:(NSArray *)otherArray {
    if ([self isKindOfClass:[NSMutableArray class]] && otherArray && [otherArray isKindOfClass:[NSArray class]] && otherArray.count > 0) {
        [self addObjectsFromArray:otherArray];
    }
}
- (void)safeReplaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray {
    if ([self isKindOfClass:[NSMutableArray class]] && self && self.count > 0 ) {
        NSRange maxRange = NSMakeRange(0, self.count);
        if (NSLocationInRange(range.location, maxRange) && !(NSMaxRange(range) > NSMaxRange(maxRange))) {
            [self replaceObjectsInRange:range withObjectsFromArray:otherArray];
        }
    }
}
- (void)filterUsingOtherArray:(NSArray *)otherArray {
    if (![self hasValue]) {
        return;
    }
    if (![otherArray hasValue]) {
        return;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT(SELF in %@)",otherArray];
    [self filterUsingPredicate:predicate];
}
@end
