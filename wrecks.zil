"WRECKS for TOA2
 Copyright (c) 1984 Infocom, Inc."

<ROOM UNDERWATER
      (IN ROOMS)
      (DESC "Underwater")
      (FLAGS RLANDBIT)
      (GLOBAL OCEAN)
      (UP PER UNDERWATER-U)
      (DOWN PER UNDERWATER-D)
      (ACTION UNDERWATER-F)
      (LINE 6)>

<ROUTINE UNDERWATER-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<FCLEAR ,UNDERWATER ,TOUCHBIT>
		<COND (<AND <IN? ,SHARK ,LOCAL-GLOBALS>
			    <NOT <QUEUED? I-SHARK>>>
		       <ENABLE <QUEUE I-SHARK <RANDOM
					       <- </ ,OCEAN-BOTTOM 50> 1>>>>)>
		<MOVE ,LINE-HACK ,UNDERWATER>
		<RFALSE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are in the sea, completely surrounded by water." CR>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<EQUAL? ,LINE-HACK ,PRSO ,PRSI>
		       <TELL-CANT-REACH
"the line. Worry about it when you've found the treasure">)
		      (<AND <VERB? WALK>
			    <NOT <EQUAL? ,P-WALK-DIR ,P?UP ,P?DOWN>>>
		       <TELL-NOWHERE>)
		      (<VERB? WALK DIVE SWIM LOOK EXAMINE SAVE RESTORE QUIT
			      SCORE TIME FIND DIAGNOSE LAMP-ON LAMP-OFF OPEN
			      CLOSE TAKE READ BREATHE WAIT INVENTORY VERSION
			      AGAIN WHAT SCRIPT UNSCRIPT RESTART $CALL>
		       <RFALSE>)
		      (<VERB? DROP THROW>
		       <TELL-NO-LITTER>)
		      ;(<VERB? LOOK-UP>
		       <TELL "You see water." CR>)
		      (T
		       <TELL-YOU-CANT "do that underwater.">
		       <RFATAL>)>)>>

<ROUTINE TELL-NOWHERE ()
	 <TELL "That won't get you anywhere." CR>>

<ROUTINE UNDERWATER-U ("OPTIONAL" (PRINT? T) "AUX" L)
	 <COND (<NOT .PRINT?>
		<RFALSE>)>
	 <SETG DEPTH <- ,DEPTH 50>>
	 <COND (<AND <NOT <IN? ,SAFETY-LINE <SET L <LOC ,WEASEL>>>>
		     <NOT <IN? ,TREASURE-CHEST .L>>
		     <NOT <IN? ,EMPTY-CHEST .L>>>
		<FCLEAR ,LINE-HACK ,INVISIBLE>)>
	 <COND (<==? ,DEPTH 0>
		<TELL "You get out of the water and reboard your ship..." CR CR>		
		<DISABLE <INT I-AIR-SUPPLY>>
		<COND (<ENABLED? I-LAST-GASP>
		       <DISABLE <INT I-LAST-GASP>>)
		      (T <DISABLE <INT I-MM-COMPRESSOR>>)>
		<COND (<OR <FSET? ,OCEAN-FLOOR ,TOUCHBIT>
			   <FSET? ,WRECK-1 ,TOUCHBIT>>
		       <RATING-UPD 25>
		       <COND (<OR <IN? ,SAFETY-LINE ,TREASURE-CHEST>
				  <AND <IN? ,GLASS-CASE ,PLAYER>
				       <NOT <FSET? ,STAMPS ,RMUNGBIT>>>>
			      <RATING-UPD 25>
			      <COND (<IN? ,TREASURE-CHEST <LOC, WEASEL>>
				     <TREASURE-CHEST-WIN>)
				    (<IN? ,SAFETY-LINE ,TREASURE-CHEST>
				     <CHEST-PULL-UP>
				     <TREASURE-CHEST-WIN>)
				    (T <TELL
"When your shipmates find that you've recovered these priceless stamps, they
congratulate you. ">)>
			      <COND (<OR ,WEASEL-BLOWN
					 <FSET? ,ENVELOPE ,INVISIBLE>>
				     <TELL
"Johnny slaps you on the back. \"Good job, matey!\" As you return to the
island over the calm, dazzling blue sea, you contemplate your wealth with a
touch of sadness. You think of Hevlin and hope his soul is resting a little
easier now." CR CR>
				     <RATING-UPD 20>
				     <V-SCORE>
			      	     <USL>
			      	     <QUIT>)
				    (T
				     <TELL
"Exhilarated but tired, you lie out on the deck. You fall asleep at once,
and dream of a tropical paradise. But even as you dream, your throat is
cut! And as your life drains away, you realize how foolish it was not to
have suspected a traitor!" CR>
				     <FINISH>)>)
			     (<AND <IN? ,GLASS-CASE ,PLAYER>
				   <FSET? ,STAMPS ,RMUNGBIT>>
			      <TELL
"But their elation turns to disappointment, as they notice that the
stamps are waterlogged and, thus, worthless">
			      <LONG-TRIP>)
			     (<IN? ,EMPTY-CHEST <LOC ,WEASEL>>
			      <EMPTY-CHEST-LOSE>)
			     (<IN? ,SAFETY-LINE ,EMPTY-CHEST>
			      <CHEST-PULL-UP>
			      <EMPTY-CHEST-LOSE>)
			     (T
			      <TELL
"When your shipmates find out that you haven't found any treasure,
Johnny shakes his head. You can't help feeling you've let them, as well as
" D ,GLOBAL-SELF ", down">
			      <LONG-TRIP>)>)
		      (<AND ,AT-SEA ;,MOMENT-OF-TRUTH <G? ,PRESENT-TIME 720>>
		       <TELL
"Johnny looks downcast when he sees that you empty-handed. \"Let's get back
to the Island. Maybe another time...\"" CR>
		       <FINISH>)
		      (<==? ,SHIP-CHOSEN ,TRAWLER>
		       <FSET ,OCEAN ,VEHBIT>
		       <MOVE ,LINE-HACK ,NW-AFT-DECK>
		       <RETURN ,NW-AFT-DECK>)
	       	      (T
		       <FSET ,OCEAN ,VEHBIT>
		       <MOVE ,LINE-HACK ,MM-AFT-DECK>
		       <RETURN ,MM-AFT-DECK>)>)
	       (T
		<TELL "You ascend ">
		<COND (<==? ,HERE ,UNDERWATER>
		       <TELL "another ">)>
		<TELL "50 feet..." CR CR>
	        <COND (<AND ,DOOMED <==? ,DEPTH 250>>
		       <JIGS-UP
"You suddenly find yourself inhaling water! The airhose trailing behind
must have torn, and there's no time to do anything about it!">)
		      (T <RETURN ,UNDERWATER>)>)>>

<ROUTINE CHEST-PULL-UP ()
	 <COND (<EQUAL? <LOC ,WEASEL> ,MM-AFT-DECK ,NW-AFT-DECK>
		<START-SENTENCE ,WEASEL>)
	       (T <START-SENTENCE ,JOHNNY>)>
	 <TELL " pulls on the " D ,SAFETY-LINE " and drags up the chest. ">>

<ROUTINE EMPTY-CHEST-LOSE ()
	 <TELL-1ST-CHEST-LINE>
	 <TELL
"disappointment, the contents are nothing more than old Portuguese
newspapers">
	 <LONG-TRIP>>

<ROUTINE TELL-1ST-CHEST-LINE ()
	 <TELL
"Johnny spends several minutes forcing open the chest. To everyone's ">>

<ROUTINE LONG-TRIP ()
	 <TELL ". It will be a long trip back." CR>
	 <FINISH>>

<ROUTINE TREASURE-CHEST-WIN ()
	 <TELL-1ST-CHEST-LINE>
	 <TELL
"delight, there are hundreds of gold escudos inside. ">>

<ROUTINE UNDERWATER-D ("OPTIONAL" (PRINT? T))
	 <COND (<NOT .PRINT?>
		<RFALSE>)>
	 <SETG DEPTH <+ ,DEPTH 50>>
	 <COND (<AND <G? ,DEPTH 300>
		     <NOT <FSET? ,DEEP-SUIT ,WORNBIT>>>
		<JIGS-UP
"As you descend further, Merv Griffin swims by, offering you Pittsburgh
Penguin tickets. You realize too late that this is a hallucination, since
Merv doesn't even like the Penguins. At this depth, narcosis takes over,
and all that's left is to say bye to Merv...">)
	       (<==? ,DEPTH ,OCEAN-BOTTOM>
		<COND (,WRECK-CHOSEN
		       <TELL
"The yellow beam from your light settles on a huge jagged outcropping of
rusted metal and barnacles. As you angle your light downward, you can
barely make out the shape of a monstrous corroded hull, partly buried in
the silt from its decades of slumber on the floor of the ocean." CR CR>
		       <RETURN ,WRECK-1>)
		      (T
		       <TELL "You flutter down to the ocean floor..." CR CR>
		       <RETURN ,OCEAN-FLOOR>)>)
	       (T
		<TELL "You descend another 50 feet..." CR CR>
		<RETURN ,UNDERWATER>)>>

<GLOBAL OCEAN-BOTTOM 400>
<GLOBAL DEPTH 0>

<OBJECT SHARK
	(IN LOCAL-GLOBALS)
	(DESC "shark")
	(SYNONYM SHARK FISH)
	(ADJECTIVE UGLY LARGE BIG HUGE TOOTHY)
	(FLAGS NDESCBIT)
	(TEXT
"The large, ugly, toothy shark is headed toward you!")>

<ROOM OCEAN-FLOOR
      (IN ROOMS)
      (DESC "Ocean Floor")
      (LDESC 
"You are on the ocean floor. Sediment and seaweed wave slowly with the
current.")
      (GLOBAL OCEAN)
      (FLAGS RLANDBIT)
      (LINE 6)
      (UP PER UNDERWATER-U)
      (ACTION OCEAN-FLOOR-F)>

<ROUTINE OCEAN-FLOOR-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-BEG>
		<COND (<AND <VERB? WALK>
			    <NOT <==? ,P-WALK-DIR ,P?UP>>>
		       <TELL-NOWHERE>)>)>>
<ROOM WRECK-1
      (IN ROOMS)
      (DESC "Top Deck")
      (FLAGS RLANDBIT)
      (GLOBAL SHIPWRECK OCEAN DECK WEST-LADDER FLOOR-HOLE-1 FLOOR-HOLE-2 MAST)
      (VALUE 20)
      (UP PER UNDERWATER-U)
      (SOUTH TO WRECK-2)
      (DOWN PER WRECK-1-D)
      (DESCFCN 0);"metal content"
      (LINE 6)
      (ACTION WRECK-1-F)>

<ROUTINE WRECK-1-F (RARG)
	 <COND (<==? .RARG ,M-ENTER>
		<COND (<NOT <FSET? ,WRECK-1 ,TOUCHBIT>>
		       <FSET ,LINE-HACK ,INVISIBLE>
		       <COND (<==? ,WRECK-CHOSEN 1>
			      ;<ENABLE <QUEUE I-PENDULUM -1>>
			      <MOVE ,SQUID ,WRECK-12>
			      <MOVE ,IRON-BAR ,WRECK-5>
			      <COND (<==? ,WRECK-FOUND 1>
				     <MOVE ,TREASURE-CHEST ,WRECK-11>
			      	     <MOVE ,EMPTY-CHEST ,WRECK-9>)>
			      <MOVE ,SKELETON ,WRECK-10>
			      <MOVE ,SCABBARD ,SKELETON>
			      <PUTP ,WRECK-8 ,P?VALUE 10>
			      ;<PUTP ,WRECK-16 ,P?VALUE 10>
			      ;<PUTP ,WRECK-3 ,P?VALUE 20>
			      <FCLEAR ,CEILING-HOLE-1 ,INVISIBLE>
			      <FCLEAR ,FLOOR-HOLE-1 ,INVISIBLE>
			      <MOVE ,CASK ,WRECK-6>
			      <MOVE ,ROPE ,WRECK-4>
			      <MOVE ,BROKEN-MAST ,WRECK-4>
			      <PUTP ,WRECK-5 ,P?DESCFCN 80>
			      <PUTP ,WRECK-7 ,P?DESCFCN 45>
			      <PUTP ,WRECK-8 ,P?DESCFCN 45>
			      <FCLEAR ,FALLEN-BUNK ,INVISIBLE>
			      <FCLEAR ,MAST ,INVISIBLE>
			      <FCLEAR ,JAGGED-HOLE ,INVISIBLE>)
			     (<==? ,WRECK-CHOSEN 2>
			      <FCLEAR ,AIRTIGHT-DOOR ,INVISIBLE>
			      <FCLEAR ,AIRTIGHT-DOOR ,OPENBIT>
			      <FCLEAR ,LOCKER-DOOR ,INVISIBLE>
			      <FCLEAR ,LOCKER-DOOR ,OPENBIT>
			      <MOVE ,SAFE ,WRECK-8>
			      <PUTP ,SAFE ,P?ACTION SAFE-F>
			      <FCLEAR ,SAFE ,NDESCBIT>
			      <COND (<==? ,WRECK-FOUND 2>
				     <MOVE ,GLASS-CASE ,SAFE>)>
			      <MOVE ,MINE ,WRECK-11>
			      <MOVE ,CLUMP-OF-MINES ,WRECK-11>
			      <FCLEAR ,CEILING-HOLE-2 ,INVISIBLE>
			      <FCLEAR ,FLOOR-HOLE-2 ,INVISIBLE>
			      <PUTP ,WRECK-6 ,P?VALUE 25>
			      <PUTP ,WRECK-1 ,P?DESCFCN 100>
			      <PUTP ,WRECK-2 ,P?DESCFCN 100>
			      <PUTP ,WRECK-3 ,P?DESCFCN 100>
			      <PUTP ,WRECK-4 ,P?DESCFCN 100>
			      <PUTP ,WRECK-5 ,P?DESCFCN 100>
			      <PUTP ,WRECK-6 ,P?DESCFCN 100>
			      <PUTP ,WRECK-7 ,P?DESCFCN 100>
			      <PUTP ,WRECK-8 ,P?DESCFCN 100>
			      <PUTP ,WRECK-9 ,P?DESCFCN 100>
			      <PUTP ,WRECK-10 ,P?DESCFCN 100>
			      <PUTP ,WRECK-11 ,P?DESCFCN 100>
			      <PUTP ,WRECK-12 ,P?DESCFCN 100>
			      <PUTP ,WRECK-13 ,P?DESCFCN 100>)>)
		      (<==? ,WRECK-CHOSEN 2>
		       <PUTP ,FLOOR-HOLE-2 ,P?SDESC "hole">)>)
	       (<==? .RARG ,M-LOOK>
		<TELL <GET ,WRECK-1-DESCS ,WRECK-CHOSEN>>
		<CRLF>)>>

<GLOBAL WRECK-CHOSEN 0>

<GLOBAL WRECK-1-DESCS
	<PLTABLE
"You are at the bow of an old, rotting wreck where a ladder leads down
through a large square hole in the deck. When the ship sank, the top of one of
the masts broke off and fell into the hole. What's left of the
deck continues aft."
"You are at the bow of a steel ship that has been here
for quite a while. The deck continues aft, and there is a passage
leading down at your feet."
"This is the bow of a very empty-looking wreck. The deck continues aft.">>

<ROUTINE WRECK-1-D ("OPTIONAL" (PRINT? T))
	 <COND (<EQUAL? ,WRECK-CHOSEN 1>
		<COND (.PRINT?
		       <COND (<FSET? ,WEST-LADDER ,RMUNGBIT>
		       	      <TELL-GRACEFUL>)
		      	     (T
		       	      <FSET ,WEST-LADDER ,RMUNGBIT>
		       	      <TELL
"As you put your foot on the top rung, the rotting wood gives way. The other
rungs break beneath your weight, and you plummet down to the deck below..." CR
CR>)>)>
		<RETURN ,WRECK-4>)
	       (<EQUAL? ,WRECK-CHOSEN 3>
		<TELL-NO-GO .PRINT?>
		<RFALSE>)
	       (T <RETURN ,WRECK-4>)>>

<OBJECT WEST-LADDER
	(IN LOCAL-GLOBALS)
	(DESC "ladder")
	(SYNONYM LADDER WOOD PIECE PIECES)
	(ADJECTIVE BROKEN WOODEN RUNG RUNGS)
	(FLAGS TRYTAKEBIT)
	(ACTION WEST-LADDER-F)>

<ROUTINE WEST-LADDER-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<FSET? ,WEST-LADDER ,RMUNGBIT>
		       <COND (<EQUAL? ,HERE ,WRECK-1>
			      <TELL
"All that's left are a couple of pieces that were broken off at the top."
CR>)
			     (T <TELL
"The ladder is nothing more than some broken pieces of wood." CR>)>)
		      (T <TELL "Looks like a ladder." CR>)>)
	       (<VERB? TAKE>
		<COND (<OR <EQUAL? ,HERE ,WRECK-1>
			   <NOT <FSET? ,WEST-LADDER ,RMUNGBIT>>>
		       <TELL <PICK-ONE ,YUKS> CR>)
		      (T <TELL "None of the pieces looks useful." CR>)>)
	       (<VERB? CLIMB-FOO>
		<COND (<EQUAL? ,HERE ,WRECK-1>
		       <DO-WALK ,P?DOWN>)
		      (T <DO-WALK ,P?UP>)>
		<SETG P-IT-OBJECT ,WEST-LADDER>
		<RTRUE>)>>

<ROOM WRECK-2
      (IN ROOMS)
      (DESC "Top Deck")
      (FLAGS RLANDBIT)
      (GLOBAL SHIPWRECK OCEAN DECK)
      (NORTH TO WRECK-1)
      (SOUTH TO WRECK-3)
      (UP PER UNDERWATER-U)
      ;(DOWN PER WRECK-2-D)
      (DESCFCN 0);"metal content"
      (LINE 6)
      (ACTION WRECK-2-F)>

<ROUTINE WRECK-2-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL <GET ,WRECK-2-DESCS ,WRECK-CHOSEN>>
		<CRLF>)>>

