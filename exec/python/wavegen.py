#! /usr/bin/python/

import struct, wave, math, random

def tri(freq,amp,dur):
    half_cycle = []
    one_cycle = []
    amp = int(float(amp)/100*clip)
    cycle_frames = out_params[2]/freq
    for i in range(0,int(cycle_frames/2)+1):
        half_cycle.append(int(i*amp/(cycle_frames/4))-amp)
    one_cycle = one_cycle + half_cycle
    half_cycle.reverse()
    one_cycle = one_cycle + half_cycle
    write(one_cycle, dur)
    return 1

def saw(freq,amp,dur,invert):
    one_cycle = []
    amp = (float(amp)/100)*clip
    cycle_frames = out_params[2]/freq
    for i in range(0,int(cycle_frames)+1):
        one_cycle.append(int(2*i*amp/cycle_frames)-amp)
    if invert == 1:
        one_cycle.reverse()
    write(one_cycle, dur)
    return 1
        
def pulse(freq,amp,dur,duty):
    one_cycle = []
    amp = (float(amp)/100)*clip
    cycle_frames = float(out_params[2]/freq)
    duty = (float(duty)/100)*cycle_frames
    for i in range(0,int(duty)):
        one_cycle.append(amp)
    for i in range(0,int(cycle_frames-duty)):
        one_cycle.append(-amp)
    write(one_cycle, dur)
    return 1
        
def sine(freq,amp,dur):
    amp = (float(amp)/100)*clip
    cycle_frames = float(out_params[2]/freq) #sample rate divided by user frequency
    const = float((2*math.pi)/cycle_frames)  #2pi radians divided by 1 cycle of frames
    deg = 0
    one_cycle = []

    for i in range(0,int(cycle_frames)):     #loops through 1 cycle of frames
        deg = deg + const
        wave_sine = int(amp*(math.sin(deg)))
        one_cycle.append(wave_sine)          #generate array of frame values
    write(one_cycle, dur)
    return 1

def noise(amp,dur):
    amp = int((float(amp)/100)*clip)
    for i in range(0,int(dur*out_params[2])):
        wave_frame = struct.pack('<h',random.randint(-amp,amp))
        output.writeframes(wave_frame)
    return 1

def shh(dur):
    for i in range(0,int(dur*out_params[2])):
        wave_frame = struct.pack('<h',0)
        output.writeframes(wave_frame)
    return 1

def write(wave, length):
    cycle_frames = len(wave)
    num_cycles = int((out_params[2]*length)/cycle_frames)
    for j in range(0,num_cycles):            #loop through num of cycles needed to fill time
        for i in wave:                       #loop through array, pack, and write
            wave_frame = struct.pack('<h',i)
            output.writeframes(wave_frame)

clip = 31000
filename = 'render'+str(random.randint(100,999))+'.wav'
output = wave.open(filename, 'w')
out_params = [1,2,44100,0,'NONE','not compressed']
output.setparams(out_params)
print filename
tri(2400,50, .1)
output.close()


