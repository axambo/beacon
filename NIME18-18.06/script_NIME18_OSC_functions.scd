////////////////////////////////////////// PART 1 //////////////////////////////////////////////////
/////////////////////////////////////  TUNING DRONES /////////////////////////////////////////////

(
//OSC functions Part 1

var o11status = 0;
var o12status = 0;

~o1 = Array.new(2); // number of functions per section

~o1.add( OSCFunc (
{
arg msg, time, addr, recvPort;

if ( msg[1] > 0.9, { o11status = 1;} );

if (o11status == 1,
	{
		var pure = msg[1]; // quick test signal
		var mapping = Lag.kr(400 + (msg[1] * 400 ));
		["[DELAY_MIX] value to freq: " ++  (mapping )]. postln; // values get, LPF or pure
	    ~section1.do ( { |item, index|
			if ( index < (~section1.size) , {
			item.set(\freq, ( Lag.kr(400 + (msg[1] * 400 ))) );
			});
		});
	});
},
	'/delay_mix', // the osc message to which to respond [0..1]
nil ); // listen to osc messages that arrive from any ip address
);

~o1.add( OSCFunc (
{
arg msg, time, addr, recvPort;

if ( msg[1] < 50, { o12status = 1;} );

if (o12status == 1,
	{
		var pure = msg[1]; // quick test signal
		var mapping = Lag.kr(msg[1]/2000);
		("[ERASE] value to reverb: " ++ mapping). postln; // pure values
		~section1fx[0].set(\amount, mapping);
	});
},
	'/erase', // the osc message to which to respond [0..1]
nil ); // listen to osc messages that arrive from any ip address
);

)



////////////////////////////////////////// PART 2 //////////////////////////////////////////////////
//////////////////////////////////// LOCALIZED DRONES ////////////////////////////////////////////


(
//OSC functions Part 2

var o21status = 0;
var o22status = 0;
var o23status = 0;

~o2 = Array.new(3);  // number of functions per section

~o2.add( OSCFunc (
{
arg msg, time, addr, recvPort;

if ( msg[1] < 0.1, { o21status = 1;} );


if (o21status == 1,
 			{
				var pure = msg[1]; // quick test signal
				var mapping_1 = Lag.kr( 300 + (msg[1] * 300 ));
				var mapping_2 = Lag.kr(400 + (msg[1] * 400 ));
 				("[DELAY MIX] value to freq HPF: " ++ mapping_1). postln;
				("[DELAY MIX] value to freq LPF: " ++ mapping_2). postln;

 				~section2[0].set(\freq, mapping_1 );
 				~section2[1].set(\freq, mapping_1 );
 				~section2[2].set(\freq, mapping_2 );
 				~section2[3].set(\freq,  mapping_1 );
 		});
 	},
 	'/delay_mix', // the osc message to which to respond [0..1]
 	nil ); // listen to osc messages that arrive from any ip address
 );


~o2.add( OSCFunc (
{
arg msg, time, addr, recvPort;

if ( msg[1] < 50, { o22status = 1;} );

if (o22status == 1,
	{
		var pure = msg[1]; // quick test signal
		var mapping = Lag.kr(msg[1]/2000);
		("[ERASE] value to reverb: " ++ mapping). postln; // pure values
	    ~section2fx.do ( { |item, index|
			if ( index < (~section2fx.size) , {
			item.set(\amount, mapping);
			});
		});
	});
},
	'/erase', // the osc message to which to respond [0..1]
nil ); // listen to osc messages that arrive from any ip address
);


~o2.add( OSCFunc (
{
arg msg, time, addr, recvPort;

if ( msg[1] < 0.2, { o23status = 1;} );

if (o23status == 1,
	{
		var pure = msg[1]; // quick test signal
		//var mapping_1 = Lag.kr( (msg[1])*20 + 60 ); // onsets (1/2)
		//var mapping_2 = Lag.kr( (msg[1]) * 8 ); // onsets (2/2)
		var mapping_3 = Lag.kr(msg[1]/2);
		//("[COLOR] value to freq kicks: " ++ mapping_1). postln; // quick test signal
		//("[COLOR] value to freq rate kicks: " ++ mapping_2). postln; // quick test signal
		("[COLOR] value to freq rate kicks: " ++ mapping_3). postln; // quick test signal
		//~kicks.set(\freq, mapping_1); // onsets (1/2)
		//~kicks.set(\rate, mapping_2); // onsets (2/2)
		~kicks.set(\rate, mapping_3); // beat tracking
	});
},
	'/color', // the osc message to which to respond [0..1]
nil ); // listen to osc messages that arrive from any ip address
);


)

