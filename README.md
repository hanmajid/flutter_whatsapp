# flutter_whatsapp

[![Join the chat at https://gitter.im/flutter_whatsapp/community](https://badges.gitter.im/flutter_whatsapp/community.svg)](https://gitter.im/flutter_whatsapp/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Whatsapp (ver. 2.19.98) clone using Flutter.

## About

I made this for my study/exercise on Flutter. I only make the client-side app, the server side is a dummy server.

## Development

To run this project on your own, do the following: 
1. Clone this project.
2. Run `flutter pub get`.
3. Create your own Firebase project and add the `google-services.json` to the folder `android/app` (for Android). This is a requirement for QR code reader package.
4. Run the project using `flutter run` or using your IDE's tools.

## Screenshots

|     |     |
| :-: | :-: |
| AppBar & TabBar | List chats from API |
| <img src="./images/image1.gif" height="300" /> | <img src="./images/image2.gif" height="300" /> |
| Search through chats/statuses/calls  | Show popup when profile is clicked |
| <img src="./images/image3.gif" height="300" /> | <img src="./images/image4.gif" height="300" /> |
| Retrieve list of contacts in phone  | See chat messages and send a new message |
| <img src="./images/image5.gif" height="300" /> | <img src="./images/image6.gif" height="300" /> |
| See status detail | (Android) Retrieve images from DCIM folder and take a picture. |
| <img src="./images/image7.gif" height="300" /> | <img src="./images/image_take_picture.gif" height="300" /> |

* Others
  * Take a video and save it to DCIM/Camera folder.
  * Scan a QR code (Still buggy).
  * Make an intent to open Contacts app on Android.
  * Make an intent to open an email app to invite friends.
