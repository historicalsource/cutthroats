"BOAT ROOMS for TOA #2
 Copyright (C) 1984 Infocom, Inc."

<OBJECT FERRY
	(IN LOCAL-GLOBALS)
	(DESC "ferry")
	(LDESC "The ferry for the mainland bobs up and down, its engines
running.")
	(TEXT "The ferry for the mainland bobs up and down, its engines
running.")
	(SYNONYM FERRY BOAT SHIP ENGINE)
	(ADJECTIVE FERRY)
	(FLAGS INVISIBLE VEHBIT)
	(ACTION FERRY-F)>

<ROUTINE FERRY-F ()
	 <COND (<VERB? BOARD THROUGH CLIMB-ON>
		<COND (<IN? ,FERRY ,FERRY-LANDING>
		       <COND (<==? ,HERE ,FERRY-LANDING>
			      <TELL-CANT-BOARD>)
			     (T <TELL-YOURE-NOT "at the landing.">)>)
		      (T <TELL "It's not at the landing. Be patient." CR>)>)
	       (<AND <VERB? WALK-TO> <NOT <==? ,HERE ,FERRY-LANDING>>>
		<TELL-SHD-DIR>)
	       (<VERB? LISTEN>
		<TELL "You hear its engines." CR>)>>

<ROUTINE TELL-CANT-BOARD ()
	 <TELL-DONT-HAVE "a ferry token">>

<OBJECT GLOBAL-FERRY
	(IN GLOBAL-OBJECTS)
	(DESC "ferry")
	(SYNONYM FERRY)
	(FLAGS CONTBIT)
	(ACTION GLOBAL-FERRY-F)>

<ROUTINE GLOBAL-FERRY-F ()
	 <COND (<NOT <VERB? ASK-ABOUT TELL FIND>>
		<GLOBAL-NOT-HERE-PRINT ,GLOBAL-FERRY>)>>

<ROOM MM-FORE-DECK
      (IN ROOMS)
      (DESC "Fore Deck")
      (FLAGS RLANDBIT ONBIT)
      (SE TO MM-STARBOARD-DECK)
      (EAST TO MM-STARBOARD-DECK)
      (SW TO MM-PORT-DECK)
      (WEST TO MM-PORT-DECK)
      (SOUTH "There's a wall in the way.")
      (DOWN TO MM-CREW-QTRS)
      (GLOBAL OCEAN DECK SALVAGER RAILING IN-WINDOW LADDER-TOP)
      (LINE 5)
      (STATION MM-FORE-DECK)
      (PSEUDO "BOLT" BOLT-PSEUDO "BOLTS" BOLT-PSEUDO)
      (ACTION MM-FORE-DECK-F)>

<ROUTINE MM-FORE-DECK-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK>
	<TELL-FORE-END ,SALVAGER>)>>

<ROUTINE TELL-FORE-END (OBJ)
	<TELL
"You are at the fore end of the " D .OBJ ". You can see the ocean over the
rail that runs around the deck. A ladder leads below deck, and the wheelhouse
is aft of you. A chair is bolted to the deck." CR>>

<OBJECT DECK-CHAIR
	(IN MM-FORE-DECK)
	(DESC "chair")
	(SYNONYM CHAIR SEAT ARMCHA)
	(ADJECTIVE LOOKOU)
	;(LDESC 
"A chair facing forward is bolted to the deck. It has a button on each arm.")
	(STATION 70) ;"metal content"
	(DESCFCN DECK-CHAIR-F)
	(FLAGS SURFACEBIT VEHBIT TRANSBIT)
	(ACTION DECK-CHAIR-F)>

<ROUTINE DECK-CHAIR-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-OBJDESC>
		<COND (<IN? ,PETE ,DECK-CHAIR>
		       <TELL-IN-CHAIR ,PETE>)
		      ;(<IN? ,WEASEL ,DECK-CHAIR>
		       <TELL-IN-CHAIR ,WEASEL>)>
		<RTRUE>)
	       (<NOT .RARG>
		<COND (<VERB? EXAMINE>
		       <TELL
"This weatherbeaten chair is used by a lookout while standing watch.
It faces forward and is bolted to the deck. ">
		       <COND ;(<IN? ,WEASEL ,DECK-CHAIR>
			      <TELL "The Weasel is currently in the chair.">)
			     (<IN? ,PETE ,DECK-CHAIR>
			      <TELL-IN-CHAIR ,PETE>
			      ;<TELL
D ,PETE " is in the chair, staring out to sea.">)>
		       <CRLF>)
		      (<VERB? ASK-ABOUT>
		       <TELL "\"It's the lookout's chair.\"" CR>)
		      (<AND <VERB? PUT PUT-ON>
			    <PRSI? ,DECK-CHAIR>>
		       <COND (<IDROP>
			      <COND (<IN? ,PLAYER ,DECK-CHAIR>
				     <MOVE ,PRSO <LOC ,DECK-CHAIR>>)>
			      <TELL
"It slides off the chair and onto the deck." CR>)>
		       <RTRUE>)
		      (<AND <VERB? BOARD>
			    <IN? ,PETE ,DECK-CHAIR>>
		       <TELL-ALREADY "occupied">)>)>>

<ROUTINE TELL-IN-CHAIR (OCC)
	 <START-SENTENCE .OCC>
	 <TELL " is sitting in the chair." CR>>

;<OBJECT LEFT-BUTTON
	(IN DECK-CHAIR)
	(DESC "left button")
	(SYNONYM BUTTON)
	(ADJECTIVE LEFT WEST ;PORT)
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

;<OBJECT RIGHT-BUTTON
	(IN DECK-CHAIR)
	(DESC "right button")
	(SYNONYM BUTTON)
	(ADJECTIVE RIGHT EAST)
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

;<ROUTINE BUTTON-F ()
	 <COND (<VERB? PUSH>
		<COND (<AND ,ON-WATCH
		     	    <NOT <EQUAL? ,ON-WATCH ,PLAYER>>>
		       <START-SENTENCE ,ON-WATCH>
		       <TELL " stops you. \"">
		       <COND (<G? ,O-CTR 0>
			      <TELL "Don't worry. I got it,\" he says.">)
			     (T <TELL
"Haven't you ever heard of the kid who cried wolf?\" he asks.">)>
		       <CRLF>
		       <RTRUE>)
		      (<PRSO? ,LEFT-BUTTON>
		       <SETG BUTTON-PUSHED 1>)
		      (T <SETG BUTTON-PUSHED 2>)>
		<COND (<==? ,O-CTR 0>
		       <ENABLE <QUEUE I-USELESS-TURN <+ 1 <RANDOM 2>>>>)>
		<TELL "Pushed." CR>)>>

;<OBJECT PROW-LIGHT
	(IN MM-FORE-DECK)
	(DESC "prow light")
	(SYNONYM LIGHT)
	(ADJECTIVE SEARCH PROW)
	(FLAGS ONBIT TRYTAKEBIT NDESCBIT)
	(TEXT
"This light, affixed to the prow of the boat, shines into the ocean.")
	(ACTION PROW-LIGHT-F)>

;<ROUTINE PROW-LIGHT-F ()
	 <COND (<VERB? LAMP-ON>
		<TELL-ALREADY "on">)
	       (<VERB? LAMP-OFF>
		<TELL "It would be too dangerous." CR>)
	       (<VERB? TAKE>
		<TELL "It's firmly attached to the prow." CR>)>>

<ROOM MM-STARBOARD-DECK
      (IN ROOMS)
      (DESC "Starboard Deck")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"The starboard side of the Mary Margaret has the wheelhouse to port.
The deck is well-worn after many years of use, but still solid. The ocean
is off to the other side of the rail.")
      (NW TO MM-FORE-DECK)
      (NORTH TO MM-FORE-DECK)
      (SW TO MM-AFT-DECK)
      (SOUTH TO MM-AFT-DECK)
      (WEST "There's a wall in the way.")
      (GLOBAL OCEAN DECK SALVAGER RAILING IN-WINDOW)
      (LINE 5)
      (STATION MM-STARBOARD-DECK)>

