//
//  Game.h
//  AppInnerFear
//

#import <Foundation/Foundation.h>
#import <UIKit/UIDevice.h>

#define EVENT_TYPE_NEW_CENTER_TRIGGERED @"newCenterLocationTriggered"

@interface Game : SPSprite

+ (Game*) instance;

@end


static Game* gameInstance;