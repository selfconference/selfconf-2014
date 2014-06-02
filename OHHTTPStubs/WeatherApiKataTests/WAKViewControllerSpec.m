//
//  WAKViewControllerSpec.m
//  WeatherApiKata
//
//  Created by Matt Chowning on 4/29/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "WAKViewController.h"

SPEC_BEGIN(WAKViewControllerSpec)

describe(@"WAKViewController", ^{
    
    it(@"has a WAKWeatherService property that is not nil", ^{
        WAKViewController *viewController = [[WAKViewController alloc] init];
        [viewController.weatherService shouldNotBeNil];
    });
    
    it(@"updates the screen with the temperature returned by the WAKWeatherService", ^{
        WAKViewController *viewController = [[WAKViewController alloc] init];
        viewController.weatherService = [WAKWeatherService nullMock];
        
        // Set up the test representing what we expect to happen by
        // the end of this test (screen UILabel is updated with current temp
        viewController.currentTempLabel = [UILabel nullMock];
        NSInteger simulatedTemp = 73;
        NSString *simulatedTempAsString = [@(simulatedTemp) stringValue];
        [[viewController.currentTempLabel should] receive:@selector(setText:)
                                            withArguments:simulatedTempAsString];
        
        // Create spy to capture the argument passed when the WAKWeatherService is
        // called with the getCurrentTemp: method
        KWCaptureSpy *spy = [viewController.weatherService captureArgument:@selector(getCurrentTemp:)
                                                                   atIndex:0];
        // Simulate the view controller loading onto the screen (which should result
        // in the getCurrentTemp: method being called
        [viewController viewDidLoad];
        
        // Get back the block that our spy captured from the getCurrentTemp: method call
        void (^capturedSuccessBlock)(NSInteger) = spy.argument;
        
        // Simulate a successful network call that returned a temperature of 73 degrees
        capturedSuccessBlock(simulatedTemp);
    });
		
});
	
SPEC_END
