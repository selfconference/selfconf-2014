//
//  WAKViewController.m
//  WeatherApiKata
//
//  Created by Matt Chowning on 4/27/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import "WAKViewController.h"

@interface WAKViewController ()

@end

@implementation WAKViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.weatherService = [[WAKWeatherService alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create the success block we're going to pass into the getCurrentTemp: method
    void(^mySuccessBlock)(NSInteger) = ^(NSInteger currentTemperature) {
        NSString *stringTemp = [@(currentTemperature) stringValue];
        UILabel *tempLabel = self.currentTempLabel;
        [tempLabel setText:stringTemp];
    };
    
    // Call getCurrentTemp on the weather service and pass the success block
    [self.weatherService getCurrentTemp:mySuccessBlock];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
