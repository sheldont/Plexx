//
//  WebImageOperations.m
//  Plexx
//
//  Created by Sheldon Trotman on 7/9/13.
//  Copyright (c) 2013 Sheldon Trotman. All rights reserved.
//

#import "WebImageOperations.h"
#import <QuartzCore/QuartzCore.h>

@implementation WebImageOperations


+ (void)processImageDataWithURLString:(NSString *)urlString andBlock:(void (^)(NSData *imageData))processImage
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    dispatch_queue_t callerQueue = dispatch_get_current_queue();
    dispatch_queue_t downloadQueue = dispatch_queue_create("com.myapp.processsmagequeue", NULL);
    dispatch_async(downloadQueue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        
        dispatch_async(callerQueue, ^{
            processImage(imageData);
        });
    });
 //   dispatch_release(downloadQueue);
}

@end