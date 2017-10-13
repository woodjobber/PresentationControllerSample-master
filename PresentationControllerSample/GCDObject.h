//
//  GCDObject.h
//  PresentationControllerSample
//
//  Created by chengbin on 16/08/2017.
//  Copyright © 2017 bricklife.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDObject : NSObject<NSCoding,NSCopying,NSMutableCopying>

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSArray *models;
+ (dispatch_queue_t)browserSerialQueue;
+ (void)barrier;
+ (void)save;
+ (void)remove;
+ (void)getCount;
- (void)testDelay;
@end