<ROOM MM-PORT-DECK
      (IN ROOMS)
      (DESC "Port Deck")
      (FLAGS RLANDBIT ONBIT)
      (NE TO MM-FORE-DECK)
      (NORTH TO MM-FORE-DECK)
      (SE TO MM-AFT-DECK)
      (SOUTH TO MM-AFT-DECK)
      (EAST "There's a wall in the way.")
      (WEST TO WHARF IF SALVAGER-DOCKED ELSE "You're out to sea now.")
      (OUT TO WHARF IF SALVAGER-DOCKED ELSE "You're out to sea now.")
      (GLOBAL OCEAN DECK SALVAGER RAILING IN-WINDOW)
      (LINE 5)
      (STATION MM-PORT-DECK)
      (ACTION MM-PORT-DECK-F)>

<ROUTINE MM-PORT-DECK-F (RARG "AUX" DOCK?)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<MOVE ,BUNK ,MM-CREW-QTRS>
		<MOVE ,UNDER-BUNK ,MM-CREW-QTRS>
		<MOVE ,STOVE ,MM-GALLEY>
		;<MOVE ,CUPBOARDS ,MM-GALLEY>
		<MOVE ,DECK-CHAIR ,MM-FORE-DECK>
		;<MOVE ,REDS-LAMP ,MM-CAPT-CABIN>
		<MOVE ,REDS-BUNK ,MM-CAPT-CABIN>
		;<MOVE ,PROW-LIGHT ,MM-FORE-DECK>
		<MOVE ,LOUNGE-CHAIR ,MM-LOUNGE>
		<COND (<IN? ,PETE ,MM-GALLEY>
		       <MOVE ,FOOD ,STOVE>
		       <FSET ,FOOD ,NDESCBIT>)>
		<COND (<AND ,WATER-DELIVERED
			    <==? ,SHIP-CHOSEN ,SALVAGER>>
		       <MOVE ,DRINKING-WATER ,MM-GALLEY>
		       <FSET ,DRINKING-WATER ,NDESCBIT>)>
		<RFALSE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL-FOO-SIDE ,SALVAGER "port" "starboard">
		<RTRUE>)>>

<ROUTINE TELL-FOO-SIDE (OBJ SIDE HOUSE "AUX" DOCK?)
	<TELL
"You are on the ".SIDE" side of the " D .OBJ", a sturdy vessel designed for ">
	<COND (<EQUAL? .OBJ ,TRAWLER> <TELL "trawling">)
	      (T <TELL "deep-sea salvaging">)>
	<TELL ". To " .HOUSE " is a small wheelhouse, while ">
	<COND (<EQUAL? .OBJ ,TRAWLER> <SET DOCK? ,TRAWLER-DOCKED>)
	      (T <SET DOCK? ,SALVAGER-DOCKED>)>
	<COND (.DOCK?
	       <TELL
"to " .SIDE " is the gangway leading to the dock. The gentle rocking of the
boat in port reminds you of time spent on the open sea." CR>)
	      (T <TELL
"the ocean, with its blue-green waves crashing, lies off the "
.SIDE " rail." CR>)>>

<ROOM MM-AFT-DECK
      (IN ROOMS)
      (DESC "Aft Deck")
      (FLAGS RLANDBIT ONBIT)
      (NE TO MM-STARBOARD-DECK)
      (EAST TO MM-STARBOARD-DECK)
      (NW TO MM-PORT-DECK)
      (WEST TO MM-PORT-DECK)
      (NORTH TO MM-WHEELHOUSE)
      (DOWN TO MM-LOUNGE)
      (GLOBAL OCEAN DECK SALVAGER RAILING LADDER-TOP)
      (LINE 5)
      (STATION MM-AFT-DECK)
      (PSEUDO "BOLT" BOLT-PSEUDO "BOLTS" BOLT-PSEUDO)
      (ACTION MM-AFT-DECK-F)>

<ROUTINE TELL-AFT-DECK ()
	<TELL
"The smell of diesel fuel is strong but reassuring here on the aft deck.
A ladder leads below deck, while forward you can see the entrance to the
command center of the boat, the wheelhouse.">>

<ROUTINE MM-AFT-DECK-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL-AFT-DECK>
		<TELL
" A huge air compressor is bolted to the deck by the aft rail." CR>)
	       (<==? .RARG ,M-BEG>
		<COND (<AND <VERB? WALK>
			    <IN? ,AIR-HOSE ,DEEP-SUIT>
			    <IN? ,DEEP-SUIT ,PLAYER>>
		       <TELL
"You don't want to drag the " D ,AIR-HOSE " around the boat." CR>)>)
	       (<==? .RARG ,M-FLASH>
		<COND (<AND <IN? ,WEASEL ,MM-AFT-DECK>
			    ,AT-SEA
			    <NOT ,WEASEL-APPREHENDED>
			    <NOT <QUEUED? I-PENDULUM>>>
		       <ENABLE <QUEUE I-PENDULUM -1>>
		       <TELL-WEASEL-TOSSES>)>)>>

<ROUTINE TELL-WEASEL-TOSSES ()
	 <FCLEAR ,LINE-HACK ,INVISIBLE>
	 <MOVE ,LINE-HACK <LOC ,WEASEL>>
	 <TELL
"The Weasel tosses a line over the side and says, " ,LINE-STR CR>>

<OBJECT LINE-HACK ;"quick and dirty"
	(IN LOCAL-GLOBALS)
	(DESC "orange line")
	(SYNONYM LINE ROPE)
	(ADJECTIVE SAFETY WEIGHT FLOURE ORANGE)
	(FLAGS TRYTAKEBIT INVISIBLE VOWELBIT NDESCBIT)
	(ACTION LINE-HACK-F)>

<ROUTINE LINE-HACK-F ("AUX" (HOLDER <>))
	 <COND (<IN? ,WEASEL <LOC ,LINE-HACK>>
		<SET HOLDER ,WEASEL>)
	       (<IN? ,JOHNNY <LOC ,LINE-HACK>>
		<SET HOLDER ,JOHNNY>)>
	 <COND (<VERB? EXAMINE>
		<COND (.HOLDER
		       <START-SENTENCE .HOLDER>
		       <TELL " is holding one end of a weighted " D ,LINE-HACK "." CR>)
		      (T <TELL "One end of " A ,LINE-HACK " is here. Leave it alone." CR>)>)
	       (<VERB? FIND ASK-ABOUT>
		<RFALSE>)
	       (T
		<COND (.HOLDER
		       <START-SENTENCE .HOLDER>
		       <TELL " pulls it away. \"Don't mess with that!\"" CR>)
		      (T <TELL "Leave it alone." CR>)>)>>

<OBJECT MM-COMPRESSOR
	(IN MM-AFT-DECK)
	(DESC "large air compressor")
	(SYNONYM COMPRE SWITCH)
	(ADJECTIVE LARGE AIR HUGE)
	(FLAGS CONTBIT OPENBIT NDESCBIT)
	(STATION 100) ;"metal content"
	(ACTION MM-COMPRESSOR-F)>

