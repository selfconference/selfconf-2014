//
//  WAKAppDelegateSpec.m
//  WeatherApiKata
//
//  Created by Matt Chowning on 4/30/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "WAKAppDelegate.h"
#import "WAKViewController.h"

SPEC_BEGIN(WAKAppDelegateSpec)

describe(@"WAKAppDelegate", ^{
    
    it(@"assigns a WAKViewController to be the rootViewController on load", ^{
        WAKAppDelegate *appDelegate = [[WAKAppDelegate alloc] init];
        
            /* Manually run the application:didFinishLaunchingWithOptions: method,
               passing nil arguments because our test should be affected by the arguments */
        [appDelegate application:nil didFinishLaunchingWithOptions:nil];
        
        [[appDelegate.window.rootViewController should] beKindOfClass:[WAKViewController class]];
    });
		
});
	
SPEC_END
