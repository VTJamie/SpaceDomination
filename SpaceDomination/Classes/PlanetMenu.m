//
//  PlanetMenu.m
//  SpaceDomination
//
//  Created by Jamieson Abbott on 2/10/14.
//
//

#import "PlanetMenu.h"
#import "Media.h"

@implementation PlanetMenu

- (id)initWithPlanet: (Planet*) planet
{
    if ((self = [super init]))
    {
        self.planet = planet;
        [self setup];
    }
    
    return self;
}

- (void)dealloc
{
    // release any resources here
        NSLog(@"%@", @"Dealloc");
    
    [self.fleetMakoCount removeEventListener:@selector(shipTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [self.planet removeEventListener:@selector(planetUpdated:) atObject:self forType:EVENT_TYPE_PLANET_FACTORY_UPDATE];
    
    [self removeEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
     [self.sapphireCount removeEventListener:@selector(shipTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [self.babylonCount removeEventListener:@selector(shipTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [self.makoCount removeEventListener:@selector(shipTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [self.fleetSapphireCount removeEventListener:@selector(shipTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [self.fleetMakoCount removeEventListener:@selector(shipTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [self.fleetBabylonCount removeEventListener:@selector(shipTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}

- (void)setup
{
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"spacedockmenu.png"];
    background.pivotX = 0;
    background.pivotY = 0;
    background.x = 0;
    background.y = 0;
    background.scaleX = Sparrow.stage.width / background.width ;
    background.scaleY = Sparrow.stage.height / background.height;
    //NSLog(@"%f, %f", background.width, background.height);
    [self addChild:background];
    
    SPImage* orbitButton = [[SPImage alloc] initWithTexture:[Media atlasTexture:@"menubutton"]];
    orbitButton.x = Sparrow.stage.width / 2.0 - 60;
    orbitButton.y = Sparrow.stage.height - 110;
    orbitButton.scaleX = (100+20) / orbitButton.width ;
    orbitButton.scaleY = 50 / orbitButton.height;
    [self addChild:orbitButton];
    
    SPTextField *orbitField = [SPTextField textFieldWithWidth:100 height:50
                                                        text:@"Enter Orbit" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    orbitField.x = Sparrow.stage.width / 2.0 - 50;
    orbitField.y = Sparrow.stage.height - 110;
    orbitField.hAlign = SPHAlignCenter;  // horizontal alignment
    orbitField.vAlign = SPVAlignCenter; // vertical alignment
    
    [self addChild:orbitField];
    
    __block PlanetMenu* that = self;
    __block SPTextField* closeField = orbitField;
    [orbitField addEventListenerForType:SP_EVENT_TYPE_TOUCH block:^(SPTouchEvent* event) {
        SPTouch *endTouch = [[event touchesWithTarget:closeField andPhase:SPTouchPhaseEnded] anyObject];
        
        if (endTouch) {
            [that removeFromParent];
            [self.planet removeEventListener:@selector(planetUpdated:) atObject:self forType:EVENT_TYPE_PLANET_FACTORY_UPDATE];
        }
    }];
    
    SPImage* sapphireButton = [[SPImage alloc] initWithTexture:[Media atlasTexture:@"menubutton"]];
    sapphireButton.x = Sparrow.stage.width - 200;
    sapphireButton.y = 50;
    sapphireButton.scaleX = (100+50) / sapphireButton.width ;
    sapphireButton.scaleY = 50 / sapphireButton.height;
    [self addChild:sapphireButton];
    
    self.sapphireCount = [[SPTextField alloc] initWithWidth:150 height:50 text:@"0: Sapphire" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    self.sapphireCount.x = Sparrow.stage.width - 200;
    self.sapphireCount.y = 50;
    self.sapphireCount.hAlign = SPHAlignCenter;  // horizontal alignment
    [self addChild:self.sapphireCount];
    [self.sapphireCount addEventListener:@selector(shipTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    SPImage* babylonButton = [[SPImage alloc] initWithTexture:[Media atlasTexture:@"menubutton"]];
    babylonButton.x = Sparrow.stage.width - 200;
    babylonButton.y = 105;
    babylonButton.scaleX = (100+50) / babylonButton.width ;
    babylonButton.scaleY = 50 / babylonButton.height;
    [self addChild:babylonButton];

    
    self.babylonCount = [[SPTextField alloc] initWithWidth:150 height:50 text:@"0: Babylon" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    self.babylonCount.x = Sparrow.stage.width - 200;
    self.babylonCount.y = 105;
    self.babylonCount.hAlign = SPHAlignCenter;  // horizontal alignment
    [self addChild:self.babylonCount];
    [self.babylonCount addEventListener:@selector(shipTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    SPImage* makoButton = [[SPImage alloc] initWithTexture:[Media atlasTexture:@"menubutton"]];
    makoButton.x = Sparrow.stage.width - 200;
    makoButton.y = 160;
    makoButton.scaleX = (100+50) / makoButton.width ;
    makoButton.scaleY = 50 / makoButton.height;
    [self addChild:makoButton];

    
    self.makoCount = [[SPTextField alloc] initWithWidth:150 height:50 text:@"0: Mako" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    self.makoCount.x = Sparrow.stage.width - 200;
    self.makoCount.y = 160;
    self.makoCount.hAlign = SPHAlignCenter;  // horizontal alignment
    [self addChild:self.makoCount];
    [self.makoCount addEventListener:@selector(shipTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    SPImage* fleetSapphireButton = [[SPImage alloc] initWithTexture:[Media atlasTexture:@"menubutton"]];
    fleetSapphireButton.x = 50;
    fleetSapphireButton.y = 50;
    fleetSapphireButton.scaleX = (100+50) / fleetSapphireButton.width ;
    fleetSapphireButton.scaleY = 50 / fleetSapphireButton.height;
    [self addChild:fleetSapphireButton];
    
    self.fleetSapphireCount = [[SPTextField alloc] initWithWidth:150 height:50 text:@"Sapphire: 0" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    self.fleetSapphireCount.x = 50;
    self.fleetSapphireCount.y = 50;
    self.fleetSapphireCount.hAlign = SPHAlignCenter;  // horizontal alignment
    [self addChild:self.fleetSapphireCount];
    [self.fleetSapphireCount addEventListener:@selector(shipTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    SPImage* fleetBabylonButton = [[SPImage alloc] initWithTexture:[Media atlasTexture:@"menubutton"]];
    fleetBabylonButton.x = 50;
    fleetBabylonButton.y = 105;
    fleetBabylonButton.scaleX = (100+50) / fleetBabylonButton.width ;
    fleetBabylonButton.scaleY = 50 / fleetBabylonButton.height;
    [self addChild:fleetBabylonButton];
    
    self.fleetBabylonCount = [[SPTextField alloc] initWithWidth:150 height:50 text:@"Babylon: 0" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    self.fleetBabylonCount.x = 50;
    self.fleetBabylonCount.y = 105;
    self.fleetBabylonCount.hAlign = SPHAlignCenter;  // horizontal alignment
    [self addChild:self.fleetBabylonCount];
    [self.fleetBabylonCount addEventListener:@selector(shipTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    SPImage* fleetMakoButton = [[SPImage alloc] initWithTexture:[Media atlasTexture:@"menubutton"]];
    fleetMakoButton.x = 50;
    fleetMakoButton.y = 160;
    fleetMakoButton.scaleX = (100+50) / fleetMakoButton.width ;
    fleetMakoButton.scaleY = 50 / fleetMakoButton.height;
    [self addChild:fleetMakoButton];
    
    self.fleetMakoCount = [[SPTextField alloc] initWithWidth:150 height:50 text:@"Mako: 0" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    self.fleetMakoCount.x = 50;
    self.fleetMakoCount.y = 160;
    self.fleetMakoCount.hAlign = SPHAlignCenter;  // horizontal alignment
    [self addChild:self.fleetMakoCount];
    [self.fleetMakoCount addEventListener:@selector(shipTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [self.planet addEventListener:@selector(planetUpdated:) atObject:self forType:EVENT_TYPE_PLANET_FACTORY_UPDATE];
    
    [self addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}

- (void)onEnterFrame:(SPEnterFrameEvent *)event
{
    if ([Game instance].playarea == nil || [Game instance].playarea.gameover)
    {
        [self removeFromParent];
    }
}

- (void) planetUpdated: (SPEvent*) event
{
    NSArray* makoships = [self.planet makoShips];
    NSArray* sapphireships = [self.planet sapphireShips];
    NSArray* babylonships = [self.planet babylonShips];
    
    NSArray* fleetMakoships = [[Game instance].playarea.player makoShips];
    NSArray* fleetSapphireships = [[Game instance].playarea.player sapphireShips];
    NSArray* fleetBabylonships = [[Game instance].playarea.player babylonShips];
    
    self.sapphireCount.text = [NSString stringWithFormat:@"%d: Sapphire", sapphireships.count];
    self.makoCount.text = [NSString stringWithFormat:@"%d: Mako", makoships.count];
    self.babylonCount.text = [NSString stringWithFormat:@"%d: Babylon", babylonships.count];
    
    self.fleetSapphireCount.text = [NSString stringWithFormat:@"Sapphire: %d", fleetSapphireships.count];
    self.fleetMakoCount.text = [NSString stringWithFormat:@"Mako: %d", fleetMakoships.count];
    self.fleetBabylonCount.text = [NSString stringWithFormat:@"Babylon: %d", fleetBabylonships.count];
}

- (void) shipTouch: (SPTouchEvent*) event
{
    SPTouch* planetSapphire = [[event touchesWithTarget:self.sapphireCount andPhase:SPTouchPhaseEnded] anyObject];
    SPTouch* planetBabylon = [[event touchesWithTarget:self.babylonCount andPhase:SPTouchPhaseEnded] anyObject];
    SPTouch* planetMako = [[event touchesWithTarget:self.makoCount andPhase:SPTouchPhaseEnded] anyObject];
    SPTouch* fleetSapphire = [[event touchesWithTarget:self.fleetSapphireCount andPhase:SPTouchPhaseEnded] anyObject];
    SPTouch* fleetBabylon = [[event touchesWithTarget:self.fleetBabylonCount andPhase:SPTouchPhaseEnded] anyObject];
    SPTouch* fleetMako = [[event touchesWithTarget:self.fleetMakoCount andPhase:SPTouchPhaseEnded] anyObject];
    Ship* moveship = nil;
    if (planetBabylon)
    {
        moveship = [self.planet popBabylon];
        if (moveship)
        {
            [[Game instance].playarea.player.ships addObject: moveship];
        }
    }
    else if (planetMako)
    {
        moveship = [self.planet popMako];
        if (moveship)
        {
            [[Game instance].playarea.player.ships addObject: moveship];
        }

    }
    else if (planetSapphire)
    {
        moveship = [self.planet popSapphire];
        if (moveship)
        {
            [[Game instance].playarea.player.ships addObject: moveship];
        }

    }
    else if (fleetBabylon)
    {
        moveship = [[Game instance].playarea.player popBabylon];
        if (moveship)
        {
            [self.planet.ships addObject: moveship];
        }
    }
    else if (fleetMako)
    {
        moveship = [[Game instance].playarea.player popMako];
        if (moveship)
        {
            [self.planet.ships addObject: moveship];
        }

    }
    else if (fleetSapphire)
    {
        moveship = [[Game instance].playarea.player popSapphire];
        if (moveship)
        {
            [self.planet.ships addObject: moveship];
        }

    }
    
    [self planetUpdated: nil];
}

@end
