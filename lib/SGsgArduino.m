#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "SGsgArduino.h"
#import "SGSDK.h"
#import "SwinGame.h"

#import <stdlib.h>

@implementation SGsgArduino : NSObject


+ (SGArduinoDevice *)arduinoDeviceNamed:(NSString *)name
{
    char name_temp[[name length] + 1];
    SGArduinoDevice * result;
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGArduinoDevice createWithId:sg_Arduino_ArduinoDeviceNamed(name_temp)];
    return result;
}

+ (BOOL)arduinoHasData:(SGArduinoDevice *)dev
{
    BOOL result;
    result = sg_Arduino_ArduinoHasData(dev->pointer) != 0;
    return result;
}

+ (unsigned char)arduinoReadByte:(SGArduinoDevice *)dev
{
    unsigned char result;
    result = sg_Arduino_ArduinoReadByte(dev->pointer);
    return result;
}

+ (unsigned char)arduinoReadByte:(SGArduinoDevice *)dev  timeout:(int)timeout
{
    unsigned char result;
    result = sg_Arduino_ArduinoReadByteTimeout(dev->pointer, timeout);
    return result;
}

+ (NSString *)arduinoReadLine:(SGArduinoDevice *)dev
{
    char result[2048];
    sg_Arduino_ArduinoReadLine(dev->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (NSString *)arduinoReadLine:(SGArduinoDevice *)dev  timeout:(int)timeout
{
    char result[2048];
    sg_Arduino_ArduinoReadLineTimeout(dev->pointer, timeout, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (void)arduinoSendByte:(SGArduinoDevice *)dev  value:(unsigned char)value
{
    sg_Arduino_ArduinoSendByte(dev->pointer, value);
}

+ (void)arduinoSendString:(SGArduinoDevice *)dev  value:(NSString *)value
{
    char value_temp[[value length] + 1];
    [value getCString:value_temp maxLength:[value length] + 1 encoding:NSASCIIStringEncoding];
    sg_Arduino_ArduinoSendString(dev->pointer, value_temp);
}

+ (void)arduinoSendStringLine:(SGArduinoDevice *)dev  value:(NSString *)value
{
    char value_temp[[value length] + 1];
    [value getCString:value_temp maxLength:[value length] + 1 encoding:NSASCIIStringEncoding];
    sg_Arduino_ArduinoSendStringLine(dev->pointer, value_temp);
}

+ (SGArduinoDevice *)createArduinoOnPort:(NSString *)port  atBaud:(int)baud
{
    char port_temp[[port length] + 1];
    SGArduinoDevice * result;
    [port getCString:port_temp maxLength:[port length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGArduinoDevice createWithId:sg_Arduino_CreateArduinoDevice(port_temp, baud)];
    return result;
}

+ (SGArduinoDevice *)createArduinoNamed:(NSString *)name  onPort:(NSString *)port  atBaud:(int)baud
{
    char name_temp[[name length] + 1];
    char port_temp[[port length] + 1];
    SGArduinoDevice * result;
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    [port getCString:port_temp maxLength:[port length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGArduinoDevice createWithId:sg_Arduino_CreateArduinoNamed(name_temp, port_temp, baud)];
    return result;
}

+ (void)ArduinoCloseConnection:(SGArduinoDevice *)dev
{
    sg_Arduino_FreeArduinoDevice(&dev->pointer);
}

+ (BOOL)hasArduinoDevice:(NSString *)name
{
    char name_temp[[name length] + 1];
    BOOL result;
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_Arduino_HasArduinoDevice(name_temp) != 0;
    return result;
}

+ (void)releaseAllArduinoDevices
{
    sg_Arduino_ReleaseAllArduinoDevices();
}

+ (void)releaseArduinoDevice:(NSString *)name
{
    char name_temp[[name length] + 1];
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    sg_Arduino_ReleaseArduinoDevice(name_temp);
}









@end
