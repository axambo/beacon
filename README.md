Beacon
===
A SuperCollider extension for a either stereo or multichannel performance piece using sound samples. The library has been written since 2017 by Anna Xambó (<a.xambo@qmul.ac.uk>) for the piece Beacon and the follow-up Beckon, a collaboration with Anna Weisling.


Introduction
----

The code has been especially written to interact with the visual interactive instrument Distaff developed by Anna Weisling. The interaction between the two systems is established via OSC. For the moment this instrument controls in real time the rate of the set of sound samples that is playing and other sound properties. It can also affect some effects, such as a reverb and a low pass filter as well as reverse the sound samples.

In the future we may explore mutual interactions so that the audio engine can also control the visual system.

The library has been adapted and modified for each new performance. Thus, the code has been divided into folders that represent each performance, so far: Root Signal Festival 2017 (Georgia Southern University, Statesboro, Georgia, USA), NIME 2017 (Stengade, Copenhagen, Denmark), and TEI 2018 (Kulturhuset, Stockholm, Sweden).

### RSF17

The `Beacon` SC class is designed for multichannel speakers set in a ring. It is possible to add an offset depending on the number of the first bus of the speakers set. The code includes SynthDefs that are triggered to pairs, even/odds, random, or sequential speakers. The rate can be modified in real time and it is linked to the unit generator PlayBuf of sound samples.

[Here](https://soundcloud.com/annaxambo/beacon-root-signals-festival-2017) you can listen to the live performance held at the Root Signals Festival 2017, Georgia Southern University.

The code used in the concert of Root Signals Festival 2017 corresponds to the following commit hash to GitHub, which is also now accessible to the RSF17 folder: https://github.com/axambo/beacon/commit/1455d416bebbbc3e6138929551ad5749831c98bf


### NIME17

The `Beacon` SC class is adapted for the first time to stereo, exploring the same effects than in RSF17 but using panning and the like.

[Here](https://soundcloud.com/annaxambo/beacon-nime-2017) you can listen to the live performance held at the NIME 2017 conference, Stengade, Copenhagen, Denmark.

### TEI18

The `Beacon` SC class is refined for a stereo setup, as a followup of NIME17, but reducing the number of sounds, adding new sounds, and refining the mappings with the Distaff and the buses for applying effects.

Application Start
----


Drag the `Beacon.sc` file to the Extensions folder of SuperCollider (suggested to create a subfolder with the same name): `/Users/{username}/Library/Application Support/SuperCollider/Extensions` (in Mac)

Either recompile the class library (`Language>Recompile Class Library`) or restart SuperCollider.

There are two relevant files to run the program: a config file (e.g., [config_RSF17.md](config_RSF17.md) and a script file (e.g., [script_RSF17.md](script_RSF17.md)) that should be run sequentially and be self-explanatory.

Bear in mind that the sound samples used are defined in the class `Beacon.sc` (both names and the directory where they are stored). Make sure to rename as appropriate. Sounds should be in mono. The sample rate of sounds has been set to 44.1Hz and the sample format to 16-bit.

Related publications
----

* Weisling, A., Xambó, A. (2018). []“Beacon: Exploring Physicality in Digital Performance”](http://annaxambo.me/pub/Weisling_Xambo_2018_Physicality_in_digital_performance.pdf). In Proceedings of the Twelfth International Conference on Tangible, Embedded, and Embodied Interaction (TEI ’18). Stockholm, Sweden. pp. 586–591.

Sound credit list
----

The sounds used come from FreeSound and are published under CC licenses. There is a list of sound credits for in each folder.


License
----

The MIT License (MIT).
