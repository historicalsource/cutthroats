"GLOBALS for
			      TOA #2
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved.
"

<DIRECTIONS NORTH EAST WEST SOUTH UP DOWN IN OUT SE SW NE NW>

"SUBTITLE GLOBAL OBJECTS"


<OBJECT GLOBAL-OBJECTS
	(FLAGS RMUNGBIT INVISIBLE TOUCHBIT SURFACEBIT TRYTAKEBIT VICBIT DOORBIT
	      TURNBIT PERSON VOWELBIT OPENBIT SEARCHBIT TRANSBIT WEARBIT ONBIT
	      TOOLBIT RENTBIT PUSHBIT WORNBIT)
	;(FDESC "")
	;(LDESC "")
	;(TEXT "")
	;(SIZE 0)
	;(VALUE 0)
	;(CAPACITY 0)>

<OBJECT LOCAL-GLOBALS
	(IN GLOBAL-OBJECTS)
	(SYNONYM ZZMGCK)
	;(DESCFCN 0)
        ;(GLOBAL GLOBAL-OBJECTS)
	;(PSEUDO "FOOBAR" V-WAIT)
	;(CONTFCN 0)
	;(SIZE 0)>
;"Yes, this synonym for LOCAL-GLOBALS needs to exist... sigh"

<OBJECT ROOMS>

<OBJECT RED-HERRING
	(IN LOCAL-GLOBALS)
	(DESC "thingy")
	(SYNONYM COMBIN)
	(ACTION RED-HERRING-F)>

<ROUTINE RED-HERRING-F ()
	 <COND (<VERB? ASK-ABOUT>
		<RFALSE>)
	       (T <GLOBAL-NOT-HERE-PRINT ,RED-HERRING>)>>

;<OBJECT FOO-TOOL
	(IN GLOBAL-OBJECTS)
	(SYNONYM HAMMER CROWBA EXPLOS MACHET)
	(DESC "such thing")>

;<OBJECT FINGER
	(IN GLOBAL-OBJECTS)
	(FLAGS SURFACEBIT OPENBIT CONTBIT TOUCHBIT)
	(CAPACITY 1)
	(SYNONYM FINGER)
	(DESC "finger")
	;(ACTION FINGER-FCN)>

;<ROUTINE FINGER-FCN ()
	 <COND (<AND <VERB? PUT-ON>
		     <PRSI? ,FINGER>>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<FSET? ,RING ,WEARBIT>
		       <TELL "Sitting on your finger is a ring." CR>
		       <RTRUE>)
		      (T
		       <TELL "It's part of your hands." CR>
		       <RTRUE>)>)>>

<OBJECT INTNUM
	(IN GLOBAL-OBJECTS)
	(SYNONYM INTNUM)
	;(DESC "number")
	(SDESC "number")
	(ACTION INTNUM-F)>

<ROUTINE INTNUM-F ()
	 <COND (<AND <VERB? GIVE WITHDRAW>
		     <NOT ,P-DOLLAR-FLAG>>
		<TELL "Next time, tell me what there's " N ,P-NUMBER " of." CR>
		<SETG CLOCK-WAIT T>
		<RFATAL>)
	       (<AND ,P-DOLLAR-FLAG
		     <NOT <VERB? WITHDRAW TAKE ASK-FOR>>
		     <==? ,WINNER ,PLAYER>
		     <G? ,P-AMOUNT ,POCKET-CHANGE>>
		<TELL-DONT-HAVE "that much">)>>

<OBJECT INTDIR
	(IN GLOBAL-OBJECTS)
	(SYNONYM INTDIR)
	(ADJECTIVE NORTH EAST SOUTH WEST NE NW SE SW)
	;(FLAGS TOOLBIT)
	(DESC "direction")>

<OBJECT PSEUDO-OBJECT
	;(DESC "pseudo")
	(SDESC "bunch of clothes")
	(DESCFCN 0)
	(ACTION CRETIN-F)>

<OBJECT IT
	(IN GLOBAL-OBJECTS)
	(SYNONYM IT THAT HIM HER)
	(DESC "random object")
	(FLAGS NDESCBIT TOUCHBIT)>

<OBJECT AIR
	(IN GLOBAL-OBJECTS)
	(DESC "air")
	(FLAGS VOWELBIT CONTBIT OPENBIT)
	(SYNONYM AIR OXYGEN)
	(TEXT "Air being what it is, you can't see it.")
	(ACTION AIR-F)>

<ROUTINE AIR-F ()
	 <COND (<VERB? SMELL TASTE>
		<COND (<AND <AIRTIGHT-ROOM?>
			    <NOT <FSET? ,MASK ,WORNBIT>>>
		       <TELL "The air is musty but breathable." CR>)
		      (<EQUAL? ,HERE ,MM-ENGINE-ROOM ,NW-ENGINE-ROOM>
		       <TELL "The air is heavy with diesel fumes." CR>)
		      (<==? <GETP ,HERE ,P?LINE> ,UNDERWATER-LINE-C>
		       <TELL
"It feels a whole lot better than the water you could be breathing." CR>)
		      (T
		       <TELL "You find nothing special about the air." CR>)>)
	       (<VERB? OPEN CLOSE>
		<TELL "I think you're an air head." CR>)
	       (<VERB? LOOK-INSIDE>
		<PERFORM ,V?LOOK>
		<RTRUE>)
	       (<AND <EQUAL? ,PRSI ,AIR>
		     <VERB? THROW DROP>>
		<PERFORM ,PRSA ,PRSO ,GROUND>
		<RTRUE>)>>

<OBJECT GROUND	;"was GROUND"
	(IN GLOBAL-OBJECTS)
	(SYNONYM FLOOR GROUND)
	(ADJECTIVE OCEAN)
	(DESC "floor")
	(ACTION FLOOR-F)>

<ROUTINE FLOOR-F ()
	 <COND (<AND <VERB? PUT-ON PUT>
		     <PRSI? ,GROUND>>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)>>

<OBJECT DECK
	(IN LOCAL-GLOBALS)
	(SYNONYM DECK)
	(ADJECTIVE NORTH SOUTH EAST WEST);"my fingers are crossed"
	(DESC "deck")
	(ACTION DECK-F)>

<ROUTINE DECK-F ()
	 <COND (<VERB? WALK-TO>
		<TELL-SHD-DIR>)
	       (<AND <VERB? PUT-ON PUT>
		     <PRSI? ,DECK>>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)>>

<OBJECT FLOOR-HOLE-1
	(IN LOCAL-GLOBALS)
	(DESC "hole")
	(SYNONYM HOLE HATCH HATCHW)
	(ADJECTIVE BOTTOM LOWER)
	(FLAGS INVISIBLE)
	(ACTION FLOOR-HOLE-F)>

<OBJECT FLOOR-HOLE-2
	(IN LOCAL-GLOBALS)
	;(DESC "hole")
	(SDESC "hole")
	(SYNONYM HOLE HATCH HATCHW)
	(ADJECTIVE BOTTOM LOWER)
	(FLAGS INVISIBLE)
	(ACTION FLOOR-HOLE-F)>

<ROUTINE FLOOR-HOLE-F ()
	 <COND (<VERB? THROUGH>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE ;LOOK-DOWN>
		<TELL-YOU-CANT "make anything out on the other side.">)
	       (<VERB? EXAMINE>
		<COND (<AND <==? ,HERE ,WRECK-5>
			    <NOT ,WRECK-5-FLOODED>>
		       <TELL "There's water on the other side." CR>)
		      (T <TELL-LOOKS-HOLE>)>)>>

<ROUTINE TELL-LOOKS-HOLE ()
	 <TELL "It looks a lot like a hole." CR>>

<OBJECT CEILING-HOLE-1
	(IN LOCAL-GLOBALS)
	(DESC "hole")
	(SYNONYM HOLE HATCH HATCHW)
	(ADJECTIVE TOP UPPER)
	(FLAGS INVISIBLE)
	(ACTION CEILING-HOLE-F)>

<OBJECT CEILING-HOLE-2
	(IN LOCAL-GLOBALS)
	;(DESC "hole")
	(SDESC "hole")
	(SYNONYM HOLE HATCH HATCHW)
	(ADJECTIVE TOP UPPER)
	(FLAGS INVISIBLE)
	(ACTION CEILING-HOLE-F)>

<ROUTINE CEILING-HOLE-F ()
	 <COND (<VERB? THROUGH>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE ;LOOK-UP>
		<TELL-YOU-CANT "make anything out on the other side.">)
	       (<VERB? EXAMINE>
		<TELL-LOOKS-HOLE>)>>

<OBJECT HOLE
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT)
	(DESC "hole")
	(SYNONYM HOLE)
	(ADJECTIVE SMALL)
	(ACTION HOLE-F)>

