/**
 * @class   DDHealth
 * @author  Alex Cummaudo
 * @date    22 Sep 2013
 * @brief   Defines the object for a health kit, which
 *          exists to boost player health
 */

// Import SwinGame Framework
#import "SwinGame.h"

// Import my interface
#import "DDHealth.h"

// Import interfaces of other classes used
#import "DDCollisionMask.h"
#import "DDCanvas.h"
#import "DDGame.h"
#import "DDBalloon.h"

@implementation DDHealth

/**
 * @brief   Constructor for the health initialises the collision
 *          mask
 * @param   game
 *          Game to initialise the DDBalloon within for access
 *          to that Game's game canvas (allows my parent to
 *          dynamically add my sprite to that canvas at runtime)
 * @return  The class's self pointer
 */
-(id)initInGame:(DDGame*) game
{
    if (self = [super initWithBitmapFile:@"health.png"
                               atStaticY:-100 - [SGUtils rndUpto:200]
                                  inGame:game]) {
        _collisionMask  = [[DDCollisionMask alloc]
                           initAsRectangleAtPointA:_position
                                            pointB:[SGGeometry pointAtX:_position.x+
                                                                        _bitmap.width
                                                                      y:_position.y+
                                                                        _bitmap.height]];
    }
    return self;
}

/**
 * @brief   Causes the health kit to fall down by its speed
 * @note    This method is required by the DDFallable protocol
 */
-(void)fall
{
    _speed = abs(_game.speed); // Always fall down (absolute)
    _position.y += _speed;
    NSArray* pts = [[NSArray alloc] initWithObjects:_position,
                    [SGGeometry pointAtX:_position.x+_bitmap.width
                                       y:_position.y+_bitmap.height],
                    nil];
    [_collisionMask updateWithPoints:pts];
    // Automatically kill myself once off bottom of screen
    if (_position.y > [SGGraphics screenHeight])
    {
        [self kill];
        self = nil;
    };
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
-(BOOL)collideWithSprite:(DDSprite<DDCollidable>*) sprite
{
    // For collision with a balloon
    if ([sprite class] == [DDBalloon class])
    {
        
        // Make mask for both outer triangle
        SGTriangle* outerColMsk = sprite.getCollisionMask.shape;
        DDBalloon* balloon = (DDBalloon*)sprite;
        
        // Now check the collision
        if ([SGGeometry triangle:outerColMsk
             intersectsRectangle:_collisionMask.shape])
        {
            [balloon oneUp];
            
            // Kill myself
            [self kill];
            self = nil;
            
            return YES;
        }
    }
    return YES;
}

@end
