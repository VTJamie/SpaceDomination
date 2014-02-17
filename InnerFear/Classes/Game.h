//
//  Game.h
//  AppInnerFear
//

#import <Foundation/Foundation.h>
#import <UIKit/UIDevice.h>
#import "Fleet.h"
#import "Background.h"
#import "GamePieceContainer.h"

#define EVENT_TYPE_NEW_CENTER_TRIGGERED @"newCenterLocationTriggered"
#define EVENT_TYPE_MOVE_FLEET @"newFleetLocation"
#define EVENT_TYPE_PLANET_TOUCH @"planetTouched"
#define EVENT_TYPE_NEW_ZOOM @"newZoomTriggered"
#define EVENT_TYPE_PLANET_FACTORY_UPDATE @"planetFactoryUpdate"

@interface Game : SPSprite

+ (Game*) instance;

@property (nonatomic, retain) SPPoint* currentcenter;
@property (nonatomic, retain) Fleet* player;
@property (nonatomic, retain) Fleet* computer;
@property (nonatomic, retain) Background* backgroundSprite;
@property (nonatomic, retain) GamePieceContainer* gamepieceSprite;


@property (nonatomic, retain) SPJuggler* gameJuggler;
@property (nonatomic, retain) SPJuggler* menuJuggler;

@property (nonatomic, assign) int numberofplanets;

@property (nonatomic, retain) NSMutableArray* planets;

@property (nonatomic, assign) BOOL menuopened;

@property (nonatomic, assign) int minX;
@property (nonatomic, assign) int maxX;
@property (nonatomic, assign) int minY;
@property (nonatomic, assign) int maxY;

@property (nonatomic, assign) double overallscale;
@property (nonatomic, assign) BOOL gameover;

@end


static Game* gameInstance;