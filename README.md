# appetizer-toolkit [![Build Status](https://travis-ci.org/appetizerio/appetizer-toolkit.svg?branch=master)](https://travis-ci.org/appetizerio/appetizer-toolkit) [![Windows Build](https://ci.appveyor.com/api/projects/status/github/appetizerio/appetizer-toolkit)](https://ci.appveyor.com/project/mingyuan-xia/appetizer-toolkit)
[中文说明](./README.cn.md)

`appetizer-toolkit` is a command line tool intended for mobile continuous integration, which provides the ability to:
* record touchscreen events from one device and replay to many (aspect ratios must be the same)
* control multiple devices concurrently (e.g., run a shell command, install an app, etc.)
* mirror the touchscreen events from one device to many in real time (aspect ratios must be the same)

`appetizer-toolkit` can work on Windows 7+, MacOS Mavericks+ and Linux. To integrate it with existing CI infrastructure, consider the [Python SDK](https://github.com/appetizerio/appetizer-toolkit-py). 

Please submit issues for bug reports, enhancements and feature requests. Pull requests are welcomed too.

## Installation
The executable file can be found in the `darwin/` for MacOS, `win32/` for Windows and `linux/` for Ubuntu, Fedora and CentOS. You might want to add to PATH to use the tool globally. Linux and MacOS build are both 64-bit and Windows build is 32-bit (compatible with 64-bit as WOW). `appetizer-toolkit` requires `adb` to be present in `PATH`. You can install the Android SDK and ensure `<sdk>/platform-tools` is in your PATH.

## Control Multiple Devices
Suppose you have several devices attached to the development machine via USB and you want them to perform the same action.

First, make sure the toolkit recognizes all of them devices:
```
./darwin/appetizer devices list
```
You should see a JSON output. Note the `serialno` field, which is the same as the `adb devices` output. A serialno uniquely identifies a connected device.

Next, you can try these:
```
DEVICE=serialno1,serialno2 # device serialnos, comma separated, no whitespace!
appetizer devices control $DEVICE uninstall com.helloworld # uninstall an app on those devices
appetizer devices control $DEVICE install hellworld.apk # install an app
appetizer devices control $DEVICE kill_all # kill all background apps
appetizer devices control $DEVICE launch_pkg com.helloworld # launch an app
appetizer devices control $DEVICE shell input keyevent KEYCODE_HOME # simulate the home button
appetizer devices control $DEVICE shell pm grant com.helloworld android.permission.SOME_PERMISSION  # grant a permission to an app 
appetizer devices control $DEVICE shell "input keyboard text 'Paste%stext%son%sAndroid%sDevice'"  # input text (pre Android 6)
appetizer devices control $DEVICE shell "input keyboard text 'Paste text on Android Device'"  # input text (Android 6+)
appetizer devices control $DEVICE shell screenrecord /sdcard/demo.mp4  # record screen into a video（Android 4.4+）
```
Basically everything you did with `adb shell` can now be replaced with `appetizer devices control serialno1,serialno2 shell` to perform that on multiple devices simultaneously.

And, just in case you need them:
* [Key code cheatsheet](https://developer.android.com/reference/android/view/KeyEvent.html)
* [Common ADB shell commands](http://stackoverflow.com/documentation/android/1051/adb-android-debug-bridge)

## Record and Replay touchscreen events
The toolkit can record touchscreen events from one device and replay back to many to automate stuff.
```
appetizer trace record --device serailno mytrace.trace
```
Now find the device and start touching. The touchsceen events will be captured and saved to `mytrace.trace`. If you are done, type in `exit` to stop. You are all set if seeing "Recorder stopped, trace saved to mytrace.trace". Try not to use `Ctrl+C`.

Check if the trace is good:
```
appetizer trace info mytrace.trace
```
Again, it shows a JSON about the recorded trace, showing the screen resolution, time length, how many fingers, etc.

Next replay the trace back to see how it goes:
```
appetizer trace replay mytrace.trace serialno
```
You will see something like the video below:
[![Record and replay](https://i.vimeocdn.com/video/583660790_640.jpg)](https://vimeo.com/176421640)

If you want to replay to more than one devices, simply replace `serialno` with a comma-separated serialno list like `serialno1, serialno2`.

## Mirror Touchscreen Events
With the toolkit, you can mirror the touchscreen events from one device to other device in real time.
```
appetizer devices mirror <from_device> <to_device>
```
The `<from_device>` is a single serialno while `<to_device>` can be a comma-separated list of device serialnos.
Make sure all involving devices have the same aspect ratio. Otherwise the command will fail.
For devices with the same aspect ratio, the touchscreen events will automatically scale to adapt to the screen resolution.

Here is a demo:
[![mirroring](https://i.vimeocdn.com/video/585120374_640.jpg)](https://vimeo.com/176421482)

## ADB related
Finally, the toolkit provides some commands to check the ADB environment.
```
appetizer adb start-server  # start the ADB server
appetizer adb kill-server  # kill the ADB server
appetizer adb detectadb  # this tells where the adb binary locates. If not found, tune your PATH
appetizer adb check-server  # check if the adb server is running properly now
```
## License
Apache License v2
