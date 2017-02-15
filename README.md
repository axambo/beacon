Beacon
===
A SuperCollider extension for a multichannel performance using sound samples written in 2017 by Anna Xambó (<anna.xambo@gatech.edu>) for the piece Beacon, a collaboration with Anna Weisling. 


Introduction
------------

This SC class is designed for multichannel speakers set in a ring. It is possible to add an offset depending on the number of the first bus of the speakers set. The code includes SynthDefs that are triggered to pairs, even/odds, random, or sequential speakers. The rate can be modified in real time and it is linked to the unit generator PlayBuf of sound samples. 

The code has been especially written to interact with the visual interactive instrument Distaff developed by Anna Weisling. The interaction between the two systems is established via OSC. For the moment this instrument controls in real time the rate of the set of sound samples that is playing. It can also apply effects, such as a reverb and a low pass filter as well as reverse the sound samples.

In the future we may explore mutual interactions so that the audio engine can also control the visual system.

Here you can listen to the live performance held at the Root Signals Festival 2017, Georgia Southern University: [https://soundcloud.com/annaxambo/beacon-root-signals-festival-2017](https://soundcloud.com/annaxambo/beacon-root-signals-festival-2017)


Application Start
----

The code used in the concert of Root Signals Festival 2017 corresponds to the following commit hash to GitHub: XXX

Drag the `Beacon.sc` file to the Extensions folder of SuperCollider (suggested to create a subfolder with the same name): `/Users/{username}/Library/Application Support/SuperCollider/Extensions` (in Mac)

Either recompile the class library (`Language>Recompile Class Library`) or restart SuperCollider.

There are two relevant files to run the program: a [config file](config_RSF17.md) and a [script file](script_RSF17.md) that should be run sequentially and be self-explanatory.

Bear in mind that the sound samples used are defined in the class `Beacon.sc` (both names and the directory where they are stored). Make sure to rename as appropriate.


Sound credit list
----

The sounds used come from FreeSound and are published under CC licenses. Here is a [full sound credit list](sound_credits_RSF17.md).



License
----

The MIT License (MIT).