<ROUTINE HOLE-F ()
	 <COND (<VERB? DRILL>
		<RFALSE>)
	       (T <GLOBAL-NOT-HERE-PRINT ,HOLE>)>>

<OBJECT BULKHEADS
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "bulkhead")
	(SYNONYM BULKHE)>

<OBJECT WALLS
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "wall")
	(SYNONYM WALL WALLS)>
		
<OBJECT CEILING
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "ceiling")
	(SYNONYM CEILIN)>

<OBJECT MAST
	(IN LOCAL-GLOBALS)
	(DESC "mast")
	(SYNONYM MAST MASTS)
	(ADJECTIVE ROTTIN)
	(FLAGS INVISIBLE)
	(ACTION MAST-F)>

<ROUTINE MAST-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "There are several rotting masts here.">
		<COND (<==? ,HERE ,WRECK-1>
		       <TELL
" The top of one has fallen into a hole at your feet.">)>
		<CRLF>)
	       (<VERB? CLIMB-FOO>
		<TELL "None of the masts looks sturdy enough." CR>)>>

;<OBJECT HANDS
	(IN GLOBAL-OBJECTS)
	(SYNONYM HAND HANDS PAIR ARMS)
	(ADJECTIVE ARM)
	(DESC "pair of hands")
	(FLAGS NDESCBIT TOOLBIT WEAPONBIT TOUCHBIT)
	;(ACTION READ-PALMS-F)>

;<ROUTINE READ-PALMS-F ()
	 <COND (<VERB? READ>
		<TELL "I don't read palms." CR>
		<RTRUE>)>>

<OBJECT LIGHTHOUSE
	(IN LOCAL-GLOBALS)
	(SYNONYM LIGHTH BEACON)
	(DESC "lighthouse")
	(ACTION LIGHTHOUSE-F)>

<ROUTINE LIGHTHOUSE-F ()
	 <COND (<EQUAL? ,HERE ,WINDING-ROAD-1>
	        <COND (<VERB? THROUGH OPEN>
		       <TELL "The door is locked." CR>
		       <RTRUE>)
		      (<VERB? EXAMINE>
		       <TELL 
"You can see the base of a " D ,LIGHTHOUSE ". ">
		       <TELL-CLOSED
			"door, which has lettering stencilled on it,">
		       <RTRUE>)>)
	       (T
	  	<COND (<VERB? EXAMINE>
		       <TELL 
"The " D ,LIGHTHOUSE " towers over Hardscrabble Island from the
island's northwest corner.">
		       <COND (<OR <G? ,PRESENT-TIME 1200>
				  <L? ,PRESENT-TIME 480>>
			      <TELL 
" Its light provides a beacon for ships.">)>
		       <CRLF>
		       <RTRUE>)
		      (<VERB? WALK-TO>
		       <TELL-SHD-DIR>
		       ;<TELL "You must supply a " D ,INTDIR "!" CR>)
		      (<VERB? FIND>
		       <RFALSE>)
		      (<VERB? ASK-ABOUT>
		       <COND (<FSET? ,PRSO ,VICBIT>
			      <TELL "\"It's been there forever.\"" CR>)>)
		      (T
		       <TELL "That would be difficult from this distance." CR>)>)>>

<OBJECT GLOBAL-TREASURE
	(IN GLOBAL-OBJECTS)
	(SYNONYM TREASU)
	(DESC "treasure")
	(ACTION GLOBAL-TREASURE-F)>

<ROUTINE GLOBAL-TREASURE-F ()
	 <COND (<VERB? ASK-ABOUT ASK-CONTEXT-ABOUT TELL>
		<RFALSE>)
	       (<VERB? FIND>
		<COND (<==? ,WINNER ,PLAYER>
		       <TELL-NOT-EASY>)
		      (T <TELL "\"I'd like to know where some is.\"" CR>)>)
	       (T <GLOBAL-NOT-HERE-PRINT ,GLOBAL-TREASURE>)>>

<OBJECT TRAWLER
	(IN LOCAL-GLOBALS)
	(DESC "Night Wind")
	(SYNONYM TRAWLE WIND BOAT SHIP)
	(ADJECTIVE NIGHT)
	(FLAGS RENTBIT)
	(LINE 4)
	(ACTION TRAWLER-F)>

<ROUTINE TRAWLER-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<==? <GETP ,HERE ,P?LINE> ,TRAWLER-LINE-C>
		       <TELL 
"The " D ,TRAWLER " is in decent shape." CR>)
		      (<AND <==? ,HERE ,MM-WHEELHOUSE>
			    ,AT-SEA>
		       <GLOBAL-NOT-HERE-PRINT ,TRAWLER>)
		      (T 
		       <TELL "The " D ,TRAWLER>
		       <TELL-BOAT-DESC>)>)
	       (<VERB? BOARD THROUGH>
		<COND (<==? ,HERE ,WHARF>
		       <DO-WALK ,P?WEST>)
		      (<AND <==? ,HERE ,UNDERWATER>
			    <==? ,DEPTH 50>>
		       <DO-WALK ,P?UP>)
		      (T <TELL-YOU-CANT "get there from here.">)>
		<RTRUE>)
	       (<VERB? DISEMBARK>
		<COND (,AT-SEA
		       <COND (<GLOBAL-IN? ,RAILING ,HERE>
			      <PERFORM ,V?DIVE>
			      <RTRUE>)
			     (T <TELL-NO-EXIT>)>)
		      (<==? ,HERE ,NW-STARBOARD-DECK>
		       <DO-WALK ,P?EAST>)
		      (T <TELL-NO-EXIT>)>)
	       (<AND <VERB? LISTEN>
		     ,AT-SEA>
		<TELL-THRUM>)
	       (<VERB? LAUNCH>
		<TELL-YOU-CANT "do it alone.">)>>

<ROUTINE TELL-NO-EXIT ()
	 <TELL-HOW-THAT "do" "from here">>

<ROUTINE TELL-HOW-THAT (STR "OPTIONAL" (LAST <>))
	 <TELL "How can you " .STR " that">
	 <COND (.LAST <TELL " " .LAST>)>
	 <TELL "?" CR>>

<ROUTINE TELL-BOAT-DESC ()
	 <TELL " looks weathered but not aged." CR>>

<ROUTINE TELL-THRUM ()
	 <TELL "You hear the powerful thrum of diesel engines." CR>>

<OBJECT SALVAGER
	(IN LOCAL-GLOBALS)
	(DESC "Mary Margaret")
	(SYNONYM SALVAG MARGAR SHIP BOAT)
	(ADJECTIVE MARY)
	(FLAGS RENTBIT)
	(LINE 5)
	(ACTION SALVAGER-F)>

<ROUTINE SALVAGER-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<==? <GETP ,HERE ,P?LINE> ,SALVAGER-LINE-C>
		       <TELL 
"The " D ,SALVAGER " is shipshape." CR>)
		      (<AND <==? ,HERE ,NW-WHEELHOUSE>
			    ,AT-SEA>
		       <GLOBAL-NOT-HERE-PRINT ,SALVAGER>)
		      (T
		       <TELL "The " D ,SALVAGER " is a medium-size boat that">
		       <TELL-BOAT-DESC>)>)
	       (<VERB? BOARD THROUGH>
		<COND (<==? ,HERE ,WHARF>
		       <DO-WALK ,P?EAST>)
		      (<AND <==? ,HERE ,UNDERWATER>
			    <==? ,DEPTH 50>>
		       <DO-WALK ,P?UP>)
		      (T <TELL-YOU-CANT "get there from here.">)>
		<RTRUE>)
	       (<VERB? DISEMBARK>
		<COND (,AT-SEA
		       <COND (<GLOBAL-IN? ,RAILING ,HERE>
			      <PERFORM ,V?DIVE>
			      <RTRUE>)
			     (T <TELL-NO-EXIT>)>)
		      (<==? ,HERE ,MM-PORT-DECK>
		       <DO-WALK ,P?WEST>)
		      (T <TELL-NO-EXIT>)>)
	       (<AND <VERB? LISTEN>
		     ,AT-SEA>
		<TELL-THRUM>)
	       (<VERB? LAUNCH>
		<TELL-YOU-CANT "do it alone.">)>>

<OBJECT SHIPWRECK
	(IN LOCAL-GLOBALS)
	(DESC "shipwreck")
	(SYNONYM WRECK SHIPWR SHIP)
	(ADJECTIVE ROTTEN)
	(ACTION SHIPWRECK-F)>

<ROUTINE SHIPWRECK-F ()
	 <COND (<VERB? DISEMBARK>
		<TELL-NOT-EASY>)
	       (<VERB? EXAMINE>
		<TELL "It is what's left of a ">
		<COND (<EQUAL? ,WRECK-CHOSEN 1 3>
		       <TELL "wooden">)
		      (T <TELL "steel">)>
		<TELL " ship." CR>)>>