<GLOBAL WRECK-2-DESCS
	<PLTABLE 
"You are now aft of midships on the topmost deck. The deck continues fore and
aft."
"You are now aft of midships on the topmost deck. The deck continues fore and
aft."
"You are now aft of midships on the topmost deck. The deck continues fore and
aft.">>

;<ROUTINE WRECK-2-D ("OPTIONAL" (PRINT? T))
	 <COND (<EQUAL? ,WRECK-CHOSEN 1 2>
		<TELL-NO-GO .PRINT?>
		<RFALSE>)
	       (T <RETURN ,WRECK-6>)>>

;<ROUTINE WRECK-2-E ("OPTIONAL" (PRINT? T))
	 <COND (<==? ,WRECK-CHOSEN 1>
		<COND (<NOT .PRINT?> <RETURN ,WRECK-3>)
		      (T
		       <TELL "Fallen masts block your way." CR>
		       <RFALSE>)>)
	       (T <RETURN ,WRECK-3>)>>

<ROOM WRECK-3
      (IN ROOMS)
      (DESC "Top Deck")
      (FLAGS RLANDBIT)
      (GLOBAL MAST SHIPWRECK OCEAN DECK FLOOR-HOLE-1)
      (NORTH TO WRECK-2)
      (UP PER UNDERWATER-U)
      (DOWN PER WRECK-3-D)
      (DESCFCN 0);"metal content"
      (LINE 6)
      (ACTION WRECK-3-F)>

<ROUTINE WRECK-3-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL <GET ,WRECK-3-DESCS ,WRECK-CHOSEN>>
		<CRLF>)>>

<GLOBAL WRECK-3-DESCS
	<PLTABLE 
"You are on the narrowing aft deck of the ship, which continues forward. A hole
at the base of one mast leads down."
"You are on the aft deck of the ship. Passengers could have gathered
here to sun themselves and sip drinks. Those times are long gone.
The only way to proceed is forward."
"You are at the stern of this wreck. The deck continues forward.">>

<ROUTINE WRECK-3-D ("OPTIONAL" (PRINT? T))
	 <COND (<EQUAL? ,WRECK-CHOSEN 1>
		<COND (.PRINT?
		       <COND (,DOOMED
			      <JIGS-UP
"Your airhose catches and tears on the way down.">)
			     (T
			      <SETG DOOMED T>
		       	      <TELL-GRACEFUL>)>)>
		<RETURN ,WRECK-7>)
	       (T
		<TELL-NO-GO .PRINT?>
		<RFALSE>)>>

<ROUTINE TELL-GRACEFUL ()
	 <TELL "You sink gracefully down to the next deck..." CR CR>>

<GLOBAL DOOMED <>>

;<ROUTINE WRECK-3-W ("OPTIONAL" (PRINT? T))
	 <COND (<EQUAL? ,WRECK-CHOSEN 1>
		<COND (<NOT .PRINT?> <RETURN ,WRECK-2>)
		      (T
		       <TELL "Fallen masts block your way." CR>
		       <RFALSE>)>)
	       (T <RETURN ,WRECK-2>)>>

<ROOM WRECK-4
      (IN ROOMS)
      (DESC "Middle Deck")
      (FLAGS RLANDBIT)
      (GLOBAL SHIPWRECK OCEAN DECK WEST-LADDER BUNKS CEILING-HOLE-1
       	      CEILING-HOLE-2 FLOOR-HOLE-2)
      (UP PER WRECK-4-U)
      (SOUTH PER WRECK-4-N)
      (DOWN PER WRECK-4-D)
      (DESCFCN 0);"metal content"
      (LINE 6)
      (PSEUDO "DEBRIS" DEBRIS-PSEUDO "BARNAC" BARNACLE-PSEUDO)
      (ACTION WRECK-4-F)>

