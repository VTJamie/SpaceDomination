//
//  Game.h
//  AppInnerFear
//

#import <Foundation/Foundation.h>
#import <UIKit/UIDevice.h>
#import "Fleet.h"
#import "Background.h"
#import "GamePieceContainer.h"
#import "Playable.h"

#define EVENT_TYPE_NEW_CENTER_TRIGGERED @"newCenterLocationTriggered"
#define EVENT_TYPE_MOVE_FLEET @"newFleetLocation"
#define EVENT_TYPE_PLANET_TOUCH @"planetTouched"
#define EVENT_TYPE_NEW_ZOOM @"newZoomTriggered"
#define EVENT_TYPE_PLANET_FACTORY_UPDATE @"planetFactoryUpdate"

@interface Game : SPSprite

+ (Game*) instance;
@property (nonatomic, retain) SPJuggler* gameJuggler;
@property (nonatomic, retain) SPJuggler* menuJuggler;

@property (nonatomic, retain) Playable* playarea;


@end


static Game* gameInstance;