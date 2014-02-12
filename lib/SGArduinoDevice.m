#import "SGArduinoDevice.h"

#import <stdlib.h>

#import "SGSDK.h"
#import "SwinGame.h"

@implementation SGArduinoDevice : NSObject

+ (void) getArduinoDevices:(arduino_device *)firstPtr fromArray:(NSArray *)in_data maxSize:(int)sz
{
    int i;
    int count = [in_data count];
    count = count <= sz ? count : sz; //get min of sz and count
    for ( i = 0; i < count; i++ ) 
    {
        SGArduinoDevice *obj = [in_data objectAtIndex:i];
        *(firstPtr + i) = obj->pointer;
    }
}

+ (NSArray *) arrayOfArduinoDevices:(arduino_device *)firstPtr size:(int)sz
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:sz];
    int i;
    SGArduinoDevice *obj;
    
    for (i = 0; i < sz; i++)
    {
        obj = [SGArduinoDevice createWithId: *(firstPtr + i)];
        [result addObject: obj];
    }
    
    return [result autorelease];
}

+ (id)createWithId:(arduino_device)ptr
{
    if (ptr == nil) return nil;
    id obj = [PointerManager objectForKey: (id)ptr];
    
    if (obj == nil)
    {
        // Create and assign to obj...
        obj = [[[self alloc] initWithId:ptr] autorelease];
    }
    
    return obj;
}

- (id)initWithId:(arduino_device)ptr
{
    if (ptr == nil)
    {
        [self release];
        return nil;
    }
    //Assign super's initialised value to the self pointer
    self = [super init];
    if (self != nil)
    {
        //If self isn't nil then assign pointer.
        pointer = ptr;
        [PointerManager registerObject:self withKey:(id)ptr];
    }
    return self;
}

- (void)releasePointer
{
    pointer = nil;
}



- (id)initOnPort:(NSString *)port  atBaud:(int)baud
{
    char port_temp[[port length] + 1];
    SGArduinoDevice * result;
    [port getCString:port_temp maxLength:[port length] + 1 encoding:NSASCIIStringEncoding];
    result = [self initWithId: sg_Arduino_CreateArduinoDevice(port_temp, baud)];
    return result;
}

- (id)initWithName:(NSString *)name  OnPort:(NSString *)port  atBaud:(int)baud
{
    char name_temp[[name length] + 1];
    char port_temp[[port length] + 1];
    SGArduinoDevice * result;
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    [port getCString:port_temp maxLength:[port length] + 1 encoding:NSASCIIStringEncoding];
    result = [self initWithId: sg_Arduino_CreateArduinoNamed(name_temp, port_temp, baud)];
    return result;
}



@dynamic hasData;


- (BOOL)hasData
{
    BOOL result;
    result = sg_Arduino_ArduinoHasData(self->pointer) != 0;
    return result;
}

- (unsigned char)readByte
{
    unsigned char result;
    result = sg_Arduino_ArduinoReadByte(self->pointer);
    return result;
}

- (unsigned char)readByteWithTimeout:(int)timeout
{
    unsigned char result;
    result = sg_Arduino_ArduinoReadByteTimeout(self->pointer, timeout);
    return result;
}

- (NSString *)readLine
{
    char result[2048];
    sg_Arduino_ArduinoReadLine(self->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

- (NSString *)readLineWithTimeout:(int)timeout
{
    char result[2048];
    sg_Arduino_ArduinoReadLineTimeout(self->pointer, timeout, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

- (void)sendByte:(unsigned char)value
{
    sg_Arduino_ArduinoSendByte(self->pointer, value);
}

- (void)sendString:(NSString *)value
{
    char value_temp[[value length] + 1];
    [value getCString:value_temp maxLength:[value length] + 1 encoding:NSASCIIStringEncoding];
    sg_Arduino_ArduinoSendString(self->pointer, value_temp);
}

- (void)sendStringLine:(NSString *)value
{
    char value_temp[[value length] + 1];
    [value getCString:value_temp maxLength:[value length] + 1 encoding:NSASCIIStringEncoding];
    sg_Arduino_ArduinoSendStringLine(self->pointer, value_temp);
}

- (void)free
{
    sg_Arduino_FreeArduinoDevice(&self->pointer);
}


@end
