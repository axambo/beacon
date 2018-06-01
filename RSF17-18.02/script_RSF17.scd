

//////////////////////////////////////////  EXEC  ///////////////////////////////////////////////////


// Instantiate class (loading buffers etc)

//~beacon = Beacon.new(2); // num of speakers, offset

~beacon = Beacon.new(8, 0); // num of speakers, offset

Server.default.makeGui // for recording

////////////////////////////////////////// PART 1 //////////////////////////////////////////////////
/////////////////////////////////////  TUNING DRONES /////////////////////////////////////////////


// Track 1, Speakers [0, 7]
~a1s1max = Synth.new(\beacon_PlayBuf_pair1, [\bufnum, Beacon.buf[0], \amp, 0.7]);
~a1s1max.set(\rate, -1.0);
~a1s1max.set(\gate, 0);
// Track 2, Speakers [1, 6]
~a1s2max = Synth.new(\beacon_PlayBuf_pair2, [\bufnum, Beacon.buf[0], \rate, 0.98, \amp, 0.7]);
~a1s2max.set(\rate, -1.0);
// Track 3, Speakers [2, 5]
~a1s3max = Synth.new(\beacon_PlayBuf_pair3, [\bufnum, Beacon.buf[0], \rate, 0.96, \amp, 0.7]);
~a1s3max.set(\rate, -1.0);
// Track 4, Speakers [3, 4]
~a1s4max = Synth.new(\beacon_PlayBuf_pair4, [\bufnum, Beacon.buf[0], \rate, 0.94, \amp, 0.7]);
~a1s4max.set(\rate, -1.0);

