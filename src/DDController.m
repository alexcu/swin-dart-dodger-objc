/**
 * @class   DDController
 * @author  Alex Cummaudo
 * @date    11 Sep 2013
 * @brief   Defines the class of the controller object
 *          which is responsible for the entire app (both
 *          in-game and non-in-game elements)
 */

// Import SwinGame Framework
#import "SwinGame.h"

// Import my interface
#import "DDController.h"

// Import interfaces of other classes used
#import "DDCanvas.h"
#import "DDGame.h"
#import "DDBalloon.h"
#import "DDInterrupt.h"

@implementation DDController

/**
 * @brief   Delcare the _currentGame and _inGame
 *          as static variables; this allows them
 *          to be accessible in the class method
 *          for interrupt to kill the game
 *          Initially, there is no game, so set to nil
 */
static DDGame*  _currentGame    = nil;

/**
 * @brief   Delcare the _currentGame and _inGame
 *          as static variables; this allows them
 *          to be accessible in the class method
 *          for interrupt to kill the game
 *          Initially not in game, so set to NO
 */
static BOOL     _inGame         = NO;

/**
 * @brief   The constructor for DDController which intialises
 *          instance variables to be used.
 * @return  The class's self pointer
 */
-(id)init
{
    if (self = [super init])
    {
        _currentGame    = nil;
        _menuCanvas     = [[DDCanvas alloc] init];
        _inGame         = NO;
        _highScore      = [self readHighScore];
        
        // Play really annoying music endlessly
        [SGAudio playMusic:[[SGMusic alloc] initWithName:@"song" fromFile:@"mainsong2.ogg"]
                    looped:-1];
    }
    return self;
}

/**
 * @brief   Creates a new game (i.e. initalises a new
 *          DDGame object) to play
 */
-(void)newGame
{
    _currentGame = [[DDGame alloc] init];
}

/**
 * @brief   Kills the current game by setting it to nil
 *          and forcing back to menu. Note that this 
 *          method is a class/factory method---it is
 *          invoked by calling the method directly on
 *          the class (i.e. [DDController killGame];)
 */
+(void)killGame
{
    _currentGame    = nil;
    _inGame         = NO;
}

/**
 * @brief   Updates the controller, by either updating in-game
 *          elements or drawing the menu
 */
-(void)update
{
    // Check for key presses
    [self checkKeys];
    
    BOOL backCol;
    
    if (_currentGame)   { backCol = NO;  }
    else                { backCol = YES; }
    
    if (_inGame) { [_currentGame updateGame]; }
    else
    {
        [_menuCanvas drawWithItems:@{@"menu": @YES,
                                     @"left": [NSString stringWithFormat:
                                               @"          High Score: %d", _highScore],
                                  @"backCol": backCol ? @"blue" : @"nil" }];
        
        // Only update a high score when not in the game
        [self updateHighScore];
    }
}

/**
 * @brief   Checks for any key presses for both in-game/non-in-game
 *          functionality
 
 */
-(void)checkKeys
{
    if ([SGInput keyTyped:VK_P])
    {
        // Create a game if there is no game
        if (_currentGame == nil) { [self newGame]; }
        [SGAudio playSoundEffect:[[SGSoundEffect alloc] initFromFile:@"menu.ogg"]];
        _inGame = !_inGame;
    }
    if (_inGame)
    {
        if ([SGInput keyDown:VK_LEFT])  { [_currentGame moveBalloonInDirection:DDLEFT]; }
        if ([SGInput keyDown:VK_RIGHT]) { [_currentGame moveBalloonInDirection:DDRIGHT]; }
    }
    else
    {
        if ([SGInput keyDown:VK_S]) { [self newHighScoreFromCorruption:YES]; }
    }
}

/**
 * @brief   Updates the HS file if need by using the following methods.
 * @note    This method is private
 */
-(void) updateHighScore
{
    // Only update the high score when needed
    if (_currentGame.score > _highScore)
    {
        _highScore = _currentGame.score;
        [self writeHighScoreWithInt:_highScore];
    }
}

/**
 * @brief   Creates a new high score file if not there or corrupted.
 * @note    This method is private
 * @param   corrupt     A directive to the method to create the file based on whether or
 *                      not the file has been corrupted---where true, the high score file
 *                      will *always* be created, regardless of if the ddhs.txt file exists
 */
-(void)newHighScoreFromCorruption:(BOOL) corrupt
{
    
    // Prepare file handling
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString* path = [NSString stringWithFormat:@"%@/ddhs.txt", [SGResources appPath]];
    
    // Check if ddhs.txt does not exist or it is corrupted
    if (!([fileManager fileExistsAtPath:path])||
        corrupt)
    {
        NSData *fileContents = [@"50" dataUsingEncoding:NSUTF8StringEncoding];
        [fileManager createFileAtPath:path
                             contents:fileContents
                           attributes:nil];
        _highScore = 50;
    }
}

/**
 * @brief   Retrieves the high score from the high score file.
 *          Will create a new high score file if not there or corrupted.
 * @note    This method is private
 */
-(int) readHighScore
{
    
    // Prepare file handling
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString* path = [NSString stringWithFormat:@"%@/ddhs.txt", [SGResources appPath]];
    
    // Create new HS file if non-existant
    [self newHighScoreFromCorruption:NO];

    // Read in the existing HS
    NSString *readHS = [NSString stringWithContentsOfFile:path
                                                encoding:NSUTF8StringEncoding
                                                   error:nil];
    
    // Where zero, intValue was not parsed correctly
    if (readHS.intValue == 0)
    {
        // Kill the file
        [fileManager removeItemAtPath:path error:nil];
        // New HS file due to corruption
        [self newHighScoreFromCorruption:YES];
        // Return default 50
        return 50;
    }
    else
    {
        return readHS.intValue;
    }
}

/**
 * @brief   Writes the high score to file.
 *          Will create a new high score file if not there or corrupted.
 * @note    This method is private
 * @param   val
 *          Value to write to the high score file
 */
-(void) writeHighScoreWithInt:(int) val
{
    // Create new HS file if non-existant
    [self newHighScoreFromCorruption:NO];
    
    // Prepare file handling
    NSString* path = [NSString stringWithFormat:@"%@/ddhs.txt", [SGResources appPath]];
    
    // Write the HS (i.e. the _currentGame score)
    NSString* newHS = [NSString stringWithFormat:@"%d", val];
    [newHS writeToFile:path
            atomically:YES
              encoding:NSUTF8StringEncoding
                 error:nil];
}
@end
