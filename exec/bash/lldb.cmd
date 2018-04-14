platform connect unix-abstract-connect:///data/local/tmp/debug.sock
platform select remote-android

adb shell /data/local/tmp/lldb-server platform --server --listen unix-abstract:///data/local/tmp/debug.sock
