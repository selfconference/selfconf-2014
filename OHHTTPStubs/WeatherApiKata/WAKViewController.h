//
//  WAKViewController.h
//  WeatherApiKata
//
//  Created by Matt Chowning on 4/27/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WAKWeatherService.h"

@interface WAKViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *currentTempLabel;
@property (strong, nonatomic) WAKWeatherService *weatherService;
@end
