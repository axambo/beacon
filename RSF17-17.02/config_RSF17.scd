//////////////////////////////////////////  CONFIG  //////////////////////////////////////////

//// Configure # speakers

/*o = Server.default.options;
o.numInputBusChannels;
o.numOutputBusChannels;

o.numInputBusChannels = 16;
o.numOutputBusChannels = 16;
s.reboot;*/

// For the concert Root Signals Festival:
(
o = Server.default.options;
o.numOutputBusChannels = 16;
s.reboot;
)

(
// make a window and embed a ServerMeterView inside of it.
w = Window.new("Server Levels");
ServerMeterView.new(s, w, 0@0, 0, 16);
w.front; // show the window
v = s.volume;
/*v.min;
v.max;
v.volume = rrand(-50, 5);
v.setVolumeRange(-90, 8);
v.mute;
v.unmute;*/
v.gui;
)

/*
Quick test for the 8 channels
*/
//{Out.ar(0, 0.1*SinOsc.ar)}.play;
//{Out.ar(1, 0.1*SinOsc.ar)}.play;
// for some reason, with the MOTU 828mkII audio interface 0-3 buses are occupied, the individual channels start to work from bus #2:
{Out.ar(0, 0.1*PinkNoise.ar)}.play;
{Out.ar(1, 0.1*PinkNoise.ar)}.play;
{Out.ar(2, 0.1*PinkNoise.ar)}.play;
{Out.ar(3, 0.1*PinkNoise.ar)}.play;
{Out.ar(4, 0.1*PinkNoise.ar)}.play;
{Out.ar(5, 0.1*PinkNoise.ar)}.play;
{Out.ar(6, 0.1*PinkNoise.ar)}.play;
{Out.ar(7, 0.1*PinkNoise.ar)}.play;

{Out.ar(LFNoise0.ar(16,6),SinOsc.ar(LFNoise0.ar(16,200,100)))}.play

{Out.ar(LFNoise0.ar(4,4),SinOsc.ar(LFNoise0.ar(4,4)))}.play

{Out.ar(LFNoise0.ar(8,4),LFNoise0.ar(Prand([200,110,220,130,240,150,260,170],inf).asStream))}.play

//Signal.rand2(10, 1.0).postln;


//// Configure client OSC

NetAddr.localAddr;
//n= NetAddr.localAddr;
//n = NetAddr.new("127.0 0.1", 57110);    // create the NetAddr
//n = NetAddr.new(nil, nil);
// If machine with MaxMSP is different, the MaxMSP should be sending to the SC ip address. Recommended to create an own wifi network, otherwise the required ports can be already in use.

//////////////////////////////////////////  TESTS  //////////////////////////////////////////

//// Speakers - visible and audible test


//// Messages OSC

// Test that gets messages from everywhere
OSCFunc.trace(true);
OSCFunc.trace(false);

/*(
f = { |msg, time, addr|
	//if(msg[0] == '/speed' {
        //"message: %\n".postf(msg);
    //});
};
thisProcess.addOSCRecvFunc(f);
);*/


//// Messages from Max

// Test that gets filtered messages e.g. speed
(
o = OSCFunc (
	{
		arg msg, time, addr, recvPort;
		[msg, time, addr, recvPort].postln;
		msg[0].postln; // name
		msg[1].postln; // value
	},
	'/erase', n);
)

o.free;    // remove the OSCFunc when you are done.

/*// Test that messages are filtered by value
(
f = { |msg, time, addr|
    if(msg[0] != '/status.reply') {
        "time: % sender: %\nmessage: %\n".postf(time, addr, msg);
    };
	if(msg[0] == '/speed') {
		"message: %\n".postf(msg);
    };
};
thisProcess.addOSCRecvFunc(f);
)
// stop posting.
thisProcess.removeOSCRecvFunc(f);*/