<ROUTINE MM-COMPRESSOR-F ("AUX" TICK)
	 <COND (<VERB? OPEN CLOSE>
		<TELL-NO-NO>)
	       (<AND <VERB? PUT>
		     <PRSI? ,MM-COMPRESSOR>>
		<TELL "There's no place to put it." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The large, gasoline-powered air compressor is ">
		<COND (<FSET? ,MM-COMPRESSOR ,ONBIT>
		       <TELL "on">)
		      (T <TELL "off">)>
		<TELL ". You can quickly see it ">
		<COND (<0? <SET TICK <GET <INT I-MM-COMPRESSOR> ,C-TICK>>>
		       <TELL "is out of fuel">)
		      (T
		       <COND (<==? .TICK 80>
			      <TELL "has">)
		      	     (T <TELL "started with">)>
		       <TELL " fuel for an hour and a half's operation">)>
		<TELL ". A retractable " D ,AIR-HOSE " is built in." CR>)
	       (<VERB? LAMP-ON>
		<COND (<FSET? ,MM-COMPRESSOR ,ONBIT>
		       <TELL-ALREADY "on">)
		      (T
		       <ENABLE <INT I-MM-COMPRESSOR>>
		       <FSET ,MM-COMPRESSOR ,ONBIT>
		       <TELL "Okay. The compressor is on." CR>)>)
	       (<VERB? LAMP-OFF>
		<COND (<FSET? ,MM-COMPRESSOR ,ONBIT>
		       <DISABLE <INT I-MM-COMPRESSOR>>
		       <FCLEAR ,MM-COMPRESSOR ,ONBIT>
		       <TELL-NOW ,MM-COMPRESSOR "off">)
		      (T <TELL-ALREADY "off">)>)
	       (<AND <VERB? LISTEN>
		     <FSET? ,MM-COMPRESSOR ,ONBIT>>
		<TELL "The compressor is making a steady loud noise." CR>)>>

<OBJECT AIR-HOSE
	(IN MM-COMPRESSOR)
	(DESC "airhose")
	(SYNONYM AIRHOSE HOSE)
	(ADJECTIVE AIR RETRAC)
	(FLAGS NDESCBIT TRYTAKEBIT VOWELBIT)
	(ACTION AIR-HOSE-F)>

<ROUTINE AIR-HOSE-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<IN? ,AIR-HOSE ,DEEP-SUIT>
		       <COND (<==? <GETP ,HERE ,P?LINE>
				   ,UNDERWATER-LINE-C>
			      <TELL
"This " D ,AIR-HOSE " goes from the aft deck of the " D ,SALVAGER" and ends at
your diving suit. Without it, you would find breathing impossible." CR>)
			     (T <TELL
"It connects the " D ,DEEP-SUIT " and the " D ,MM-COMPRESSOR " ">
			      <COND (<EQUAL? ,HERE ,MM-AFT-DECK>
				     <TELL "here">)
				    (T <TELL "on the aft deck">)>
			      <TELL "." CR>)>)
		      (T <TELL
"It is designed to be connected to a " D ,DEEP-SUIT " to provide air and
is about 600 feet long." CR>)>)
	       (<AND <VERB? PUT TIE>
		     <OR <PRSI? ,DEEP-SUIT>
			 <PRSO? ,DEEP-SUIT>>>
		<COND (<IN? ,AIR-HOSE ,DEEP-SUIT>
		       <TELL-ALREADY "connected">)
		      (T
		       <MOVE ,AIR-HOSE ,DEEP-SUIT>
		       <TELL-NOW ,AIR-HOSE ,CONNECT-STR>)>)
	       (<VERB? TAKE>
		<COND (<IN? ,AIR-HOSE ,DEEP-SUIT>
		       <TELL-ALREADY ,CONNECT-STR>)
		      (T <TELL
"Why drag it around? Just connect it to the " D ,DEEP-SUIT "." CR>)>)
	       (<VERB? TIE>
		<TELL-YOU-CANT "connect the airhose to that!">)
	       (<VERB? UNTIE>
		<COND (<EQUAL? <GETP ,HERE ,P?LINE>
			       ,UNDERWATER-LINE-C>
		       <JIGS-UP "Oops! So much for instantly growing gills.">)
		      (T
		       <MOVE ,AIR-HOSE ,MM-COMPRESSOR>
		       <TELL "The hose retracts back to the compressor." CR>)>)
	       (<VERB? MOVE>
		<TELL "That was fun." CR>)
	       (<VERB? CLIMB-FOO>
		<TELL-YOU-CANT "climb that!">)>>

<GLOBAL CONNECT-STR "connected to the deep-sea diving suit">

<ROOM MM-WHEELHOUSE
      (IN ROOMS)
      (DESC "Wheelhouse")
      (FLAGS RLANDBIT ONBIT)
      (SOUTH TO MM-AFT-DECK)
      (DOWN TO MM-GALLEY)
      (GLOBAL DECK SALVAGER TRAWLER LADDER-TOP WINDOW OCEAN)
      (PSEUDO "WHEEL" WHEEL-PSEUDO "COMPRE" COMPRESSOR-PSEUDO)
      (LINE 5)
      (STATION MM-AFT-DECK)
      (ACTION MM-WHEELHOUSE-F)>

<ROUTINE TELL-WHEELHOUSE (OBJ)
	<TELL " Through the glass windows you see the ">
	<COND (,AT-SEA <TELL "ocean churning all around you." CR>)
	      (T <TELL
D .OBJ " docked at the wharf, and the island stretching aft.
Forward, you see the choppy waters of the bay." CR>)>>

;<TELL
"wharf and the island beyond, stretching out to the south. Forward, you
see the choppy waters of the bay. To starboard you can see the salvager docked.">

<ROUTINE MM-WHEELHOUSE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in the wheelhouse with a passageway leading out onto the deck abaft.
You can see the " D ,MM-COMPRESSOR " sitting there, taking up most of the aft deck.">
		<TELL-WHEELHOUSE ,TRAWLER>
		<RTRUE>)
	       (<==? .RARG ,M-BEG>
		<COND (<EQUAL? ,OCEAN ,PRSO ,PRSI>
		       <COND (<VERB? EXAMINE>
			      <TELL
"You see the ocean through the window." CR>)
			     (<VERB? FIND ASK-ABOUT>
			      <RFALSE>)
			     (T <TELL-YOU-CANT "from here.">)>)>)>>  

<ROUTINE COMPRESSOR-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "large air compressor">)
	       (<VERB? EXAMINE>
		<TELL-YOU-CANT "make out too many details from here.">)
	       (T <TELL-CANT-REACH "it from here">)>>

;<ROOM MM-HEAD
      (IN ROOMS)
      (DESC "Head")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"You are in the small head aboard the Mary Margaret. There's barely enough
room to turn around and get out abaft.")
      (SOUTH TO MM-LOCKER)
      (GLOBAL DECK SALVAGER)
      (LINE 5)
      (STATION MM-LOCKER)>

<ROOM MM-LOCKER
      (IN ROOMS)
      (DESC "Storage Locker")
      (FLAGS RLANDBIT ONBIT)
      ;(NORTH TO MM-HEAD)
      (SOUTH TO MM-CREW-QTRS)
      (GLOBAL DECK SALVAGER)
      (LINE 5)
      (PSEUDO "LOCKER" GLOBAL-ROOM-F)
      (STATION MM-CREW-QTRS)
	(ACTION MM-LOCKER-F)>

<ROUTINE MM-LOCKER-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK>
	<TELL
"You are in a relatively empty locker." ,SPARE-PARTS-STR CR>)>>

<GLOBAL SPARE-PARTS-STR
" There are spare parts for the engine and other equipment scattered about.">

<OBJECT METAL-DETECTOR
	(IN MM-LOCKER)
	(DESC "small machine")
	(SYNONYM MACHIN DETECT DEVICE)
	(ADJECTIVE SMALL METAL ACME)
	(FLAGS CONTBIT TRANSBIT SEARCHBIT TAKEBIT)
	(ACTION METAL-DETECTOR-F)>

