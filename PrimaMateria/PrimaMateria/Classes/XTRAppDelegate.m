//
//  XTRAppDelegate.m
//  PrimaMateria
//
//  Created by Jerry Porter on 11/21/11.
//  Copyright 2014 xTrensa. All rights reserved.
//

#import "PrimaMateria.h"

@implementation XTRAppDelegate

+ (UIColor *) navigationBarColor {
    return [UIColor colorWithRed:36 / RGB_CONSTANT green:36 / RGB_CONSTANT blue:36 / RGB_CONSTANT alpha:1.0];
}

+ (UIColor *) toolBarColor {
    return [UIColor colorWithRed:36 / RGB_CONSTANT green:36 / RGB_CONSTANT blue:36 / RGB_CONSTANT alpha:1.0];
}

+ (UIColor *) alternateRowColor {
    return [UIColor colorWithRed: 245.0 / RGB_CONSTANT green: 245.0 / RGB_CONSTANT blue: 255.0 / RGB_CONSTANT alpha: 1.0];
}

+ (UIColor *) rowColor {
    return [UIColor colorWithRed: 245.0 / RGB_CONSTANT green: 255.0 / RGB_CONSTANT blue: 255.0 / RGB_CONSTANT alpha: 1.0];
}

+ (UIColor *) alternateRowTableCellTextLabelColor {
    return [UIColor blackColor];
}

+ (UIColor *) rowTableCellTextLabelColor {
    return [UIColor whiteColor];
}

+ (UIColor *) labelColor {
    return [UIColor colorWithRed: 44.0 / RGB_CONSTANT green: 119.0 / RGB_CONSTANT blue: 164.0 / RGB_CONSTANT alpha: 1.0];
}

+ (UIColor *) tableBackgroundColor {
    return [UIColor clearColor];
}

+ (UIColor *) viewBackgroundColor {
    return [UIColor whiteColor];
}

+ (UIColor *) tableViewCellDetailLabelColor {
    return [UIColor colorWithRed: 50.0 / RGB_CONSTANT green: 79.0 / RGB_CONSTANT blue: 133.0 / RGB_CONSTANT alpha: 1.0f];
}

+ (UIColor *) tableViewCellBorderColor {
    return [UIColor colorWithRed: 191.0 / RGB_CONSTANT green: 191.0 / RGB_CONSTANT blue: 191.0 / RGB_CONSTANT alpha: 1.0f];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    //[[UINavigationBar appearance] setTintColor:[XTRAppDelegate navigationBarColor]];
    
    //[[UIToolbar appearance] setTintColor:[XTRAppDelegate navigationBarColor]];
    return YES;
}
							
@end
