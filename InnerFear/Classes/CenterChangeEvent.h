//
//  CenterChangeEvent.h
//  InnerFear
//
//  Created by Jamieson Abbott on 2/9/14.
//
//

#import "SPEvent.h"

@interface CenterChangeEvent : SPEvent


@property (nonatomic, retain) SPPoint* change;
@property (nonatomic, retain) SPPoint* newcenter;

@end