<ROUTINE METAL-DETECTOR-F ("AUX" TMP)
	 <COND (<VERB? EXAMINE>
		<TELL 
"The " D ,METAL-DETECTOR "'s label is well-worn. It has a "
D ,DETECTOR-SWITCH " which is currently ">
		<COND (,DETECTOR-ON <TELL "on">)
		      (T <TELL "off">)>
		<TELL ", and a compartment on the side which is ">
		<COND (<FSET? ,DETECTOR-COMPARTMENT ,OPENBIT>
		       <TELL "open">
		       <COND (<SET TMP <FIRST? ,DETECTOR-COMPARTMENT>>
			      <TELL " and contains " A .TMP>)>)
		      (T <TELL "closed">)>
		<TELL "." CR>
		<RTRUE>)
	       (<VERB? LAMP-ON>
		<SETG DETECTOR-ON T>
		<TELL-SWITCH "on">
		<RTRUE>)
	       (<VERB? LAMP-OFF>
		<SETG DETECTOR-ON <>>
		<TELL-SWITCH "off">
		<RTRUE>)
	       (<VERB? LISTEN>
		<DETECTOR-NOISE T>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSI? ,METAL-DETECTOR>>
		<PERFORM ,V?PUT ,PRSO ,DETECTOR-COMPARTMENT>
		<RTRUE>)
	       (<VERB? OPEN CLOSE EMPTY>
		<PERFORM ,PRSA ,DETECTOR-COMPARTMENT>
		<SETG P-IT-OBJECT ,METAL-DETECTOR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<PERFORM ,V?EXAMINE ,DETECTOR-COMPARTMENT>
		<SETG P-IT-OBJECT ,METAL-DETECTOR>
		<RTRUE>)
	       (<VERB? SHAKE>
		<COND (<AND <FSET? ,DETECTOR-COMPARTMENT ,OPENBIT>
			    <FIRST? ,DETECTOR-COMPARTMENT>>
		       <MOVE ,DRY-CELL ,HERE>
		       <SETG DETECTOR-POWERED <>>
		       <TELL
"The " D ,DRY-CELL " falls out of the machine." CR>)
		      (T <TELL "Nothing happens." CR>)>
		<RTRUE>)>>

<OBJECT DETECTOR-LABEL
	(IN METAL-DETECTOR)
	(DESC "machine label")
	(SYNONYM LABEL TAG STICKE LOGO)
	(ADJECTIVE WELL WORN WELL-W MACHIN DETECT METAL SMALL)
	(TEXT 
"The label is worn, so all you can make out is a large \"ACME\" at the top.")
	(FLAGS READBIT NDESCBIT)
	(ACTION DETECTOR-LABEL-F)>

<ROUTINE DETECTOR-LABEL-F ()
	 <COND (<VERB? TAKE>
		<TELL "You tug at it, but it can't be pulled off." CR>
		<RTRUE>)>>

<OBJECT DETECTOR-SWITCH
	(IN METAL-DETECTOR)
	(DESC "machine switch")
	(SYNONYM SWITCH)
	(ADJECTIVE MACHIN DETECT METAL SMALL POWER ON-OFF ON/OFF)
	(FLAGS NDESCBIT TURNBIT)
	(ACTION DETECTOR-SWITCH-F)>

<ROUTINE DETECTOR-SWITCH-F ()
	 <COND (<VERB? EXAMINE>
		<COND (,DETECTOR-ON
		       <TELL-SWITCH "on">)
		      (T <TELL-SWITCH "off">)>
		<RTRUE>)
	       (<VERB? LAMP-ON>
		<PERFORM ,V?LAMP-ON ,METAL-DETECTOR>
		<SETG P-IT-OBJECT ,DETECTOR-SWITCH>
		<RTRUE>)
	       (<VERB? LAMP-OFF>
		<PERFORM ,V?LAMP-OFF ,METAL-DETECTOR>
		<SETG P-IT-OBJECT ,DETECTOR-SWITCH>
		<RTRUE>)
	       (<VERB? TURN MOVE THROW>
		<COND (,DETECTOR-ON <PERFORM ,V?LAMP-OFF ,METAL-DETECTOR>)
		      (T <PERFORM ,V?LAMP-ON ,METAL-DETECTOR>)>
		<SETG P-IT-OBJECT ,DETECTOR-SWITCH>
		<RTRUE>)>>

<OBJECT DETECTOR-COMPARTMENT
	(IN METAL-DETECTOR)
	(DESC "machine compartment")
	(SYNONYM COMPAR RECESS PANEL)
	(ADJECTIVE SMALL MACHIN METAL DETECT)
	(CAPACITY 3)
	(CONTFCN DETECTOR-COMPARTMENT-F)
	(FLAGS CONTBIT NDESCBIT)
	(ACTION DETECTOR-COMPARTMENT-F)>

<ROUTINE DETECTOR-COMPARTMENT-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-CONT>
		<COND (<AND <VERB? TAKE>
			    <PRSO? ,DRY-CELL>>
		       <COND (<ITAKE>
			      <TELL "Taken." CR>
			      <COND (,DETECTOR-POWERED
				     <SETG DETECTOR-POWERED <>>)>)>
		       <RTRUE>)>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<FSET? ,DETECTOR-COMPARTMENT ,OPENBIT>
		       <TELL 
"The compartment is on the side of the machine. Inside ">
			<COND (<FIRST? ,DETECTOR-COMPARTMENT>
			       <TELL "is a connected">)
			      (T <TELL "are connections for a">)>
			<TELL " nine-volt " D ,DRY-CELL "." CR>)
		       (T
			<TELL-CLOSED "small panel on the side of the machine">)>
		<RTRUE>)
	       (<VERB? PUT>
		<COND (<PRSO? ,DETECTOR-COMPARTMENT>
		       <RFALSE>)
		      (<NOT <FSET? ,DETECTOR-COMPARTMENT ,OPENBIT>>
		       <TELL-CLOSED "panel">)
		      (<PRSO? ,DRY-CELL>
		       <MOVE ,DRY-CELL ,DETECTOR-COMPARTMENT>
		       <COND (<NOT <FSET? ,DRY-CELL ,RMUNGBIT>>
			      <SETG DETECTOR-POWERED T>)>
		       <TELL "The " D ,DRY-CELL " fits snugly inside." CR>
		       <RTRUE>)
		      (T <TELL "Unfortunately, it doesn't fit." CR>)>)
	       (<AND <VERB? OPEN>
		     <IN? ,DRY-CELL ,DETECTOR-COMPARTMENT>
		     <==? <GETP ,HERE ,P?LINE> ,UNDERWATER-LINE-C>
		     <NOT <AIRTIGHT-ROOM?>>>
		<FSET ,DRY-CELL ,RMUNGBIT>
		<SETG DETECTOR-POWERED <>>
		<RFALSE>)
	       (<AND <VERB? EMPTY>
		     <FSET? ,DETECTOR-COMPARTMENT ,OPENBIT>>
		<SETG DETECTOR-POWERED <>>
		<RFALSE>)>>

<OBJECT DEEP-SUIT
	(IN MM-LOCKER)
	(DESC "deep-sea diving suit")
	(SYNONYM SUIT HOOD)
	(ADJECTIVE DEEP DEEP-S SEA DIVING BULKY)
	(FLAGS TAKEBIT WEARBIT CONTBIT OPENBIT)
	(ACTION DEEP-SUIT-F)>

