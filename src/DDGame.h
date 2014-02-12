/**
 * @class   DDGame
 * @author  Alex Cummaudo
 * @date    11 Sep 2013
 * @brief   Defines the class of the game object which
 *          maintains a game.
 */

#import <Foundation/Foundation.h>

// Forward reference classes (and typedef) referenced in interface
@class DDBalloon, DDCanvas, DDBackground, DDSprite;

#import "DDDirection.h"

@interface DDGame : NSObject
{
    // Define ivars
    int             _score;         //!< Value of kept score for this game (incremented on
                                    //!< every `metre' the balloon goes up (about 1m/~500ms))
    int             _recScore;      //!< Value of the recovery score, used to `bump' up the
                                    //!< player's score if they survived falling to their
                                    //!< death
    int             _maxDarts;      //!< Value of the maximum number of darts that can be on
                                    //!< the screen at once
    int             _speed;         //!< Value of the game speed, which controls:
                                    //!<  - the balloon's speed
                                    //!<  - the background's speed
                                    //!<  - the cloud's speed
                                    //!<  - the speed of falling objects (health and darts)
    DDBackground*   _background;    //!< Defines the current game's background
    DDBalloon*      _balloon;       //!< Defined the balloon object, the playable object which
                                    //!< the game revolves around
    NSMutableArray* _darts;         //!< Defines a collection of darts used to kill the player
    DDCanvas*       _canvas;        //!< Defines the game canvas which draws every drawable
                                    //!< sprite onto as well as the game's HUD
    SGTimer*        _chanceTimer;   //!< Random chance timer
                                    //!< Defines the chance timer for creating new health kits
                                    //!< and clouds
    SGTimer*        _scoreTimer;    //!< Score incrementing timer
                                    //!< Defines the timer for increasing score and
                                    //!< decrementing score when dying
    SGTimer*        _dyingTimer;    //!< Defines the timer to check whether the player has
                                    //!< been dying for too long (and hence kill them once
                                    //!< this clock ticks over)
}

// Define properties
@property   (readonly)  int             speed;      //!< Readonly access to the game's speed
                                                    //!< for DDController
@property   (readonly)  int             score;      //!< Readonly access to the game's score
                                                    //!< for DDController


// Define methods
-(id)   init;
-(void) updateGame;
-(void) removeSprite:(DDSprite*) sprite;
-(void) addSprite:(DDSprite*) sprite;
-(void) moveBalloonInDirection:(DDDirection) dir;

@end
