#import <Foundation/Foundation.h>
#import "SwinGame.h"
#import "DDSprite.h"
#import "DDCollidable.h"
#import "DDDart.h"
#import "DDCanvas.h"
#import "DDGame.h"
#import "DDController.h"

int main()
{
    @autoreleasepool {
    
        [SGAudio openAudio];
        [SGGraphics openGraphicsWindow:@"Dart Dodger" 
                                 width:400
                                height:600];
        [SGColors loadDefaultColors];
        
        [SGGraphics clearScreen:ColorBlue];
        
        // Create a new Game Controller
        DDController* controller = [[DDController alloc] init];
        
        
        [controller newGame];
        
        while (![SGInput windowCloseRequested])
        {
            [SGInput processEvents];
            [controller update];
        }
        
        [controller release];
        [SGAudio closeAudio];
        [SGResources releaseAllResources];
        
        return 0;
        
    }
}