<ROUTINE DEEP-SUIT-F ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL-NO-NO>)
	       (<VERB? EXAMINE>
		<TELL
"This " D ,DEEP-SUIT " is bulky on land, but underwater it will
protect you to 500 feet. It has a hood with \"viewport\" and a
connection for a compressor hose." CR>)
	       (<AND <VERB? PUT>
		     <PRSI? ,DEEP-SUIT>
		     <NOT <PRSO? ,AIR-HOSE>>>
		<TELL-NO-NO>)
	       (<AND <VERB? WEAR>
		     <FSET? ,WET-SUIT ,WORNBIT>>
		<TELL-NO-FIT "over the wet suit">)
	       (<AND <VERB? DROP THROW DISEMBARK>
		     <==? <GETP ,HERE ,P?LINE> ,UNDERWATER-LINE-C>>
		<JIGS-UP
"You take the suit off and quickly realize you're not a dolphin. You realize
this too late, though.">)>>

<ROOM MM-CREW-QTRS
      (IN ROOMS)
      (DESC "Crew's Quarters")
      (FLAGS RLANDBIT ONBIT)
      (NORTH TO MM-LOCKER)
      (SOUTH TO MM-GALLEY)
      (UP TO MM-FORE-DECK)
      (GLOBAL DECK SALVAGER LADDER-BOTTOM)
      (LINE 5)
      (STATION MM-CREW-QTRS)
      (PSEUDO "BUNKS" BUNKS-PSEUDO)
      (ACTION MM-CREW-QTRS-F)>

<ROUTINE MM-CREW-QTRS-F (RARG "AUX" W)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL-CREW-QTRS>
		<RTRUE>)
	       (<==? .RARG ,M-ENTER>
		<MOVE-SHARED-OBJECTS ,MM-CREW-QTRS>
		<RFALSE>)
	       ;(<==? .RARG ,M-BEG>
		<COND (<AND <NOT ,GROGGIED>
			    ,AT-SEA
			    <SET W <W-KLUDGE>>>
		       <SETG GROGGIED T>
		       <START-SENTENCE .W>
		       <TELL " looks up groggily. ">
		       <RFALSE>)>)>>

;<GLOBAL GROGGIED <>>

;<ROUTINE W-KLUDGE ()
	 <COND (<EQUAL? ,WINNER ,WEASEL ,PETE>
		<RETURN ,WINNER>)
	       (<VERB? ASK-ABOUT>
		<RETURN ,PRSO>)
	       (T <RFALSE>)>>

<OBJECT BUNK
	(IN MM-CREW-QTRS)
	(DESC "bunk")
	(SYNONYM BUNK BED MATTRE)
	(FLAGS VEHBIT SURFACEBIT CONTBIT OPENBIT TRANSBIT NDESCBIT)
	(CAPACITY 25)
	(STATION 30) ;"metal content"
	(ACTION BUNK-F)>

<ROUTINE BUNK-F ("OPTIONAL" (RARG <>) "AUX" F)
	 <COND (<NOT .RARG>
		<COND (<AND <VERB? BOARD SLEEP>
		       	    <OR <AND <SET F <FIRST? ,BUNK>>
				     <NOT <==? .F ,PLAYER>>>
				<WEARING-SOMETHING?>>>
		       <TELL-NOT-COMFORTABLE>)
		      (<VERB? PUT-UNDER HIDE-UNDER>
		       <COND (<PRSO? ,ME ,GLOBAL-SELF>
			      <TELL "You won't fit." CR>)
			     (<L? <GETP ,PRSO ,P?SIZE> 5>
		       	      <COND (<FIRST? ,UNDER-BUNK>
				     <TELL-NO-FIT>)
				    (T
				     <MOVE ,PRSO ,UNDER-BUNK>
		       	      	     <FSET ,PRSO ,NDESCBIT>
		       	      	     <TELL-NOW ,PRSO "hidden under the mattress">)>)
		      	     (T <TELL-NO-FIT>)>)
	       	      (<VERB? LOOK-UNDER>
		       <COND (<SET F <FIRST? ,UNDER-BUNK>>
		       	      <SETG P-IT-OBJECT .F>
		       	      <TELL "There is " A .F " under the mattress." CR>)
			     (T <TELL "Nobody's hidden his life savings there." CR>)>)>)>>

<ROUTINE WEARING-SOMETHING? ("AUX" F)
	 <SET F <FIRST? ,PLAYER>>
	 <REPEAT ()
	  <COND (<NOT .F> <RFALSE>)
		(<AND <FSET? .F ,WORNBIT>
		      <NOT <==? .F ,WATCH>>>
		 <RTRUE>)
		(T <SET F <NEXT? .F>>)>>>

<OBJECT UNDER-BUNK
	(IN MM-CREW-QTRS)
	(DESC "under the bunk")
	(FLAGS CONTBIT NDESCBIT OPENBIT)
	(CAPACITY 10)
	(DESCFCN UNDER-BUNK-F)
	(CONTFCN UNDER-BUNK-F)>

<ROUTINE UNDER-BUNK-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-OBJDESC>
		<RTRUE>)
	       (<==? .RARG ,M-CONT>
		<COND (<VERB? TAKE>
		       <FCLEAR ,PRSO ,NDESCBIT>
		       <RFALSE>)>)>>

<ROUTINE BUNKS-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "bunks">)
	       (T <TELL "The only bunk you should worry about is your own." CR>)>>

<ROOM MM-GALLEY
      (IN ROOMS)
      (DESC "Galley")
      (FLAGS RLANDBIT ONBIT)
      (NORTH TO MM-CREW-QTRS)
      (SOUTH TO MM-LOUNGE)
      (UP TO MM-WHEELHOUSE)
      (GLOBAL DECK SALVAGER LADDER-BOTTOM)
      (LINE 5)
      (STATION MM-GALLEY)
      (ACTION MM-GALLEY-F)>

<ROUTINE MM-GALLEY-F (RARG)
	 <GENERIC-GALLEY-F .RARG ,MM-GALLEY>>

<ROUTINE GENERIC-GALLEY-F (RARG PLACE)
	 <COND (<==? .RARG ,M-ENTER>
		<PUTP ,GLOBAL-SURFACE ,P?SDESC "table">
		<MOVE-SHARED-OBJECTS .PLACE>
		<RFALSE>)
	       (<==? .RARG ,M-LOOK>
		<TELL "You are in the ">
		<COND (<==? .PLACE ,MM-GALLEY>
		       <TELL D ,SALVAGER>)
		      (T <TELL D ,TRAWLER>)>
		<TELL
"'s galley. A stove and a small table are the fixtures here.">
		<COND (<IN? ,FOOD ,STOVE>
		       <TELL-STEW-ON>)>
		<COND (<AND ,WATER-DELIVERED
			    <==? <GETP ,SHIP-CHOSEN ,P?LINE>
				 <GETP ,PLACE ,P?LINE>>>
		       <TELL " Water is available.">)>
		<TELL
" A ladder leads up through the deck to the wheelhouse for
feeding the captain in rough weather." CR>)
	       (<==? .RARG ,M-BEG>
		<COND (<DOUBLE-DUTY-CHECK>
		       <RTRUE>)>)>>

<ROUTINE DOUBLE-DUTY-CHECK ()
	 <COND (<AND <VERB? ASK-FOR>
		     <PRSO? ,PETE>>
		<COND (<PRSI? ,FOOD>
		       <COND (,SOUPS-ON
			      <TELL "\"Take some " D ,GLOBAL-SELF ".\"" CR>)
			     (T <TELL "\"Wait 'til it's ready.\"" CR>)>)
		      (<PRSI? ,DRINKING-WATER>
		       <TELL "\"Take it " D ,GLOBAL-SELF ".\"" CR>)>)>>

<ROUTINE TELL-STEW-ON ("OPTIONAL" (LEAD? T))
	 <COND (.LEAD? <TELL " ">)>
	 <TELL "A pot of stew is simmering on the stove.">>

<OBJECT STOVE
	(IN MM-GALLEY)
	(DESC "stove")
	(SYNONYM STOVE RANGE GIMBAL)
	(ADJECTIVE SMALL)
	(FLAGS SURFACEBIT OPENBIT CONTBIT NDESCBIT)
	(CAPACITY 5)
	(ACTION STOVE-F)>

<ROUTINE STOVE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The small stove rests on gimbals that keep it relatively level.">
		<COND (<IN? ,FOOD ,STOVE>
		       <TELL-STEW-ON>)>
		<CRLF>)
	       (<AND <VERB? LOOK-INSIDE>
		     <IN? ,FOOD ,STOVE>>
		<TELL-STEW-ON <>>
		<CRLF>)
	       (<VERB? LAMP-ON LAMP-OFF>
		<TELL "That's Pete's job." CR>)>>

;<OBJECT CUPBOARDS
	(IN MM-GALLEY)
	(DESC "set of cupboards")
	(SYNONYM CUPBOA CABINE SET)
	(ADJECTIVE EMPTY BARE FEW STORAG)
	(FLAGS NDESCBIT CONTBIT)
	(CAPACITY 1)
	(ACTION CUPBOARDS-F)>