<ROUTINE WRECK-4-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL <GET ,WRECK-4-DESCS ,WRECK-CHOSEN>>
		<COND (<EQUAL? ,WRECK-CHOSEN 1>
		       <COND (<FSET? ,ROPE ,NDESCBIT>
			      <TELL-WRAPPED "the mast">)>)>
		<CRLF>)
	       (<AND <==? .RARG ,M-ENTER>
		     <==? ,WRECK-CHOSEN 2>>
		<PUTP ,CEILING-HOLE-2 ,P?SDESC "upper hole">
		<FSET ,CEILING-HOLE-2 ,VOWELBIT>
		<PUTP ,FLOOR-HOLE-2 ,P?SDESC "lower hole">
		<RFALSE>)
	       (<==? .RARG ,M-BEG>
		<COND (<==? ,WRECK-CHOSEN 1>
		       <NOT-THIS-WRECK ,BUNKS>)
		      (<==? ,WRECK-CHOSEN 2>
		       <NOT-THIS-WRECK ,PSEUDO-OBJECT>)>)>>

<GLOBAL WRECK-4-DESCS
	<PLTABLE
"This cabin was apparently used for storage, although what's left can only
be described as debris. There is an exit abaft, a doorway outlined with
barnacle-encrusted timbers. There is a hole above your head through which
a broken-off mast descends."
"This cabin seems to have been sleeping quarters. It must have
been used by the crew, as it is spartanly furnished. The only ways
out of this room are up and down."
"bug"
;"This cabin is eerily empty, as though someone had taken everything out. You
can go aft, up, or down from here.">>

<ROUTINE TELL-WRAPPED (STR)
	 <TELL " A rope is wrapped around " .STR ".">>

<ROUTINE WRECK-4-N ("OPTIONAL" (PRINT? T))
	 <COND (<EQUAL? ,WRECK-CHOSEN 2>
		<TELL-NO-GO .PRINT?>
		<RFALSE>)
	       (T <RETURN ,WRECK-5>)>>

