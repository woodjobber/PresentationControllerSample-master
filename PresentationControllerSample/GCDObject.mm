//
//  GCDObject.m
//  PresentationControllerSample
//
//  Created by chengbin on 16/08/2017.
//  Copyright © 2017 bricklife.com. All rights reserved.
//

#import "GCDObject.h"
static dispatch_queue_t serialQueue;
@implementation GCDObject

+ (void)initialize{
    serialQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);

}
+(dispatch_queue_t)browserSerialQueue{
    return serialQueue?:(serialQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL));
}

+ (void)save{
   
    dispatch_async(serialQueue, ^{
        NSLog(@"save");
        dispatch_async(serialQueue, ^{
            NSLog(@"save1");
            int i = 0;
            while (i < 10) {
                static NSMutableArray *array = @[].mutableCopy;
                GCDObject *obj = [GCDObject new];
                [array addObject:obj];
                [NSKeyedArchiver archiveRootObject:array toFile:[self path]];
                ++i;
            }
        
        });
    });
}
+ (void)remove {
    
    dispatch_async(serialQueue, ^{
        NSLog(@"delete");
        dispatch_async(serialQueue, ^{
            NSLog(@"delete1");
        });
    });
}
+ (void)getCount {

    dispatch_async(serialQueue, ^{
        
        NSLog(@"getCount");
        dispatch_async(serialQueue, ^{
            NSLog(@"getCount1");
            NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:[self path]];
            NSLog(@"%ld",arr.count);
        });
    });
}
+ (void)barrier {
    dispatch_barrier_sync([self browserSerialQueue], ^{
        NSLog(@"====");
    });
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.name forKey:@"name"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone {
    return self;
}
- (id)mutableCopyWithZone:(NSZone *)zone {
    
    //[self.name mutableCopyWithZone:zone];
    return self;
}
+ (NSString *)path {
    NSString *docPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/"];
    NSString *database_path = [docPath stringByAppendingPathComponent:@"GCDObject.sqlite"];
    return database_path;
}
- (void)testDelay{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self autoSetBadgeFrame];
        [self testDelay1];
    });
    
}
- (NSUInteger)hash {
    return self.userId.hash ;
}
- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    if (self == object) {//比较的是内存地址
        return YES;
    }
    return [self.userId isEqualToString:((GCDObject *)object).userId];
}
- (void)testDelay1{
    [self performSelector:@selector(autoSetBadgeFrame)
               withObject:nil
               afterDelay:10.00f
                  inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
}
- (void)autoSetBadgeFrame {
    
    NSLog(@"_++++++%@",self.name);
}
- (void)dealloc {
      NSLog(@"dealloc");
}
- (NSArray *)models {
    return @[@2,@1];
}
@end

