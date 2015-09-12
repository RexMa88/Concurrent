//
//  main.m
//  ConurrentByGCD
//
//  Created by Rex Ma on 15/9/12.
//  Copyright (c) 2015年 Rex Ma. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        dispatch_group_t group = dispatch_group_create();
        
//        dispatch_queue_t queueOne = dispatch_get_global_queue(0, 0);
//        
//        dispatch_queue_t queueTwo = dispatch_get_global_queue(0, 0);
        
        dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
            NSLog(@"The queue One");
        });
        
        dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
            NSLog(@"The queue Two");
        });
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