<ROUTINE WRECK-4-U ("OPTIONAL" (PRINT? T))
	 <COND (<EQUAL? ,WRECK-CHOSEN 1>
		<COND (.PRINT?
		       <COND (,ROPE-HANGING
			      <TELL-ROPE-HIGH>)
			     (<FSET? ,WEST-LADDER ,RMUNGBIT>
			      <TELL
"There's no way to get back up what's left of the ladder." CR>)
			     (T
			      <FSET ,WEST-LADDER ,RMUNGBIT>
			      <TELL
"As you start to climb, a rung collapses under your foot. You grab
at other rungs but find you are back where you started
amidst several pieces of what used to be the ladder." CR>)>
		       <RFALSE>)
		      (T <RETURN ,WRECK-1>)>)
	       (T
		<COND (<AND <IN? ,GLASS-CASE ,PLAYER>
			    <NOT <FSET? ,STAMPS ,RMUNGBIT>>
			    <G? ,WATER-IN-CASE 0>>
		       <FSET ,STAMPS ,RMUNGBIT>
		       <SETG WATER-IN-CASE 10>
		       <TELL
"As you go up, the water in the " D ,GLASS-CASE
" sloshes around, ruining the stamps." CR CR>)>
		<RETURN ,WRECK-1>)>>

<ROUTINE WRECK-4-D ("OPTIONAL" (PRINT? T))
	 <COND (<==? ,WRECK-CHOSEN 1>
		<TELL-NO-GO .PRINT?>
		<RFALSE>)
	       (T <RETURN ,WRECK-9>)>>

<GLOBAL WRECK-5-FLOODED <>>

<ROUTINE AIRTIGHT-ROOM? ()
	 <COND (<AND <==? ,WRECK-CHOSEN 2>
	      	     <==? ,HERE ,WRECK-5>
	      	     <NOT ,WRECK-5-FLOODED>>
		<RTRUE>)>>

;<GLOBAL DOOR-HOLES 0>

<OBJECT ROPE
	(IN LOCAL-GLOBALS)
	(DESC "rope")
	(SYNONYM ROPE)
	(ADJECTIVE HANGIN)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(DESCFCN ROPE-F)
	(ACTION ROPE-F)>

<ROUTINE ROPE-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-OBJDESC>
		<COND (<FSET? ,ROPE ,TAKEBIT>
		       <TELL "A length of rope lies here.">)
		      (T <TELL "A rope hangs down here.">)>
		<CRLF>)
	       (<VERB? CUT>
		<COND (<PRSI? ,SWORD>
		       <COND (,ROPE-HANGING ;"second cut"
			      <FSET ,ROPE ,TAKEBIT>
			      <SETG ROPE-HANGING <>>
			      <TELL
"A three-foot length of rope falls to the deck." CR>)
			     (<FSET? ,ROPE ,NDESCBIT> ;"first cut"
			      <COND (<IN? ,PLAYER ,CASK>
				     <SETG ROPE-HANGING T>
			      	     <FCLEAR ,ROPE ,NDESCBIT>
			      	     <RATING-UPD 15>
				     <TELL
"The rope falls to within eight feet of the floor." CR>)
				    (T <TELL-ROPE-HIGH>)>)
			     (T ;"third cut"
			      <MOVE ,ROPE ,LOCAL-GLOBALS>
			      <TELL
"You chop the rope into many small pieces, which float off on the current and
become lost among the debris." CR>)>)
		      (T <TELL-YOU-CANT "cut it with that.">)>)
	       (<NOT ,ROPE-HANGING>
		<COND (<VERB? RUB MOVE UNTIE CLIMB-FOO TAKE>
		       <COND (<FSET? ,ROPE ,TAKEBIT>
			      <RFALSE>)
			     (T <TELL-ROPE-HIGH>)>)>)
	       (<VERB? TAKE>
		<TELL "It's tied securely above." CR>)
	       (<VERB? CLIMB-FOO>
	        <DO-WALK ,P?UP>
		<SETG P-IT-OBJECT ,ROPE>
		<RTRUE>)
	       (<VERB? UNTIE>
		<TELL-CANT-REACH "the top knot">)>>

<GLOBAL ROPE-HANGING <>>

<OBJECT BROKEN-MAST
	(IN LOCAL-GLOBALS)
	(DESC "mast")
	(SYNONYM MAST)
	(ADJECTIVE BROKEN SUSPEN FALLEN)
	(FLAGS NDESCBIT)
	(ACTION BROKEN-MAST-F)>

<ROUTINE BROKEN-MAST-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The mast is suspended securely above you.">
		<COND (,ROPE-HANGING
		       <TELL " A rope is hanging from it.">)
		      (<FSET? ,ROPE ,NDESCBIT>
		       <TELL-WRAPPED "it">)>
		<CRLF>)
	       (<VERB? RUB MOVE UNTIE CLIMB-FOO TAKE>
		<TELL-CANT-REACH "the mast">)>>

<ROOM WRECK-5
      (IN ROOMS)
      (DESC "Middle Deck")
      (FLAGS RLANDBIT)
      (GLOBAL SHIPWRECK OCEAN DECK BUNKS AIRTIGHT-DOOR FLOOR-HOLE-2
       	      LG-IRON-BAR BARNACLES)
      (SOUTH TO WRECK-6 IF AIRTIGHT-DOOR IS OPEN)
      (NORTH PER WRECK-5-N)
      (DOWN PER WRECK-5-D)
      (PSEUDO "PLAQUE" PLAQUE-PSEUDO "PARTIT" PARTITIONS-PSEUDO)
      (DESCFCN 0);"metal content"
      (LINE 6)
      (ACTION WRECK-5-F)>

<ROUTINE WRECK-5-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<COND (<==? ,WRECK-CHOSEN 2>
		       <TELL "This cabin was once a passenger compartment, ">
		       <COND (,WRECK-5-FLOODED
			      <TELL
"but it is now flooded. There is a passage leading down through the deck, and a
door in the aft " D ,BULKHEADS ".">)
			     (T <TELL
"although the fragile
partitions within have collapsed. The room is filled with
air and a glance tells you why: the closed door to aft kept the
air and water pressures equalized, stopping the flow of water up
through the hole in the deck.">)>)
		      (T <TELL <GET ,WRECK-5-DESCS ,WRECK-CHOSEN>>)>
		<CRLF>)
	       (<==? .RARG ,M-BEG>
		<COND (<AND <NOT <==? ,WRECK-CHOSEN 1>>
			    <EQUAL? ,LG-IRON-BAR ,PRSO ,PRSI>>
		       <GLOBAL-NOT-HERE-PRINT ,LG-IRON-BAR>)
		      (<AND <NOT <==? ,WRECK-CHOSEN 1>>
			    <EQUAL? ,BARNACLES ,PRSO ,PRSI>>
		       <GLOBAL-NOT-HERE-PRINT ,BARNACLES>)>)
	       (<==? .RARG ,M-ENTER>
		<COND (<AND <IN? ,GLASS-CASE ,PLAYER>
			    <NOT ,WRECK-5-FLOODED>>
		       <DISABLE <INT I-CASE-LEAK>>
		       <COND (<AND <IN? ,HOLE-2 ,GLASS-CASE>
				   <NOT <IN? ,PUTTY ,GLASS-CASE>>>
			      <SETG WATER-IN-CASE 0>)>)>)>>

<GLOBAL WRECK-5-DESCS
	<PLTABLE
"This area is full of barnacle-encrusted iron bars, probably pikes used by
the sailors for fending off boarding parties. There is a plaque on one wall.
Exits are fore and aft."
"bug"
"bug"
;"You are in a cabin with nothing in it. There are passages fore, aft, up, and
down.">>

<ROUTINE WRECK-5-N ("OPTIONAL" (PRINT? T))
	 <COND (<EQUAL? ,WRECK-CHOSEN 2>
		<TELL-NO-GO .PRINT?>
		<RFALSE>)
	       (T <RETURN ,WRECK-4>)>>

<ROUTINE WRECK-5-D ("OPTIONAL" (PRINT? T))
	 <COND (<==? ,WRECK-CHOSEN 1>
		<TELL-NO-GO .PRINT?>
		<RFALSE>)
	       (T <RETURN ,WRECK-10>)>>

<OBJECT AIRTIGHT-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "door")
	(FLAGS INVISIBLE DOORBIT OPENBIT)
	(SYNONYM DOOR)
	(ACTION AIRTIGHT-DOOR-F)>

<ROUTINE AIRTIGHT-DOOR-F ()
	 <COND (<VERB? OPEN>
		<COND (<FSET? ,AIRTIGHT-DOOR ,OPENBIT>
		       <TELL-ALREADY "open">)
		      (T
		       <FSET ,AIRTIGHT-DOOR ,OPENBIT>
		       <TELL-NOW ,AIRTIGHT-DOOR "open">
		       <COND (<NOT ,WRECK-5-FLOODED>
			      <SETG WRECK-5-FLOODED T>
			      <COND (<EQUAL? ,HERE ,WRECK-5>
				     <COND (<AND
					     <NOT <FSET? ,DEEP-SUIT ,WORNBIT>>
			    		     <OR <NOT <FSET? ,MASK ,WORNBIT>>
						 <NOT <IN? ,AIR-TANK ,PLAYER>>
						 <NOT <FSET? ,WET-SUIT ,WORNBIT>>>>
					    <JIGS-UP
"Water rushes into the room, making you realize the value of your equipment.">)
					   (T <TELL
"Water rushes in through the open door and the hole in the deck,
filling the room to above your head, forcing the air out." CR>)>)
				     (T <TELL
"Water rushes through the door into the next room." CR>)>)>
		       <RTRUE>)>)
	       (<VERB? CLOSE>
		<COND (<FSET? AIRTIGHT-DOOR ,OPENBIT>
		       <FCLEAR ,AIRTIGHT-DOOR ,OPENBIT>
		       <TELL-NOW ,AIRTIGHT-DOOR "closed">)
		      (T
		       <TELL-ALREADY "closed">)>)>>

<OBJECT IRON-BAR
	(IN LOCAL-GLOBALS)
	(DESC "iron bar")
	(SYNONYM BAR ROD PIKE)
	(ADJECTIVE IRON METAL HEAVY)
	(FLAGS TAKEBIT NDESCBIT VOWELBIT)
	(STATION 30) ;"metal content"
	(SIZE 9)
	(TEXT
"This heavy iron bar was probably used as a pike.")
	(ACTION IRON-BAR-F)>

<ROUTINE IRON-BAR-F ()
	 <COND (<IN? ,IRON-BAR ,FALLEN-BUNK>
		<COND (<VERB? EXAMINE>
		       <TELL "The " D ,IRON-BAR " is" ,WEDGED-STR CR>)
		      (<VERB? TAKE MOVE>
		       <TELL "It's too tightly" ,WEDGED-STR CR>)>)
	       (<VERB? TAKE>
		<COND (<ITAKE>
		       <COND (<EQUAL? ,HERE ,WRECK-5>
			      <FCLEAR ,IRON-BAR ,NDESCBIT>
		       	      <TELL
"You take one of the " D ,IRON-BAR "s." CR>)
			     (T <TELL "Taken." CR>)>)>
		<RTRUE>)
	       (<VERB? DROP>
		<COND (<AND <V-DROP>
			    <EQUAL? ,HERE ,WRECK-5>>
		       <FSET ,IRON-BAR ,NDESCBIT>)>
		<RTRUE>)>>

<OBJECT LG-IRON-BAR ;"the ones left on the deck"
	(IN LOCAL-GLOBALS)
	(DESC "lot of iron bars")
	(SYNONYM BAR PIKE PIKES BARS)
	(ADJECTIVE IRON BARNAC METAL)
	(FLAGS TRYTAKEBIT)
	(ACTION LG-IRON-BAR-F)>

<ROUTINE LG-IRON-BAR-F ()
	 <COND (<AND <VERB? TAKE>
		     <IN? ,IRON-BAR ,HERE>>
		<PERFORM ,V?TAKE ,IRON-BAR>
		<RTRUE>)
	       (T <TELL
"These are a " D ,LG-IRON-BAR " held firmly together by barnacles." CR>)>>

<ROUTINE PLAQUE-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "plaque">)
	       (<EQUAL? ,WRECK-CHOSEN 1>
		<COND (<VERB? READ EXAMINE>
		       <TELL
"Although your knowledge of 17th-century Portuguese is minimal,
you can see that the ship is named the Sao Vera, and the plaque
is signed by King Alfonso VI." CR>)>)
	       (T <GLOBAL-NOT-HERE-PRINT ,PSEUDO-OBJECT>)>>

<ROUTINE PARTITIONS-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "fallen partition">)
	       (<==? ,WRECK-CHOSEN 2>
		<COND (<VERB? EXAMINE>
		       <TELL
"These partitions once separated cabins." CR>)>)
	       (T <GLOBAL-NOT-HERE-PRINT ,PSEUDO-OBJECT>)>>

<ROOM WRECK-6
      (IN ROOMS)
      (DESC "Middle Deck")
      (FLAGS RLANDBIT)
      (GLOBAL SHIPWRECK OCEAN DECK AIRTIGHT-DOOR FLOOR-HOLE-2)
      (NORTH TO WRECK-5 IF AIRTIGHT-DOOR IS OPEN)
      (SOUTH PER WRECK-6-S)
      (DOWN PER WRECK-6-D)
      ;(UP PER WRECK-6-U)
      (VALUE 0)
      (DESCFCN 0);"metal content"
      (LINE 6)
      (PSEUDO "WOOD" WOOD-PSEUDO "TABLES" OVERTURNED-PSEUDO)
      (ACTION WRECK-6-F)>

<ROUTINE WRECK-6-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL <GET ,WRECK-6-DESCS ,WRECK-CHOSEN>>
		<CRLF>)
	       (<==? .RARG ,M-ENTER>
		<COND (<AND <NOT <FSET? ,DEEP-SUIT ,WORNBIT>>
			    <OR <NOT <FSET? ,MASK ,WORNBIT>>
				<NOT <IN? ,AIR-TANK ,PLAYER>>
				<NOT <FSET? ,WET-SUIT ,WORNBIT>>>>
		       <JIGS-UP ,WATERY-ENVIRONMENT>)
		      (<COMPILER-SUCKS-EXP-2>
		       <ENABLE <INT I-CASE-LEAK>>)>)>>

<GLOBAL WATERY-ENVIRONMENT
"As you return to a watery environment, you realize the value of leaving your
equipment on.">

<ROUTINE COMPILER-SUCKS-EXP-2 ()
	 <COND (<FSET? ,STAMPS ,RMUNGBIT>
		<RFALSE>)
	       (<NOT <IN? ,GLASS-CASE ,PLAYER>>
		<RFALSE>)
	       (<OR <NOT <IN? ,PUTTY ,GLASS-CASE>>
		    <AND <OR <IN? ,HOLE-1 ,GLASS-CASE>
			     <IN? ,HOLE-2 ,GLASS-CASE>>
			 ,NO-HOLE-PLUGGED>>
		<RTRUE>)
	       (T <RFALSE>)>>

<GLOBAL WRECK-6-DESCS
	<PLTABLE 
"This was a galley or a pantry, though only the shape and
size of the cabin suggest that. There are exits fore and aft."
"This former dining room has some tables upturned and scattered about, a door
forward, a hole through the floor, and a narrow opening abaft."
"bug"
;"This cabin is notable for its complete lack of contents. You can go up, down,
forward, or aft from here.">>

;<ROUTINE WRECK-6-U ("OPTIONAL" (PRINT? T))
	 <COND (<EQUAL? ,WRECK-CHOSEN 1 2>
		<TELL-NO-GO .PRINT?>
		<RFALSE>)
	       (T <RETURN ,WRECK-2>)>>

<ROUTINE WRECK-6-D ("OPTIONAL" (PRINT? T))
	 <COND (<==? ,WRECK-CHOSEN 1>
		<TELL-NO-GO .PRINT?>
		<RFALSE>)
	       (T
		<COND (<NOT .PRINT?>
		       <RETURN ,WRECK-11>)
		      (<FSET? ,MINE ,RMUNGBIT>
		       <COND (<OR <FSET? ,AIR-TANK ,WORNBIT>
				  <NOT <IN? ,AIR-TANK ,PLAYER>>>
			      <RETURN ,WRECK-11>)
			     (T
			      <TELL-TOO-BIG>
			      <RFALSE>)>)
		      (T
		       <TELL
"As you make your way down, you bump what had to be a floating mine. A second
later..." CR CR>
		       <BOOM>)>)>>

<ROUTINE TELL-SCUBA-STOPS ()
	 <TELL
"The scuba tank makes it impossible to fit through the passage." CR>>

<ROUTINE TELL-CARRY-SCUBA? ()
	 <COND (<IN? ,AIR-TANK ,PLAYER>
		<TELL
"Carrying your tank in front of you, you swim to the next room..." CR CR>)>>

<ROUTINE WRECK-6-S ("OPTIONAL" (PRINT? T))
	 <COND (<==? ,WRECK-CHOSEN 2>
		<COND (<NOT .PRINT?> <RETURN ,WRECK-7>)
		      (<FSET? ,AIR-TANK ,WORNBIT>
		       <TELL-SCUBA-STOPS>
		       <RFALSE>)
		      (T
		       <TELL-CARRY-SCUBA?>
		       <RETURN ,WRECK-7>)>)
	       (T <RETURN ,WRECK-7>)>>

<OBJECT CASK
	(IN LOCAL-GLOBALS)
	(DESC "wooden cask")
	(SYNONYM CASK BARREL)
	(ADJECTIVE WOODEN WHOLE)
	(FLAGS PUSHBIT SURFACEBIT CONTBIT VEHBIT CLIMBBIT OPENBIT)
	(FDESC
"Amidst a stack of rotted wood is a cask that is still in one piece.")
	(CAPACITY 15)
	(ACTION CASK-F)>

<ROUTINE CASK-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-BEG>
		<COND (<AND ,ROPE-HANGING
			    <VERB? WALK>
			    <EQUAL? ,P-WALK-DIR ,P?UP>
			    <IN? ,CASK ,WRECK-4>>
		       <COND (<G? <WEIGHT ,PLAYER> 22>
			      <TELL-YOU-CANT "climb the rope with that load.">)
			     (T
			      <MOVE ,PLAYER ,WRECK-1>
		       	      <SETG HERE ,WRECK-1>
		       	      <TELL
"You reach up, grab the rope, and climb..." CR CR>
		       	      <WRECK-1-F ,M-ENTER>
		       	      <V-FIRST-LOOK>
		       	      <RTRUE>)>)>)
	       (<NOT .RARG>
		<COND (<VERB? CLIMB-FOO>
		       <PERFORM ,V?CLIMB-ON ,CASK>
		       <RTRUE>)
		      (<VERB? ,DRILL>
		       <TELL "There is now a hole in the " D ,CASK "." CR>
		       <ADD-HOLE ,CASK>)>)>>

<ROUTINE WOOD-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "stack of rotted wood">)
	       (<==? ,WRECK-CHOSEN 2>
		<GLOBAL-NOT-HERE-PRINT ,PSEUDO-OBJECT>)>>

<ROUTINE OVERTURNED-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "bunch of overturned tables">)
	       (<==? ,WRECK-CHOSEN 1>
		<GLOBAL-NOT-HERE-PRINT ,PSEUDO-OBJECT>)
	       (<VERB? EXAMINE>
		<TELL
"These are dining tables now scattered in various positions." CR>)>>

