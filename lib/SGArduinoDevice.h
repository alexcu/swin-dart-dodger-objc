#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "Types.h"
#import "SGTypes.h"
#import "PointerManager.h"


@interface SGArduinoDevice : NSObject <PointerWrapper>
{
@package
    arduino_device pointer;
}

+ (NSArray *) arrayOfArduinoDevices:(arduino_device *)firstPtr size:(int)sz;
+ (void) getArduinoDevices:(arduino_device *)firstPtr fromArray:(NSArray *)in_data maxSize:(int)sz;
+ (id)createWithId:(arduino_device)ptr;

- (id)initWithId:(arduino_device)ptr; 

- (id)initOnPort:(NSString *)port  atBaud:(int)baud;
- (id)initWithName:(NSString *)name  OnPort:(NSString *)port  atBaud:(int)baud;


#if OBJC_NEW_PROPERTIES
@property (assign, readonly ) BOOL hasData;
#endif


#if OBJC_NEW_PROPERTIES != 1
- (BOOL)hasData;
#endif
- (unsigned char)readByte;
- (unsigned char)readByteWithTimeout:(int)timeout;
- (NSString *)readLine;
- (NSString *)readLineWithTimeout:(int)timeout;
- (void)sendByte:(unsigned char)value;
- (void)sendString:(NSString *)value;
- (void)sendStringLine:(NSString *)value;
- (void)free;
@end
