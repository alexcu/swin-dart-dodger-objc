/**
 * @class   DDDart
 * @author  Alex Cummaudo
 * @date    11 Sep 2013
 * @brief   Defines the class for the singular dart object,
 *          which falls from the screen in hope to hit and
 *          hurt the player.
 */

// Import SwinGame Framework
#import "SwinGame.h"

// Import my interface
#import "DDDart.h"

// Import interfaces of other classes used
#import "DDCollisionMask.h"
#import "DDCanvas.h"
#import "DDGame.h"
#import "DDBalloon.h"

@implementation DDDart

/**
 * @brief   Causes the dart to fall down by its speed
 * @param   game
 *          Game to initialise the DDBalloon within for access
 *          to that Game's game canvas (allows my parent to
 *          dynamically add my sprite to that canvas at runtime)
 * @return  The class's self pointer
 */
-(id)initInGame:(DDGame*) game
{
    if (self = [super initWithBitmapFile:@"dart.png"
                               atStaticY:-100 - [SGUtils rndUpto:200]
                                  inGame:game]) {
        _collisionMask  = [[DDCollisionMask alloc]
                           initAsRectangleAtPointA:_position
                                            pointB:[SGGeometry pointAtX:_position.x
                                                                        +_bitmap.width
                                                                      y:_position.y
                                                                        +_bitmap.height]];
    }
    return self;
}

/**
 * @brief   Causes the dart to fall down by its speed
 * @note    This method is required by the DDFallable protocol
 */
-(void)fall
{
    _speed = _game.speed;
    _position.y += _speed;
    NSArray* pts = [[NSArray alloc] initWithObjects:_position,
                                                    [SGGeometry pointAtX:_position.x
                                                                         +_bitmap.width
                                                                       y:_position.y
                                                                         +_bitmap.height],
                                                    nil];
    [_collisionMask updateWithPoints:pts];
    // Automatically kill myself once off bottom of screen
    if (_position.y > [SGGraphics screenHeight])
    {
        [self kill];
        self = nil;
    }
    [pts release];
}

/**
 * @brief   Returns the _collisionMask (required for DDCanvas)
 * @note    This method is required by the DDCollidable protocol.
 * @return  The collision mask for this sprite
 */
-(DDCollisionMask*) getCollisionMask
{
    return _collisionMask;
}

/**
 * @brief   This method checks collision between its own collision mask
 *          and that of the passed sprite
 * @note    This method is required by the DDCollidable protocol.
 * @param   sprite
 *          The sprite to check if both this sprite's and that sprite's
 *          collision masks are overlapping
 * @return  YES on a collision, NO otherwise
 */
-(BOOL) collideWithSprite:(DDSprite<DDCollidable>*) sprite
{
    // This only needs to work with rectangles
    // since all other sprites have rect. col msks
    SGPoint2D* colPoint = [SGGeometry rectangleCenterBottom:
                                            (SGRectangle*)[sprite getCollisionMask].shape];
    
    if ([SGGeometry point:colPoint inRect:_collisionMask.shape])
    {
        [self kill];
        self = nil;

        [sprite kill];
        sprite = nil;
        
        return YES;
    }
    return YES;
}

@end
