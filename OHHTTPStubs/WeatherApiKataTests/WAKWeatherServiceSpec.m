//
//  WAKWeatherServiceSpec.m
//  WeatherApiKata
//
//  Created by Matt Chowning on 4/26/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "WAKWeatherService.h"

SPEC_BEGIN(WAKWeatherServiceSpec)

describe(@"WAKWeatherService", ^{
    
    __block WAKWeatherService *weatherService;
    beforeEach(^{
        weatherService = [[WAKWeatherService alloc] init];
    });
    
    it(@"has a getCurrentTemp: method", ^{
        [[weatherService should] respondToSelector:@selector(getCurrentTemp:)];
    });
    
    it(@"has an AFHTTPRequestOperationManager object stored as a property", ^{
        [[weatherService.manager should] beKindOfClass:[AFHTTPRequestOperationManager class]];
    });
    
    context(@"when its getCurrentTemp method is called", ^{
        
        beforeEach(^{
            weatherService.manager = [AFHTTPRequestOperationManager nullMock];
        });
        
        it(@"calls GET:parameters:success:failure: on its manager property", ^{
            [[weatherService.manager should] receive:@selector(GET:parameters:success:failure:)];
            [weatherService getCurrentTemp:nil];
        });
        
        it(@"passes the proper url to the network request", ^{
            KWCaptureSpy *spy = [weatherService.manager captureArgument:@selector(GET:parameters:success:failure:)
                                                                atIndex:0];
            [weatherService getCurrentTemp:nil];
            NSString *urlPassedAsArgument = spy.argument;
            NSString *expectedUrl = @"http://api.wunderground.com/api/ee4ed185d47c8af2/conditions/q/MI/Detroit.json";
            [[urlPassedAsArgument should] equal:expectedUrl];
        });
        
        it(@"accepts a success block that is executed after a successful network response", ^{
            __block BOOL blockHasBeenExecuted = NO;
            void (^blockThatUpdatesTheScreen)(NSInteger) = ^(NSInteger currentTemperature) {
                blockHasBeenExecuted = YES;
            };
            KWCaptureSpy *spy = [weatherService.manager captureArgument:@selector(GET:parameters:success:failure:) atIndex:2];
            [weatherService getCurrentTemp:blockThatUpdatesTheScreen];
            void(^blockThatWouldBeExecutedOnSuccessfulNetworkCall)(AFHTTPRequestOperation *, id) = spy.argument;
            blockThatWouldBeExecutedOnSuccessfulNetworkCall(nil, nil);
            [[theValue(blockHasBeenExecuted) should] beYes];
        });
        
        it(@"passes the correct temperature to the received success block after a successful network call", ^{
            
            __block NSInteger temperaturePassedToBlockThatUpdatesScreen = 0;
            void (^blockThatUpdatesTheScreen)(NSInteger) = ^(NSInteger currentTemperature) {
                temperaturePassedToBlockThatUpdatesScreen = currentTemperature;
            };
            
            KWCaptureSpy *spy = [weatherService.manager captureArgument:@selector(GET:parameters:success:failure:) atIndex:2];
            [weatherService getCurrentTemp:blockThatUpdatesTheScreen];
            void(^blockThatWouldBeExecutedOnSuccessfulNetworkCall)(AFHTTPRequestOperation *, id) = spy.argument;
            
            NSInteger currentTemp = 67;
            id fakeResponse = @{@"current_observation" : @{@"temp_f" : @(currentTemp)}};
            blockThatWouldBeExecutedOnSuccessfulNetworkCall(nil, fakeResponse);
            
            [[theValue(temperaturePassedToBlockThatUpdatesScreen) should] equal:theValue(currentTemp)];
        });
        
    });
});
	
SPEC_END
