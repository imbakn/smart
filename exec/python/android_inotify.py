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

arglen = len(sys.argv)
wpath = "system"

if arglen == 2 :
    if sys.argv[1] != "data" and sys.argv[1] != "system":
        sys.exit(-3)
    else:
        wpath = sys.argv[1]

if android_project_root == "":
    sys.exit(0)

if not os.path.isdir(android_project_root):
    sys.exit(-2)


file_name = "%s/%s_%s_%s.pid" % (android_project_root, android_product, android_build_variant, wpath)
print(file_name)

def writePid():
    pid = str(os.getpid())
    f = open(file_name, 'w')
    f.write(pid)
    f.close()


def getPid():
    if not os.path.exists(file_name):
        return "-1"
    with open(file_name, 'r') as pid:
        pid_str = pid.read()
        print("pid is %s" % pid_str)
        return str(pid_str)


def is_run(pid):
    strtmp = os.popen("ps -p %s" % pid)
    cmdback = strtmp.read()
    print(cmdback)
    p = str(cmdback).find('python')
    print(p)
    if not p == -1:
        print('android_inotify is run')
        return True
    else:
        print('android_inotify is not run')
        return False


if is_run(getPid()):
    print("already running. exit now.")
    sys.exit()
else:
    print("start inotify")
    writePid()


out_dir = android_project_root + "/out/target/product/" + android_product
system_dir = out_dir + "/" + wpath

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