<OBJECT GLOBAL-SLEEP
	(IN GLOBAL-OBJECTS)
	(DESC "sleep")
	(SYNONYM SLEEP)
	(ACTION GLOBAL-SLEEP-F)>

<ROUTINE GLOBAL-SLEEP-F ()
	 <COND (<VERB? WALK-TO>
		<PERFORM ,V?SLEEP>
		<RTRUE>)
	       (T <TELL "Huh? Wake up!" CR>)>>

;<OBJECT GLOBAL-MEETING
	(IN GLOBAL-OBJECTS)
	(DESC "meeting")
	(SYNONYM MEETING)
	(ACTION GLOBAL-MEETING-F)>

;<ROUTINE GLOBAL-MEETING-F ()
	<COND (<VERB? LAMP-ON>
	       <TELL-YOURE-NOT "Tip O'Neill.">)
	      (<VERB? EXAMINE>
	       <TELL "How do you propose I do that?" CR>)>>

<OBJECT FIELD
	(IN LOCAL-GLOBALS)
	(DESC "abandoned field")
	(SYNONYM FIELD WEEDS)
	(ADJECTIVE ABANDO OVERGR)
	(FLAGS VOWELBIT)
	(ACTION FIELD-F)>

<ROUTINE FIELD-F ()
	 <COND (<VERB? BOARD THROUGH>
		<TELL-YOU-CANT "make your way through the growth.">)
	       (<VERB? LOOK-BEHIND>
		<TELL <PICK-ONE ,YUKS> CR>)
	       (<VERB? CUT>
		<TELL-DONT-HAVE "all week">)
	       (<VERB? PLAY>
		<TELL "Sounds exciting." CR>)
	       (<VERB? EXAMINE>
		<TELL
"This field was once productive farmland but hasn't been tended for many
years." CR>)>>

<OBJECT ROCKS
	(IN LOCAL-GLOBALS)
	(DESC "rocky coastline")
	(SYNONYM ROCKS COASTL)
	(ADJECTIVE ROCKY)
	(ACTION ROCKS-F)>

<ROUTINE ROCKS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The rocks here are large, pointy, and impossible to get through." CR>)
	       (<VERB? BOARD THROUGH>
		<TELL-YOU-CANT "get through the rocks.">)>>

<OBJECT POCKET
	(IN GLOBAL-OBJECTS)
	(DESC "pocket")
	(SYNONYM POCKET)
	(FLAGS CONTBIT OPENBIT)
	(TEXT "You keep your money in it.")
	(ACTION POCKET-F)>

<ROUTINE POCKET-F ()
	 <COND (<OR <FSET? ,WET-SUIT ,WORNBIT>
		    <FSET? ,DEEP-SUIT ,WORNBIT>>
		<TELL "Your diving gear is over the pocket." CR>)
	       (<AND <VERB? TAKE>
		     <PRSO? ,GLOBAL-MONEY ,RIDICULOUS-MONEY-KLUDGE>>
		<TELL-FLASHING-CASH>)
	       (<VERB? LOOK-INSIDE>
		<TELL "There is $" N ,POCKET-CHANGE " in it." CR>)
	       (<VERB? EMPTY>
		<TELL "You think better of the idea." CR>)
	       (<VERB? OPEN>
		<TELL "It's open enough." CR>)
	       (<AND <VERB? PUT>
		     <PRSI? ,POCKET>>
		<COND (<AND ,P-DOLLAR-FLAG
			    <PRSO? ,INTNUM>
			    <G? ,P-AMOUNT ,POCKET-CHANGE>>
		       <TELL-DONT-HAVE "that much">)
		      (<OR <PRSO? ,GLOBAL-MONEY ,RIDICULOUS-MONEY-KLUDGE>
			   <AND <PRSO? ,INTNUM> ,P-DOLLAR-FLAG>>
		       <TELL-ALREADY "there">)
		      (T <TELL-NO-FIT>)>)>>

<ROUTINE TELL-NO-FIT ("OPTIONAL" (STR <>))
	 <TELL "It won't fit">
	 <COND (.STR <TELL " " .STR>)>
	 <TELL "." CR>>

<OBJECT PEOPLE
	(IN GLOBAL-OBJECTS)
	(DESC "bunch of people")
	(SYNONYM PEOPLE)
	(ACTION PEOPLE-F)>

<ROUTINE PEOPLE-F ()
	 <COND (<EQUAL? ,HERE ,SHANTY ,FERRY-LANDING>
		<TELL "Leave them alone. They're not bothering you." CR>)
	       (<OR <IN? ,HERE ,WEASEL>
		    <IN? ,HERE ,JOHNNY>
		    <IN? ,HERE ,PETE>
		    <IN? ,HERE ,SPEAR-CARRIER>
		    <IN? ,HERE ,DELIVERY-BOY>>
		<TELL-REFER-INDIVIDUAL "s">)
	       (T <GLOBAL-NOT-HERE-PRINT ,PEOPLE>)>>

<ROUTINE TELL-REFER-INDIVIDUAL (STR)
	 <TELL "Refer to individual" .STR "." CR>>

<OBJECT WALLPAPER
	(IN LOCAL-GLOBALS)
	(DESC "wallpaper")
	(SYNONYM WALLPA)
	(ADJECTIVE FADED DRAB OFF-WH)
	(TEXT "It's faded to a drab off-white.")>

;<ROUTINE WALLPAPER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "It's a drab off-white." CR>)>>

<OBJECT CARPET
	(IN LOCAL-GLOBALS)
	(DESC "carpeting")
	(SYNONYM CARPET RUG)
	(ADJECTIVE DRAB WORN)
	(TEXT "It's drab and worn.")>

;<ROUTINE CARPET-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "It's drab and worn." CR>)>>

<OBJECT GLOBAL-SURFACE ;"local that moves"
	(IN RED-BOAR-INN)
	;(DESC "counter")
	(SDESC "counter")
	(SYNONYM TABLE DESK COUNTE DRAWER)
	(FLAGS SURFACEBIT CONTBIT OPENBIT NDESCBIT)
	(CAPACITY 10)
	(ACTION GLOBAL-SURFACE-F)>

<ROUTINE GLOBAL-SURFACE-F ()
	 <COND (<VERB? OPEN>
		<TELL <PICK-ONE ,YUKS> CR>)>>

<GLOBAL SHARED-OBJECT-TABLE
	<TABLE 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>>
<GLOBAL LAST-S-O-T-PLACE <>>

<ROUTINE MOVE-SHARED-OBJECTS (PLACE "AUX" (CTR 0) (SURFACE? T))
	 <COND (<==? .PLACE ,LAST-S-O-T-PLACE>
		<RFALSE>)
	       (<EQUAL? ,LAST-S-O-T-PLACE ,MM-CREW-QTRS ,NW-CREW-QTRS>
		<SET SURFACE? <>>
		<UNLOAD ,UNDER-BUNK>
		<UNLOAD ,BUNK>)
	       (<EQUAL? ,LAST-S-O-T-PLACE ,MM-GALLEY ,NW-GALLEY>
		<UNLOAD ,STOVE>)
	       (<EQUAL? ,LAST-S-O-T-PLACE ,MM-LOUNGE ,NW-LOUNGE>
		<UNLOAD ,LOUNGE-CHAIR>)>
	 <COND (.SURFACE?
		<UNLOAD ,GLOBAL-SURFACE>)>
	 <COND (<NOT <EQUAL? .PLACE ,MM-CREW-QTRS ,NW-CREW-QTRS>>
		<MOVE ,GLOBAL-SURFACE ,PLACE>)>
	 <SETG LAST-S-O-T-PLACE .PLACE>
	 <REPEAT ()
		 <COND (<G? .CTR 44> <RETURN>)
		       (<==? <GET ,SHARED-OBJECT-TABLE <+ .CTR 1>> .PLACE>
			<MOVE <GET ,SHARED-OBJECT-TABLE .CTR>
			      <GET ,SHARED-OBJECT-TABLE <+ .CTR 2>>>
			<PUT ,SHARED-OBJECT-TABLE .CTR 0>
			<PUT ,SHARED-OBJECT-TABLE <+ .CTR 1> 0>
			<PUT ,SHARED-OBJECT-TABLE <+ .CTR 2> 0>)>
		 <SET CTR <+ .CTR 3>>>>

<ROUTINE UNLOAD (OBJ "AUX" F N)
	 <COND (<SET F <FIRST? .OBJ>>
		<SET N <NEXT? .F>>
		<PUT-IN-TABLE .F ,LAST-S-O-T-PLACE .OBJ>
		<REPEAT ()
			<COND (<NOT .N> <RETURN>)>
			<SET F .N>
			<SET N <NEXT? .F>>
			<PUT-IN-TABLE .F ,LAST-S-O-T-PLACE .OBJ>>)>>

