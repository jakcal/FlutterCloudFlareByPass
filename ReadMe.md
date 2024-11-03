
# Bypassing Cloudflare Protection in Flutter Apps

This guide outlines how to bypass Cloudflare protection in a Flutter app using a WebView challenge screen to verify access and store cookies for future requests. 

## Packages Used
- **flutter_inappwebview**: for WebView handling and cookie management.
- **flutter_secure_storage**: for securely storing cookies on the device.

## User Flow
1. **App Launch**: On launch, the app checks if Cloudflare protection is active.
2. **Challenge Verification**: If Cloudflare is detected, a WebView screen opens for the user to complete the challenge.
3. **Cookie Storage**: After successful verification, the app captures and stores cookies using `flutter_secure_storage` for future automated requests.

For the complete code example implementation, see the `cookie_spoofer` folder.