//
//  WAKWeatherService.h
//  WeatherApiKata
//
//  Created by Matt Chowning on 4/26/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface WAKWeatherService : NSObject

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

- (void)getCurrentTemp:(void (^)(NSInteger))successBlock;

@end