////////////////////////////////////////// PART 3 //////////////////////////////////////////////////
//////////////////////////////////// MACHINES & REVERBS //////////////////////////////////////////


(
//OSC functions Part 3

var o31status = 0;
var o32status = 0;
var o33status = 0;
var o34status = 0;

~o3 = Array.new(4);  // number of functions per section

~o3.add( OSCFunc (
{
arg msg, time, addr, recvPort;

if ( msg[1] < 0.1, { o31status = 1;} );

if (o31status == 1,
	{
		var pure = msg[1]; // quick test signal
		var mapping = msg[1] * 4;
		("[DELAY_MIX] value to trigvalue: " ++  mapping ).postln;
		~section3[1].set(\trigvalue,  mapping );
	});
},
	'/delay_mix', // the osc message to which to respond [0..1]
nil ); // listen to osc messages that arrive from any ip address
);

~o3.add( OSCFunc (
{
arg msg, time, addr, recvPort;

if ( msg[1] < 50 , { o32status = 1;} );

if (o32status == 1,
	{
		var pure = msg[1]; // quick test signal
		var mapping = Lag.kr(msg[1]/2000);
		("[ERASE] value to reverb: " ++ mapping). postln; // pure values
		~section3fx[0].set(\amount, mapping);

	});
},
'/erase', // the osc message to which to respond [0..100]
nil ); // listen to osc messages that arrive from any ip address
);

~o3.add( OSCFunc (
{
arg msg, time, addr, recvPort;

if ( msg[1] < 0.1, { o33status = 1;} );

if (o33status == 1,
	{
		var pure = msg[1]; // quick test signal
		var mapping = msg[1] * 8;
		("[DELAY_MIX] value to trigvalue: " ++  mapping ).postln;
		~section3[3].set(\trigvalue, mapping);
	});
},
	'/color', // the osc message to which to respond [0..1]
nil ); // listen to osc messages that arrive from any ip address
);


~o3.add( OSCFunc (
{
arg msg, time, addr, recvPort;

if ( msg[1] < 8, { o34status = 1;} );

if (o34status == 1,
	{
		var pure = msg[1]; // quick test signal
		("[SPEED] RAW value: " ++  msg[1] ).postln;
		if ( msg[1] < 8, {
			~section3[1].set(\rate,  -1.0 );
			("[SPEED] value mapped to reversed speed audio: " ++  msg[1] ).postln;
				}
			, {
			~section3[1].set(\rate, 1.0 );
			("[SPEED] value mapped to normal speed audio: " ++  msg[1] ).postln;
			}
		);

	});
},
	'/speed', // the osc message to which to respond [0..1]
nil ); // listen to osc messages that arrive from any ip address
);



)

////////////////////////////////////////// PART 4 //////////////////////////////////////////////////
///////////////////////////////////// ALARMS & INDUSTRY //////////////////////////////////////////


