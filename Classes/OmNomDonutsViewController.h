//
//  OmNomDonutsViewController.h
//  OmNomDonuts
//
//  Created by John Z Wu on 12/31/10.
//  Copyright 2010 TFM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@class SingletonSoundManager;

@interface OmNomDonutsViewController : UIViewController {
	NSMutableArray *donutArray;
	NSMutableArray *hitDonutArray;
	NSMutableArray *missDonutArray;
	NSTimer *donutTimer;
	NSTimer *donutTimerHard;
	SingletonSoundManager *sharedSoundManager;
}

@property (nonatomic, retain) NSTimer *donutTimerHard;
@property (nonatomic, retain) NSMutableArray *hitDonutArray;
@property (nonatomic, retain) NSMutableArray *missDonutArray;
@property (nonatomic, retain) NSTimer *donutTimer;
@property (nonatomic, retain) NSMutableArray *donutArray;

-(void)setUp;
-(void)animateDonutPress:(id)sender;
-(void)addDonut;
-(void)animateDonutScaleUp:(id)sender value:(NSUInteger)x;
-(void)animateDonutScaleDown:(id)sender value:(NSUInteger)x;
-(void)checkProgress;

@end

