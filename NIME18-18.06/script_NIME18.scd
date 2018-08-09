//////////////////////////////////////////  TEST  ///////////////////////////////////////////////////

// Sound check
{Out.ar(0, 0.1*PinkNoise.ar)}.play;
{Out.ar(1, 0.1*PinkNoise.ar)}.play;

////Test audio in
{ SoundIn.ar(0) }.play;
{ Amplitude.kr(SoundIn.ar(0)); }.scope;
{ SoundIn.ar(0) }.stop;

//// Configure client OSC
NetAddr.localAddr;
// Test that gets messages from everywhere
OSCFunc.trace(true);
OSCFunc.trace(false);

//////////////////////////////////////////  EXEC  ///////////////////////////////////////////////////

// Instantiate class (loading buffers etc)

// Beacon(numnodes:
// num of speakers, offset,
// offset mapping speakers,
// audioinbus: [0 or above, the input bus of the mic, -1: replace with recordings]
//
// Beacon.new
// Beacon.new(numnodes: 2, offset: 0, audioinbus: 0)
// ~beacon = Beacon.new();

//(
//~beacon = Beacon.new(audioinbus:0); // stereo, audioin = -1: recordings, audioin = 0: bus 0
//)
//(
//s.record;
//)

(
~beacon = Beacon.new(audioinbus:0); // stereo, audioin = -1: recordings, audioin = 0: bus 0
)

(
s.record;
"Recording!".postln;
)




////////////////////////////////////////// PART 1 //////////////////////////////////////////////////
/////////////////////////////////////  TUNING DRONES /////////////////////////////////////////////

// Synths Part 1

// 1. Effects

(
~section1 = Array.new(5);
~section1fx = Array.new(1);
~section1fx.add ( Synth.new(\reverb, [\in, 11, \amount, 0], addAction:\addToTail ) );
)

// 2. Launch each synth in a slow pace...


~section1.add(Synth.new(\beacon_PlayBuf_LPF, [\bufnum, Beacon.buf[0], \amp, [ 0.2, 0.3, 0.4 ].choose] ) );

~section1.add(Synth.new(\beacon_PlayBuf_LPF, [\bufnum, Beacon.buf[0], \rate, [-1.0, 0.98, -0.98].choose, \amp, 0.3] ) );

~section1.add(Synth.new(\beacon_PlayBuf_LPF, [\bufnum, Beacon.buf[0], \rate, [ 0.93, 0.94, 0.95 ].choose, \amp, [ 0.2, 0.3, 0.4].choose] ) );

~section1.add(Synth.new(\beacon_PlayBuf_LPF, [\bufnum, Beacon.buf[0], \amp, [ 0.5, 0.6, 0.7 ].choose] ) );

// wait to launch this last synth to emphasize that is one octave higher

~section1.add(Synth.new(\beacon_PlayBuf_LPF, [\bufnum, Beacon.buf[0], \rate, 2, \amp, [ 0.5, 0.6, 0.7 ].choose] ) );


// 3. Launch the OSC functions...

// For testing: synths can be controlled independently, e.g.
// ~section1[0].set(\freq, 600);
// ~section1[4].set(\rate, 1.02);
// fx can be added/removed:
// ~section1[0].set(\bypassfx, 1)



////////////////////////////////////////// PART 2 //////////////////////////////////////////////////
//////////////////////////////////// MOTOR SPINNING WITH DRUM KIT ////////////////////////////////////////////


//Synths Part 2

(
~section2 = Array.new(4);

// 1. Effects


~section2fx = Array.new(4);
~section2fx.add (Synth.new(\reverb, [\in, 60, \amount, 0], addAction:\addToTail ) );
~section2fx.add (Synth.new(\reverb, [\in, 23, \amount, 0], addAction:\addToTail ) );
~section2fx.add (Synth.new(\reverb, [\in, 21, \amount, 0], addAction:\addToTail ) );
~section2fx.add (Synth.new(\reverb, [\in, 23, \amount, 0], addAction:\addToTail ) );
)

// 2. Audio in
// MIRLC

(
~kicks = Synth.new(\kickdrum, [\amp, 0]);

~wp2=Window("My Window", Rect(100,500,100,240));

~slidkicks=Slider(~wp2,Rect(30,10,40,180)); //a basic slider object of size 40 by 180 appears 10 pixels in from the left, and 10 pixels down from the top

~slidkicks.action_({
	~slidkicks.value.postln;
	~kicks.set(\amp,~slidkicks.value);
});

StaticText.new(~wp2, Rect(35,200,170,30)).string_("Kick drums");

~wp2.front;
)

//~kicks.set(\freq,90);



// 3. Synths

~section2.add(Synth.new(\beacon_PlayBuf_HPF, [\bufnum, Beacon.buf[21], \amp, [ 0.3, 0.4, 0.5 ].choose, \freq, [ 500, 550, 600 ].choose ] ) );
//~section2[1].set(\amp, 0);

~section2.add(Synth.new(\beacon_PlayBuf_HPF, [\bufnum, Beacon.buf[22], \amp, 0] ) );
//~section2[0].set(\freq, 800);

// Fade out P1, wait...