<ROUTINE PUT-IN-TABLE (OBJ RM SURF "AUX" (CTR 0))
	 <COND (<==? .OBJ ,PLAYER> <RFALSE>)>
	 <REPEAT ()
		 <COND (<G? .CTR 44> <RETURN>)
		       (<==? <GET ,SHARED-OBJECT-TABLE .CTR> 0>
			<PUT ,SHARED-OBJECT-TABLE .CTR .OBJ>
			<PUT ,SHARED-OBJECT-TABLE <+ .CTR 1> .RM>
			<PUT ,SHARED-OBJECT-TABLE <+ .CTR 2> .SURF>
			<MOVE .OBJ ,LOCAL-GLOBALS>
			<RFALSE>)
		       (T <SET CTR <+ .CTR 3>>)>>
	 <TELL "[BUG: Too much on surfaces.]" CR>>

<OBJECT GLOBAL-BANK
	(IN GLOBAL-OBJECTS)
	(SYNONYM BANK TRUST)
	(ADJECTIVE MARINE TRUST)
	(DESC "bank")
	(ACTION GLOBAL-BANK-F)>

<ROUTINE GLOBAL-BANK-F ()
	 <COND (<EQUAL? ,HERE ,BANK>
		<COND (<VERB? EXAMINE>
		       <PERFORM ,V?LOOK>
		       <SETG P-IT-OBJECT ,GLOBAL-BANK>
		       <RTRUE>)
		      (<VERB? ROB>
		       <ROBBERY-ENDING>)
		      (<VERB? DROP EXIT>
		       <DO-WALK ,P?OUT>
		       <RTRUE>)
		      (<VERB? MUNG>
		       <TELL "This isn't Monte Carlo." CR>
		       <RTRUE>)>)
		(<EQUAL? ,HERE ,SHORE-ROAD-2>
		 <COND (<VERB? THROUGH>
			<DO-WALK ,P?IN>
			<RTRUE>)
		       (<VERB? EXAMINE>
			<TELL 
"The " D ,BANK " is an imposing granite building." CR>
			<RTRUE>)
		       (<VERB? ROB>
			<COND (,BUSINESS-HOURS?
			       <ROBBERY-ENDING>)
			      (T <ROBBERY-ENDING <>>)>)>)
		(<OR <AND <VERB? ASK-ABOUT>
		      	  <PRSI? ,GLOBAL-BANK>>
		     <AND <VERB? FIND WALK-TO>
			  <PRSO? ,GLOBAL-BANK>>>
		 <RFALSE>)
		(T <GLOBAL-NOT-HERE-PRINT ,GLOBAL-BANK>)>>