;<ROUTINE CUPBOARDS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "There are a few ">
		<COND (<FSET? ,CUPBOARDS ,OPENBIT>
		       <TELL "empty">)
		      (T <TELL "closed">)>
		<TELL " storage cupboards here." CR>)
	       (<VERB? OPEN>
		<COND (<FSET? ,CUPBOARDS ,OPENBIT>
		       <TELL "They're already open." CR>)
		      (T
		       <FSET ,CUPBOARDS ,OPENBIT>
		       <TELL
"Opening them reveals nothing but empty cupboards." CR>)>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,CUPBOARDS ,OPENBIT>
		       <FCLEAR ,CUPBOARDS ,OPENBIT>
		       <TELL "Closed." CR>)
		      (T <TELL "They're already closed." CR>)>)
	       (<AND <VERB? PUT>
		     <PRSI? ,CUPBOARDS>>
		<TELL "It would only make Pete mad." CR>)>>

<ROOM MM-LOUNGE
      (IN ROOMS)
      (DESC "Lounge")
      (FLAGS RLANDBIT ONBIT)
      (LDESC
"You are in a small, cramped cabin decorated with a table and a few chairs.
To the aft is the captain's cabin, while the galley lies forward. A ladder
leading down goes into the engine room.")
      (NORTH TO MM-GALLEY)
      (SOUTH TO MM-CAPT-CABIN)
      (UP TO MM-AFT-DECK)
      (DOWN TO MM-ENGINE-ROOM)
      (GLOBAL DECK SALVAGER LADDER-BOTTOM LADDER-TOP)
      (LINE 5)
      (STATION MM-LOUNGE)
      (ACTION MM-LOUNGE-F)>

<ROUTINE MM-LOUNGE-F (RARG)
	 <COND (<==? .RARG ,M-ENTER>
		<PUTP ,GLOBAL-SURFACE ,P?SDESC "table">
		<MOVE-SHARED-OBJECTS ,MM-LOUNGE>
		<RFALSE>)>>

<OBJECT LOUNGE-CHAIR
	(IN MM-LOUNGE)
	(DESC "chair")
	(SYNONYM CHAIR CHAIRS SEAT)
	(FLAGS NDESCBIT VEHBIT SURFACEBIT TRANSBIT OPENBIT)
	(CAPACITY 10)
	(ACTION LOUNGE-CHAIR-F)>

<ROUTINE LOUNGE-CHAIR-F ("OPTIONAL" (RARG <>) "AUX" F)
	 <COND (<PRSO? ,CHAIR>
		<COND (<VERB? BOARD>
		       <COND (<SET F <FIRST? ,CHAIR>>
			      <TELL-NOT-COMFORTABLE>)>)>)>>

<ROOM MM-CAPT-CABIN
      (IN ROOMS)
      (DESC "Captain's Cabin")
      (FLAGS RLANDBIT ONBIT)
      (LDESC
"You are in the captain's cabin. There is a large and
comfortable-looking bunk here. The forward doorway leads to the
crew's lounge.")
      (NORTH TO MM-LOUNGE)
      (GLOBAL DECK SALVAGER)
      (LINE 5)
      (STATION MM-LOUNGE)>

;<OBJECT REDS-LAMP
	(IN MM-CAPT-CABIN)
	(DESC "reading lamp")
	(SYNONYM LAMP LIGHT)
	(ADJECTIVE READIN)
	(FLAGS NDESCBIT)
	(ACTION REDS-LAMP-F)>

;<ROUTINE REDS-LAMP-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The lamp is ">
		<COND (<FSET? ,REDS-LAMP ,ONBIT>
		       <TELL "on">)
		      (T <TELL "off">)>
		<TELL "." CR>)
	       (<VERB? LAMP-ON>
		<COND (<FSET? ,REDS-LAMP ,ONBIT>
		       <TELL-ALREADY "on">)
		      (T
		       <FSET ,REDS-LAMP ,ONBIT>
		       <TELL-NOW ,REDS-LAMP "on">)>)
	       (<VERB? LAMP-OFF>
		<COND (<FSET? ,REDS-LAMP ,ONBIT>
		       <FCLEAR ,REDS-LAMP ,ONBIT>
		       <TELL "The lamp is now off." CR>)
		      (T <TELL-ALREADY "off">)>)>>

<OBJECT REDS-BUNK
	(IN MM-CAPT-CABIN)
	(DESC "large bunk")
	(SYNONYM BUNK BED MATTRE)
	(ADJECTIVE LARGE COMFOR LOOKIN CAPTAI)
	(FLAGS NDESCBIT)
	(TEXT "This large, comfortable-looking bunk is the captain's.")
	(ACTION REDS-BUNK-F)>

<ROUTINE REDS-BUNK-F ()
	 <COND (<OR <VERB? BOARD SLEEP SIT>
		    <VERB? SIT-ON PUT-UNDER HIDE-UNDER>
		    <AND <VERB? PUT>
			 <PRSI? ,REDS-BUNK>>>
		<TELL "You know better than to disturb the captain's bunk!" CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL "It's shipshape." CR>)>>

<ROOM MM-ENGINE-ROOM
      (IN ROOMS)
      (DESC "Engine Room")
      (FLAGS RLANDBIT ONBIT)
      (UP TO MM-LOUNGE)
      (GLOBAL DECK SALVAGER LADDER-BOTTOM)
      (LINE 5)
      (DESCFCN 100) ;"metal content"
      (PSEUDO "ENGINE" ENGINE-PSEUDO)
      (STATION MM-LOUNGE)
      (ACTION MM-ENGINE-ROOM-F)>

<ROUTINE MM-ENGINE-ROOM-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"You are in a tiny cabin with barely enough room to breathe. By your feet lie
the huge diesel engines of the " D ,SALVAGER "." CR>)>>
 
<ROUTINE ENGINE-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "diesel engine">)
	       (<VERB? EXAMINE>
		<TELL
"The engines are extremely complex and delicate pieces of machinery." CR>)
	       (<VERB? LAMP-ON LAMP-OFF PLUG>
		<TELL
"Leave the engines to " D ,WEASEL " and he'll leave the diving to you." CR>)
	       (<AND <VERB? ASK-ABOUT>
		     <PRSO? ,WEASEL>>
		<TELL "\"These are in pretty good shape.\"" CR>)
	       (<AND <VERB? LISTEN>
		     ,AT-SEA>
	        <TELL-YOU-CANT "avoid it.">)>>

<ROOM NW-FORE-DECK
      (IN ROOMS)
      (DESC "Fore Deck")
      (FLAGS RLANDBIT ONBIT)
      (SE TO NW-STARBOARD-DECK)
      (EAST TO NW-STARBOARD-DECK)
      (SW TO NW-PORT-DECK)
      (WEST TO NW-PORT-DECK)
      (SOUTH "There's a wall in the way.")
      (DOWN TO NW-CREW-QTRS)
      (GLOBAL OCEAN DECK TRAWLER RAILING IN-WINDOW LADDER-TOP)
      (LINE 4)
      (STATION NW-FORE-DECK)
      (PSEUDO "BOLT" BOLT-PSEUDO "BOLTS" BOLT-PSEUDO)
      (ACTION NW-FORE-DECK-F)>

<ROUTINE NW-FORE-DECK-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK>
	<TELL-FORE-END ,TRAWLER>)>>

<ROOM NW-STARBOARD-DECK
      (IN ROOMS)
      (DESC "Starboard Deck")
      (FLAGS RLANDBIT ONBIT)
      (EAST TO WHARF IF TRAWLER-DOCKED ELSE "You're out to sea now.")
      (OUT TO WHARF IF TRAWLER-DOCKED ELSE "You're out to sea now.")
      (NW TO NW-FORE-DECK)
      (NORTH TO NW-FORE-DECK)
      (SW TO NW-AFT-DECK)
      (SOUTH TO NW-AFT-DECK)
      (WEST "There's a bulkhead there.")
      (GLOBAL OCEAN DECK TRAWLER RAILING IN-WINDOW)
      (LINE 4)
      (STATION NW-STARBOARD-DECK)
      (ACTION NW-STARBOARD-DECK-F)>