(
//OSC functions Part 1

var o1status = 0;
var o2status = 0;

~o1 = OSCFunc (
	{
		arg msg, time, addr, recvPort;
		var maxerase = 100;

		if ( msg[1] < 5, { o1status = 1;});

		if (
			msg[1] > 0 && o1status == 1,
			{
				~a1s1max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				~a1s2max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				~a1s3max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				~a1s4max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				["[ERASE] raw value: " ++ msg[1] ]. postln;
				["[ERASE] normalized value: " ++ Lag.kr(msg[1]/maxerase) ]. postln;
			}
		);
	},
	'/erase', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

~o2 = OSCFunc (
	{
		arg msg, time, addr, recvPort;
		var maxspeed = 15;

		if ( msg[1] < 5, { o2status = 1;});
		if (
			msg[1] > 0 && o2status == 1,
			{
				~a1s1max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				~a1s2max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				~a1s3max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				~a1s4max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				["[SPEED] raw value: " ++ msg[1] ]. postln;
				["[SPEED] normalized value: " ++ Lag.kr(msg[1]/maxspeed) ]. postln;
			}
		);
	},
	'/speed', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

~o3 = OSCFunc (
	{
		arg msg, time, addr, recvPort;

		if (
			msg[1] == 1,
			{
				~a1s1max.set(\rate, -1.0);
				~a1s2max.set(\rate, -1.0);
				~a1s3max.set(\rate, -1.0);
				~a1s4max.set(\rate, -1.0);
				["[SCROLL] raw value: " ++ msg[1] ]. postln;
			},
			{
				~a1s1max.set(\rate, 1.0);
				~a1s2max.set(\rate, 1.0);
				~a1s3max.set(\rate, 1.0);
				~a1s4max.set(\rate, 1.0);
				["[SCROLL] raw value: " ++ msg[1] ]. postln;
			}
		);
	},
	'/scroll', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

~o4 = OSCFunc (
	{
		arg msg, time, addr, recvPort;

		if (
			msg[1] == 1,
			{
				~a1s1max.set(\freq, 330);
				~a1s2max.set(\freq, 330);
				~a1s3max.set(\freq, 330);
				~a1s4max.set(\freq, 330);
				["[THIRDS] raw value: " ++ msg[1] ]. postln;
			},
			{
				~a1s1max.set(\freq, 440);
				~a1s2max.set(\freq, 440);
				~a1s3max.set(\freq, 440);
				~a1s4max.set(\freq, 440);
				["[THIRDS] raw value: " ++ msg[1] ]. postln;
			}
		);
	},
	'/thirds', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

)

////////////////////////////////////////// PART 2 //////////////////////////////////////////////////
//////////////////////////////////// LOCALIZED DRONES ////////////////////////////////////////////


// Track 1, Speakers [0, 7]
~a1s5max = Synth.new(\beacon_PlayBuf_pair4, [\bufnum, Beacon.buf[1], \amp, 0.8] );
~a1s5max.set(\maxdelaytime, 0.9);
~a1s5max.set(\delaytime, 0.9);
~a1s5max.set(\rate, -1.0);
// Track 2, Speakers [1, 6]
// !!!TODO!!!: fix this sound, the loop connects abruptly with the beginning
~a1s6max = Synth.new(\beacon_PlayBuf_pair2, [\bufnum, Beacon.buf[2], \rate, 1.0, \amp, 0.6] );
~a1s6max.set(\rate, -1.0);
// Track 3, Speakers [2, 5]
~a1s7max = Synth.new(\beacon_PlayBuf_pair3, [\bufnum, Beacon.buf[3], \rate, 1.0, \amp, 0.8]);
~a1s7max.set(\rate, -1.0);
// Track 4, Speakers [3, 4]
~a1s8max = Synth.new(\beacon_PlayBuf_pair1, [\bufnum, Beacon.buf[4], \rate, 1.0, \amp, 0.8] );
~a1s8max.set(\rate, -1.0);


(
// Bye to Part 1
~a1s1max.set(\gate, 0);
~a1s2max.set(\gate, 0);
~a1s3max.set(\gate, 0);
~a1s4max.set(\gate, 0);
~o1.free;
~o2.free;
~o3.free;
~o4.free;
)

(
// OSC functions Part 2

var o5status = 0;
var o6status = 0;

~o5 = OSCFunc (
	{
		arg msg, time, addr, recvPort;
		var maxspeed = 15;

		if ( msg[1] < 5, { o5status = 1;});

		if (
			msg[1] > 0 && o5status == 1,
			{
				~a1s5max.set(\rate, 0.85 + Lag.kr(msg[1]/maxspeed) );
				~a1s5max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				~a1s6max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				~a1s7max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				~a1s8max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				["[SPEED] raw value: " ++ msg[1] ]. postln;
				["[SPEED] normalized value: " ++ Lag.kr(msg[1]/maxspeed) ]. postln;
			}
		);
	},
	'/speed', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

~o6 = OSCFunc (
	{
		arg msg, time, addr, recvPort;
		var maxerase = 100;

		if ( msg[1] < 5, { o6status = 1;} );

		if (
			msg[1] > 0 && o6status == 1,
			{
				~a1s5max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				~a1s6max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				~a1s7max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				~a1s8max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				["[ERASE] raw value: " ++ msg[1] ]. postln;
				["[ERASE] normalized value: " ++ Lag.kr(msg[1]/maxerase) ]. postln;
			}
		);
	},
	'/erase', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

~o7 = OSCFunc (
	{
		arg msg, time, addr, recvPort;
		if (
			msg[1] == 1,
			{
				~a1s5max.set(\rate, -1.0);
				~a1s6max.set(\rate, -1.0);
				~a1s7max.set(\rate, -1.0);
				~a1s8max.set(\rate, -1.0);
				["[SCROLL] raw value: " ++ msg[1] ]. postln;
			},
			{
				~a1s5max.set(\rate, 1.0);
				~a1s6max.set(\rate, 1.0);
				~a1s7max.set(\rate, 1.0);
				~a1s8max.set(\rate, 1.0);
				["[SCROLL] raw value: " ++ msg[1] ]. postln;
			}
		);
	},
	'/scroll', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

~o8 = OSCFunc (
	{
		arg msg, time, addr, recvPort;

		if (
			msg[1] == 1,
			{
				~a1s5max.set(\freq, 330);
				~a1s6max.set(\freq, 330);
				~a1s7max.set(\freq, 330);
				~a1s8max.set(\freq, 330);
				["[THIRDS] raw value: " ++ msg[1] ]. postln;
			},
			{
				~a1s5max.set(\freq, 440);
				~a1s6max.set(\freq, 440);
				~a1s7max.set(\freq, 440);
				~a1s8max.set(\freq, 440);
				["[THIRDS] raw value: " ++ msg[1] ]. postln;
			}
		);
	},
	'/thirds', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

)



////////////////////////////////////////// PART 3 //////////////////////////////////////////////////
//////////////////////////////////// MACHINES & REVERBS //////////////////////////////////////////


// Track 1, Speakers [0, 2, 4, 6]
~a1s9max = Synth.new(\beacon_PlayBuf_Saw, [\bufnum, Beacon.buf[5], \modrate, 1] );
~a1s9max.set(\modrate, 1);
(
~rndsnd = [ Beacon.buf[6], Beacon.buf[7], Beacon.buf[8], Beacon.buf[9]].choose;
// Track 2, Speakers [1, 3, 5, 7]
~a1s10max = Synth.new(\beacon_PlayBuf_Saw, [\bufnum, ~rndsnd, \modrate, 1 ] );
)

//beacon_PlayBuf_even
//beacon_PlayBuf_odds

~a1s11 = Synth.new(\beacon_PlayBuf_Saw, [\bufnum, Beacon.buf[13], \rate, 0.2, \modrate, 1, \amp, 0.8 ] );
~a1s11.set(\modrate, 2);
~a1s11.set(\modrate, 3);
~a1s11.set(\modrate, 4);
~a1s11.set(\amp, 1);
~a1s11.set(\gate, 0);

(
// Bye to Part 2
~a1s5max.set(\gate, 0);
~a1s6max.set(\gate, 0);
~a1s7max.set(\gate, 0);
~a1s8max.set(\gate, 0);
~o5.free;
~o6.free;
~o7.free;
~o8.free;
)

(
// OSC functions Part 3

var o9status = 0;
var o10status = 0;

~o9 = OSCFunc (
	{
		arg msg, time, addr, recvPort;
		var maxspeed = 15;

		if ( msg[1] < 5, { o9status = 1;});
		if (
			msg[1] > 0 && o9status == 1,
			{
				//~a1s9max.set(\rate, 1.0 + Lag.kr(msg[1]/maxspeed) );
				//~a1s10max.set(\rate, 1.0 + Lag.kr(msg[1]/maxspeed) );
				~a1s9max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				~a1s10max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				["[SPEED] raw value: " ++ msg[1] ]. postln;
				["[SPEED] normalized value: " ++ Lag.kr(msg[1]/maxspeed) ]. postln;
			}
		);
	},
	'/speed', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

~o10 = OSCFunc (
	{
		arg msg, time, addr, recvPort;
		var maxerase = 100;

		if ( msg[1] > 95, { o10status = 1;});
		if (
			msg[1] > 0 && o10status == 1,
			{

				~a1s9max.set(\rate, 10 *  Lag.kr( 1 - (msg[1]/maxerase) ) );
				~a1s10max.set(\rate, 10 *  Lag.kr(1 - (msg[1]/maxerase) ) );
				~a1s9max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				~a1s10max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				["[ERASE] raw value: " ++ msg[1] ]. postln;
				["[ERASE] normalized value: " ++ Lag.kr(msg[1]/maxerase) ]. postln;
			}
		);
	},
	'/erase', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

~o11 = OSCFunc (
	{
		arg msg, time, addr, recvPort;
		if (
			msg[1] == 1,
			{
				~a1s9max.set(\rate, -1.0);
				~a1s10max.set(\rate, -1.0);
				["[SCROLL] raw value: " ++ msg[1] ]. postln;
			},
			{
				~a1s9max.set(\rate, 1.0);
				~a1s10max.set(\rate, 1.0);
				["[SCROLL] raw value: " ++ msg[1] ]. postln;
			}
		);
	},
	'/scroll', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

~o12 = OSCFunc (
	{
		arg msg, time, addr, recvPort;

		if (
			msg[1] == 1,
			{
				~a1s9max.set(\freq, 330);
				~a1s10max.set(\freq, 330);
				["[THIRDS] raw value: " ++ msg[1] ]. postln;
			},
			{
				~a1s9max.set(\freq, 440);
				~a1s10max.set(\freq, 440);
				["[THIRDS] raw value: " ++ msg[1] ]. postln;
			}
		);
	},
	'/thirds', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

)


////////////////////////////////////////// PART 4 //////////////////////////////////////////////////
///////////////////////////////////// ALARMS & INDUSTRY //////////////////////////////////////////


// Tracks 1-7, same than in Part 3, but under beacon effect

~a1s12max = Synth.new(\beacon_PlayBuf_random_speaker, [\bufnum, Beacon.buf[10], \rate, 0.2, \amp, 1.2 ] );
~a1s12max.set(\rate, 2);
~a1s12max.set(\gate, 0);

~a1s13max = Synth.new(\beacon_PlayBuf_random_speaker, [\bufnum, Beacon.buf[11], \rate, 0.2, \amp, 1.2 ] );
~a1s13max.set(\rate, 2);
~a1s13max.set(\gate, 0);

~a1s14max = Synth.new(\beacon_PlayBuf_random_speaker, [\bufnum, Beacon.buf[12], \rate, 0.2, \amp, 1.2 ] );
~a1s14max.set(\rate, 2);
~a1s14max.set(\gate, 0);

~a1s15max = Synth.new(\beacon_PlayBuf_random_speaker, [\bufnum, Beacon.buf[10], \amp, 1.2 ] );
~a1s15max.set(\rate, 2);
~a1s15max.set(\gate, 0);

~a1s16max = Synth.new(\beacon_PlayBuf_random_speaker, [\bufnum, Beacon.buf[11], \amp, 1.2 ] );
~a1s16max.set(\rate, 2);
~a1s16max.set(\gate, 0);

~a1s17max = Synth.new(\beacon_PlayBuf_random_speaker, [\bufnum, Beacon.buf[12], \amp, 1.2 ] );
~a1s17max.set(\rate, 2);
~a1s17max.set(\gate, 0);

~a1s18 = Synth.new(\beacon_PlayBuf_Saw, [\bufnum, Beacon.buf[5], \modrate, 1, \amp, 1.2 ] );
~a1s18.set(\modrate, 1);
~a1s18.set(\modrate, 10);
~a1s18.set(\modrate, 100);
~a1s18.set(\gate, 0);

(
// OSC functions Part 4 (1/2)

var o13status = 0;
var o14status = 0;

~o13 = OSCFunc (
	{
		arg msg, time, addr, recvPort;
		var maxspeed = 15;

		if ( msg[1] < 5, { o13status = 1;});
		if (
			msg[1] > 0 && o13status == 1,
			{
				~a1s12max.set(\rate, 1.0 + Lag.kr(msg[1]/maxspeed) );
				~a1s13max.set(\rate, 1.0 + Lag.kr(msg[1]/maxspeed) );
				~a1s14max.set(\rate, 1.0 + Lag.kr(msg[1]/maxspeed) );
				~a1s15max.set(\rate, 1.0 + Lag.kr(msg[1]/maxspeed) );
				~a1s16max.set(\rate, 1.0 + Lag.kr(msg[1]/maxspeed) );
				~a1s17max.set(\rate, 1.0 + Lag.kr(msg[1]/maxspeed) );
				~a1s12max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				~a1s13max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				~a1s14max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				~a1s15max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				~a1s16max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				~a1s17max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				["[SPEED] raw value: " ++ msg[1] ]. postln;
				["[SPEED] normalized value: " ++ Lag.kr(msg[1]/maxspeed) ]. postln;
			}
		);
	},
	'/speed', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

~o14 = OSCFunc (
	{
		arg msg, time, addr, recvPort;
		var maxerase = 100;

		if ( msg[1] < 5, { o14status = 1;});
		if (
			msg[1] > 0 && o14status == 1,
			{
				~a1s12max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				~a1s13max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				~a1s14max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				~a1s15max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				~a1s16max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				~a1s17max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				["[ERASE] raw value: " ++ msg[1] ]. postln;
				["[ERASE] normalized value: " ++ Lag.kr(msg[1]/maxerase) ]. postln;
			}
		);
	},
	'/erase', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

~o15 = OSCFunc (
	{
		arg msg, time, addr, recvPort;
		if (
			msg[1] == 1,
			{
				~a1s12max.set(\rate, -1.0);
				~a1s13max.set(\rate, -1.0);
				~a1s14max.set(\rate, -1.0);
				~a1s15max.set(\rate, -1.0);
				~a1s16max.set(\rate, -1.0);
				~a1s17max.set(\rate, -1.0);
				["[SCROLL] raw value: " ++ msg[1] ]. postln;
			},
			{
				~a1s12max.set(\rate, 1.0);
				~a1s13max.set(\rate, 1.0);
				~a1s14max.set(\rate, 1.0);
				~a1s15max.set(\rate, 1.0);
				~a1s16max.set(\rate, 1.0);
				~a1s17max.set(\rate, 1.0);
				["[SCROLL] raw value: " ++ msg[1] ]. postln;
			}
		);
	},
	'/scroll', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

~o16 = OSCFunc (
	{
		arg msg, time, addr, recvPort;

		if (
			msg[1] == 1,
			{
				~a1s12max.set(\freq, 330);
				~a1s13max.set(\freq, 330);
				~a1s14max.set(\freq, 330);
				~a1s15max.set(\freq, 330);
				~a1s16max.set(\freq, 330);
				~a1s17max.set(\freq, 330);
				["[THIRDS] raw value: " ++ msg[1] ]. postln;
			},
			{
				~a1s12max.set(\freq, 440);
				~a1s13max.set(\freq, 440);
				~a1s14max.set(\freq, 440);
				~a1s15max.set(\freq, 440);
				~a1s16max.set(\freq, 440);
				~a1s17max.set(\freq, 440);
				["[THIRDS] raw value: " ++ msg[1] ]. postln;
			}
		);
	},
	'/thirds', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

)


)

~a1s19max = Synth.new(\beacon_PlayBuf_Saw, [\bufnum, Beacon.buf[5], \modrate, 10, \amp, 1.2 ] );
~a1s19max.set(\modrate, 10, \offset, 1, \amp, 1);
~a1s19max.set(\modrate, 100, \offset, 1, \amp, 1);
~a1s19max.set(\modrate, 10, \offset, 1, \amp, 1);

~a1s20 = Synth.new(\beacon_PlayBuf_Saw, [\bufnum, Beacon.buf[13], \modrate, 1, \amp, 1.2 ] );
~a1s20.set(\rate, 0.8);

(
// Bye to Part 3
~a1s9max.set(\gate, 0);
~a1s10max.set(\gate, 0);
~o9.free;
~o10.free;
~o11.free;
~o12.free;
)


(
// OSC functions Part 4 (2/2)

var o17status = 0;
var o18status = 0;

~o17 = OSCFunc (
	{
		arg msg, time, addr, recvPort;
		var maxspeed = 15;

		if ( msg[1] < 5, { o17status = 1;});
		if (
			msg[1] > 0 && o17status == 1,
			{
				~a1s19max.set(\modrate, 100 *  Lag.kr(msg[1]/maxspeed) );
				~a1s19max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				["[SPEED] raw value: " ++ msg[1] ]. postln;
				["[SPEED] normalized value: " ++ Lag.kr(msg[1]/maxspeed) ]. postln;
			}
		);
	},
	'/speed', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

~o18 = OSCFunc (
	{
		arg msg, time, addr, recvPort;
		var maxerase = 100;

		if ( msg[1] < 5, { o18status = 1;});
		if (
			msg[1] > 0 && o18status == 1,
			{
				~a1s19max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				["[ERASE] raw value: " ++ msg[1] ]. postln;
				["[ERASE] normalized value: " ++ Lag.kr(msg[1]/maxerase) ]. postln;
			}
		);
	},
	'/erase', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

~o19 = OSCFunc (
	{
		arg msg, time, addr, recvPort;
		if (
			msg[1] == 1,
			{
				~a1s19max.set(\rate, -1.0);
				["[SCROLL] raw value: " ++ msg[1] ]. postln;
				["[SCROLL] incoming value: " ++ msg[1]]. postln;
			},
			{
				~a1s19max.set(\rate, 1.0);
				["raw value: " ++ msg[1] ]. postln;
			}
		);
	},
	'/scroll', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

~o20 = OSCFunc (
	{
		arg msg, time, addr, recvPort;

		if (
			msg[1] == 1,
			{
				~a1s19max.set(\freq, 330);
				["[SCROLL] raw value: " ++ msg[1] ]. postln;
				["incoming value: " ++ msg[1]]. postln;
			},
			{
				~a1s19max.set(\freq, 440);
				["raw value: " ++ msg[1] ]. postln;
			}
		);
	},
	'/thirds', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

)

////////////////////////////////////////// PART 5 //////////////////////////////////////////////////
//////////////////////////////// OLD MACHINES & BEACONS /////////////////////////////////////////


~a1s21max = Synth.new(\beacon_PlayBuf_Saw, [\bufnum, Beacon.buf[14], \modrate, 0.1, \amp, 2] )  ;
~a1s21max.set(\modrate, 1);
~a1s21max.set(\rate, -1.0);
~a1s21max.set(\amp, 2);

{Saw.kr(freq: 100, mul: 6, add: 2.5)}.plot

~a1s22max = Synth.new(\beacon_PlayBuf_Saw, [\bufnum, Beacon.buf[15], \modrate, 0.1, \amp, 2] )  ;
~a1s22max.set(\modrate, 0.05);
~a1s22max.set(\rate, -1.0);
~a1s22max.set(\amp, 2);

~a1s23max = Synth.new(\beacon_PlayBuf_Saw, [\bufnum, Beacon.buf[16], \modrate, 0.1, \amp, 2] )  ;
~a1s23max.set(\modrate, 0.05);
~a1s23max.set(\rate, -1.0);
~a1s23max.set(\gate, 0);


~a1s24max = Synth.new(\beacon_PlayBuf_Saw, [\bufnum, Beacon.buf[17], \modrate, 0.1, \amp, 2] )  ;
~a1s24max.set(\modrate, 0.05);
~a1s24max.set(\rate, -1.0);

~a1s25max = Synth.new(\beacon_PlayBuf_Saw, [\bufnum, Beacon.buf[18], \modrate, 0.1, \amp, 2] )  ;
~a1s25max.set(\rate, -1.0);
~a1s25max.set(\modrate, 10);

(

// OSC functions Part 5

var o21status = 0;
var o22status = 0;

~o21 = OSCFunc (
	{
		arg msg, time, addr, recvPort;
		var maxspeed = 15;

		if ( msg[1] < 5, { o21status = 1;});
		if (
			msg[1] > 0 && o21status == 1,
			{
				/*~a1s21max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				~a1s22max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				~a1s23max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				~a1s24max.set(\room, 0.15 + Lag.kr(msg[1]/maxspeed) );
				["raw value: " ++ msg[1] ]. postln;
				["normalized value: " ++ Lag.kr(msg[1]/maxspeed) ]. postln;*/
			}
		);
	},
	'/speed', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

~o22 = OSCFunc (
	{
		arg msg, time, addr, recvPort;
		var maxerase = 100;
		if ( msg[1] > 95, { o22status = 1;});
		if (
			msg[1] > 0 && o22status == 1,
			{
				~a1s21max.set(\modrate, 10 *  Lag.kr( 1 - (msg[1]/maxerase) ) );
				~a1s22max.set(\modrate, 10 *  Lag.kr(1 - (msg[1]/maxerase) ) );
				~a1s23max.set(\modrate, 10 *  Lag.kr(1 - (msg[1]/maxerase) ) );
				~a1s24max.set(\modrate, 10 *  Lag.kr(1 - (msg[1]/maxerase) ) );
				~a1s25max.set(\modrate, 10 *  Lag.kr(1 - (msg[1]/maxerase) ) );

				/*~a1s21max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				~a1s22max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				~a1s23max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				~a1s24max.set(\mix, 0.0 + Lag.kr(msg[1]/maxerase) );
				["raw value: " ++ msg[1] ]. postln;
				["normalized value: " ++ Lag.kr(msg[1]/maxerase) ]. postln;*/

				/*~a1s21max.set(\room, 0.15 + Lag.kr(msg[1]/maxerase) );
				~a1s22max.set(\room, 0.15 + Lag.kr(msg[1]/maxerase) );
				~a1s23max.set(\room, 0.15 + Lag.kr(msg[1]/maxerase) );
				~a1s24max.set(\room, 0.15 + Lag.kr(msg[1]/maxerase) );*/
				["raw value: " ++ msg[1] ]. postln;
				["normalized value: " ++ Lag.kr(1 - (msg[1]/maxerase) ) ]. postln;

			}
		);
	},
	'/erase', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

~o23 = OSCFunc (
	{
		arg msg, time, addr, recvPort;
		if (
			msg[1] == 1,
			{
				~a1s21max.set(\rate, -1.0);
				~a1s22max.set(\rate, -1.0);
				~a1s23max.set(\rate, -1.0);
				~a1s24max.set(\rate, -1.0);
				~a1s25max.set(\rate, -1.0);
				["raw value: " ++ msg[1] ]. postln;
				["incoming value: " ++ msg[1]]. postln;
			},
			{
				~a1s21max.set(\rate, 1.0);
				~a1s22max.set(\rate, 1.0);
				~a1s23max.set(\rate, 1.0);
				~a1s24max.set(\rate, 1.0);
				~a1s25max.set(\rate, -1.0);
				["raw value: " ++ msg[1] ]. postln;
			}
		);
	},
	'/scroll', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

~o24 = OSCFunc (
	{
		arg msg, time, addr, recvPort;

		if (
			msg[1] == 1,
			{
				~a1s21max.set(\freq, 330);
				~a1s22max.set(\freq, 330);
				~a1s23max.set(\freq, 330);
				~a1s24max.set(\freq, 330);
				~a1s25max.set(\freq, 330);
				["[THIRDS] raw value: " ++ msg[1] ]. postln;
			},
			{
				~a1s21max.set(\freq, 440);
				~a1s22max.set(\freq, 440);
				~a1s23max.set(\freq, 440);
				~a1s24max.set(\freq, 440);
				~a1s25max.set(\freq, 440);
				["[THIRDS] raw value: " ++ msg[1] ]. postln;
			}
		);
	},
	'/thirds', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address

)


(
// Bye Part 4 (1/2)
~a1s11.set(\gate, 0 );
~a1s12max.set(\gate, 0 );
~a1s13max.set(\gate, 0 );
~a1s14max.set(\gate, 0 );
~a1s15max.set(\gate, 0 );
~a1s16max.set(\gate, 0 );
~a1s17max.set(\gate, 0 );
~o13.free;
~o14.free;
~o15.free;
~o16.free;
)

(
// Bye Part 4 (2/2)
~a1s18.set(\gate, 0 );
~a1s19max.set(\gate, 0 );
~a1s20.set(\gate, 0 );
~o17.free;
~o18.free;
~o19.free;
~o20.free;
)

// Bye Part 5

~a1s21max.set(\gate, 0 );

~a1s22max.set(\gate, 0 );

~a1s23max.set(\gate, 0 );

~a1s24max.set(\gate, 0 );

~a1s25max.set(\gate, 0 );

(
~o21.free;
~o22.free;
~o23.free;
~o24.free;
)