<ROUTINE ROBBERY-ENDING ("OPTIONAL" (INSIDE? T))
	 <COND (.INSIDE?
		<TELL 
"The teller trips the alarm, and policemen come and drag you away.
As you contemplate a stretch in prison, you consider that
crime might not pay." CR>)
	       (T
		<TELL 
"You don't realize your attempts have set off a silent alarm
until the police arrive. At that point, you can only wonder if
attempted robbery wasn't such a bright idea." CR>)>
	 <CRLF>
	 <FINISH>>

<OBJECT GLOBAL-MONEY
	(IN GLOBAL-OBJECTS)
	(SYNONYM MONEY CASH \$)
	(DESC "money")
	(ACTION GLOBAL-MONEY-F)>

<ROUTINE GLOBAL-MONEY-F ()
	 <COND (<VERB? ASK-FOR ASK-ABOUT STEP WHAT FOLLOW>
		<RFALSE>)
	       (<VERB? FIND>
		<TELL-NOT-EASY>
		<RTRUE>)
	       (<G? ,POCKET-CHANGE 0>
		<COND (<OR <FSET? ,WET-SUIT ,WORNBIT>
			   <FSET? ,DEEP-SUIT ,WORNBIT>>
		       <TELL-CANT-REACH "it">)
		      (<VERB? COUNT>
		       <TELL "You are carrying $" N ,POCKET-CHANGE "." CR>)
		      (<VERB? EXAMINE>
		       <TELL "It looks a lot like $" N ,POCKET-CHANGE "." CR>)
		      (<NOT <VERB? TAKE>>
		       <TELL-FLASHING-CASH>)>)
	       (<EQUAL? ,HERE ,BANK>
		<TELL 
"Not surprisingly, the money here is not easily accessible." CR>
		<RTRUE>)
	       (T <GLOBAL-NOT-HERE-PRINT ,GLOBAL-MONEY>)>>

<ROUTINE TELL-FLASHING-CASH ()
	 <TELL "Flashing your bankroll is not a good idea." CR>>

<OBJECT FERRY-TOKEN
	(IN GLOBAL-OBJECTS)
	(SYNONYM TOKEN)
	(ADJECTIVE FERRY)
	(DESC "ferry token")
	(ACTION FERRY-TOKEN-F)>

<ROUTINE FERRY-TOKEN-F ()
	 <COND (<AND <IN? ,SPEAR-CARRIER ,HERE>
		     <OR <AND <VERB? ASK-ABOUT ASK-FOR>
		              <PRSO? ,SPEAR-CARRIER>>
		         <VERB? BUY>>>
		<NO-TOKENS ,HERE>)
	       (<AND <VERB? ASK-ABOUT>
		     <FSET? ,PRSO ,PERSON>>
		<TELL "\"You need them for the ferry.\"" CR>)
	       (<VERB? FIND ASK-FOR>
		<RFALSE>)
	       (T <GLOBAL-NOT-HERE-PRINT ,FERRY-TOKEN>)>>

<ROUTINE NO-TOKENS (PLACE)
	 <COND (<==? .PLACE ,BANK>
		<TELL 
"The teller says, \"We're out. Try Outfitters.\"">)
	       (T <TELL
"The " D ,SPEAR-CARRIER " checks and then says, \"I'm afraid we're
out of tokens. Try " D ,BANK ".\"">)>
	 <CRLF>
	 <RTRUE>>

<OBJECT GLOBAL-TIME
	(IN GLOBAL-OBJECTS)
	(SYNONYM TIME)
	(ADJECTIVE CORREC)
	(DESC "time")
	(FLAGS NDESCBIT)
	(ACTION GLOBAL-TIME-F)>

<ROUTINE GLOBAL-TIME-F ()
	 <COND (<VERB? ASK-FOR ASK-ABOUT>
		<COND (<PRSO? ,SPEAR-CARRIER>
		       <TELL "The " D ,PRSO " checks and tells you it's ">
		       <TIME-PRINT ,PRESENT-TIME>
		       <CRLF>)
		      (<FSET? ,PRSO ,PERSON>
		       <TELL "\"I'm not sure.\"" CR>)>)
	       (<AND <VERB? TELL>
		     <PRSO? ,GLOBAL-TIME>
		     <NOT ,PRSI>>
		<TELL
"Didn't you learn that the little hand points to the hour and the big hand
points to the minute?" CR>)
	       (<VERB? EXAMINE>
		<PERFORM ,V?TIME>
		<SETG P-IT-OBJECT ,GLOBAL-TIME>
		<RTRUE>)
	       (<AND <VERB? TELL>
		     <FSET? ,PRSO ,VICBIT>
		     <NOT <PRSO? ,ME>>>
		<RFALSE>)
	       (T <TELL "If you want to know the time, check your watch." CR>)>>

<OBJECT GLOBAL-DAY ;"installed under protest"
	(IN GLOBAL-OBJECTS)
	(DESC "day")
	(SYNONYM DAY)
	(ACTION GLOBAL-DAY-F)>

<ROUTINE GLOBAL-DAY-F ()
	 <COND (<OR <AND <VERB? ASK-FOR ASK-ABOUT>
		     	 <FSET? ,PRSO ,VICBIT>>
		    <AND <VERB? WHAT>
			 <NOT <==? ,WINNER ,PLAYER>>>>
		<TELL "\"Wednesday.\"" CR>)
	       (<VERB? WHAT> ;"waste of valuable space"
		<TELL "Ask somebody." CR>)
	       (T <TELL-SERIOUS>)>>

<ROUTINE TELL-SERIOUS ()
	 <TELL "Be serious." CR>>

<OBJECT ADVENTURER
	(IN BEDROOM)
	(SYNONYM PLAYER ADVENT CRETIN)
	(DESC "cretin")
        (CHARACTER 0)
	(FLAGS PERSON VICBIT NDESCBIT INVISIBLE)
	(ACTION ADVENTURER-F)>

<ROUTINE ADVENTURER-F ()
	 <COND (<G? ,BLOOD-ALCOHOL 25>
		<JIGS-UP
"You pass out and never find that you've been mugged, rolled and killed.">)
	       (<OR <G? ,HOW-THIRSTY 3>
		    <G? ,BLOOD-ALCOHOL 15>
		    <G? ,HOW-HUNGRY 3>
		    <==? ,HOW-TIRED 6>
		    <==? ,P-ADVERB ,W?SLOWLY>>
		<COND (<OR <VERB? SLEEP WAIT>
			   <AND <VERB? TELL> <NOT ,PRSI>>
			   <GAME-COMMAND?>
			   ,WAITED?>
		       <SETG WAITED? 2>
		       <COND (<VERB? WALK> T)
			     (<AND ,PRSO
				   <NOT <==? <META-LOC ,PRSO> ,HERE>>
				   <NOT <IN? ,PRSO ,GLOBAL-OBJECTS>>>
			      <SETG PRSO ,NOT-HERE-OBJECT>)
			     (<AND ,PRSI
				   <NOT <==? <META-LOC ,PRSI> ,HERE>>
				   <NOT <IN? ,PRSI ,GLOBAL-OBJECTS>>>
			      <SETG PRSI ,NOT-HERE-OBJECT>)>
		       <COND (<EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
			      <RETURN <NOT-HERE-OBJECT-F>>)
			     (T <RFALSE>)>)
		      (T
		       <SETG WAITED? 1>
		       <COND (<EQUAL? <CLOCKER> ,M-FATAL>
			      <SETG CLOCK-WAIT T>
		       	      <TELL "This interrupts what you're trying to do." CR>
		       	      <RFATAL>)
			     (<VERB? WALK>
		       	      <COND (<AND <NOT <IN? ,PLAYER ,UNDERWATER>>
					  <IN? ,PLAYER ,HERE>>
				     <COND (<G? ,BLOOD-ALCOHOL 15>
       					    <TELL-YOURE-NOT
"quite sure which direction is which...">
					    <CRLF>
		       	      	     	    <RANDOM-WALK>)
					   (<PROB 40>
				     	    <TELL
"You stop to sit down for a bit and then struggle back to your feet." CR>
				     	    <RFATAL>)>)>)>)>)
	       (<AND <FSET? ,FLIPPERS ,WORNBIT>
		     <VERB? WALK>
		     <NOT ,AT-SEA>
		     <OR <L? <GETP ,HERE ,P?LINE> ,TRAWLER-LINE-C>
			 <AND <==? ,HERE ,MM-PORT-DECK>
			      <==? ,P-WALK-DIR ,P?WEST>>
			 <AND <==? ,HERE ,NW-STARBOARD-DECK>
			      <==? ,P-WALK-DIR ,P?EAST>>>>
		<TELL "You'd look silly walking around in flippers." CR>)>>

<GLOBAL WAITED? <>>

<ROUTINE RANDOM-WALK ("AUX" P Z L S (D <>))
	 <SET P 0>
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<COND (.D
			       <DO-WALK .D>)>
			<RETURN>)
		       (T
			<SET Z <GETPT ,HERE .P>>
			<SET L <PTSIZE .Z>>
			<COND (<OR <EQUAL? .L ,UEXIT>
				   <AND <EQUAL? .L ,CEXIT>
					<VALUE <GETB .Z ,CEXITFLAG>>>
				   <AND <EQUAL? .L ,DEXIT>
					<FSET? <GETB .Z ,DEXITOBJ> ,OPENBIT>>>
			       <COND (<NOT .D> <SET D .P>)
				     (<PROB 50> <SET D .P>)>)>)>>>

<ROUTINE DETECTOR-NOISE ("OPTIONAL" (LISTENING? <>) "AUX" C H P Z L R
			 				  (LAST-R <>))
	 <SET H <META-LOC ,PLAYER>>
	 <COND (<AND <NOT .LISTENING?>
		     <VERB? LISTEN>
		     <PRSO? ,METAL-DETECTOR>>
		<RFALSE>)
	       (<AND <==? <META-LOC ,METAL-DETECTOR> .H>
		     ,DETECTOR-ON
		     ,DETECTOR-POWERED>
		<SET C <+ <COUNT-METAL .H> <GETP .H ,P?DESCFCN>>>
		<SET P 0>
		<REPEAT ()
		        <COND (<0? <SET P <NEXTP .H .P>>>
			       <RETURN>)
			      (<NOT <L? .P ,LOW-DIRECTION>>
			       <SET Z <GETPT .H .P>>
			       <SET L <PTSIZE .Z>>
			       <COND (<EQUAL? .L ,UEXIT ,CEXIT ,DEXIT>
				      <SET R <GETB .Z 0>>
				      <COND (<NOT <==? .R .LAST-R>>
					    <SET C <+ .C </ <COUNT-METAL .R> 2>
						</ <GETP .R ,P?DESCFCN> 2>>>
					     <SET LAST-R .R>)>)
				     (<EQUAL? .L ,FEXIT>
				      <SET R <APPLY <GET .Z 0> <>>>
				      <COND (<AND .R <NOT <==? .R .LAST-R>>>
					     <SET C <+
						     .C
						     </ <COUNT-METAL .R> 2>
						     </ <GETP .R ,P?DESCFCN> 2>
						     >>
					     <SET LAST-R .R>)>)>)>>
		<COND (<EQUAL? .C 0>
		       <COND (.LISTENING?
			      <TELL
"The " D ,METAL-DETECTOR " makes no noise." CR>
			      <RTRUE>)
			     (T <RFALSE>)>)>
		<TELL "The " D ,METAL-DETECTOR " is clicking ">
		<COND (<G? .C 100>
		       <TELL "extremely fast">)
		      (<G? .C 75>
		       <TELL "quickly">)
		      (<G? .C 50>
		       <TELL "moderately">)
		      (<G? .C 25>
		       <TELL "slowly">)
		      (T <TELL "occasionally">)>
		<TELL "." CR>)
	       (.LISTENING?
		<TELL "The " D ,METAL-DETECTOR " makes no noise." CR>)>>

<ROUTINE COUNT-METAL (R "AUX" F (V 0))
	 <SET F <FIRST? .R>>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN .V>)
		       (<OR <NOT <FSET? .F ,INVISIBLE>>
			    <EQUAL? .F ,PLAYER>>
			<SET V <+ .V <GETP .F ,P?STATION>>>
			<COND (<FIRST? .F>
			       <SET V <+ .V <COUNT-METAL .F>>>)>)>
		 <SET F <NEXT? .F>>>>

<OBJECT ME
	(IN GLOBAL-OBJECTS)
	(SYNONYM ME MYSELF)
	(DESC "you")
	(FLAGS PERSON VICBIT)
	(ACTION CRETIN-F)>

<ROUTINE CRETIN-F ()
	 <COND (<NOT <EQUAL? ,PRSO ,WINNER ,ME>>
		<RFALSE>)>
	 <COND (<VERB? EAT>
		<TELL "Stick to stew." CR>)
	       (<VERB? DRINK>
		<TELL "Stick to grog." CR>)
	       (<VERB? ALARM>
		<TELL "Good morning!" CR>)
	       (<VERB? MUNG ATTACK KILL>
		<TELL
"Although it's not hard, I can't make it that simple." CR>)
	       (<VERB? FIND>
		<TELL "Have you tried asking the parrot?" CR>)
	       (<OR <VERB? TAKE LAMP-ON>
		    <AND <VERB? GIVE> <PRSO? ,ME>>>
		<TELL "You romantic fool!" CR>)
	       (<VERB? EXAMINE>
		<TELL "You look like a diver." CR>)
	       ;(<VERB? LOOK-INSIDE>
		<TELL "I'm a computer, not a doctor!" CR>)
	       (<VERB? LOOK-UNDER>
		<TELL
"I think the center of the earth is down there somewhere." CR>)
	       (<VERB? RUB>
		<TELL "You're starting to rub me the wrong way." CR>)
	       (<VERB? PLAY>
		<TELL "Don't expect an Oscar." CR>)
	       (<VERB? CLIMB-ON BOARD THROUGH>
		<TELL "I'm not impressed." CR>)
	       ;(<VERB? CLOSE>
		<TELL
"I've heard of zipping one's lip..." CR>)
	       (<VERB? CROSS SHAKE>
		<TELL "I'm much too kind." CR>)
	       ;(<VERB? DISEMBARK>
		<TELL "What makes you think you deserve it?" CR>)
	       (<VERB? DROP>
		<TELL "Like a hot potato." CR>)
	       ;(<VERB? LEAN-ON OPEN>
		<TELL "I think you've got enough troubles." CR>)
	       (<VERB? FOLLOW>
		<TELL "What makes you think you know where you're going?" CR>)
	       ;(<VERB? LISTEN>
		<TELL "Huh? Did you say something?" CR>)
	       (<VERB? SEARCH>
		<TELL "Okay. I found one empty head but a strong heart." CR>)
	       ;(<VERB? MAKE>
		<TELL "What an attitude!" CR>)
	       (<VERB? SMELL PUSH>
		<TELL "I'd rather not." CR>)
	       (<VERB? THROW>
		<TELL "For a loop?" CR>)
	       ;(<VERB? WEAR>
		<TELL "Consider " D ,GLOBAL-SELF " worn. Happy?" CR>)
	       (<VERB? ROB>
		<TELL "You wouldn't get much from anyone that stupid." CR>)
	       (T
		<RFALSE>)>
	 <RTRUE>>

<OBJECT GLOBAL-SELF
	(IN GLOBAL-OBJECTS)
	(DESC "yourself")
	(SYNONYM SELF YOURSE)
	(FLAGS VICBIT)
	(ACTION GLOBAL-SELF-F)>

<ROUTINE GLOBAL-SELF-F ()
	 <COND (<==? ,WINNER ,PLAYER>
		<COND (<PRSI? ,GLOBAL-SELF>
		       <SETG PRSI ,ME>)>
		<COND (<PRSO? ,GLOBAL-SELF>
		       <SETG PRSO ,ME>)>)>
	 <PERFORM ,PRSA ,PRSO ,PRSI>
	 <RTRUE>>

<OBJECT GLOBAL-ROOM
	(IN GLOBAL-OBJECTS)
	(DESC "room")
	(SYNONYM ROOM CABIN)
	(ACTION GLOBAL-ROOM-F)>

<ROUTINE GLOBAL-ROOM-F ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "room">)
	       (<VERB? EXAMINE>
		<PERFORM ,V?LOOK>
		<SETG P-IT-OBJECT ,GLOBAL-ROOM>
		<RTRUE>)
	       (<VERB? DROP EXIT DISEMBARK>
		<DO-WALK ,P?OUT>
		<RTRUE>)
	       (<VERB? ENTER THROUGH>
		<DO-WALK ,P?IN>
		<RTRUE>)
	       (<VERB? MUNG ATTACK>
		<TELL "It's sturdier than you give it credit for." CR>
		<RTRUE>)
	       (<VERB? UNLOCK>
		<TELL "Please be more specific about what you want to unlock." CR>)
	       (<VERB? PUT>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)>>