(
var o41status = 0;
var o42status = 0;
var o43status = 0;

~o4 = Array.new(3); // number of functions per section

~o4.add ( OSCFunc (
	{
		arg msg, time, addr, recvPort;
		var maxspeed = 15;

		if ( msg[1] < 0.1, { o41status = 1;});
		if (
			o41status == 1,
			{
				var pure = msg[1]; // quick test signal
				//var mapping_1 = (msg[1] * 2) - 1;
				var mapping_1 = msg[1] * 200;
				//var mapping_2 = Lag.kr(mapping_1);
				//["[DELAY_MIX] value to trigger mapping_1 (-1:1): " ++ mapping_1 ].postln;
				["[DELAY_MIX] value to trigger mapping_1: " ++ mapping_1 ].postln;
				//["[DELAY_MIX] value to modrate mapping_2 (-1:1): " ++ mapping_2 ].postln;
				/*~section4.do ( { |item, index|
					if ( (index > 1) && (index < (~section4.size - 1)) , {
						item.set(\trigger, mapping_1);
					});
				});*/
				~section4[0].set(\trigger, mapping_1);
				~section4[1].set(\trigger, mapping_1);
				~section4[2].set(\trigger, mapping_1);

				//~section4[0].set(\modrate, mapping_2);

			}
		);
	},
	'/delay_mix', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address
);

~o4.add ( OSCFunc (
	{
		arg msg, time, addr, recvPort;

		if ( msg[1] < 50, { o42status = 1} );

		if (
			o42status == 1,
			{

				var pure = msg[1]; // quick test signal
				//var mapping = Lag.kr(msg[1]/50 - 1) ; // interesting serendipity
				var mapping = Lag.kr(msg[1]/2000);
				("[ERASE] value to reverb: " ++ mapping). postln; // pure values
				~section4fx[0].set(\amount, mapping);
				//~section4[3].set(\modrate,  ( Lag.kr(msg[1]/50 - 1)) );
			}
		);
	},
	'/erase', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address
);

~o4.add(OSCFunc (
{
arg msg, time, addr, recvPort;

if ( msg[1] < 8, { o43status = 1;} );

if (o43status == 1,
	{

				var pure = msg[1]; // quick test signal
				var mapping = (msg[1]/11);
				("[SPEED] value to rate (1 sound): " ++ mapping). postln; // pure values
				~section4[3].set(\rate, mapping);
	});
},
	'/speed', // the osc message to which to respond [0..1]
nil ); // listen to osc messages that arrive from any ip address
);

)

(
// OSC functions Part 4 (2/2)

var o4b1status = 0;
var o4b2status = 0;
var o4b3status = 0;

~o4b = Array.new(3); // number of functions per section


~o4b.add( OSCFunc (
{
arg msg, time, addr, recvPort;

if ( msg[1] > 0.9, { o4b1status = 1;} );

if (o4b1status == 1,
	{
		var pure = msg[1]; // quick test signal
		var mapping = Lag.kr(440 + (msg[1] * 400 ));
		["[DELAY_MIX] value to freq: " ++  (mapping )]. postln; // values get, LPF or pure
	    ~section4b.do ( { |item, index|
			if ( index < (~section4b.size) , {
			item.set(\freq, mapping );
			});
		});
	});
},
	'/delay_mix', // the osc message to which to respond [0..1]
nil ); // listen to osc messages that arrive from any ip address
);

~o4b.add ( OSCFunc (
	{
		arg msg, time, addr, recvPort;

		if ( msg[1] < 50, { o4b2status = 1} );

		if (
			o4b2status == 1,
			{

				var pure = msg[1]; // quick test signal
				var mapping = Lag.kr(msg[1]/2000);
				("[ERASE] value to reverb: " ++ mapping). postln; // pure values
				~section4bfx.do ( { |item, index|
					if ( index < (~section4b.size) , {
						item.set(\amount, mapping );
					});
				});
			}
		);
	},
	'/erase', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address
);

)


////////////////////////////////////////// PART 5 //////////////////////////////////////////////////
//////////////////////////////// OLD MACHINES & BEACONS /////////////////////////////////////////

(

// OSC functions Part 5

var o51status = 0;
var o52status = 0;
var o53status = 0;

~o5 = Array.new(3);

~o5.add ( OSCFunc (
	{
		arg msg, time, addr, recvPort;

		if ( msg[1] < 0.2, { o51status = 1;});

		if (
			o51status == 1,
			{
				["[DELAY_MIX] RAW value: " ++ msg[1] ]. postln;
				~section5.do ( { |item, index|
					if ( index < (~section5.size) , {
						item.set(\freq, ( Lag.kr(400 + (msg[1] * 200 ))) );
						item.set(\modrate, msg[1] * 100 );
					});

		});
			}
		);
	},
	//remove it
	'/delay_mix', // the osc message to which to respond
nil ); // listen to osc messages that arrive from any ip address
);

~o5.add ( OSCFunc (
	{
		arg msg, time, addr, recvPort;

		if ( msg[1] < 25 , { o52status = 1;});
		if (
			o52status == 1,
			{
				var pure = msg[1]; // quick test signal
				var mapping = Lag.kr(msg[1]/2000);
				("[ERASE] value to reverb: " ++ mapping). postln; // pure values

				~section5fx.do ( { |item, index|
					if ( index < (~section5fx.size) , {
						item.set(\amount,  mapping );
					});
				});

			}
		);
	},
	'/erase', // the osc message to which to respond
	nil ); // listen to osc messages that arrive from any ip address
);


)


)

