//
//  WAKWeatherServiceOHHTTPStubsSpec.m
//  WeatherApiKata
//
//  Created by Matt Chowning on 5/18/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "WAKWeatherService.h"
#import <OHHTTPStubs.h>

SPEC_BEGIN(WAKWeatherServiceOHHTTPStubsSpec)

    describe(@"WAKWeatherService", ^{
        
        it(@"should retrieve the correct temperature", ^{
            
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                
                    // If you just return yes, then you will stub ALL network requests, so you better be sure this
                    // is the only one you want to stub.
                    // In the alternative, you could just match the base url that the request is being sent to:
                    //      return [request.URL.host isEqualToString:@"api.wunderground.com"];
                
                return [[request.URL absoluteString]
                        isEqualToString:@"http://api.wunderground.com/api/ee4ed185d47c8af2/conditions/q/MI/Detroit.json"];
            
            } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
                NSString *filePath = OHPathForFileInBundle(@"SampleResponse.json", nil);
                return [OHHTTPStubsResponse responseWithFileAtPath:filePath
                                                        statusCode:200
                                                           headers:@{@"Content-Type":@"text/json"}];
            }];
            
                // Set up block to receive and record the WAKWeatherServices's reported current temperature
            __block NSInteger resultingValue;
            void (^blockPassedToMethod)(NSInteger) = ^(NSInteger currentTemperature) {
                resultingValue = currentTemperature;
            };
            
            WAKWeatherService *weatherService = [[WAKWeatherService alloc] init];
            [weatherService getCurrentTemp:blockPassedToMethod];
                
            NSInteger temperatureProvidedByOHHTTPSStub = 50;
            
            
            [[expectFutureValue(theValue(resultingValue)) shouldEventuallyBeforeTimingOutAfter(1.0)]
                equal:theValue(temperatureProvidedByOHHTTPSStub)];
            
                // On my computer this entire test takes around 0.2 seconds, so I am giving it more than that
                // amount of time to make sure there is plenty of extra time.  Giving extra time, does not slow
                // a successful test down, it just slows down your test if it is failing (because then it waits
                // for the full duration of time that you provide).
            
            [OHHTTPStubs removeAllStubs];
        });
    });
	
SPEC_END