;<OBJECT DOORWAY
	(IN LOCAL-GLOBALS)
	(FLAGS NDESCBIT CONTBIT OPENBIT)
	(DESC "doorway")
	(SYNONYM DOORWAY OPENIN)
	(ADJECTIVE ARCHED TIMBER)
	;(ACTION DOORWAY-FCN)>

;<ROUTINE DOORWAY-FCN ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<AND <EQUAL? ,HERE ,NORTH-ANTECHAMBER ,BURIAL-CHAMBER>
			    <EQUAL? ,BEAM-PLACED 4>>
		       <TELL
"The mast is in the doorway, running from top to bottom." CR>
		       <RTRUE>)
		      (<AND <EQUAL? ,HERE ,SOUTH-ANTECHAMBER ,ANNEX>
			    <EQUAL? ,BEAM-PLACED 2 3>>
		       <TELL 
"The beam is wedged in the doorway from side to side." CR>
		       <RTRUE>)>)>>

<OBJECT WINDOW
	(IN LOCAL-GLOBALS)
	(DESC "window")
	(SYNONYM WINDOW)
	(FLAGS TRANSBIT)
	(ACTION WINDOW-F)>

<ROUTINE WINDOW-F ()
	 <COND (<EQUAL? ,HERE ,BEDROOM>
		<COND (<VERB? LOOK-INSIDE>
		       <TELL 
"You see an " D ,FIELD " beyond the alley where the terrible events of last
night transpired." CR>)
		      (<VERB? OPEN CLOSE>
		       <TELL "It's stuck shut." CR>)>)
	       (<EQUAL? ,HERE ,BANK>
		<COND (<VERB? EXAMINE>
		       <TELL 
"It is a barred window about chest-high behind which the teller transacts his
business." CR>)
		      (<VERB? LOOK-INSIDE LOOK-BEHIND>
		       <TELL "There is a teller there." CR>)>)
	       (<EQUAL? ,HERE ,MM-WHEELHOUSE ,NW-WHEELHOUSE>
	        <COND (<VERB? LOOK-INSIDE>
		       <TELL "You can see the ocean beyond the deck." CR>)>)>>

<OBJECT IN-WINDOW
	(IN LOCAL-GLOBALS)
	(DESC "window")
	(SYNONYM WINDOW)
	(FLAGS TRANSBIT)
	(ACTION IN-WINDOW-F)>

<ROUTINE IN-WINDOW-F ("AUX" L)
	 <COND (<VERB? LOOK-INSIDE>
		<TELL "You see ">
		<COND (<AND <EQUAL? <SET L <LOC ,JOHNNY>> ,MM-WHEELHOUSE
				    		 	  ,NW-WHEELHOUSE>
			    <==? <GETP ,HERE ,P?LINE> <GETP .L ,P?LINE>>>
		       <TELL "Johnny in ">)>
		<TELL "the wheelhouse." CR>)>>

<OBJECT BEDROOM-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "bedroom door")
	(SYNONYM DOOR)
	(ADJECTIVE BEDROOM MY ROOM)
	(FLAGS NDESCBIT DOORBIT)
	(ACTION BEDROOM-DOOR-F)>

<ROUTINE BEDROOM-DOOR-F ()
	 <COND (<VERB? OPEN>
	        <COND (<FSET? ,BEDROOM-DOOR ,OPENBIT>
		       <TELL-ALREADY "open">
		       <RTRUE>)
		      (<AND <EQUAL? ,HERE ,UPSTAIRS-HALLWAY>
			    ,BEDROOM-DOOR-LOCKED>
		       <TELL "It's locked." CR>
		       <RTRUE>)
		      (T
		       <FSET ,BEDROOM-DOOR ,OPENBIT>
		       <SETG BEDROOM-DOOR-LOCKED <>>
		       <COND (<IN? ,WEASEL ,UPSTAIRS-HALLWAY>
			      <TELL 
"You open the door and see " D ,WEASEL ". He says,
\"Oh. Hi. I was just wonderin' if you were gonna be at the meetin'
at " D ,SHANTY ".\" He turns and heads down the steps." CR>
			      <ESTABLISH-GOAL ,WEASEL ,SHANTY>
			      <DISABLE <INT I-WEASEL-TO-BEDROOM>>)
			     (T <TELL-NOW ,BEDROOM-DOOR "open">)>
		       <RTRUE>)>)
		(<VERB? CLOSE>
		 <COND (<NOT <FSET? ,BEDROOM-DOOR ,OPENBIT>>
			<TELL-ALREADY "closed">
			<RTRUE>)
		       (T
			<FCLEAR ,BEDROOM-DOOR ,OPENBIT>
			<TELL-NOW ,BEDROOM-DOOR "closed">
			<RTRUE>)>)
		(<VERB? UNLOCK>
		 <COND (,BEDROOM-DOOR-LOCKED
			<COND (<OR <IN? ,PLAYER ,BEDROOM>
				   <PRSI? ,KEY>>
			       <SETG BEDROOM-DOOR-LOCKED <>>
			       <TELL-NOW ,BEDROOM-DOOR "unlocked">)
			      (,PRSI
			       <TELL-YOU-CANT "unlock it with that!">)
			     (T <TELL "Not without the key." CR>)>)
		       (T <TELL-ALREADY "unlocked">)>)>>

<OBJECT OCEAN
	(IN LOCAL-GLOBALS)
	(SYNONYM WATER OCEAN SEA WAVES)
	(ADJECTIVE BRINE SEA OCEAN)
	(DESC "ocean")
	(FLAGS OPENBIT DRINKBIT VOWELBIT)
	(ACTION OCEAN-F)>

<ROUTINE OCEAN-F ("AUX" L)
	 <COND (<AIRTIGHT-ROOM?>
		<TELL "There's no water in here." CR>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? <GETP ,HERE ,P?LINE> ,UNDERWATER-LINE-C>
		       <TELL "There is water all around you." CR>)
		      (T
		       <TELL "The ocean looks choppy">
		       <COND (,AT-SEA
			      <TELL ". Whitecaps rise and fall around the boat.">)
			     (T <TELL
", and you know about the dangerous currents here.">)>
		       <CRLF>)>)
	       (<VERB? LISTEN>
		<TELL "You hear the crashing of the waves." CR>)
	       (<VERB? BOARD THROUGH SWIM>
		<COND (<EQUAL? <SET L <GETP ,HERE ,P?LINE>> ,UNDERWATER-LINE-C>
		       <TELL "You're already in it!" CR>)
		      (<OR <EQUAL? .L ,TRAWLER-LINE-C ,SALVAGER-LINE-C>
			   <EQUAL? ,HERE ,WHARF ,FERRY-LANDING>>
		       <COND (,AT-SEA
		       	      <PERFORM ,V?DIVE>
		       	      <RTRUE>)
		      	     (T
		       	      <JIGS-UP
"The currents pull you in several conflicting directions, and you end up
much the worse for it.">)>)
		      (T <TELL-NO-SHORELINE>)>)
	       (<AND <VERB? DROP THROW>
		     <PRSI? ,OCEAN>>
		<COND (<==? <GETP ,HERE ,P?LINE> ,UNDERWATER-LINE-C>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)
		      (T <TELL-NO-LITTER>)>)
	       (<VERB? SMELL>
		<TELL
"It smells very salty, which is what you might expect from the sea." CR>)
	       (<VERB? DRINK TASTE>
		<COND (<OR <G? <GETP ,HERE ,P?LINE> ,BACK-ALLEY-LINE-C>
			   <EQUAL? ,HERE ,FERRY-LANDING ,WHARF>>
		       <TELL "Bleahhhh! You spit it out immediately!" CR>)
		      (T <TELL-NO-SHORELINE>)>)
	       (<VERB? RUB>
		<COND (<OR <G? <GETP ,HERE ,P?LINE> ,BACK-ALLEY-LINE-C>
			   <EQUAL? ,HERE ,FERRY-LANDING ,WHARF>>
		       <TELL "It's wet." CR>)
		      (T <TELL-NO-SHORELINE>)>)>>

<ROUTINE TELL-NO-SHORELINE ()
	 <TELL-YOU-CANT "make your way to the shoreline.">>

<ROUTINE TELL-NO-LITTER ()
	 <TELL "It would spoil the beauty of the sea." CR>>

<OBJECT STAIRS
	(IN LOCAL-GLOBALS)
	(SYNONYM STAIRS STEPS STAIRW)
	(DESC "stairs")
	;(FLAGS NDESCBIT CLIMBBIT TOUCHBIT)
	(ACTION STAIRS-F)>

<ROUTINE STAIRS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The carpeted stairway leads ">
		<COND (<EQUAL? ,HERE ,UPSTAIRS-HALLWAY>
		       <TELL "down">)
		      (<EQUAL? ,HERE ,RED-BOAR-INN>
		       <TELL "up">)>
		<TELL "." CR>)
	       (<VERB? CLIMB-FOO>
		<COND (<EQUAL? ,HERE ,UPSTAIRS-HALLWAY>
		       <V-CLIMB-UP ,P?DOWN>)
		      (T <V-CLIMB-UP>)>
		<RTRUE>)>>

<OBJECT LADDER-TOP
	(IN LOCAL-GLOBALS)
	(DESC "ladder top")
	(SYNONYM LADDER TOP)
	(ADJECTIVE LADDER TOP)
	(TEXT "It's the top of a ladder that leads down.")
	(ACTION LADDER-TOP-F)>

<ROUTINE LADDER-TOP-F ()
	 <COND (<VERB? CLIMB-FOO>
		<DO-WALK ,P?DOWN>
		<RTRUE>)>>

<OBJECT LADDER-BOTTOM
	(IN LOCAL-GLOBALS)
	(DESC "ladder bottom")
	(SYNONYM LADDER BOTTOM)
	(ADJECTIVE LADDER BOTTOM)
	(TEXT "It's the bottom of a ladder that leads up.")
	(ACTION LADDER-BOTTOM-F)>

<ROUTINE LADDER-BOTTOM-F ()
	 <COND (<VERB? CLIMB-FOO>
		<DO-WALK ,P?UP>
		<RTRUE>)>>

<OBJECT RAILING
	(IN LOCAL-GLOBALS)
	(DESC "railing")
	(SYNONYM RAILIN RAIL)
	(ADJECTIVE METAL STURDY)
	(TEXT "The sturdy metal railing encircles the deck.")
	(ACTION RAILING-F)>

<ROUTINE RAILING-F ()
	 <COND (<VERB? CLIMB-FOO>
		<TELL "You immediately climb back down." CR>)
	       (<VERB? DISEMBARK LEAP>
		<PERFORM ,V?DIVE>
		<RTRUE>)>>

<OBJECT BUNKS
	(IN LOCAL-GLOBALS)
	(DESC "collection of decrepit bunks")
	(SYNONYM BUNK BUNKS COLLEC BEDS)
	(ADJECTIVE OLD DECREP ROTTIN ROTTEN)
	(ACTION BUNKS-F)>

<ROUTINE BUNKS-F ()
	 <COND (<VERB? BOARD SLEEP>
		<TELL-BAD-SHAPE>)
	       (<VERB? EXAMINE>
		<TELL
"These stacks of bunks look as though they were never comfortable.
The work of time and the sea have made them fairly
decrepit, incapable of supporting much weight." CR>)
	       (<VERB? MUNG>
		<TELL
"Some pieces fall away, but the structure holds together." CR>)>>

<ROUTINE TELL-BAD-SHAPE ()
	 <TELL "They don't look as if they could support your weight." CR>>

<ROUTINE TIME-PRINT (NUM "AUX" HR (PM <>))
	 <COND (<G? <SET HR </ .NUM 60>> 12>
		<SET HR <- .HR 12>>
		<SET PM T>)
	       (<==? .HR 12> <SET PM T>)
	       (<==? .HR 0> <SET HR 12>)>
	 <PRINTN .HR>
	 <TELL ":">
	 <COND (<L? <SET HR <MOD .NUM 60>> 10>
		<TELL "0">)>
	 <TELL N .HR " ">
	 <TELL <COND (.PM "p.m.") (T "a.m.")>>>

;"GLOBAL VARIABLES"

<GLOBAL HERE <>>

<GLOBAL LOAD-ALLOWED 100>

;<GLOBAL LOAD-MAX 0>

<GLOBAL LIT T>

;<GLOBAL DEBUG <>>

<GLOBAL WATCH-SCORE 8>

<GLOBAL WATCH-MOVES 0>

<GLOBAL SCORE 8> ;"This is actually HOURS; STATUS-LINE stuff looks for SCORE.
		   Normal SCORE is RATING here; initialized in VERBS."

<GLOBAL MOVES 0> ;"This is actually minutes. Moves themselves aren't counted."

<GLOBAL PRESENT-TIME 480>

<GLOBAL WATCH-WOUND T>

<GLOBAL SET-HR 0>

<GLOBAL SET-MIN 60>

<GLOBAL DELIVERY-TABLE <TABLE 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>>

<GLOBAL DT-PTR 0>

<GLOBAL QCONTEXT <>>

<GLOBAL QCONTEXT-ROOM <>>

<GLOBAL BEDROOM-MESSAGE <>>

<GLOBAL MEETINGS-COMPLETED 0>

<GLOBAL DETECTOR-POWERED <>>

<GLOBAL DETECTOR-ON <>>

<GLOBAL SOUPS-ON <>>

<GLOBAL HOW-TIRED 1>

<GLOBAL HOW-HUNGRY 1>

<GLOBAL WRECK-FOUND 0>

<GLOBAL WEASEL-PISSED <>>

;<GLOBAL INDENTS
	<TABLE ""
	       "  "
	       "    "
	       "      "
	       "        "
	       "          ">>

;"******************************************
	Here come the pseudos
********************************************"

<ROUTINE TABLE-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "table">)
	       (<VERB? EXAMINE>
		<TELL 
"The table has a variety of forms and brochures you find boring." CR>)
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,PSEUDO-OBJECT>>
		<TELL 
"A bank official scurries out, picks up the " D ,PRSO ", and hands it
to you, pointing out that the table is for bank business only." CR>
		<RTRUE>)>>

