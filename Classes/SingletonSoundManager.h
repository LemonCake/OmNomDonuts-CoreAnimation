//
//  SingletonSoundManager.h
//  Tutorial1
//
//  Created by Michael Daley on 22/05/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
// This sound engine class has been created based on the OpenAL tutorial at
// http://benbritten.com/blog/2008/11/06/openal-sound-on-the-iphone/

#import <Foundation/Foundation.h>
#import <OpenAL/al.h>
#import <OpenAL/alc.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "Common.h"

// Define the maximum number of sources we can use
#define kMaxSources 32

@interface SingletonSoundManager : NSObject {
	
	// OpenAL context for playing sounds
	ALCcontext *context;
	
	// The device we are going to use to play sounds
	ALCdevice *device;
	
	// Array to store the OpenAL buffers we create to store sounds we want to play
	NSMutableArray *soundSources;
	NSMutableDictionary *soundLibrary;
	NSMutableDictionary *musicLibrary;
	
	// AVAudioPlayer responsible for playing background music
	AVAudioPlayer *backgroundMusicPlayer;
	
	// Background music volume which is remembered between tracks
	ALfloat backgroundMusicVolume;
}

+ (SingletonSoundManager *)sharedSoundManager;

- (id)init;
- (NSUInteger) playSoundWithKey:(NSString*)theSoundKey gain:(ALfloat)theGain pitch:(ALfloat)thePitch location:(Vector2f)theLocation shouldLoop:(BOOL)theShouldLoop;
- (void) loadSoundWithKey:(NSString*)theSoundKey fileName:(NSString*)theFileName fileExt:(NSString*)theFileExt frequency:(NSUInteger)theFrequency;
- (void) playMusicWithKey:(NSString*)theMusicKey timesToRepeat:(NSUInteger)theTimesToRepeat;
- (void) loadBackgroundMusicWithKey:(NSString*)theMusicKey fileName:(NSString*)theFileName fileExt:(NSString*)theFileExt;
- (void) setBackgroundMusicVolume:(ALfloat)theVolume;
- (void) shutdownSoundManager;

@end
