Beacon {

	classvar <>server, <>buf, <>idspk;
	//classvar <>allPlaying;
	var directory, filenames;
	var iter, j, k;
	classvar <numspeakers, spkbufnums, offsetspknum, ispk, <pairs, <evenodds, <circular;

	*new {arg numnodes = 2, offset = 0;
		^super.new.init(numnodes, offset);
	}

		init {arg numnodes, offset;

		server = Server.local;
		Server.default = server;
		server.boot;

		// Change numspeakers depending on setup
		numspeakers = numnodes;
		// Change offset speaker number depending on where the first speaker starts from the audio interface
		offsetspknum = offset;

		//this.mapSpeakersStereo(numspeakers, offsetspknum);
		//this.mapSpeakersPairs(numspeakers, offsetspknum);


		pairs = List.new;
		4.do{ pairs.add(List.new)}; // for 16 speakers, it should loop 8 times

		evenodds = List.new;
		2.do{ evenodds.add(List.new) }; // for 16 speakers, it should loop 8 times

		switch (numspeakers,
			2, {
				pairs[0] = [0+offsetspknum, 1+offsetspknum]; pairs[1] = [0+offsetspknum, 1+offsetspknum]; pairs[2] = [0+offsetspknum, 1+offsetspknum]; pairs[3] = [0+offsetspknum, 1+offsetspknum];
				evenodds[0] = [0+offsetspknum]; evenodds[1] = [1+offsetspknum];
			},
			4, {
				pairs[0] = [0+offsetspknum, 3+offsetspknum]; pairs[1] = [1+offsetspknum, 2+offsetspknum]; pairs[2] = [0+offsetspknum, 3+offsetspknum]; pairs[3] = [1+offsetspknum, 2+offsetspknum];
				evenodds[0] = [0+offsetspknum, 2+offsetspknum]; evenodds[1] = [1+offsetspknum, 3+offsetspknum];
			},
			8, {
				pairs[0] = [0+offsetspknum, 7+offsetspknum]; pairs[1] = [1+offsetspknum, 6+offsetspknum]; pairs[2] = [2+offsetspknum, 5+offsetspknum]; pairs[3] = [3+offsetspknum, 4+offsetspknum];
				evenodds[0] = [0+offsetspknum, 2+offsetspknum, 4+offsetspknum, 6+offsetspknum]; evenodds[1] = [1+offsetspknum, 3+offsetspknum, 5+offsetspknum, 7+offsetspknum];
			}
		);

		server.waitForBoot {

			// Just one bus output as an input parameter, it works as an example
			/*SynthDef(\beacon_PlayBuf, { | out = 0, amp = 1, bufnum = 0, rate = 1, da = 2, loop = 1, gate = 1 |
				var sig, env;
				env = EnvGen.kr(Env.asr(20.0,2.0,20.0, 'sine'), gate, doneAction:2);
				sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum) * rate, doneAction:da, loop: loop);
				sig = sig * amp;
				Out.ar(out, sig * env);
			}).add;*/

			// Pairing mode: 1st pair of speakers
			SynthDef(\beacon_PlayBuf_pair1, { | amp = 1, bufnum = 0, rate = 1, da = 2, loop = 1, gate = 1, mix = 0.25, room= 0.15, damp = 0.5, freq = 440 |
				var sig, env, out;
				env = EnvGen.kr(Env.asr(20.0,2.0,20.0, 'sine'), gate, doneAction:2);
				sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum) * rate, doneAction:da, loop: loop);
				sig = sig * amp;
				sig = FreeVerb.ar(sig, mix, room, damp, amp);
				sig = RLPF.ar(sig, freq);
				out = pairs[0];
				Out.ar(out, sig * env);
			}).add;

			// Pairing mode: 2nd pair of speakers
			SynthDef(\beacon_PlayBuf_pair2, { | amp = 1, bufnum = 0, rate = 1, da = 2, loop = 1, gate = 1, mix = 0.25, room= 0.15, damp = 0.5, freq = 440 |
				var sig, env, out;
				env = EnvGen.kr(Env.asr(20.0,2.0,20.0, 'sine'), gate, doneAction:2);
				sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum) * rate, doneAction:da, loop: loop);
				sig = sig * amp;
				sig = FreeVerb.ar(sig, mix, room, damp, amp);
				sig = RLPF.ar(sig, freq);
				out = pairs[1];
				Out.ar(out, sig * env);
			}).add;

			// Pairing mode: 3rd pair of speakers
			SynthDef(\beacon_PlayBuf_pair3, { | amp = 1, bufnum = 0, rate = 1, da = 2, loop = 1, gate = 1, mix = 0.25, room= 0.15, damp = 0.5, freq = 440 |
				var sig, env, out;
				env = EnvGen.kr(Env.asr(20.0,2.0,20.0, 'sine'), gate, doneAction:2);
				sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum) * rate, doneAction:da, loop: loop);
				sig = sig * amp;
				sig = FreeVerb.ar(sig, mix, room, damp, amp);
				sig = RLPF.ar(sig, freq);
				out = pairs[2];
				Out.ar(out, sig * env);
			}).add;

			// Pairing mode: 4th pair of speakers
			SynthDef(\beacon_PlayBuf_pair4, { | amp = 1, bufnum = 0, rate = 1, da = 2, loop = 1, gate = 1, mix = 0.25, room= 0.15, damp = 0.5, freq = 440 |
				var sig, env, out;
				env = EnvGen.kr(Env.asr(20.0,2.0,20.0, 'sine'), gate, doneAction:2);
				sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum) * rate, doneAction:da, loop: loop);
				sig = sig * amp;
				sig = FreeVerb.ar(sig, mix, room, damp, amp);
				sig = RLPF.ar(sig, freq);
				out = pairs[3];
				Out.ar(out, sig * env);
			}).add;

			// EvenOdds mode: even speakers
			SynthDef(\beacon_PlayBuf_even, { | amp = 1, bufnum = 0, rate = 1, da = 2, loop = 1, gate = 1, mix = 0.25, room= 0.15, damp = 0.5, freq = 440 |
				var sig, env, out;
				env = EnvGen.kr(Env.asr(20.0,2.0,20.0, 'sine'), gate, doneAction:2);
				sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum) * rate, doneAction:da, loop: loop);
				sig = sig * amp;
				sig = FreeVerb.ar(sig, mix, room, damp, amp);
				sig = RLPF.ar(sig, freq);
				out = evenodds[0];
				Out.ar(out, sig * env);
			}).add;

			// EvenOdds mode: odds speakers
			SynthDef(\beacon_PlayBuf_odds, { | amp = 1, bufnum = 0, rate = 1, da = 2, loop = 1, gate = 1, mix = 0.25, room= 0.15, damp = 0.5, freq = 440 |
				var sig, env, out;
				env = EnvGen.kr(Env.asr(20.0,2.0,20.0, 'sine'), gate, doneAction:2);
				sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum) * rate, doneAction:da, loop: loop);
				sig = sig * amp;
				sig = FreeVerb.ar(sig, mix, room, damp, amp);
				sig = RLPF.ar(sig, freq);
				out = evenodds[1];
				Out.ar(out, sig * env);
			}).add;

			// Random mode: random speaker at a trigger that equals to the end of the buffer
			SynthDef(\beacon_PlayBuf_random_speaker, { | amp = 1, rate = 1, da = 2, loop = 1, gate = 1, bufnum = 0, trigrate = 1, mix = 0.25, room= 0.15, damp = 0.5, freq = 440 |
				var sig, env, out, trig, lo, hi, min, max;
				min = 0 + offsetspknum;
				max = numspeakers + offsetspknum;
				lo = \lo.kr(min);
				hi = \hi.kr(max);
				trig = Impulse.kr(BufDur.kr(bufnum).reciprocal);
				env = EnvGen.kr(Env.asr(20.0,2.0,20.0, 'sine'), gate, doneAction:2);
				sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum) * rate, doneAction: da, loop: loop);
				sig = sig * amp;
				sig = FreeVerb.ar(sig, mix, room, damp, amp);
				sig = RLPF.ar(sig, freq);
				out = TRand.kr(lo, hi, trig);
				Out.ar(out, sig * env);
			}).add;

			// Random mode: random speaker and random buf at a certain trigger
			/*SynthDef(\beacon_PlayBuf_random_speaker_buf, { | amp = 1, rate = 1, da = 2, loop = 1, gate = 1, triggerate = 10, bufnum = 0 |
				var sig, env, out, trig, min, max, buftmp, buf, min, max, lo, hi;
				min = 0 + offsetspknum;
				max = numspeakers + offsetspknum;
				lo = \lo.kr(min);
				hi = \hi.kr(max);
			    buftmp = bufnum;
				trig = Impulse.kr(BufDur.kr(buftmp).reciprocal);
				env = EnvGen.kr(Env.asr(4.0,0.5,2.9), gate, doneAction:2);
				sig = PlayBuf.ar(1, buftmp, rate, doneAction:da, loop: loop);
				sig = sig * amp;
				out = TRand.kr(lo, hi, trig);
		        buf = TRand.kr(10, 12, trig);
				Out.ar(out, sig * env);
			}).add;*/



			SynthDef(\beacon_PlayBuf_Saw, { | out = 0, amp = 1, bufnum = 0, rate = 1, da = 2, loop = 1, gate = 1, modrate = 100, mix = 0.25, room= 0.15, damp = 0.5, freq = 440 |
				var sig, env, mod, maxbufnum, offset;
				maxbufnum =  numspeakers + offsetspknum;
				offset = offsetspknum + 0.5;
				//offset = 0.5;
				mod = Saw.kr(freq: modrate, mul: maxbufnum, add: offset);
				env = EnvGen.kr(Env.asr(20.0,2.0,20.0, 'sine'), gate, doneAction:2);
				sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum) * rate, doneAction:da, loop: loop);
				sig = sig * amp;
				sig = FreeVerb.ar(sig, mix, room, damp, amp);
				sig = RLPF.ar(sig, freq);
				Out.ar(mod, sig * env);
			}).add;

			// Change directory path depending on where the audio samples are
			directory = "/Users/annaxambo/Documents/**Postdoc Projects**/Ongoing/Root Signals Festival/Sounds/Normalized_mono/";

		// Change audio files depending on the performance
		filenames = Dictionary.new;
			filenames = [
				"367489.wav",
				"195969.wav", "367632.wav", "369242.wav", "368256.wav",
				"369240.wav", "133048.wav", "336333.wav", "250760.wav", "92739.wav",
				"33781.wav", "331155.wav", "333859.wav", "367538.wav",
				"105210.wav", "133033.wav", "244688.wav", "268077.wav",
				"380788.wav"
			];

		buf = Dictionary.new;
		filenames.size.do { |i|
			buf[i] = Buffer.read(server, directory +/+ filenames[i]);
		};
		};

	}



}	