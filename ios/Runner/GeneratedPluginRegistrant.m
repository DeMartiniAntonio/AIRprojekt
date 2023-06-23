//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

<<<<<<< HEAD
#if __has_include(<flutter_barcode_scanner/SwiftFlutterBarcodeScannerPlugin.h>)
#import <flutter_barcode_scanner/SwiftFlutterBarcodeScannerPlugin.h>
#else
@import flutter_barcode_scanner;
#endif

#if __has_include(<permission_handler/PermissionHandlerPlugin.h>)
#import <permission_handler/PermissionHandlerPlugin.h>
#else
@import permission_handler;
#endif

=======
>>>>>>> 5338af3d0c2c59bd13452f369e7ab3c9002e3110
#if __has_include(<qr_code_scanner/FlutterQrPlugin.h>)
#import <qr_code_scanner/FlutterQrPlugin.h>
#else
@import qr_code_scanner;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
<<<<<<< HEAD
  [SwiftFlutterBarcodeScannerPlugin registerWithRegistrar:[registry registrarForPlugin:@"SwiftFlutterBarcodeScannerPlugin"]];
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
=======
>>>>>>> 5338af3d0c2c59bd13452f369e7ab3c9002e3110
  [FlutterQrPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterQrPlugin"]];
}

@end
