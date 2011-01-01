//
//  OmNomDonutsAppDelegate.h
//  OmNomDonuts
//
//  Created by John Z Wu on 12/31/10.
//  Copyright 2010 TFM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OmNomDonutsViewController;

@interface OmNomDonutsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    OmNomDonutsViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet OmNomDonutsViewController *viewController;

@end

