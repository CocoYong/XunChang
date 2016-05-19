//
//  ITTCommonMacros.h
//  iTotemFrame
//
//  Created by jack 廉洁 on 3/15/12.
//  Copyright (c) 2012 iTotemStudio. All rights reserved.
//

#ifndef iTotemFrame_ITTCommonMacros_h
#define iTotemFrame_ITTCommonMacros_h
////////////////////////////////////////////////////////////////////////////////
#pragma mark - shortcuts

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#define DATA_ENV [ITTDataEnvironment sharedDataEnvironment]

#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]


////////////////////////////////////////////////////////////////////////////////
#pragma mark - common functions 

#define RELEASE_SAFELY(__POINTER) { if(__POINTER){[__POINTER release]; __POINTER = nil; }}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - iphone 5 detection functions
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT_OF_IPHONE4       480
#define SCREEN_HEIGHT_OF_IPHONE5       568
#define SCREEN_HEIGHT_OF_IPHONE6       667
#define SCREEN_HEIGHT_OF_IPHONE6PLUS   736
#define isiPHONE4       ([UIScreen mainScreen].bounds.size.height == SCREEN_HEIGHT_OF_IPHONE4)
#define isiPHONE5       ([UIScreen mainScreen].bounds.size.height == SCREEN_HEIGHT_OF_IPHONE5)
#define is4InchScreen() ([UIScreen mainScreen].bounds.size.height == SCREEN_HEIGHT_OF_IPHONE5)
#define isiPHONE6       ([UIScreen mainScreen].bounds.size.height == SCREEN_HEIGHT_OF_IPHONE6)
#define isiPHONE6PLUS   ([UIScreen mainScreen].bounds.size.height == SCREEN_HEIGHT_OF_IPHONE6PLUS)
#define iPhone6PlusStatusHeight         27
#define iPhoneOtherStatusHeight         20
#define iPhone6PlusNavagationHeight     66
#define iPhoneOtherNavigationHeight     44

#define IOS6_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS8_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define iPhoneVersionThan6          (isiPHONE6||isiPHONE6PLUS)

#define SCREEN_NAVIGATION_HEIGHT    (isiPHONE6PLUS?44:44)
#define SCREEN_STATUS_HEIGTH        (isiPHONE6PLUS?20:20)


////////////////////////////////////////////////////////////////////////////////
#pragma mark - degrees/radian functions 

#define degreesToRadian(x) (M_PI * (x) / 180.0)

#define radianToDegrees(radian) (radian*180.0)/(M_PI)

////////////////////////////////////////////////////////////////////////////////
#pragma mark - color functions 

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define SHOULDOVERRIDE(basename, subclassname){ NSAssert([basename isEqualToString:subclassname], @"subclass should override the method!");}

#pragma mark - DYMacros
#define DYFAKEDATA              1
#define DYAnimationTime         0.35f
#define DYVerion                [[[NSBundle mainBundle] infoDictionary]valueForKey:@"CFBundleShortVersionString"]
#define DYLINECOLOR             RGBCOLOR(196,196,196)

#define IS_STRING_NOT_EMPTY(sting)    (sting && ![@"" isEqualToString:sting] && (NSNull *)sting!=[NSNull null])
#define IS_STRING_EMPTY(sting)        (!sting || [@"" isEqualToString:sting] || (NSNull *)sting==[NSNull null])
#define SAFE_STRING(x)                (IS_STRING_EMPTY(x))?(@""):(x)
                  
#endif