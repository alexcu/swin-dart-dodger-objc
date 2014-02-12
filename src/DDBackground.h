/**
 * @class   DDBackground
 * @author  Alex Cummaudo
 * @date    13 Sep 2013
 * @brief   Defines the class for the background object.
 */

// Import parent class
#import "DDSprite.h"
#import "DDFallable.h"

// Forward reference classes referenced in interface
@class DDGame;

@interface DDBackground : DDSprite <DDFallable>
{
    // Declare ivars
    int _speed;     //!< Declare the speed at which this background moves at
}

// Declare methods
-(id)   initInGame:(DDGame*) game;
-(void) fall;

@end