<ROUTINE NW-STARBOARD-DECK-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<MOVE ,BUNK ,NW-CREW-QTRS>
		<MOVE ,UNDER-BUNK ,NW-CREW-QTRS>
		<MOVE ,STOVE ,NW-GALLEY>
		;<MOVE ,CUPBOARDS ,NW-GALLEY>
		<MOVE ,DECK-CHAIR ,NW-FORE-DECK>
		;<MOVE ,REDS-LAMP ,NW-CAPT-CABIN>
		<MOVE ,REDS-BUNK ,NW-CAPT-CABIN>
		<MOVE ,LOUNGE-CHAIR ,NW-LOUNGE>
		;<MOVE ,PROW-LIGHT ,NW-FORE-DECK>
		<COND (<IN? ,PETE ,NW-GALLEY>
		       <MOVE ,FOOD ,STOVE>
		       <FSET ,FOOD ,NDESCBIT>)>
		<COND (<AND ,WATER-DELIVERED
			    <==? ,TRAWLER ,SHIP-CHOSEN>>
		       <MOVE ,DRINKING-WATER ,NW-GALLEY>
		       <FSET ,DRINKING-WATER ,NDESCBIT>)>
		<RFALSE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL-FOO-SIDE ,TRAWLER "starboard" "port">
		<RTRUE>)>>

<ROOM NW-PORT-DECK
      (IN ROOMS)
      (DESC "Port Deck")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"You are on the port side of the Night Wind. The wheelhouse is to starboard.
The teak deck is very well-kept. The ocean lies off to port.")
      (NE TO NW-FORE-DECK)
      (NORTH TO NW-FORE-DECK)
      (SE TO NW-AFT-DECK)
      (SOUTH TO NW-AFT-DECK)
      (GLOBAL OCEAN DECK TRAWLER RAILING IN-WINDOW)
      (LINE 4)
      (STATION NW-PORT-DECK)>

<ROOM NW-AFT-DECK
      (IN ROOMS)
      (DESC "Aft Deck")
      (FLAGS RLANDBIT ONBIT)
      (NE TO NW-STARBOARD-DECK)
      (EAST TO NW-STARBOARD-DECK)
      (NW TO NW-PORT-DECK)
      (WEST TO NW-PORT-DECK)
      (NORTH TO NW-WHEELHOUSE)
      (DOWN TO NW-LOUNGE)
      (GLOBAL OCEAN DECK TRAWLER RAILING LADDER-TOP)
      (LINE 4)
      (STATION NW-AFT-DECK)
      (ACTION NW-AFT-DECK-F)>

<ROUTINE NW-AFT-DECK-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL-AFT-DECK>
		<CRLF>)
	       (<EQUAL? .RARG ,M-FLASH>
		<COND (<AND <IN? ,WEASEL ,NW-AFT-DECK>
			    ,AT-SEA
			    <NOT ,WEASEL-APPREHENDED>
			    <NOT <QUEUED? I-PENDULUM>>>
		       <ENABLE <QUEUE I-PENDULUM -1>>
		       <TELL-WEASEL-TOSSES>)>)>>

<ROOM NW-WHEELHOUSE
      (IN ROOMS)
      (DESC "Wheelhouse")
      (FLAGS RLANDBIT ONBIT)
      (SOUTH TO NW-AFT-DECK)
      (DOWN TO NW-GALLEY)
      (GLOBAL DECK TRAWLER SALVAGER LADDER-TOP WINDOW OCEAN)
      (LINE 4)
      (STATION NW-AFT-DECK)
      (PSEUDO "WHEEL" WHEEL-PSEUDO)
      (ACTION NW-WHEELHOUSE-F)>

<ROUTINE NW-WHEELHOUSE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in the wheelhouse of the " D ,TRAWLER ". The passageway leading
out onto the deck lies abaft.">
		<TELL-WHEELHOUSE ,SALVAGER>
		<RTRUE>)
	       (<==? .RARG ,M-BEG>
		<COND (<EQUAL? ,OCEAN ,PRSO ,PRSI>
		       <COND (<VERB? EXAMINE>
			      <TELL
"You see the ocean through the window." CR>)
			     (T <TELL-YOU-CANT "from here.">)>)>)>>  

;<ROOM NW-HEAD
      (IN ROOMS)
      (DESC "Head")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"You are in the small head on board the Night Wind. It's so small there's
only enough room to turn around to get out aft.")
      (SOUTH TO NW-LOCKER)
      (GLOBAL DECK TRAWLER)
      (LINE 4)
      (STATION NW-LOCKER)>

<ROOM NW-LOCKER
      (IN ROOMS)
      (DESC "Storage Locker")
      (FLAGS RLANDBIT ONBIT)
      ;(NORTH TO NW-HEAD)
      (SOUTH TO NW-CREW-QTRS)
      (GLOBAL DECK TRAWLER)
      (LINE 4)
      (PSEUDO "LOCKER" GLOBAL-ROOM-F)
      (STATION NW-CREW-QTRS)
	(ACTION NW-LOCKER-F)>

<ROUTINE NW-LOCKER-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK>
	<TELL
"You are in a fairly empty storage locker. It must have been cleaned out
after its last trawling expedition." ,SPARE-PARTS-STR CR>)>>

<OBJECT DRILL
	(IN NW-LOCKER)
	(DESC "portable drill")
	(SYNONYM DRILL BIT PANEL SWITCH)
	(ADJECTIVE WATERP PORTAB ;BATTER ;OPERAT ;DRILL)
	(FLAGS TAKEBIT CONTBIT TOOLBIT)
	(CAPACITY 3)
	(STATION 25) ;"metal content"
	(CONTFCN DRILL-F)
	(ACTION DRILL-F)>

<ROUTINE TELL-SWITCH (STR)
	 <TELL "The switch is now in the \"" .STR "\" position." CR>>
	 
<ROUTINE DRILL-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-CONT>
		<COND (<AND <VERB? TAKE>
			    <PRSO? ,BATTERY>>
		       <COND (<ITAKE>
			      <TELL "Taken.">
			      <COND (,DRILL-POWERED
				     <SETG DRILL-POWERED <>>
				     <COND (,DRILL-ON
					    <DISABLE <INT I-DRILL>>
					    <TELL
				      " The drill bit winds to a halt.">)>)>
			      <CRLF>)>
		       <RTRUE>)>)
	       (<AND <VERB? LAMP-ON>
		     <PRSO? ,DRILL>>
		<COND (,DRILL-ON
		       <TELL-ALREADY "on">)
		      (,DRILL-POWERED
		       <SETG DRILL-ON T>
		       <ENABLE <INT I-DRILL>>
		       <TELL "The drill bit begins to spin." CR>)
		      (T
		       <SETG DRILL-ON T>
		       <TELL-SWITCH "on">)>)
	       (<AND <VERB? LAMP-OFF>
		     <PRSO? ,DRILL>>
		<COND (<NOT ,DRILL-ON>
		       <TELL-ALREADY "off">)
		      (,DRILL-POWERED
		       <SETG DRILL-ON <>>
		       <DISABLE <INT I-DRILL>>
		       <TELL "The drill bit stops spinning." CR>)
		      (T
		       <SETG DRILL-ON <>>
		       <TELL-SWITCH "off">)>)
	       (<VERB? EXAMINE>
		<TELL "This waterproof wonder features a permanent bit">
		<COND (<QUEUED? I-DRILL>
		       <TELL " which is turning">)>
		<TELL ", a panel which is ">
		<COND (<FSET? ,DRILL ,OPENBIT>
		       <TELL "open">
		       <COND (,DRILL-POWERED
			      <TELL " with a C battery inside">)
			     (T <TELL ", revealing space for a C battery">)>)
		      (T <TELL "closed">)>
		<TELL ", and a switch which is in the \"">
		<COND (,DRILL-ON <TELL "on">) (T <TELL "off">)>
		<TELL "\" position." CR>)
	       (<VERB? LOOK-INSIDE>
		<PERFORM ,V?EXAMINE ,DRILL>
		<RTRUE>)
	       (<AND <VERB? OPEN>
		     <PRSO? ,DRILL>
		     <IN? ,BATTERY ,DRILL>
		     <==? <GETP ,HERE ,P?LINE> ,UNDERWATER-LINE-C>
		     <NOT <AIRTIGHT-ROOM?>>>
		<FSET ,BATTERY ,RMUNGBIT>
		<SETG DRILL-POWERED <>>
		<RFALSE>)
	       (<PRSI? ,DRILL>
		<COND (<VERB? PUT>
		       <COND (<NOT <FSET? ,DRILL ,OPENBIT>>
			      <SETG P-IT-OBJECT ,DRILL>
			      <TELL-CLOSED "panel">)
			     (<PRSO? ,BATTERY>
			      <MOVE ,BATTERY ,DRILL>
			      <COND (<FSET? ,BATTERY ,RMUNGBIT>
				     <TELL-NOW ,BATTERY "in the drill">
				     <RTRUE>)>
			      <SETG DRILL-POWERED T>
			      <COND (,DRILL-ON
				     <ENABLE <INT I-DRILL>>
				     <TELL "The drill bit starts spinning." CR>)
				    (T
				     <TELL-NOW ,BATTERY "in the drill">)>)
			     (T <TELL-NO-FIT>)>)
		      (<VERB? TAKE ASK-ABOUT TELL PUT-AGAINST PUT-ON>
		       <RFALSE>)
		      (<AND <OR <NOT ,DRILL-ON>
			   	<NOT ,DRILL-POWERED>>
			    <NOT <PRSO? ,GLOBAL-TIME>>>
		       <SETG P-IT-OBJECT ,DRILL>
		       <TELL "The " D ,DRILL " isn't running!" CR>)>)>>

