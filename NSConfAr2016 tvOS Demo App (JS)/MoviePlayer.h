//
//  MoviePlayer.h
//  NSConfAr2016 tvOS Demo App
//
//  Created by Diego Sebastian Mera on 3/27/16.
//  Copyright © 2016 Diego Sebastian Mera. All rights reserved.
//

#import <Foundation/Foundation.h>
@import JavaScriptCore;

// El bridge entre Native y JS requiere que expongamos un protocolo que extienda JSExport
// Para mas informacion es de 'lectura' obligatoria el video de la WWDC del 2013
// https://developer.apple.com/videos/play/wwdc2013/615/
@protocol MoviePlayer <JSExport>

- (nullable instancetype) initWithVideoURL:(nonnull NSString *)videoURL;
+ (nullable instancetype) playerWithVideoURL:(nonnull NSString *)videoURL;
- (void) play;

@end

// La implementacion real puede tener mas cosas, pero JS solo va a ver lo que expongamos
// a traves de JSExport. En este caso, el estado del player no es visible en JS, solo el play
@interface MoviePlayer : NSObject<MoviePlayer>

@property (nonatomic, nonnull, strong, readonly) NSString *videoURL;

- (nullable instancetype) initWithVideoURL:(nonnull NSString *)videoURL;
+ (nullable instancetype) playerWithVideoURL:(nonnull NSString *)videoURL;
- (void) play;

@end