<ROOM WRECK-7
      (IN ROOMS)
      (DESC "Middle Deck")
      (FLAGS RLANDBIT)
      (GLOBAL SHIPWRECK DECK ;BUNKS FALLEN-BUNK CEILING-HOLE-1)
      (NORTH PER WRECK-7-N)
      (SOUTH PER WRECK-7-S)
      (UP PER WRECK-7-U)
      ;(DOWN PER WRECK-7-D)
      (DESCFCN 0);"metal content"
      (LINE 6)
      (PSEUDO "DEBRIS" DEBRIS-PSEUDO)
      (ACTION WRECK-7-F)>

<ROUTINE WRECK-7-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<COND (<EQUAL? ,WRECK-CHOSEN 1>
		       <TELL
"This cabin was used for housing the crew. In addition to lining the
" D ,BULKHEADS "s, bunks are strewn about the cabin">
		       <COND (<NOT ,BUNKS-MOVED>
			      <TELL ", blocking a doorway aft. There is">)
			     (T <TELL ". There is a doorway aft, and">)>
		       <TELL " an unblocked forward exit.">)
		      (T
		       <TELL <GET ,WRECK-7-DESCS ,WRECK-CHOSEN>>)>
		<CRLF>)
	       (<==? .RARG ,M-BEG>
		<COND (<==? ,WRECK-CHOSEN 2>
		       <COND (<VERB? WEAR>
		       	      <TELL
"There's not enough room here for you to put that on." CR>
			      <RTRUE>)
		      	     (<AND <VERB? WALK>
			    	   <FSET? ,DEEP-SUIT ,WORNBIT>>
		       	      <JIGS-UP
"As you begin to move, you suddenly find yourself breathing water! Your
airhose tore on some of the sharper debris.">)>
		       <NOT-THIS-WRECK ,PSEUDO-OBJECT>)>)>>

<GLOBAL WRECK-7-DESCS
	<PLTABLE 
"bug"
"The settling of debris has left a very narrow passage through this
cabin. You can go forward or aft."
"bug"
;"This cabin is also empty. It has exits forward, aft, up, and down.">>

<ROUTINE WRECK-7-S ("OPTIONAL" (PRINT? T))
	 <COND (<EQUAL? ,WRECK-CHOSEN 1>
		<COND (<OR ,BUNKS-MOVED <NOT .PRINT?>>
		       <RETURN ,WRECK-8>)
		      (T
		       <SETG P-IT-OBJECT ,FALLEN-BUNK>
		       <TELL "There are bunks in the way." CR>
		       <RFALSE>)>)
	       (T
		<COND (<NOT .PRINT?> <RETURN ,WRECK-8>)
		      (<FSET? ,AIR-TANK ,WORNBIT>
		       <TELL-SCUBA-STOPS>
		       <RFALSE>)
		      (T
		       <TELL-CARRY-SCUBA?>
		       <RETURN ,WRECK-8>)>)>>

<ROUTINE WRECK-7-N ("OPTIONAL" (PRINT? T))
	 <COND (<==? ,WRECK-CHOSEN 2>
		<COND (<NOT .PRINT?> <RETURN ,WRECK-6>)
		      (<FSET? ,AIR-TANK ,WORNBIT>
		       <TELL-SCUBA-STOPS>
		       <RFALSE>)
		      (T
		       <TELL-CARRY-SCUBA?>
		       <RETURN ,WRECK-6>)>)
	       (T <RETURN ,WRECK-6>)>>

<ROUTINE WRECK-7-U ("OPTIONAL" (PRINT? T))
	 <COND (<==? ,WRECK-CHOSEN 1>
		<COND (.PRINT?
		       <TELL "There's no way you can reach that hole." CR>
		       <RFALSE>)
		      (T <RETURN ,WRECK-3>)>)
	       (T <TELL-NO-GO .PRINT?> <RFALSE>)>>

;<ROUTINE WRECK-7-D ("OPTIONAL" (PRINT? T))
	 <COND (<==? ,WRECK-CHOSEN 1 2>
		<TELL-NO-GO .PRINT?>
		<RFALSE>)
	       (T <RETURN ,WRECK-12>)>>

<OBJECT FALLEN-BUNK
	(IN LOCAL-GLOBALS)
	(DESC "row of fallen bunks")
	(SYNONYM BUNK BUNKS ROW)
	(ADJECTIVE FALLEN)
	(FLAGS INVISIBLE TRANSBIT)
	(ACTION FALLEN-BUNK-F)>

<ROUTINE FALLEN-BUNK-F ()
	 <COND (<VERB? PUSH>
		<TELL
"The bunks move a bit but fall back to where they were." CR>)
	       (<VERB? EXAMINE>
		<COND (,BUNKS-MOVED
		       <TELL
"A " D ,FALLEN-BUNK " teeters by the passageway.">
		       <COND (<IN? ,IRON-BAR ,FALLEN-BUNK>
			      <TELL
" They are being held up by an " D ,IRON-BAR ".">)>
		       <CRLF>)
		      (T <TELL
"There is a " D, FALLEN-BUNK " before the aft doorway." CR>)>)
	       (<VERB? SLEEP>
		<TELL-BAD-SHAPE>)
	       (<VERB? MOVE>
		<COND (<PRSI? ,IRON-BAR>
		       <COND (,BUNKS-MOVED
			      <TELL "They've already been moved." CR>)
			     (T
			      <SETG BUNKS-MOVED T>
		       	      <ENABLE <QUEUE I-PLUMMET 2>>
		       	      <SETG CRIMP-CTR 0>
		       	      <TELL
"Using the " D ,IRON-BAR ", you move the bunks out of the way." CR>)>)
		      (T
		       <TELL "They're too heavy to move ">
		       <COND (,PRSI <TELL "that way">)
			     (T <TELL "by hand">)>
		       <TELL "." CR>)>)
	       (<AND <VERB? LOOK-BEHIND>
		     <==? ,HERE ,WRECK-7>
		     <NOT ,BUNKS-MOVED>>
		<TELL "There is a passageway there." CR>)
	       (<AND ,BUNKS-MOVED
		     <VERB? PUT-UNDER>
		     <PRSO? ,IRON-BAR>>
		<DISABLE <INT I-PLUMMET>>
		<MOVE ,IRON-BAR ,FALLEN-BUNK>
		<PUTP ,WRECK-7 ,P?DESCFCN 65>
		<PUTP ,WRECK-8 ,P?DESCFCN 65>
		<TELL "The " D ,IRON-BAR " is wedging the bunks up." CR>)
	       (<AND <VERB? LOOK-UNDER>
		     <IN? ,IRON-BAR ,FALLEN-BUNK>>
		<TELL "The " D ,IRON-BAR " is there," ,WEDGED-STR CR>)>>

<GLOBAL BUNKS-MOVED <>>
<GLOBAL WEDGED-STR " wedged under the bunks.">

<ROUTINE DEBRIS-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "debris">)
	       (<VERB? EXAMINE>
		<TELL
"All sorts of jetsam has collected here, none of it very
interesting on its own." CR>)>>

<ROOM WRECK-8
      (IN ROOMS)
      (DESC "Middle Deck")
      (FLAGS RLANDBIT)
      (GLOBAL SHIPWRECK DECK BUNKS FALLEN-BUNK EAST-LADDER FLOOR-HOLE-1)
      ;(UP PER WRECK-8-U)
      (NORTH PER WRECK-8-N)
      (DOWN PER WRECK-8-D)
      (DESCFCN 0);"metal content"
      (VALUE 0)
      (LINE 6)
      (ACTION WRECK-8-F)>

<ROUTINE WRECK-8-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL <GET ,WRECK-8-DESCS ,WRECK-CHOSEN>>
		<CRLF>)>>

<GLOBAL WRECK-8-DESCS
	<PLTABLE 
"You are in a bunk-lined cabin. The forward bulkhead has an open
doorway in it, and a ladder leads down through the deck. The rotting interior
of the hull lies aft."
"This might have been the purser's cabin. It can be exited forward
through a narrow opening."
"bug"
;"There is nothing at all in this cabin. Exits lead up, down, and forward.">>

;<ROUTINE WRECK-8-U ("OPTIONAL" (PRINT? T))
	 <COND (<EQUAL? ,WRECK-CHOSEN 1 2>
		<TELL-NO-GO .PRINT?>
		<RFALSE>)
	       (T <RETURN ,WRECK-3>)>>

<ROUTINE WRECK-8-D ("OPTIONAL" (PRINT? T))
	 <COND (<==? ,WRECK-CHOSEN 2>
		<TELL-NO-GO .PRINT?>
		<RFALSE>)
	       (T <RETURN ,WRECK-13>)>>

<ROUTINE WRECK-8-N ("OPTIONAL" (PRINT? T))
	 <COND (<==? ,WRECK-CHOSEN 2>
		<COND (<NOT .PRINT?> <RETURN ,WRECK-7>)
		      (<FSET? ,AIR-TANK ,WORNBIT>
		       <TELL-SCUBA-STOPS>
		       <RFALSE>)
		      (T
		       <TELL-CARRY-SCUBA?>
		       <RETURN ,WRECK-7>)>)
	       (T <RETURN ,WRECK-7>)>>

;<ROUTINE WRECK-8-SW ("OPTIONAL" (PRINT? T))
	 <COND (<EQUAL? ,WRECK-CHOSEN 1>
		<TELL-NO-GO .PRINT?>
		<RFALSE>)
	       (T <RETURN ,WRECK-10>)>>

