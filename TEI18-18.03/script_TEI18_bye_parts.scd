
////////////////////////////////////////// PART 1 //////////////////////////////////////////////////
/////////////////////////////////////  TUNING DRONES /////////////////////////////////////////////

( // Bye to Part 1 (1 of 2)
~section1.do ( { |item, index|
	if ( index < (~section1.size) , {
		item.set(\gate, 0);
	});
});
)


( // Bye to Part 1 (2 of 2) -- leave until the very end (complete silence!) to avoid artifacts

 ~section1fx.do ( { |item, index|
 	if ( index < (~section1fx.size) , {
 		item.free;
 	});
 });
)

(

~o1.do ( { |item, index|
	if ( index < (~o1.size) , {
		item.free;
	});
});

)

////////////////////////////////////////// PART 2 //////////////////////////////////////////////////
//////////////////////////////////// LOCALIZED DRONES ////////////////////////////////////////////


( // Bye to Part 2
~section2.do ( { |item, index|
	if ( index < (~section2.size) , {
		item.set(\gate, 0);
		if(index == 4, {item.free});
	});
});

~o2.do ( { |item, index|
	if ( index < (~o2.size) , {
		item.free;
	});
});

)

// manually volume down..

~kicks.set(\da, 2);

//wait

(
~section2fx.do ( { |item, index|
	if ( index < (~section2fx.size) , {
	item.set(\amount, 0);
	});
});
)

//wait until silence (otherwise reverb) !!!


// only if kicks is still playing...

~kicks.free;




////////////////////////////////////////// PART 3 //////////////////////////////////////////////////
//////////////////////////////////// MACHINES & REVERBS //////////////////////////////////////////


( // Bye Part 3
~section3.do ( { |item, index|
	if ( index < (~section3.size) , {
		item.set(\gate, 0);
	});
});

~section3fx.do ( { |item, index|
	if ( index < (~section3fx.size) , {
	item.set(\amount, 0);
	});
});


~o3.do ( { |item, index|
	if ( index < (~o3.size) , {
		item.free;
	});
});

)



////////////////////////////////////////// PART 4 //////////////////////////////////////////////////
///////////////////////////////////// ALARMS & INDUSTRY //////////////////////////////////////////


(
// Bye Part 4 (1/2)
~section4.do ( { |item, index|
	if ( index < (~section4.size) , {
		item.set(\gate, 0);
	});
});

~section4fx.do ( { |item, index|
	if ( index < (~section4fx.size) , {
	item.set(\amount, 0);
	});
});

~o4.do ( { |item, index|
	if ( index < (~o4.size) , {
		item.free;
	});
});
)

// MIRLC -- free

~directin.set(\gate, 0);
~directin.free;

(
// Bye Part 4 (2/2)
~section4b.do ( { |item, index|
	if ( index < (~section4b.size) , {
		item.set(\gate, 0);
	});
});

~section4bfx.do ( { |item, index|
	if ( index < (~section4bfx.size) , {
	item.set(\amount, 0);
	});
});

~o4b.do ( { |item, index|
	if ( index < (~o4b.size) , {
		item.free;
	});
});
)




////////////////////////////////////////// PART 5 //////////////////////////////////////////////////
//////////////////////////////// OLD MACHINES & BEACONS /////////////////////////////////////////


// Bye Part 5

~section5[0].set(\gate, 0 );

~section5[1].set(\gate, 0 );

~section5[2].set(\gate, 0 );

~section5[3].set(\gate, 0 );

~section5[4].set(\gate, 0 );

~noisein.set(\doneAction, 2) // fer que funcioni
~noisein.free;
~purein.set(\gate, 0);
~purein.free;

(
~o5.do ( { |item, index|
	if ( index < (~o5.size) , {
		item.free;
	});
});
)
