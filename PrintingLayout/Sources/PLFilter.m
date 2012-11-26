//
//  PrintingLayoutFilter.m
//  PrintingLayout
//
//  Copyright (c) 2012 HUG. All rights reserved.
//

#import "PLFilter.h"
#import <objc/runtime.h>
#import <OsiriXAPI/DCMView.h>

@interface PLFilter ()

- (void)setupSwizzles;

@end

@implementation PLFilter

- (void) initPlugin
{
    [self filterImage:nil];
    
    [self setupSwizzles];
}

- (long) filterImage:(NSString*) menuName
{
    PLWindowController * layoutController = [[PLWindowController alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:1. target:[layoutController window] selector:@selector(makeKeyAndOrderFront:) userInfo:nil repeats:NO];
//    [[layoutController window] makeKeyAndOrderFront:self];
    
    return 0;
}

- (void)setupSwizzles
{
    Method printingLayoutTimeIntervalForDragMethod = class_getInstanceMethod([DCMView class], @selector(printingLayoutTimeIntervalForDrag));
    Method timeIntervalForDragMethod = class_getInstanceMethod([DCMView class], @selector(timeIntervalForDrag));
    
    method_exchangeImplementations(printingLayoutTimeIntervalForDragMethod, timeIntervalForDragMethod);
}

@end