<OBJECT EAST-LADDER
	(IN LOCAL-GLOBALS)
	(DESC "ladder")
	(SYNONYM LADDER RUNG RUNGS)
	(ADJECTIVE WOODEN)
	(TEXT
"Except for two broken rungs at the bottom, this ladder looks as if it's in
good shape.")
	(ACTION EAST-LADDER-F)>

<ROUTINE EAST-LADDER-F ()
	 <COND (<VERB? CLIMB-FOO>
		<COND (<EQUAL? ,HERE ,WRECK-8>
		       <DO-WALK ,P?DOWN>)
		      (T <DO-WALK ,P?UP>)>
		<SETG P-IT-OBJECT ,EAST-LADDER>
		<RTRUE>)>>

<OBJECT SAFE
	(IN BANK)
	(DESC "safe")
	(SYNONYM SAFE VAULT DOOR LOCK)
	(ADJECTIVE BANK SAFE)
	(FLAGS NDESCBIT SEARCHBIT CONTBIT)
	(CAPACITY 20)
	(ACTION VAULT-F);"VAULT-F can be found in ISLAND">

<ROUTINE SAFE-F ()
	 <COND (<AND <VERB? THROUGH>
		     <NOT <==? ,HERE ,WRECK-8>>
		     <NOT <==? ,WRECK-CHOSEN 2>>>
		<GLOBAL-NOT-HERE-PRINT ,SAFE>)
	       (<OR <VERB? OPEN>
		    <VERB? DRILL>>
		<COND (<PRSI? ,DRILL>
		       <FSET ,SAFE ,OPENBIT>
		       <ENABLE <QUEUE I-CASE-LEAK -1>>
		       <TELL
"As you drill through the lock, the door pops open with a rush of escaping
air!">
		       <COND (<FIRST? ,SAFE>
			      <TELL " This reveals ">
			      <PRINT-CONTENTS ,SAFE>
			      <TELL "!">)>
		       <CRLF>
		       <ADD-HOLE ,SAFE>)
		      (,PRSI <TELL "With " A ,PRSI "??!?" CR>)
		      (<OR <IN? ,HOLE-1 ,SAFE>
			   <IN? ,HOLE-2 ,SAFE>>
		       <RFALSE>)
		      (T <TELL "It's locked." CR>)>)
	       (<VERB? UNLOCK>
		<COND (<OR <IN? ,HOLE-1 ,SAFE>
			   <IN? ,HOLE-2 ,SAFE>>
		       <TELL "You've already done it. By brute force." CR>)
		      (T <TELL-DONT-HAVE "the combination">)>)>>

<OBJECT GLASS-CASE
	(IN LOCAL-GLOBALS)
	(DESC ;"sealed " "glass case")
	(SYNONYM CASE CRACK SHELF)
	(ADJECTIVE SEALED GLASS CLEAR)
	(FLAGS CONTBIT TRANSBIT TAKEBIT)
	(CAPACITY 10)
	(VALUE 25)
	(ACTION GLASS-CASE-F)>

<ROUTINE GLASS-CASE-F ()
	 <COND (<VERB? OPEN>
		<TELL "It's sealed shut." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The " D ,GLASS-CASE " has a shelf inside it. A collection of
extremely rare ">
		<COND (<FSET? ,STAMPS ,RMUNGBIT>
		       <TELL "but soggy ">)>
		<TELL
"postage stamps sits on the shelf. There is a crack near a bottom corner of
the case">
		<COND (<IN? ,PUTTY ,GLASS-CASE>
		       <TELL ", which is sealed with putty">)>
		<TELL ".">
		<COND (<OR <IN? ,HOLE-1 ,GLASS-CASE>
			   <IN? ,HOLE-2 ,GLASS-CASE>>
		       <TELL " Near the crack is the hole you drilled">
		       <COND (<AND <IN? ,PUTTY ,GLASS-CASE>
				   <NOT ,NO-HOLE-PLUGGED>>
			      <TELL ", which is also filled with putty">)>
		       <TELL ".">)>
		<COND (<G? ,WATER-IN-CASE 0>
		       <TELL " The case has some water in it.">)>
		<CRLF>)
	       (<OR <AND <VERB? POUR TAKE>
		     	 <PRSO? ,OCEAN>>
		    <VERB? EMPTY>>
		<COND (<==? ,WATER-IN-CASE 0>
		       <TELL "There's no water in the case." CR>)
		      (<NOT <AIRTIGHT-ROOM?>>
		       <TELL "That would be a losing battle." CR>)
		      (T
		       <SETG WATER-IN-CASE 0>
		       <FSET ,STAMPS ,RMUNGBIT>
		       <TELL
"In the process of emptying the case, you manage to get the stamps wet." CR>)>)
	       (<VERB? DRILL>
		<COND (<AND <IN? ,PLAYER ,WRECK-5>
			    <NOT ,WRECK-5-FLOODED>>
		       <SETG WATER-IN-CASE 0>
		       <TELL "The water pours out of the hole." CR>)
		      (T
		       <SETG WATER-IN-CASE 10>
		       <DISABLE <INT I-CASE-LEAK>>
		       <FSET ,STAMPS ,RMUNGBIT>
		       <TELL "Water pours into the case, ruining the stamps." CR>)>
		<ADD-HOLE ,GLASS-CASE>)
	       (<AND <VERB? MUNG>
		     <PRSO? ,GLASS-CASE>>
		<TELL "That wouldn't be too smart." CR>)>>

<OBJECT STAMPS
	(IN GLASS-CASE)
	(DESC "collection of rare stamps")
	(SYNONYM STAMPS COLLEC)
	(ADJECTIVE RARE VALUAB PRICEL)
	(ACTION STAMPS-F)>

<ROUTINE STAMPS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"These are rare stamps which include a little-known sheet of
\"inverted biplanes,\" full sheets of \"Graf Zeppelins,\" and other rarities.
Sold at auction, their value would exceed $50 million">
		<COND (<FSET? ,STAMPS ,RMUNGBIT>
		       <TELL
". Unfortunately, since they're all stuck together and salty, they're
not even worth the price of a cup of coffee">)>
		<TELL "." CR>)
	       (<VERB? COUNT>
		<TELL "It's hard to tell." CR>)>>

<ROOM WRECK-9
      (IN ROOMS)
      (DESC "Below Decks")
      (FLAGS RLANDBIT)
      (GLOBAL SHIPWRECK OCEAN DECK BUNKS JAGGED-HOLE CEILING-HOLE-2)
      (UP PER WRECK-9-U)
      (SOUTH TO WRECK-10)
      (WEST PER WRECK-9-W)
      (OUT PER WRECK-9-W)
      (DESCFCN 0);"metal content"
      (LINE 6)
      (ACTION WRECK-9-F)>

<ROUTINE WRECK-9-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL <GET ,WRECK-9-DESCS ,WRECK-CHOSEN>>
		<CRLF>)
	       (<AND <==? .RARG ,M-ENTER>
		     <==? ,WRECK-CHOSEN 2>>
		<PUTP ,CEILING-HOLE-2 ,P?SDESC "hole">
		<FCLEAR ,CEILING-HOLE-2 ,VOWELBIT>
		<PUTP ,FLOOR-HOLE-2 ,P?SDESC "hole">)
	       (<==? .RARG ,M-BEG>
		<COND (<==? ,WRECK-CHOSEN 1>
		       <NOT-THIS-WRECK ,BUNKS>)>)>>

<GLOBAL WRECK-9-DESCS
	<PLTABLE 
"You can go aft from this cabin, a small and claustrophobic area
little more than a widened passageway, or through a jagged hole in the port
bulkhead."
"This cabin is the third-class passengers' quarters. There
couldn't have been many frills here since the remains are spartan. The cabin
can be exited aft and up."
"bug"
;"This room, once again, is entirely devoid of contents. You can leave it aft or
go up.">>

<ROUTINE WRECK-9-U ("OPTIONAL" (PRINT? T))
	 <COND (<==? ,WRECK-CHOSEN 1>
		<TELL-NO-GO .PRINT?>
		<RFALSE>)
	       (T <RETURN ,WRECK-4>)>>

<ROUTINE WRECK-9-W ("OPTIONAL" (PRINT? T))
	 <COND (<EQUAL? ,WRECK-CHOSEN 1>
		<COND (.PRINT?
		       <TELL-CAREFULLY-PICK>
		       <RETURN ,WEST-OF-WRECK-9>)
		      (T <RFALSE>)>)
	       (T
		<TELL-NO-GO .PRINT?>
		<RFALSE>)>>

<OBJECT EMPTY-CHEST
	(IN LOCAL-GLOBALS)
	(DESC "maple chest")
	(SYNONYM CHEST TRUNK)
	(ADJECTIVE WOODEN MAPLE WOOD TREASU)
	(FLAGS PUSHBIT SURFACEBIT VEHBIT CLIMBBIT TRYTAKEBIT OPENBIT)
	(ACTION EMPTY-CHEST-F)>

<ROUTINE EMPTY-CHEST-F ("OPTIONAL" (RARG <>))
	 <GENERIC-CHEST-F ,EMPTY-CHEST .RARG>>

