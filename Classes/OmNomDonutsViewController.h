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
	UILabel *scoreLabel;
	UILabel *accLabel;
	NSMutableArray *donutArray;
	NSMutableArray *hitDonutArray;
	NSMutableArray *missDonutArray;
	NSRunLoop *donutLoop;
	NSTimer *donutTimer;
	SingletonSoundManager *sharedSoundManager;
	NSMutableDictionary *gameStats;
}

@property (nonatomic, retain) IBOutlet UILabel *scoreLabel;
@property (nonatomic, retain) IBOutlet UILabel *accLabel;
@property (nonatomic, retain) NSMutableDictionary *gameStats;
@property (nonatomic, retain) NSRunLoop *donutLoop;
@property (nonatomic, retain) NSMutableArray *hitDonutArray;
@property (nonatomic, retain) NSMutableArray *missDonutArray;
@property (nonatomic, retain) NSTimer *donutTimer;
@property (nonatomic, retain) NSMutableArray *donutArray;

-(void)setUp;
-(void)animateDonutPress:(id)sender;
-(void)addDonut;
-(void)animateDonutScaleUp:(id)sender value:(NSUInteger)x;
-(void)animateDonutScaleDown:(id)sender value:(NSUInteger)x;
-(void)updateProgress:(id)sender;

@end