<GLOBAL DRILL-ON <>>
<GLOBAL DRILL-POWERED <>>

<OBJECT HOLE-1
        (IN LOCAL-GLOBALS)
        ;(DESC "hole")
	(SDESC "hole you drilled")
	(FLAGS INVISIBLE NDESCBIT)
	(SYNONYM HOLE DRILLE)
	(ADJECTIVE FIRST 1ST HOLE I)
	(ACTION GENERIC-HOLE-F)>

<OBJECT HOLE-2
        (IN LOCAL-GLOBALS)
        ;(DESC "hole")
	(SDESC "second hole you drilled")
        (FLAGS INVISIBLE NDESCBIT)
	(SYNONYM HOLE DRILLE)
	(ADJECTIVE SECOND 2ND HOLE I)
	(ACTION GENERIC-HOLE-F)>

<ROUTINE GENERIC-HOLE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "As holes go, it's very nice." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL "You see nothing new." CR>)
	       (<VERB? REACH-IN>
		<TELL "It's not that big." CR>)>>

<ROUTINE ADD-HOLE (OBJ "AUX" I)
	 <COND (<FSET? ,HOLE-1 ,INVISIBLE>
		<FCLEAR ,HOLE-1 ,INVISIBLE>
		<MOVE ,HOLE-1 .OBJ>)
	       (<FSET? ,HOLE-2 ,INVISIBLE>
		<FCLEAR ,HOLE-2 ,INVISIBLE>
		<PUTP ,HOLE-1 ,P?SDESC "first hole you drilled">
		<MOVE ,HOLE-2 .OBJ>)
	       (T <TELL "The drill should be dead now." CR>)>
         <SET I <INT I-DRILL>>
	 <PUT .I ,C-TICK <- <GET .I ,C-TICK> 1>>
	 <COND (<0? <GET .I ,C-TICK>>
		<I-DRILL>)>
	 <RTRUE>>

<ROOM NW-CREW-QTRS
      (IN ROOMS)
      (DESC "Crew's Quarters")
      (FLAGS RLANDBIT ONBIT)
      (NORTH TO NW-LOCKER)
      (SOUTH TO NW-GALLEY)
      (UP TO NW-FORE-DECK)
      (GLOBAL DECK TRAWLER LADDER-BOTTOM)
      (LINE 4)
      (STATION NW-CREW-QTRS)
      (PSEUDO "BUNKS" BUNKS-PSEUDO)
      (ACTION NW-CREW-QTRS-F)>

<ROUTINE TELL-CREW-QTRS ()
	<TELL
"You are below deck in the crew's quarters. Narrow, uncomfortable bunks
line the bulkheads, and you note the similarity between this area and a
sardine can. Sleeping here is necessary but uninviting. A ladder leads
up and out to the fore deck." CR>>

<ROUTINE NW-CREW-QTRS-F (RARG "AUX" W)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL-CREW-QTRS>)
	       (<==? .RARG ,M-ENTER>
		<MOVE-SHARED-OBJECTS ,NW-CREW-QTRS>
		<RFALSE>)
	       ;(<==? .RARG ,M-BEG>
		<COND (<AND <NOT ,GROGGIED>
			    ,AT-SEA
			    <SET W <W-KLUDGE>>>
		       <SETG GROGGIED T>
		       <START-SENTENCE .W>
		       <TELL " looks up groggily. ">
		       <RFALSE>)>)>>

<ROOM NW-GALLEY
      (IN ROOMS)
      (DESC "Galley")
      (FLAGS RLANDBIT ONBIT)
      ;(LDESC
"You are in the Night Wind's tiny galley. A stove and a small
table are all that are here. A ladder leads
up through the deck overhead to the wheelhouse for feeding the captain
in rough weather.")
      (NORTH TO NW-CREW-QTRS)
      (SOUTH TO NW-LOUNGE)
      (UP TO NW-WHEELHOUSE)
      (GLOBAL DECK TRAWLER LADDER-BOTTOM)
      (LINE 4)
      (STATION NW-GALLEY)
      (ACTION NW-GALLEY-F)>

<ROUTINE NW-GALLEY-F (RARG)
	 <GENERIC-GALLEY-F .RARG ,NW-GALLEY>>

<ROOM NW-LOUNGE
      (IN ROOMS)
      (DESC "Lounge")
      (FLAGS RLANDBIT ONBIT)
      (LDESC
"You are in the crew's lounge, a cramped cabin with little more than
a table and a few chairs. To aft is the captain's cabin, while
the galley lies forward. A ladder leads into the engine room.")
      (NORTH TO NW-GALLEY)
      (SOUTH TO NW-CAPT-CABIN)
      (UP TO NW-AFT-DECK)
      (DOWN TO NW-ENGINE-ROOM)
      (GLOBAL DECK TRAWLER LADDER-BOTTOM LADDER-TOP)
      (LINE 4)
      (STATION NW-LOUNGE)
      (ACTION NW-LOUNGE-F)>

<ROUTINE NW-LOUNGE-F (RARG)
	 <COND (<==? .RARG ,M-ENTER>
		<PUTP ,GLOBAL-SURFACE ,P?SDESC "table">
		<MOVE-SHARED-OBJECTS ,NW-LOUNGE>
		<RFALSE>)>>

<ROOM NW-CAPT-CABIN
      (IN ROOMS)
      (DESC "Captain's Cabin")
      (FLAGS RLANDBIT ONBIT)
      (LDESC
"You are in the captain's cabin. A large and
comfortable-looking bunk is one of the many comforts in the
cabin. The forward doorway leads to the crew's lounge.")
      (NORTH TO NW-LOUNGE)
      (GLOBAL DECK TRAWLER)
      (LINE 4)
      (STATION NW-LOUNGE)>

<ROOM NW-ENGINE-ROOM
      (IN ROOMS)
      (DESC "Engine Room")
      (FLAGS RLANDBIT ONBIT)
      (UP TO NW-LOUNGE)
      (GLOBAL DECK TRAWLER LADDER-BOTTOM)
      (LINE 4)
      (DESCFCN 100) ;"metal content"
      (PSEUDO "ENGINE" ENGINE-PSEUDO)
      (STATION NW-LOUNGE)
      (ACTION NW-ENGINE-ROOM-F)>

<ROUTINE NW-ENGINE-ROOM-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"You are in a tiny, smelly space where it is difficult to breathe.
By your feet lie the diesel engines of the " D ,TRAWLER "." CR>)>>