~section2.add(Synth.new(\beacon_PlayBuf_LPF_p2, [\bufnum, Beacon.buf[20], \amp, 0.1] ) );


~section2.add(Synth.new(\beacon_PlayBuf_HPF, [\bufnum, Beacon.buf[20], \amp, 0.2] ) );

// 4. Launch the OSC functions...

//synths can be controlled independently, e.g.
//~section2[0].set(\freq, 500);
//~section2[0].set(\amp, 0.8);
//~section2[1].set(\freq, 1400);
//~section2[2].set(\amp, 0.7);



////////////////////////////////////////// PART 3 //////////////////////////////////////////////////
//////////////////////////////////// SPINNING & PHASES //////////////////////////////////////////

(
~section3 =  Array.new(5);

// 1. Effects...

~section3fx = Array.new(1);
~section3fx.add (Synth.new(\reverb, [\in, 31, \amount, 0], addAction:\addToTail ) );
)

// 2. Synths

// launch the next 2 right after the other

 ~section3.add(Synth.new(\beacon_PlayBuf_rhythmic, [\bufnum, Beacon.buf[19], \rate, 1, \amp, 0.1]) );
//~section3[0].set(\trigvalue, 1);
//~section3[0].set(\amp, 0.1);

~section3.add(Synth.new(\beacon_PlayBuf_rhythmic, [\bufnum, Beacon.buf[19], \rate, 2, \amp, 0.3]) );
//~section3[1].set(\amp, 0.3);

// wait

// launch next 2 right after the other

 ~section3.add(Synth.new(\beacon_PlayBuf_rhythmic, [\bufnum, Beacon.buf[20], \rate, 1, \amp, 0.04, \freq, 2000]) );
//~section3[2].set(\trigvalue, 1);
//~section3[2].set(\amp, 0);
//~section3[2].set(\freq, 2000);
~section3[2].set(\amp, 0.04);

 ~section3.add(Synth.new(\beacon_PlayBuf_rhythmic, [\bufnum, Beacon.buf[20], \rate, 2, \amp, 0.1, \freq, 2000]) );
//~section3[3].set(\freq, 2000);
//~section3[3].set(\amp, 0.2);
//~section3[3].set(\amp, 0.1);

~section3.add(Synth.new(\beacon_PlayBuf_HPF, [\bufnum, Beacon.buf[23], \amp, 0.2, \outbus, 31] ) );
//~section3[4].set(\amp, 0.2);


// 3. Launch the OSC functions...


////////////////////////////////////////// PART 4 //////////////////////////////////////////////////
///////////////////////////////////// ALARMS & INDUSTRY //////////////////////////////////////////

// SET VOLUME DOWN

// Tracks 1-7, beacon effect

(
~section4 = Array.new(4);

// 1. Effects

~section4fx = Array.new(2);
~section4fx.add (Synth.new(\reverb, [\in, 41, \amount, 0], addAction:\addToTail ) );
~section4fx.add (Synth.new(\reverb, [\in, 43, \amount, 0], addAction:\addToTail ) );
)

//2. Synths

~section4.add(Synth.new(\beacon_PlayBuf_HPF, [\bufnum, Beacon.buf[24], \amp, 0.3, \outbus, 41] ) );
//~section4[0].set(\amp, 0.3);

~section4.add( Synth.new(\beacon_PlayBuf_random_speaker, [\bufnum, Beacon.buf[10], \rate, 0.2, \amp, 1 ] ) );
//~section4[1].set(\rate, 0.2);
//~section4[1].set(\amp, 1);
//~section4[1].set(\amp, 0);

~section4.add( Synth.new(\beacon_PlayBuf_random_speaker, [\bufnum, Beacon.buf[11], \rate, 0.2, \amp, 0.4 ] ) );
//~section4[2].set(\rate, 2);
//~section4[2].set(\amp, 0.4);
//~section4[2].set(\trigger, 1);

~section4.add(Synth.new(\beacon_PlayBuf_HPF, [\bufnum, Beacon.buf[25], \amp, 0, \outbus, 41] ) );
//~section4[3].set(\amp, 0);

//~section4.add( Synth.new(\beacon_PlayBuf_random_speaker, [\bufnum, Beacon.buf[11], \rate, -1, \amp, 0.5 ] ) );
//~section4[3].set(\rate, 2);
//~section4[3].set(\trigger, 0.5);


// 3. Launch the OSC functions...


// 4. Audio in
// MIRLC

(
~directin = Synth.new(\audioin, [\amp, 0]);

~wp4 = Window("My Window", Rect(100,500,100,240));

~sliddirectin = Slider(~wp4,Rect(30,10,40,180)); //a basic slider object of size 40 by 180 appears 10 pixels in from the left, and 10 pixels down from the top

~sliddirectin.action_({
	~sliddirectin.value.postln;
	~directin.set(\amp,~sliddirectin.value);
});

StaticText.new(~wp4, Rect(35,200,170,30)).string_("Direct in");

~wp4.front;
)

//~directin.set(\feedback, 0.4);

//

//{Saw.kr(freq: 100, mul: 2, add: -0.5)}.plot
//No use of buffer 6, 8 from past concert