<ROUTINE LIGHTHOUSE-LOCK-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "lock">)
	       (<VERB? PICK>
		<TELL "You try for a while, but the lock won't give." CR>
		<RTRUE>)
	       (<VERB? UNLOCK>
		<TELL-NO-KEY>
		<RTRUE>)
	       (<VERB? MUNG>
		<TELL 
"You find that the door and lock withstand your attempts." CR>
		<RTRUE>)
	       (<VERB? LOCK>
		<TELL-ALREADY "locked">
		<RTRUE>)>>

<ROUTINE WHEEL-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "wheel">)
	       (<VERB? TURN SPIN>
		<COND (<IN? ,JOHNNY ,HERE>
		       <TELL 
D ,JOHNNY " glares at you. You decide to leave the piloting to the captain."
CR>)
		      (T <TELL "The wheel spins." CR>)>)>>

<ROUTINE BOLT-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "bolts">)
	       (T <TELL
"The bolts are rusted firmly into place." CR>)>>

;"Parser-related stuff"
	 
<OBJECT NOT-HERE-OBJECT
	(DESC "such thing" ;"[not here]")
	(ACTION NOT-HERE-OBJECT-F)>

<ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ)
	 ;"This COND is game independent (except the TELL)"
	 <COND (<AND <EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		     <EQUAL? ,PRSI ,NOT-HERE-OBJECT>>
		<TELL "Those things aren't here." CR>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>)
	       (T
		<SET TBL ,P-PRSI>
		<SET PRSO? <>>)>
	 <COND (.PRSO?
		<COND (<VERB? ASK-CONTEXT-ABOUT ASK-CONTEXT-FOR CLIMB-UP
			      EXAMINE FIND FOLLOW WAIT-FOR
			      ;LOOK-INSIDE ;LOOK-OUTSIDE ;SEARCH WHAT
			      $CALL GIVE MAKE THROUGH WALK-TO ;TELL>
		       <COND (<SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
			      <COND (<NOT <==? .OBJ ,NOT-HERE-OBJECT>>
				     <RTRUE>)>)
			     (T
			      <RFALSE>)>)>)
	       (T
		<COND (<VERB? ASK-ABOUT ASK-FOR
			      ;SEARCH-OBJECT-FOR SGIVE TELL>
		       <COND (<SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
			      <COND (<NOT <==? .OBJ ,NOT-HERE-OBJECT>>
				     <RTRUE>)>)
			     (T
			      <RFALSE>)>)>)>
        ;"Here is the default 'cant see any' printer"
	 <COND (<VERB? $CALL>
		<V-CALL-LOSE>
		<SETG CLOCK-WAIT <>>)
	       (<EQUAL? ,WINNER ,ADVENTURER>
		<TELL-YOU-CANT "see any" <>>
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here." CR>)
	       (T
		<START-SENTENCE ,WINNER>
		<TELL " seems confused. \"I don't see any">
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!\"" CR>)>
	 <SETG P-MOBY-FOUND <>>
	 <SETG PRSA <>>
	 <SETG PRSO <>>
	 <SETG PRSI <>>
	 <RFATAL>>

<ROUTINE FIND-NOT-HERE (TBL PRSO? "AUX" M-F OBJ CTR PER)
	;"Here is where special-case code goes. <MOBY-FIND .TBL> returns
	   number of matches. If 1, then P-MOBY-FOUND is it. One may treat
	   the 0 and >1 cases alike or different. It doesn't matter. Always
	   return RFALSE (not handled) if you have resolved the problem (i.e.
	   come up with one object)."
	<SET M-F <MOBY-FIND .TBL>>
	<COND (<AND <G? .M-F 1>
	            <SET OBJ <GETP <1 .TBL> ,P?GLOBAL>>>
	       <SET M-F 1>
	       <SETG P-MOBY-FOUND .OBJ>)>
	;<COND (<AND ,DEBUG
		    <G? .M-F 0>>
	       <TELL "[MOBY-FOUND " N .M-F "; to wit:">
	       <SET CTR 1>
	       <REPEAT ()
		<COND (<G? .CTR .M-F>
		       <TELL "]" CR>
		       <RETURN>)>
		<TELL " " D <GET .TBL .CTR>>
		<SET CTR <+ .CTR 1>>
		<COND (<L? .CTR .M-F> <TELL ",">)>>)
	      (,DEBUG <TELL "[Nothing MOBY-FOUND.]" CR>)>
	<COND (<==? 1 .M-F>
	       <COND (.PRSO?
		      <COND (<AND <VERB? TELL>
				  <==? ,WINNER ,PLAYER>
				  <FSET? ,P-MOBY-FOUND ,VICBIT>>
			     <SETG P-CONT <>>
			     <TELL-NOT-HERE-TALK>
			     <RTRUE>)
			    (<VERB? EXAMINE>
			     <COND (<AND <FSET? ,P-MOBY-FOUND ,PERSON>
				  	<NOT <0? <BAND <GETP <META-LOC ,PLAYER>
							,P?CORRIDOR>
						 <GETP <LOC ,P-MOBY-FOUND>
							,P?CORRIDOR>>>>>
			     	    <TELL
"You can see " D ,P-MOBY-FOUND " in the distance." CR>)
			    	   (<AND <PRSO? ,MCGINTY>
				  	 <IN? ,PLAYER ,BACK-ALLEY-2>
				  	 <IN? ,MCGINTY ,MCGINTY-HQ>>
			     	    <TELL
"Looking through the window, you see " D ,MCGINTY " in his office." CR>)
				   (T
				    <GLOBAL-NOT-HERE-PRINT ,PRSO>)>
			     <RTRUE>)
			    (T <SETG PRSO ,P-MOBY-FOUND>)>)
		     (T <SETG PRSI ,P-MOBY-FOUND>)>
	       <COND (<AND ,P-XADJ <NOT ,P-XNAM>> <SETG P-NONOUN T>)
		     (T <SETG P-NONOUN <>>)>
	       <RFALSE>)
	      (<NOT .PRSO?>
	       <COND (<OR <VERB? ASK-ABOUT>
			  <AND <VERB? TELL>
			       <PRSO? ,ME>>>
		      <COND (<PRSO? ,ME>
			     <COND (<AND <==? ,WINNER ,PLAYER>
					 ,QCONTEXT
					 <==? ,HERE ,QCONTEXT-ROOM>>
				    <SET PER ,QCONTEXT>)
				   (T <SET PER ,WINNER>)>)
			    (T <SET PER ,PRSO>)>
		      <COND (<FSET? .PER ,VICBIT>
			     <SAY-CONFUSED .PER .PRSO?>)
			    (T <SUDDENLY-REALIZE-TALKING .PER>
			       ;<TELL 
"You realize you're talking to " A ,PRSO "." CR>)>
		      <RTRUE>)
		     (<FSET? ,PRSO ,VICBIT>
		      <SAY-CONFUSED ,PRSO .PRSO?>)
		     (T
	       	      <TELL "You wouldn't find any">
	       	      <NOT-HERE-PRINT .PRSO?>
	       	      <TELL " there." CR>
	       	      <RTRUE>)>)
	      (T ,NOT-HERE-OBJECT)>>

<ROUTINE GLOBAL-NOT-HERE-PRINT (OBJ)
	 <COND (,P-MULT <SETG P-NOT-HERE <+ ,P-NOT-HERE 1>>)
	       (T
		<TELL-YOU-CANT "see any" <>>
		<COND (<EQUAL? .OBJ ,PRSO> <PRSO-PRINT>)
		      (T <PRSI-PRINT>)>
		<TELL " here." CR>)>
	 <SETG P-WON <>>
	 <RTRUE>>

<ROUTINE SAY-CONFUSED (PER PRSO?)
	 <START-SENTENCE .PER>
	 <TELL " looks confused. \"I have no idea what">
	 <NOT-HERE-PRINT .PRSO?>
	 <TELL " you're talking about!\"" CR>>

<ROUTINE NOT-HERE-PRINT (PRSO?)
 <COND (,P-OFLAG
	<COND (,P-XADJ <TELL " "> <PRINTB ,P-XADJN>)>
	<COND (,P-XNAM <TELL " "> <PRINTB ,P-XNAM>)>)
       (.PRSO?
	<BUFFER-PRINT <GET ,P-ITBL ,P-NC1> <GET ,P-ITBL ,P-NC1L> <>>)
       (T
	<BUFFER-PRINT <GET ,P-ITBL ,P-NC2> <GET ,P-ITBL ,P-NC2L> <>>)>
 <SETG P-WON <>>>

<ROUTINE TELL-YOU-CANT (STR "OPTIONAL" (FINISH T))
	 <TELL "You can't " .STR>
	 <COND (.FINISH <CRLF>)>>

<ROUTINE TELL-ROPE-HIGH ()
	 <TELL-CANT-REACH "the rope">>

<ROUTINE TELL-CANT-REACH (STR)
	 <TELL-YOU-CANT "reach " <>>
	 <TELL .STR "." CR>>

<ROUTINE TELL-NO-GO (PRINT?)
	 <COND (.PRINT? <TELL-YOU-CANT "go that way.">)>>

<ROUTINE TELL-NO-NO ()
	 <TELL-YOU-CANT "do that.">>

<ROUTINE TELL-NO-AFFORD ()
	 <TELL-YOU-CANT "afford it.">>

<ROUTINE TELL-TOO-BIG ()
	 <TELL-YOU-CANT "fit through the hole carrying the tank.">>