<ROUTINE GENERIC-CHEST-F (CHEST RARG)
	 <COND (<==? .RARG ,M-BEG>
		<COND (<AND <VERB? WALK>
			    <EQUAL? ,P-WALK-DIR ,P?UP>
			    <IN? .CHEST ,WRECK-13>>
		       <MOVE ,PLAYER ,WRECK-8>
		       <SETG HERE ,WRECK-8>
		       <COND (,CHEST-CLIMB-POINTS
			      <RATING-UPD ,CHEST-CLIMB-POINTS>
			      <SETG CHEST-CLIMB-POINTS 0>)>
		       <TELL
"You reach the first unbroken rung and climb the ladder..." CR CR>
		       <WRECK-8-F ,M-ENTER>
		       <V-FIRST-LOOK>
		       <RTRUE>)
		      (<AND <VERB? WALK>
			    <NOT <==? ,P-WALK-DIR ,P?UP>>>
		       <TELL-YOUD-BETTER "get off the chest" T>)
		      (<AND <VERB? MOVE>
			    <PRSO? ,SAFETY-LINE>
			    <IN? ,SAFETY-LINE ,CHEST>>
		       <JIGS-UP
"As the chest starts to rise, you fall off it rather awkwardly and disconnect
your airhose.">)>)
	       (<NOT .RARG>
		<COND (<VERB? CLIMB-FOO>
		       <PERFORM ,V?CLIMB-ON .CHEST>
		       <RTRUE>)
		      (<VERB? TAKE>
		       <TELL "It's much too heavy." CR>)
		      (<AND <VERB? PUSH-TO>
			    <IN? ,SAFETY-LINE .CHEST>
			    <==? ,P-WALK-DIR ,P?EAST>>
		       <TELL-TOO-SHORT>)
		      (<VERB? TIE>
		       <COND (<OR <PRSO? ,SAFETY-LINE>
			   	  <PRSI? ,SAFETY-LINE>>
		       	      <COND (<IN? ,SAFETY-LINE .CHEST>
				     <TELL-ALREADY "tied">)
				    (T
				     <MOVE ,SAFETY-LINE .CHEST>
			      	     <FSET ,SAFETY-LINE ,NDESCBIT>
		       	      	     <COND (,CHEST-TIE-POINTS
				     	    <RATING-UPD ,CHEST-TIE-POINTS>
				     	    <SETG CHEST-TIE-POINTS 0>)>
			      	     <DISABLE <INT I-PENDULUM>>
		       	      	     <TELL "Tied." CR>)>)>)>)>>

<GLOBAL CHEST-CLIMB-POINTS 10>
<GLOBAL CHEST-TIE-POINTS 15>

<OBJECT JAGGED-HOLE
	(IN LOCAL-GLOBALS)
	(DESC "jagged hole")
	(SYNONYM HOLE)
	(ADJECTIVE JAGGED)
	(FLAGS INVISIBLE)
	(TEXT
"This jagged hole is the result of centuries of wear on the hull.")
	(ACTION JAGGED-HOLE-F)>

<ROUTINE JAGGED-HOLE-F ("AUX" (OUTSIDE? <>))
	 <COND (<EQUAL? ,HERE ,WEST-OF-WRECK-9 ,WEST-OF-WRECK-11>
		<SET OUTSIDE? T>)>
	 <COND (<VERB? THROUGH>
		<COND (.OUTSIDE? <DO-WALK ,P?EAST>)
		      (T <DO-WALK ,P?WEST>)>)
	       (<AND <VERB? PUSH-THROUGH>
		     <PRSI? ,JAGGED-HOLE>>
		<COND (.OUTSIDE? <SETG ,P-WALK-DIR ,P?EAST>)
		      (T <SETG ,P-WALK-DIR ,P?WEST>)>
		<PERFORM ,V?PUSH-TO ,PRSO ,INTDIR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<TELL-YOU-CANT "make anything out on the other side.">)>>

<ROOM WEST-OF-WRECK-9
      (IN ROOMS)
      (DESC "Ocean Floor")
      (FLAGS RLANDBIT)
      (GLOBAL SHIPWRECK OCEAN JAGGED-HOLE)
      (LINE 6)
      (EAST TO WRECK-9)
      (IN TO WRECK-9)
      (ACTION GENERIC-WEST-F)>

<ROUTINE TELL-TOO-SHORT ("OPTIONAL" (STR <>))
	 <TELL "The " D ,SAFETY-LINE " isn't long enough">
	 <COND (.STR <TELL .STR>)>
	 <TELL "." CR>>

<ROUTINE GENERIC-WEST-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"You are on the murky ocean floor, outside the rotted hull of a " D ,SHIPWRECK
". You can return to the wreck through the hole in the hull to starboard." CR>)
	       (<==? .RARG ,M-BEG>
		<COND (<VERB? WALK>
		       <COND (<EQUAL? ,P-WALK-DIR ,P?EAST ,P?IN>
			      <COND (<IN? ,SAFETY-LINE ,PLAYER>
		       		     <TELL-TOO-SHORT " to take with you">
				     <RFATAL>)>)
			     (<NOT ,P-WALK-DIR>
			      <RFALSE>)
			     (T <LINE-SNAGS>)>)
		      (<AND <VERB? WAIT-FOR>
			    <PRSO? ,SAFETY-LINE>
			    <QUEUED? I-PENDULUM>>
		       <COND (<IN? ,SAFETY-LINE ,HERE>
			      <SETG CLOCK-WAIT T>
			      <TELL "It's right here!" CR>)
			     (T <V-WAIT>)>)>)
	       (<==? .RARG ,M-END>
		<COND (<AND <IN? ,SAFETY-LINE ,HERE>
			    <NOT <ENABLED? I-PENDULUM>>>
		       <ENABLE <QUEUE I-PENDULUM 3>>)>)>>

<ROUTINE LINE-SNAGS ()
	 <JIGS-UP
"As you move away from the hole, your airhose gets caught on
the edge of the hole in the wreck! As it tears, you find that breathing water
is beyond your talents.">>

<OBJECT SAFETY-LINE
	(IN LOCAL-GLOBALS)
	(DESC "orange line")
	(SYNONYM LINE ROPE)
	(ADJECTIVE SAFETY WEIGHT FLOURE ORANGE)
	(FLAGS TAKEBIT VOWELBIT)
	(DESCFCN SAFETY-LINE-F)
	(ACTION SAFETY-LINE-F)>

<ROUTINE SAFETY-LINE-F ("OPTIONAL" (RARG <>) "AUX" MSTR)
	 <COND (<EQUAL? .RARG ,M-OBJDESC>
		<TELL
"The " D ,SAFETY-LINE " from the ship is swaying to and fro." CR>)
	       (<VERB? TAKE>
		<COND (<OR <IN? ,SAFETY-LINE ,TREASURE-CHEST>
			   <IN? ,SAFETY-LINE ,EMPTY-CHEST>>
		       <TELL "It's tied to the chest." CR>)
		      (<NOT <IN? ,SAFETY-LINE ,HERE>>
		       <TELL "It's no longer here." CR>)
		      (<ITAKE>
		       <DISABLE <INT I-PENDULUM>>
		       <TELL "Taken." CR>)>
		<RTRUE>)
	       (<VERB? UNTIE>
		<COND (<OR <IN? ,SAFETY-LINE ,TREASURE-CHEST>
			   <IN? ,SAFETY-LINE ,EMPTY-CHEST>>
		       <MOVE ,SAFETY-LINE <META-LOC ,SAFETY-LINE>>
		       <FCLEAR ,SAFETY-LINE ,NDESCBIT>
		       <ENABLE <QUEUE I-PENDULUM 3>>
		       <TELL "Untied." CR>)
		      (T <TELL "It's not tied to anything!" CR>)>)
	       (<VERB? MOVE>
		<TELL "The line starts to move upward">
		<SET MSTR ", dragging the chest up with it.">
		<COND (<IN? ,SAFETY-LINE ,TREASURE-CHEST>
		       <MOVE ,TREASURE-CHEST <LOC ,WEASEL>>)
		      (<IN? ,SAFETY-LINE ,EMPTY-CHEST>
		       <MOVE ,EMPTY-CHEST <LOC ,WEASEL>>)
		      (T
		       <SET MSTR ".">
		       <DISABLE <INT I-PENDULUM>>
		       <MOVE ,SAFETY-LINE <LOC ,WEASEL>>)>
		<TELL .MSTR CR>)
	       (<VERB? CLIMB-FOO>
		<LINE-SNAGS>)
	       (<VERB? CUT>
		<TELL "This rope is too strong." CR>)>>

<ROOM WRECK-10
      (IN ROOMS)
      (DESC "Below Decks")
      (FLAGS RLANDBIT)
      (GLOBAL SHIPWRECK OCEAN DECK LOCKER-DOOR)
      (UP PER WRECK-10-U)
      (NORTH TO WRECK-9)
      (SOUTH TO WRECK-11 IF LOCKER-DOOR IS OPEN)
      (DESCFCN 0);"metal content"
      (LINE 6)
      (PSEUDO "BARNAC" BARNACLE-PSEUDO)
      (ACTION WRECK-10-F)>

<ROUTINE WRECK-10-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL <GET ,WRECK-10-DESCS ,WRECK-CHOSEN>>
		<CRLF>)
	       (<==? .RARG ,M-ENTER>
		<COND (<AND <NOT <FSET? ,DEEP-SUIT ,WORNBIT>>
			    <OR <NOT <FSET? ,MASK ,WORNBIT>>
				<NOT <IN? ,AIR-TANK ,PLAYER>>
				<NOT <FSET? ,WET-SUIT ,WORNBIT>>>>
		       <JIGS-UP ,WATERY-ENVIRONMENT>)
		      (<COMPILER-SUCKS-EXP-2>
		       <ENABLE <INT I-CASE-LEAK>>)>)>>

<GLOBAL WRECK-10-DESCS
	<PLTABLE 
"This room, which may have been a lounge, can be exited fore or aft."
"This was once the supplies locker, with exits forward and up, and a door
with a sign on it in the aft bulkhead."
"bug"
;"This cabin actually has the phrase \"H.M.S. INTRANSIGENT\" carved in one of
the bulkheads. Aside from that, it's empty, with exits fore and aft and a
passage up.">>

<ROUTINE WRECK-10-U ("OPTIONAL" (PRINT? T))
	 <COND (<==? ,WRECK-CHOSEN 1>
		<TELL-NO-GO .PRINT?>
		<RFALSE>)
	       (T <RETURN ,WRECK-5>)>>

<OBJECT LOCKER-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "door")
	(SYNONYM DOOR SIGN)
	(ADJECTIVE LOCKER)
	(FLAGS INVISIBLE DOORBIT OPENBIT READBIT)
	(ACTION LOCKER-DOOR-F)>

<ROUTINE LOCKER-DOOR-F ()
	 <COND (<VERB? OPEN>
		<COND (<FSET? ,LOCKER-DOOR ,OPENBIT>
		       <TELL-ALREADY "open">)
		      (T
		       <FSET ,LOCKER-DOOR ,OPENBIT>
		       <TELL-NOW ,LOCKER-DOOR "open">)>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,LOCKER-DOOR ,OPENBIT>
		       <FCLEAR ,LOCKER-DOOR ,OPENBIT>
		       <TELL-NOW ,LOCKER-DOOR "closed">)
		      (T <TELL-ALREADY "closed">)>)
	       (<VERB? READ>
		<FIXED-FONT-ON>
		<TELL
"    \"S.S. LEVIATHAN|
     STORAGE LOCKER|
   DANGER: EXPLOSIVES!\"|
">
		<FIXED-FONT-OFF>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL "The door, which has a sign on it, is ">
		<COND (<FSET? ,LOCKER-DOOR ,OPENBIT>
		       <TELL "open">)
		      (T <TELL "closed">)>
		<TELL "." CR>)>>

<OBJECT SKELETON
	(IN LOCAL-GLOBALS)
	(DESC "skeleton")
	(SYNONYM SKELET BONES)
	(FLAGS TRYTAKEBIT SEARCHBIT TRANSBIT)
	;(LDESC "The cabin is full of skeletons.")
	(DESCFCN SKELETON-F)
	(ACTION SKELETON-F)>

<ROUTINE SKELETON-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-OBJDESC>
		<TELL
"Some who went down with the ship were in here, where they are nothing more
than " D ,SKELETON "s." CR>)
	       (<VERB? KILL>
		<TELL "The " D ,SKELETON "s remain dead." CR>)
	       (<VERB? MUNG ATTACK TAKE PUSH>
		<TELL "One of the " D ,SKELETON "s falls apart." CR>)
	       (<VERB? EXAMINE COUNT>
		<TELL "There are about fifty of them. ">
		<COND (<VERB? COUNT>
		       <TELL "It's hard to tell exactly." CR>)
		      (T <TELL
"As you look around, you notice
that one of the " D ,SKELETON "s has what looks like a " D ,SCABBARD
" at its hip."
CR>)>)>>

<OBJECT SCABBARD
	(IN LOCAL-GLOBALS)
	(DESC "scabbard")
	(SYNONYM SCABBA)
	(FLAGS CONTBIT TRYTAKEBIT OPENBIT)
	(CAPACITY 5)
	;(DESCFCN SCABBARD-F)
	(ACTION SCABBARD-F)>

<ROUTINE SCABBARD-F ("AUX" F)
	 <COND (<VERB? TAKE>
		<TELL
"The " D ,SCABBARD " is stuck to the " D ,SKELETON " by encrusted barnacles."
CR>)
	       (<VERB? EXAMINE>
		<TELL
"There is very little of the original leather left to this " D ,SCABBARD
", but barnacles have collected in its place.">
		<COND (<SET F <FIRST? ,SCABBARD>>
		       <TELL " There is " A .F " in the " D ,SCABBARD ".">)>
		<CRLF>)
	       (<VERB? OPEN>
		<TELL-ALREADY "open">)
	       (<VERB? CLOSE>
		<TELL "It doesn't close." CR>)
	       	(<VERB? CUT>
		<TELL-BARNACLES>)>>

