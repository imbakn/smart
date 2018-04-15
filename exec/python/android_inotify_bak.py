#! /usr/bin/env python3

import pyinotify
import os
import sys

if len(sys.argv) < 2:
    print("must input a dir to watch.")
    sys.exit(1)

watch_event = pyinotify.IN_MODIFY | pyinotify.IN_DELETE | pyinotify.IN_MOVED_FROM | pyinotify.IN_MOVED_TO
watch_path = sys.argv[1]

class MyEventHandler(pyinotify.ProcessEvent):
    def process_IN_MODIFY(self, event):
        handle_add(event.pathname)

    def process_IN_MOVED_TO(self, event):
        handle_add(event.pathname)

    def process_IN_DELETE(self, event):
        handle_remove(event.pathname)

    def process_IN_MOVED_FROM(self, event):
        handle_remove(event.pathname)


def handle_add(path):
    print('file added', path[len(watch_path):len(path)])
    remout = os.popen("adb remount")
    ret = remout.read()
    print(ret)

    cmd = "adb push " + path + " /system/" + path[len(watch_path):len(path)]
    print(cmd)
    text = os.popen(cmd)
    print(text.read())


def handle_remove(path):
    print('file remove', path[len(watch_path):len(path)])

wm = pyinotify.WatchManager()
handler = MyEventHandler()
notifier = pyinotify.Notifier(wm, handler)

wm.add_watch(watch_path, watch_event)
for (root, dirs, files) in os.walk(watch_path):
    for dirc in dirs:
        tmppath = os.path.join(root, dirc)
        # print(tmppath)
        wm.add_watch(tmppath, watch_event)

notifier.loop()
