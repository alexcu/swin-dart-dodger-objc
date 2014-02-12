#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "Types.h"
#import "SGTypes.h"
#import "PointerManager.h"


@interface SGGUITextbox : NSObject <PointerWrapper>
{
@package
    guitextbox pointer;
}

+ (NSArray *) arrayOfGUITextboxs:(guitextbox *)firstPtr size:(int)sz;
+ (void) getGUITextboxs:(guitextbox *)firstPtr fromArray:(NSArray *)in_data maxSize:(int)sz;
+ (id)createWithId:(guitextbox)ptr;

- (id)initWithId:(guitextbox)ptr; 





@end