<ROUTINE TELL-BARNACLES ()
	 <TELL "The barnacles are too firmly emplaced." CR>>

<OBJECT BARNACLES
	(IN LOCAL-GLOBALS)
	(SYNONYM BARNAC)
	(DESC "barnacle")
	(ACTION BARNACLE-PSEUDO)>

<ROUTINE BARNACLE-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "barnacle">)
	       (<VERB? EXAMINE>
		<TELL "The barnacles look very firmly emplaced." CR>)
	       (<VERB? TAKE CUT MOVE>
		<TELL-BARNACLES>)>>

<OBJECT SWORD
	(IN SCABBARD)
	(DESC "sword")
	(SYNONYM SWORD BLADE RAPIER)
	(ADJECTIVE OLD WORN)
	(STATION 30) ;"metal content"
	(TEXT
"Although this sword is old and worn, it is still moderately sharp.")
	(FLAGS TAKEBIT WEAPONBIT)>

<ROOM WRECK-11
      (IN ROOMS)
      (DESC "Below Decks")
      (FLAGS RLANDBIT)
      (GLOBAL SHIPWRECK OCEAN DECK LOCKER-DOOR JAGGED-HOLE CEILING-HOLE-2)
      (UP PER WRECK-11-U)
      (NORTH TO WRECK-10 IF LOCKER-DOOR IS OPEN)
      (SOUTH PER WRECK-11-S)
      (WEST PER WRECK-11-W)
      (OUT PER WRECK-11-W)
      (DESCFCN 0);"metal content"
      (LINE 6)
      (ACTION WRECK-11-F)>

<ROUTINE WRECK-11-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL <GET ,WRECK-11-DESCS ,WRECK-CHOSEN>>
		<CRLF>)
	       (<==? .RARG ,M-BEG>
		<COND (<AND <VERB? WALK>
			    <IN? ,MINE ,MAGNET>
		     	    <IN? ,MAGNET ,PLAYER>
			    ,MAGNET-ON>
		       <TELL "The mine bumps a " D ,BULKHEADS "..." CR CR>
		       <BOOM>)>)>>

<GLOBAL WRECK-11-DESCS
	<PLTABLE
"You're in one of the large holds of the ship, impressive in size.
There are rooms fore and aft, and a hole in the port bulkhead."
"This had to have been a mine locker. There is a door forward and a
passage above your head."
"bug"
;"This cabin has nothing in it. You can leave through the passage above your
head, or fore or aft.">>

<ROUTINE WRECK-11-U ("OPTIONAL" (PRINT? T))
	 <COND (<==? ,WRECK-CHOSEN 1>
		<TELL-NO-GO .PRINT?>
		<RFALSE>)
	       (T
		<COND (<NOT .PRINT?>
		       <RETURN ,WRECK-6>)
		      (<NOT <FSET? ,MINE ,RMUNGBIT>>
		       <TELL
"As you make your way up, you bump the floating mine. A second later..." CR CR>
		       <BOOM>)
		      (<FSET? ,AIR-TANK ,WORNBIT>
		       <RETURN ,WRECK-6>)
		      (T
		       <TELL-TOO-BIG>
		       <RFALSE>)>)>>

<ROUTINE WRECK-11-S ("OPTIONAL" (PRINT? T))
	 <COND (<EQUAL? ,WRECK-CHOSEN 2>
		<TELL-NO-GO .PRINT?>
		<RFALSE>)
	       (T <RETURN ,WRECK-12>)>>

<ROUTINE TELL-CAREFULLY-PICK ()
	 <TELL
"You carefully pick your way through the jagged edge of the hole..." CR CR>>

<ROUTINE WRECK-11-W ("OPTIONAL" (PRINT? T))
	 <COND (<EQUAL? ,WRECK-CHOSEN 1>
		<COND (.PRINT?
		       <TELL-CAREFULLY-PICK>
		       <RETURN ,WEST-OF-WRECK-11>)
		      (T <RFALSE>)>)
	       (T
		<TELL-NO-GO .PRINT?>
		<RFALSE>)>>

<OBJECT TREASURE-CHEST
	(IN LOCAL-GLOBALS)
	(DESC "oak chest")
	(SYNONYM CHEST TRUNK)
	(ADJECTIVE WOODEN TREASU OAK WOOD)
	(STATION 100) ;"metal content"
	(FLAGS PUSHBIT CLIMBBIT VEHBIT SURFACEBIT VOWELBIT TRYTAKEBIT OPENBIT)
	(ACTION TREASURE-CHEST-F)>

<ROUTINE TREASURE-CHEST-F ("OPTIONAL" (RARG <>))
	 <GENERIC-CHEST-F ,TREASURE-CHEST .RARG>>

<OBJECT MINE
	(IN LOCAL-GLOBALS)
	(DESC "loose mine")
	(SYNONYM MINE BOMB SPIKE SPIKES)
	(ADJECTIVE EXPLOS LOOSE FLOATI)
	(FLAGS NDESCBIT TAKEBIT)
	(STATION 40) ;"metal content"
	(ACTION MINE-F)>

<ROUTINE MINE-F ()
	 <COND (<VERB? TAKE THROW THROW-OFF MOVE MUNG PUSH PUSH-TO>
		<BOOM>)
	       (<VERB? EXAMINE>
		<COND (<AND <IN? ,MINE ,MAGNET>
			    ,MAGNET-ON>
		       <TELL
"A single mine is being held by the " D ,MAGNET " which
is safely attached between its spikes." CR>
		       <RTRUE>)
		      (<FSET? ,MINE ,RMUNGBIT>
		       <TELL
"A single mine is floating relatively harmlessly in one corner of the room.">)
		      (T <TELL
"This mine is blocking the hole that leads to the room above.">)>
		<TELL
" It has lots of widely-spaced spikes pointing out from it.">
		<COND (<IN? ,MINE ,MAGNET>
		       <TELL
" You are holding the " D ,MAGNET " next to it.">)>
		<CRLF>)>>

<OBJECT CLUMP-OF-MINES
	(IN LOCAL-GLOBALS)
	(DESC "bunch of mines")
	(SYNONYM MINES BOMBS POINTS)
	(DESCFCN CLUMP-OF-MINES-F) ;"metal content covered in room's DESCFCN"
	(ACTION CLUMP-OF-MINES-F)>

<ROUTINE CLUMP-OF-MINES-F ("OPTIONAL" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-OBJDESC>
		<TELL
"A number of spherical mines with spikes sticking out of them
litter the room. These mines must have once been used to blockade shipping
lanes. Most of them are tethered together on the deck, but one is ">
		<COND (<IN? ,MINE ,MAGNET>
		       <COND (,MAGNET-ON
		       	      <TELL "being held by the ">)
		       	     (T <TELL "touching your ">)>
		       <TELL D ,MAGNET>)
		      (<FSET? ,MINE ,RMUNGBIT>
		       <TELL "floating in a corner of the room">)
		      (T <TELL "floating up near the hole in the " D ,CEILING>)>
		<TELL "." CR>)
	       (<VERB? TAKE>
		<BOOM>)>>

<ROUTINE BOOM () <JIGS-UP "BOOOOOOOOOOMMMMMMMMMM!">>

<ROOM WEST-OF-WRECK-11
      (IN ROOMS)
      (DESC "Ocean Floor")
      (FLAGS RLANDBIT)
      (LINE 6)
      (GLOBAL SHIPWRECK OCEAN JAGGED-HOLE)
      (EAST TO WRECK-11)
      (IN TO WRECK-11)
      (ACTION GENERIC-WEST-F)>

<ROOM WRECK-12
      (IN ROOMS)
      (DESC "Below Decks")
      (FLAGS RLANDBIT)
      (GLOBAL SHIPWRECK OCEAN DECK BUNKS)
      ;(UP PER WRECK-12-U)
      (NORTH TO WRECK-11)
      (SOUTH TO WRECK-13)
      (DESCFCN 0);"metal content"
      (LINE 6)
      (ACTION WRECK-12-F)>

<ROUTINE WRECK-12-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL <GET ,WRECK-12-DESCS ,WRECK-CHOSEN>>
		<CRLF>)
	       (<==? .RARG ,M-ENTER>
		<ENABLE <QUEUE I-SQUID 2>>)>>

<GLOBAL WRECK-12-DESCS
	<PLTABLE 
"This is another cabin used to house the ship's crew. There are exits forward
and aft."
"bug"
"bug"
;"You are in another spookily empty cabin, which you can leave to forward, aft,
or up.">>

;<ROUTINE WRECK-12-U ("OPTIONAL" (PRINT? T))
	 <COND (<==? ,WRECK-CHOSEN 1>
		<TELL-NO-GO .PRINT?>
		<RFALSE>)
	       (T <RETURN ,WRECK-7>)>>

<OBJECT SQUID
	(IN LOCAL-GLOBALS)
	(DESC "giant squid")
	(SYNONYM SQUID)
	(ADJECTIVE GIANT HUGE LARGE BIG)
	(LDESC "There is a giant squid sleeping here.")
	(ACTION SQUID-F)>

<ROUTINE SQUID-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The squid is huge, its body 20 feet long, and each of its ten arms 35 feet
long! It is currently asleep, its arms waving placidly beneath its body." CR>)
	       (<VERB? ALARM>
		<TELL "As it awakens, the behemoth turns to you. ">
		<I-SQUID>)>>

<ROOM WRECK-13
      (IN ROOMS)
      (DESC "Below Decks")
      (FLAGS RLANDBIT)
      (GLOBAL SHIPWRECK OCEAN DECK EAST-LADDER CEILING-HOLE-1)
      (UP PER WRECK-13-U)
      (NORTH TO WRECK-12)
      (DESCFCN 0);"metal content"
      (LINE 6)
      (ACTION WRECK-13-F)>

<ROUTINE WRECK-13-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL <GET ,WRECK-13-DESCS ,WRECK-CHOSEN>>
		<CRLF>)>>

<GLOBAL WRECK-13-DESCS
	<PLTABLE
"This cabin has suffered the ravages of the sea. Above your head at one end of
the cabin a ladder leads up. The bottom two rungs of the ladder are broken,
but the rest of it seems to be pretty sturdy. A doorway, outlined by rotting
timbers, leads forward."
"bug"
"bug"
;"This cabin is completely deserted. You can leave it by going up or forward.">>

<ROUTINE WRECK-13-U ("OPTIONAL" (PRINT? T))
		<COND (<NOT .PRINT?> <RETURN ,WRECK-8>)
		      (T 
		       <TELL-CANT-REACH
"high enough to get past the two broken rungs">
		       <RFALSE>)>>

<ROUTINE NOT-THIS-WRECK (OBJ)
	 <COND (<OR <PRSO? .OBJ> <PRSI? .OBJ>>
		<GLOBAL-NOT-HERE-PRINT .OBJ>
		<RTRUE>)>>