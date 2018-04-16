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

out_dir = android_project_root + "/out/target/product/" + android_product
system_dir = out_dir + "/system"

watch_event = pyinotify.IN_CLOSE_WRITE | pyinotify.IN_DELETE | pyinotify.IN_MOVED_FROM | pyinotify.IN_MOVED_TO
watch_path = system_dir

print("Watch path is %s" % system_dir)


class MyEventHandler(pyinotify.ProcessEvent):
    def process_IN_CLOSE_WRITE(self, event):
        handle_add(event.pathname)

    def process_IN_MOVED_TO(self, event):
        handle_add(event.pathname)

    def process_IN_DELETE(self, event):
        handle_remove(event.pathname)

    def process_IN_MOVED_FROM(self, event):
        handle_remove(event.pathname)


def handle_add(path):
    print(path)
    with open(android_project_root + "/.system.change", "a+") as f:
        f.write(path.replace("\n", "").replace("\r", "").replace(out_dir + "/", "") + "\n")


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

