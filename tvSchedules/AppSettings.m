//
//  AppSettings.m
//  tvSchedules
//
//  Created by Tik on 30/8/17.
//  Copyright © 2017 tipayanond. All rights reserved.
//

#import "AppSettings.h"

@implementation AppSettings

+(AppSettings *)sharedInstance {
    static dispatch_once_t _onceToken;
    static AppSettings *_instance = nil;
    dispatch_once(&_onceToken, ^{
        _instance = [[AppSettings alloc] init];
    });
    return _instance;
}

-(NSString *)loadConfigWihKey:(NSString *)key {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];
    NSDictionary *defaultsDict = [NSDictionary dictionaryWithContentsOfFile:path];
    return [defaultsDict objectForKey:key];
}

-(NSString *)showURL {
    static int maxNumber = 10;
    static int number = 0;
    if(++number > maxNumber) {
        number = 1;
    }
    NSString *url = [NSString stringWithFormat:@"%@%d", [self loadConfigWihKey:@"url"], number];
    return url;
}

@end