// 5. Effects

(
~section4bfx = Array.new(1);
~section4bfx.add (Synth.new(\reverb, [\in, 45, \amount, 0], addAction:\addToTail ) );

// 6. Synths


~section4b = Array.new(2);
)

~section4b.add( Synth.new(\beacon_PlayBuf_Saw_MIRLC, [\bufnum, Beacon.buf[5], \modrate, 0.5, \amp, 0.3, \mul, 2, \add, -0.5, \bus, 45  ]) );
//~section4b[0].set(\amp, 0.3);
//~section4b[0].set(\freq, 1200);

// wait

~section4b.add( Synth.new(\beacon_PlayBuf_Saw_MIRLC, [\bufnum, Beacon.buf[26], \modrate, 0.5, \amp, 0.3, \mul, 2, \add, -0.5, \bus, 45 ] ) );


// // 7. Launch the OSC functions...


////////////////////////////////////////// PART 5 //////////////////////////////////////////////////
//////////////////////////////// OLD MACHINES & BEACONS /////////////////////////////////////////


//{Saw.kr(freq: 100, mul: 2, add: 2.5)}.plot

(
~section5 = Array.new(5);


// 1. Effects

~section5fx = Array.new(1);
~section5fx.add (Synth.new(\reverb, [\in, 51, \amount, 0], addAction:\addToTail ) );
)

// 2. Synths

~section5.add( Synth.new(\beacon_PlayBuf_Saw_MIRLC, [\bufnum, Beacon.buf[14], \modrate, 0.5,  \rate, 1, \amp, 2, \mul, 2, \add, -0.5, \bus, 51] ) ) ;
//~section5[0].set(\modrate, 0.5);

~section5.add( Synth.new(\beacon_PlayBuf_Saw_MIRLC, [\bufnum, Beacon.buf[15], \modrate, 0.5, \rate, 1, \amp, 2, \mul, 2, \add, -0.5, \bus, 51] ) ) ;
//~section5[1].set(\modrate, 1);

~section5.add( Synth.new(\beacon_PlayBuf_Saw_MIRLC, [\bufnum, Beacon.buf[16], \modrate, 0.5, \rate, 1, \amp, 2, \mul, 2, \add, -0.5, \bus, 51] ) ) ;
//~section5[2].set(\modrate, 1);

~section5.add( Synth.new(\beacon_PlayBuf_Saw_MIRLC, [\bufnum, Beacon.buf[17], \modrate, 0.5, \rate, 1, \amp, 2, \mul, 2, \add, -0.5, \bus, 51] ) ) ;
//~section5[3].set(\modrate, 1);

~section5.add( Synth.new(\beacon_PlayBuf_Saw_MIRLC, [\bufnum, Beacon.buf[18], \modrate, 0.5, \rate, 1, \amp, 2, \mul, 2, \add, -0.5, \bus, 51] ) ) ;
//~section5[4].set(\modrate, 1);


// 3. Audio in
// MIRLC -- noise in

(
~noisein = Synth.new(\noisegrain, [\amp, 0]);
~purein = Synth.new(\pureaudioin, [\amp, 0]);

~wp5=Window("My Window", Rect(100,500,200,240));

~slidnoisein=Slider(~wp5,Rect(40,10,40,180)); //a basic slider object of size 40 by 180 appears 10 pixels in from the left, and 10 pixels down from the top

~slidpurein=Slider(~wp5,Rect(120,10,40,180)); //a basic slider object of size 40 by 180 appears 10 pixels in from the left, and 10 pixels down from the top

~slidnoisein.action_({
	~slidnoisein.value.postln;
	~noisein.set(\amp,~slidnoisein.value);
});

~slidpurein.action_({
	~slidpurein.value.postln;
	~purein.set(\amp,~slidpurein.value);
});

StaticText.new(~wp5, Rect(35,200,170,30)).string_("Noise in");
StaticText.new(~wp5, Rect(115,200,160,30)).string_("Audio in");

~wp5.front;
)

// 3. Launch the OSC functions...


/*(
//~kicks2 = Synth.new(\kickdrum, [\amp, 0]);
~kicks2 = Synth.new(\beattrkdef, [\amp, 0]);

~wp6=Window("My Window", Rect(100,500,100,240));

~slidkicks2=Slider(~wp2,Rect(30,10,40,180)); //a basic slider object of size 40 by 180 appears 10 pixels in from the left, and 10 pixels down from the top

~slidkicks2.action_({
	~slidkicks2.value.postln;
	~kicks2.set(\amp,~slidkicks2.value);
});

StaticText.new(~wp6, Rect(35,200,170,30)).string_("Kick drums");

~wp6.front;
)*/

//~kicks.set(\rate,0.01);

//synths can be controlled independently, e.g.
//~kicks.set(\freq,90);
//~kicks.set(\freq, 60);
//~kicks.set(\rate, 8);
//~kicks.set(\bypassfx,1);
//~kicks.set(\bypassfx,0);
//~kicks.set(\amp, 0.5) // add reverb, at least try, affect the reverb by amplitude
//~section2fx[0].set(\amount, 0.2);
