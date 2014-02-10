//
//  Game.h
//  AppInnerFear
//

#import <Foundation/Foundation.h>
#import <UIKit/UIDevice.h>
#import "Fleet.h"

#define EVENT_TYPE_NEW_CENTER_TRIGGERED @"newCenterLocationTriggered"
#define EVENT_TYPE_MOVE_FLEET @"newFleetLocation"

@interface Game : SPSprite

+ (Game*) instance;

@property (nonatomic, retain) SPPoint* currentcenter;
@property (nonatomic, retain) Fleet* player;
@property (nonatomic, retain) Fleet* computer;
@property (nonatomic, assign) int numberofplanets;

@property (nonatomic, retain) NSMutableArray* planets;

@property (nonatomic, assign) int minX;
@property (nonatomic, assign) int maxX;
@property (nonatomic, assign) int minY;
@property (nonatomic, assign) int maxY;

@end


static Game* gameInstance;