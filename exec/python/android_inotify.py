#! /usr/bin/env python3

import pyinotify
import os
import sys

try:
    android_project_root = os.environ["T"]
    android_product = os.environ["TARGET_PRODUCT"]
    android_build_variant = os.environ["TARGET_BUILD_VARIANT"]
except:
    sys.exit(-1)

if android_project_root == "":
    sys.exit(0)

if not os.path.isdir(android_project_root):
    sys.exit(-2)

if len(sys.argv) < 2:
    print("must input a dir to watch.")
    sys.exit(1)

watch_event = pyinotify.IN_MODIFY | pyinotify.IN_DELETE | pyinotify.IN_MOVED_FROM | pyinotify.IN_MOVED_TO
watch_path = android_project_root + "/" + sys.argv[1]


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
    with open(android_project_root + "/.system.change", "a+") as f:
        f.write(path.replace("\n", "").replace("\r", "") + "\n")


def handle_remove(path):
    print('file remove', path[len(watch_path):len(path)])


wm = pyinotify.WatchManager()
handler = MyEventHandler()
notifier = pyinotify.Notifier(wm, handler)

wm.add_watch(watch_path, watch_event)
for (root, dirs, files) in os.walk(watch_path):
    for dir_ in dirs:
        tmp_path = os.path.join(root, dir_)
        wm.add_watch(tmp_path, watch_event)

notifier.loop()
