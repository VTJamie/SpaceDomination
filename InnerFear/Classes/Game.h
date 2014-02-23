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
#import "StartMenu.h"

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
@property (nonatomic, retain) StartMenu* startmenu;


- (void) startGame;
- (void) showStartMenu;


@end


static Game* gameInstance;