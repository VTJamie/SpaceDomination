//
//  Game.h
//  AppInnerFear
//

#import <Foundation/Foundation.h>
#import <UIKit/UIDevice.h>

#define EVENT_TYPE_NEW_CENTER_TRIGGERED @"newCenterLocationTriggered"

@interface Game : SPSprite

+ (Game*) instance;

@property (nonatomic, retain) SPPoint* currentcenter;

@property (nonatomic, assign) int minX;
@property (nonatomic, assign) int maxX;
@property (nonatomic, assign) int minY;
@property (nonatomic, assign) int maxY;

@end


static Game* gameInstance;