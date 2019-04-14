"The island geography for TOA2.
  Copyright (C) 1984 Infocom, Inc. All rights reserved."

<GLOBAL BUSINESS-HOURS? <>>

;<GLOBAL SHANTY-OPEN T>

<GLOBAL TRAWLER-DOCKED T>

<GLOBAL SALVAGER-DOCKED T>

<GLOBAL BEDROOM-DOOR-LOCKED T>

<GLOBAL PASSBOOK-BALANCE 603>

<GLOBAL POCKET-CHANGE 20> ;"how much the player has on him"

<ROOM WINDING-ROAD-1
      (IN ROOMS)
      (DESC "Winding Road")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"The road ends at the lighthouse to the north, and heads back to the southeast.
You can see and hear the ocean pound the shoreline.")
      (GLOBAL LIGHTHOUSE OCEAN LOCKED-DOOR)
      (PSEUDO "LOCK" LIGHTHOUSE-LOCK-PSEUDO "LETTER" LOCKED-DOOR-F)
      (SE TO WINDING-ROAD-2)
      (NORTH "The lighthouse door is locked.")
      (IN "The lighthouse door is locked.")
      (CORRIDOR 1)
      (LINE 0)
      (STATION WINDING-ROAD-1)
      (ACTION WINDING-ROAD-1-F)>

<ROUTINE WINDING-ROAD-1-F (RARG)
	 <COND (<==? .RARG ,M-ENTER>
		<PUTP ,LOCKED-DOOR ,P?SDESC "lighthouse door">
		<COND (<==? ,MEETINGS-COMPLETED 1>
		       <COND (<G? ,PRESENT-TIME 585>
			      <ALL-GO-HOME>
			      <I-PLOT-NEVER-STARTS>
			      <SETG SM-CTR 4>)
			     (T <ENABLE <QUEUE I-SECOND-MEETING -1>>)>)>)
	       (<==? .RARG ,M-BEG>
		<COND (<VERB? WALK>
		       <COND (<AND <G? ,SM-CTR 0>
			    	   <L? ,SM-CTR 4>>
		       	      <COND (<G? ,HOW-HUNGRY 3>
				     <TELL
"Johnny looks at you. \"If you can't keep in shape, we don't want
you. One word to anyone and you're a goner.\" He then lets you
pass..." CR CR>
				     <SETG SM-CTR 4>
				     <RFALSE>)
				    (T <TELL 
"Johnny blocks you. \"What's the hurry, matey?\"" CR>)>)>)>)>>

<ROOM WINDING-ROAD-2
      (IN ROOMS)
      (DESC "Winding Road")
      (FLAGS RLANDBIT ONBIT)
      (LDESC
"The road branches to the northeast and northwest with the lighthouse off to
the northwest. To the south is an impenetrable swamp.")
      (GLOBAL LIGHTHOUSE)
      (NW TO WINDING-ROAD-1)
      (NE TO WINDING-ROAD-3)
      (SOUTH "There's no way to get footing on the swamp.")
      (CORRIDOR 3)
      (LINE 0)
      (PSEUDO "SWAMP" SWAMP-PSEUDO)
      (STATION WINDING-ROAD-2)
      (ACTION WINDING-ROAD-2-F)>

<ROUTINE WINDING-ROAD-2-F (RARG)
	 <COND (<==? .RARG ,M-BEG>
		<COND (<AND <VERB? BOARD THROUGH>
			    <PRSO? ,PSEUDO-OBJECT>>
		       <TELL "After trying to get a foothold, you give up." CR>)>)>>

<ROUTINE SWAMP-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "swamp">)
	       (<VERB? SMELL>
		<TELL "It smells awful." CR>)>>

<ROOM WINDING-ROAD-3
      (IN ROOMS)
      (DESC "Winding Road")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"A winding road starts up here to the southwest. You can see the
top of the lighthouse off to the northwest. The Wharf Road lies to the
northeast.")
      (GLOBAL LIGHTHOUSE)
      (SW TO WINDING-ROAD-2)
      (NE TO WHARF-ROAD-1)
      (CORRIDOR 2)
      (LINE 0)
      (STATION WINDING-ROAD-3)>

<ROOM WHARF-ROAD-1
      (IN ROOMS)
      (DESC "Wharf Road")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"This is the end of the Wharf Road, an east/west, two-lane road
that's the island's main street. Off to the east, small businesses line
the south side of the street. A winding road starts to the southwest,
heading toward the lighthouse. The Red Boar Inn is to the south.")
      (GLOBAL LIGHTHOUSE OCEAN FRONT-DOOR)
      (EAST TO WHARF-ROAD-2)
      (SW TO WINDING-ROAD-3)
      (SOUTH TO RED-BOAR-INN)
      (IN TO RED-BOAR-INN)
      (CORRIDOR 6)
      (LINE 0)
      (STATION WHARF-ROAD-1)>

<ROOM WHARF-ROAD-2
      (IN ROOMS)
      (DESC "Wharf Road")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"You are on the Wharf Road, with the McGinty Salvage office to the south. The
ocean lies to the north, its brine smell strong and refreshing.")
      (GLOBAL LIGHTHOUSE OCEAN FRONT-DOOR)
      (WEST TO WHARF-ROAD-1)
      (EAST TO WHARF-ROAD-3)
      (SOUTH PER WHARF-ROAD-2-S)
      (IN PER WHARF-ROAD-2-S)
      (CORRIDOR 4)
      (LINE 0)
      (STATION WHARF-ROAD-2)>

<ROUTINE WHARF-ROAD-2-S ("OPTIONAL" (PRINT? T))
	 <COND (<NOT .PRINT?>
		<RFALSE>)
	       (<AND ,BUSINESS-HOURS?
		     <IN? ,MCGINTY ,MCGINTY-HQ>>
		<RETURN ,MCGINTY-HQ>)
	       (T
		<TELL D ,MCGINTY "'s is closed." CR>
		<RFALSE>)>>

<OBJECT FRONT-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "front door")
	(SYNONYM DOOR)
	(ADJECTIVE FRONT)
	(FLAGS DOORBIT)
	(ACTION FRONT-DOOR-F)>

<ROUTINE FRONT-DOOR-F ("AUX" (OPEN? <>))
	 <COND (<OR <EQUAL? ,HERE ,RED-BOAR-INN ,WHARF-ROAD-1 ,WHARF-ROAD-5>
		    <EQUAL? ,HERE ,SHANTY>>
		<SET OPEN? T>)
	       (,BUSINESS-HOURS?
		<COND (<OR <EQUAL? ,HERE ,WHARF-ROAD-4 ,OUTFITTERS-HQ ,BANK>
			   <EQUAL? ,HERE ,SHORE-ROAD-2>>
		       <SET OPEN? T>)
		      (<IN? ,MCGINTY ,MCGINTY-HQ>
		       <SET OPEN? T>)>)>
	 <COND (<VERB? EXAMINE>
		<TELL "The door is ">
		<COND (.OPEN? <TELL "open">)
		      (T <TELL "closed">)>
		<TELL "." CR>)
	       (<VERB? OPEN>
		<COND (.OPEN? <TELL-ALREADY "open">)
		      (<==? ,HERE ,MCGINTY-HQ>
		       <TELL-BLOWS "closed">)
		      (T <TELL "It's locked." CR>)>)
	       (<VERB? UNLOCK>
		<COND (<OR <EQUAL? ,HERE ,MCGINTY-HQ ,OUTFITTERS-HQ ,SHANTY>
		    	   <EQUAL? ,HERE ,BANK ,RED-BOAR-INN>>
		       <TELL-DONT-HAVE "to from inside">)
		      (T <TELL-NO-KEY>)>)
	       (<VERB? CLOSE>
		<COND (.OPEN? <TELL-BLOWS "open">)
		      (T <TELL-ALREADY "closed">)>)>>

<ROUTINE TELL-BLOWS (STR)
	 <TELL "It blows back " .STR "." CR>>

<ROOM WHARF-ROAD-3
      (IN ROOMS)
      (DESC "Wharf Road")
      (FLAGS RLANDBIT ONBIT)
      (LDESC
"You are on the Wharf Road where the wharf starts up to the north.
The former site of Outfitters International's warehouse fronts the south
side of the road.")
      (GLOBAL LIGHTHOUSE OCEAN)
      (NORTH TO WHARF)
      (WEST TO WHARF-ROAD-2)
      (EAST TO WHARF-ROAD-4)
      (SOUTH TO VACANT-LOT)
      (CORRIDOR 260)
      (LINE 0)
      (STATION WHARF-ROAD-3)>

<ROOM WHARF-ROAD-4
      (IN ROOMS)
      (DESC "Wharf Road")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"The east/west Wharf Road continues, with Outfitters International,
a store which supplies ocean-going vessels, to the south.")
      (GLOBAL LIGHTHOUSE OCEAN FRONT-DOOR)
      (WEST TO WHARF-ROAD-3)
      (EAST TO WHARF-ROAD-5)
      (SOUTH TO OUTFITTERS-HQ IF BUSINESS-HOURS? ELSE "Outfitters is closed.")
      (IN TO OUTFITTERS-HQ IF BUSINESS-HOURS? ELSE "Outfitters is closed.")
      (CORRIDOR 4)
      (LINE 1)
      (STATION WHARF-ROAD-4)>

<ROOM WHARF-ROAD-5
      (IN ROOMS)
      (DESC "Wharf Road")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"You're on the east end of Wharf Road. The Ocean Road starts here and
parallels the island's east edge, heading to the southeast.
The Shanty is to the south.")
      (GLOBAL LIGHTHOUSE OCEAN FRONT-DOOR)
      (WEST TO WHARF-ROAD-4)
      (SOUTH TO SHANTY);(IF SHANTY-OPEN ELSE "It's after closing time.")
      (IN TO SHANTY);(IF SHANTY-OPEN ELSE "It's after closing time.")
      (SE TO OCEAN-ROAD-1)
      (CORRIDOR 12)
      (LINE 1)
      (STATION WHARF-ROAD-5)>

<ROOM OCEAN-ROAD-1
      (IN ROOMS)
      (DESC "Ocean Road")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"You are at the north end of the Ocean Road, a narrow north/south road
on the east edge of the island. The Wharf Road starts
to the northwest, and a back alley starts off to the southwest.")
      (GLOBAL LIGHTHOUSE OCEAN ROCKS)
      (NW TO WHARF-ROAD-5)
      (SW TO BACK-ALLEY-5)
      (SOUTH TO OCEAN-ROAD-2)
      (EAST "The rocks are too sharp and dangerous.")
      (CORRIDOR 24)
      (LINE 1)
      (STATION OCEAN-ROAD-1)>

<ROOM OCEAN-ROAD-2
      (IN ROOMS)
      (DESC "Ocean Road")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"You are halfway along the Ocean Road, with the start of an
alley off to the northwest. An empty field lies to your west,
and the dangerous ocean shore lies off to your east.")
      (GLOBAL LIGHTHOUSE OCEAN FIELD ROCKS)
      (NORTH TO OCEAN-ROAD-1)
      (NW TO BACK-ALLEY-5)
      (SOUTH TO OCEAN-ROAD-3)
      (WEST "You can't get through the weeds.")
      (EAST "The rocks are too sharp and dangerous.")
      (CORRIDOR 16)
      (LINE 1)
      (STATION OCEAN-ROAD-2)>

<ROOM OCEAN-ROAD-3
      (IN ROOMS)
      (DESC "Ocean Road")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"This is the south end of the Ocean Road. To the southeast is a small path
leading up to about 100 feet above sea level. The Ocean Road heads north,
and the Shore Road starts to the southwest.")
      (GLOBAL LIGHTHOUSE OCEAN ROCKS)
      (NORTH TO OCEAN-ROAD-2)
      (SW TO SHORE-ROAD-2)
      (UP TO POINT-LOOKOUT)
      (SE TO POINT-LOOKOUT)
      (EAST "The rocks are too sharp and dangerous.")
      (CORRIDOR 112)
      (LINE 1)
      (STATION OCEAN-ROAD-3)>

<ROOM SHORE-ROAD-1
      (IN ROOMS)
      (DESC "Shore Road")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"You are at the west end of the east/west Shore Road, with the
ferry landing to the west. To the north is an impenetrable field,
while the south is bordered by the ocean. You can see the mainland in the
distance.")
      (GLOBAL LIGHTHOUSE FERRY OCEAN FIELD)
      (WEST TO FERRY-LANDING)
      (EAST TO SHORE-ROAD-2)
      (NORTH "You can't get through the weeds.")
      (CORRIDOR 128)
      (LINE 1)
      (STATION SHORE-ROAD-1)>

<ROOM SHORE-ROAD-2
      (IN ROOMS)
      (DESC "Shore Road")
      (FLAGS RLANDBIT ONBIT)
      ;(LDESC 
"This is the east end of the Shore Road, before the ferry. The Mariners'
Trust, the island's only bank, is off to the north. The Ocean Road starts
to the northeast.")
      (GLOBAL LIGHTHOUSE FERRY OCEAN FRONT-DOOR)
      (NORTH TO BANK IF BUSINESS-HOURS? ELSE "The bank is closed.")
      (IN TO BANK IF BUSINESS-HOURS? ELSE "The bank is closed.")
      (WEST TO SHORE-ROAD-1)
      (NE TO OCEAN-ROAD-3)
      (CORRIDOR 192)
      (LINE 1)
      (STATION SHORE-ROAD-2)
      (ACTION SHORE-ROAD-2-F)>

<ROUTINE SHORE-ROAD-2-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"This is the east end of the " D ,SHORE-ROAD-1 ", an east/west road with a ferry landing
at its west end. The " D ,BANK ", the island's only bank, is off to the north.
The " D ,OCEAN-ROAD-1 " starts up to the northeast." CR>)>>

<ROOM BACK-ALLEY-1
      (IN ROOMS)
      (DESC "Back Alley")
      (LDESC
"You're at the west end of an east/west alley. The back
entrance to the Red Boar Inn is to the north, and an overgrown field is to
the south.")
      (GLOBAL LOCKED-DOOR FIELD)
      (EAST TO BACK-ALLEY-2)
      (NORTH "The door is locked.")
      (SOUTH "You can't get through the weeds.")
      (FLAGS RLANDBIT ONBIT)
      (LINE 3)
      (CORRIDOR 512)
      (STATION BACK-ALLEY-1)
      (ACTION BACK-ALLEY-1-F)>

<ROUTINE BACK-ALLEY-1-F (RARG)
	 <COND (<==? .RARG ,M-ENTER>
		<PUTP ,LOCKED-DOOR ,P?SDESC "back door">)>>

<ROOM BACK-ALLEY-2
      (IN ROOMS)
      (DESC "Back Alley")
      (LDESC
"You are in a narrow alley. To the north is the back door of McGinty
Salvage, as well as a small window. An overgrown field lies to the south.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BACK-WINDOW LOCKED-DOOR FIELD)
      (NORTH PER BACK-ALLEY-2-N)
      (IN PER BACK-ALLEY-2-N)
      (SOUTH "You can't get through the weeds.")
      (WEST TO BACK-ALLEY-1)
      (EAST TO BACK-ALLEY-3)
      (LINE 3)
      (CORRIDOR 512)
      (STATION BACK-ALLEY-2)
      (ACTION BACK-ALLEY-2-F)>

<ROUTINE BACK-ALLEY-2-F (RARG)
	 <COND (<==? .RARG ,M-ENTER>
		<PUTP ,LOCKED-DOOR ,P?SDESC "back door">)>>

<ROUTINE BACK-ALLEY-2-N ("OPTIONAL" (PRINT? T))
	 <COND (<NOT .PRINT?>
		<RFALSE>)
	       (<FSET? ,BACK-WINDOW ,OPENBIT>
		<COND (<OR <IN? ,MCGINTY ,BACK-ALLEY-1>
			   <IN? ,MCGINTY ,BACK-ALLEY-2>
			   <IN? ,MCGINTY ,BACK-ALLEY-3>>
		       <JIGS-UP
"\"No, you don't!\" cries McGinty as he pulls out a gun and shoots you.">)
		      (T
	               <TELL-THRU-WINDOW>
		       <COND (<IN? ,MCGINTY ,MCGINTY-HQ>
		       	      <SETG MCGINTY-HQ-OCCUPIED T>)>
		       <RETURN ,MCGINTY-HQ>)>)
	       (T
		<TELL "The door is locked." CR>
		<RFALSE>)>>

<GLOBAL MCGINTY-HQ-OCCUPIED <>>

<OBJECT BACK-WINDOW
	(IN LOCAL-GLOBALS)
	(DESC "back window")
	(SYNONYM WINDOW)
	(ADJECTIVE SMALL BACK)
	(ACTION BACK-WINDOW-F)>

<ROUTINE BACK-WINDOW-F ()
	 <COND (<VERB? OPEN>
		<COND (<IN? ,PLAYER ,MCGINTY-HQ>
		       <TELL-YOU-CANT "open it from this side.">)
		      (<FSET? ,BACK-WINDOW ,OPENBIT>
		       <TELL-ALREADY "open">)
		      (T
		       <FSET ,BACK-WINDOW ,OPENBIT>
		       <TELL
"You open it enough to fit through it." CR>)>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,BACK-WINDOW ,OPENBIT>
		       <FCLEAR ,BACK-WINDOW ,OPENBIT>
		       <TELL "You close the window." CR>)
		      (T <TELL-ALREADY "closed">)>)
	       (<VERB? THROUGH BOARD>
		<COND (<FSET? ,BACK-WINDOW ,OPENBIT>
		       <COND (<IN? ,PLAYER ,MCGINTY-HQ>
			      <DO-WALK ,P?SOUTH>)
			     (T <DO-WALK ,P?NORTH>)>)
		      (T <TELL-CLOSED "window">)>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<TELL "You see ">
                <COND (<IN? ,PLAYER ,MCGINTY-HQ>
		       <TELL "the back alley">)
		      (<IN? ,MCGINTY ,MCGINTY-HQ>
		       <TELL D ,MCGINTY " sitting at his desk">)
		      (T <TELL D ,MCGINTY "'s office">)>
		<TELL "." CR>)
	       (<VERB? UNLOCK>
		<TELL "It doesn't seem to be locked." CR>)>>

<OBJECT LOCKED-DOOR
	(IN LOCAL-GLOBALS)
	;(DESC "back door")
	(SDESC "back door")
	(SYNONYM DOOR)
	(ADJECTIVE BACK LIGHTH)
	(ACTION LOCKED-DOOR-F)>

<ROUTINE LOCKED-DOOR-F ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "lighthouse door">)
	       (<VERB? OPEN>
		<TELL "It's locked." CR>)
	       (<VERB? UNLOCK>
		<TELL-NO-KEY>)
	       (<VERB? READ EXAMINE>
		<COND (<EQUAL? ,HERE ,WINDING-ROAD-1>
		       <TELL 
"The lettering on the door reads:|
">
		       <FIXED-FONT-ON>
		       <TELL
"    \"This " D ,LIGHTHOUSE " is part of|
             CUTTHROATS|
    an Infocom Tale of Adventure|
 by Michael Berlyn and Jerry Wolper|
        (c)1984 Infocom, Inc.\"" CR>
		       <FIXED-FONT-OFF>
		       <RTRUE>)
		      (<VERB? READ>
		       <V-READ>)
		      (T <TELL-CLOSED "door">)>)
	       (<VERB? MUNG>
		<TELL "The door and lock withstand your attempts." CR>)
	       (<VERB? KNOCK>
		<TELL-NO-ANSWER>)
	       (<VERB? CLOSE>
	        <TELL-ALREADY "closed">)
	       (<VERB? LOCK>
		<TELL-ALREADY "locked">)>>

<ROUTINE TELL-NO-ANSWER ()
	 <TELL "You wait a minute, but there's no answer." CR>>

<ROOM BACK-ALLEY-3
      (IN ROOMS)
      (DESC "Back Alley")
      (LDESC
"You are in an east/west alley. To the north is a
vacant lot, and an overgrown field lies to the south.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL FIELD)
      (NORTH TO VACANT-LOT)
      (SOUTH "You can't get through the weeds.")
      (WEST TO BACK-ALLEY-2)
      (EAST TO BACK-ALLEY-4)
      (LINE 3)
      (CORRIDOR 768)
      (STATION BACK-ALLEY-3)>

<ROOM BACK-ALLEY-4
      (IN ROOMS)
      (DESC "Back Alley")
      (LDESC
"You are in an alley behind Outfitters International. An abandoned
field lies to the south.")
      (GLOBAL LOCKED-DOOR FIELD)
      (FLAGS RLANDBIT ONBIT)
      (NORTH "The door is locked.")
      (SOUTH "You can't get through the weeds.")
      (WEST TO BACK-ALLEY-3)
      (EAST TO BACK-ALLEY-5)
      (LINE 3)
      (CORRIDOR 512)
      (STATION BACK-ALLEY-4)
      (ACTION BACK-ALLEY-4-F)>

<ROUTINE BACK-ALLEY-4-F (RARG)
	 <COND (<==? .RARG ,M-ENTER>
		<PUTP ,LOCKED-DOOR ,P?SDESC "back door">)>>

<ROOM BACK-ALLEY-5
      (IN ROOMS)
      (DESC "Back Alley")
      (LDESC
"You're at the east end of an east/west alley. The back door of
The Shanty is to the north, and an overgrown field is to the south.
Narrow paths to the northeast and southeast lead to the Ocean Road.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL LOCKED-DOOR FIELD)
      (NORTH "The door is locked.")
      (SOUTH "You can't get through the weeds.")
      (WEST TO BACK-ALLEY-4)
      (NE TO OCEAN-ROAD-1)
      (SE TO OCEAN-ROAD-2)
      (LINE 3)
      (CORRIDOR 512)
      (STATION BACK-ALLEY-5)
      (ACTION BACK-ALLEY-5-F)>

<ROUTINE BACK-ALLEY-5-F (RARG)
	 <COND (<==? .RARG ,M-ENTER>
		<PUTP ,LOCKED-DOOR ,P?SDESC "back door">)>>

<ROOM RED-BOAR-INN
      (IN ROOMS)
      (DESC "Red Boar Inn")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"This is the lobby of the Red Boar Inn, a place with the charm of a
two-dollar flophouse. The Wharf Road is outside, to the north, and a
stairway leads up to the rooms to the south.")
      (GLOBAL STAIRS WALLPAPER CARPET FRONT-DOOR)
      (NORTH TO WHARF-ROAD-1)
      (OUT TO WHARF-ROAD-1)
      (SOUTH TO UPSTAIRS-HALLWAY)
      (UP TO UPSTAIRS-HALLWAY)
      (LINE 2)
      (STATION RED-BOAR-INN)
      (PSEUDO "MAIL" MAIL-PSEUDO "MESSAG" MESSAGE-PSEUDO)
      (ACTION RED-BOAR-INN-F)>

<ROUTINE RED-BOAR-INN-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<MOVE ,SPEAR-CARRIER ,RED-BOAR-INN>
		<PUTP ,SPEAR-CARRIER ,P?SDESC "desk clerk">
		<PUTP ,SPEAR-CARRIER ,P?LDESC 
"A desk clerk sits behind the counter.">
		<PUTP ,GLOBAL-SURFACE ,P?SDESC "counter">
		<MOVE-SHARED-OBJECTS ,RED-BOAR-INN>
		<RFALSE>)>>

<ROUTINE MAIL-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "mail">)
	       (<VERB? ASK-FOR ASK-CONTEXT-FOR>
		<RFALSE>)
	       (T
		<GLOBAL-NOT-HERE-PRINT ,PSEUDO-OBJECT>
		<RFATAL>)>>

<ROUTINE MESSAGE-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "message">)
	       (T <MAIL-PSEUDO>)>>

<ROOM UPSTAIRS-HALLWAY
      (IN ROOMS)
      (DESC "Upstairs Hallway")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"You are at the top of the stairs in the Red Boar. Your room is to
the south, and other rooms line the hall. The lighting in
the hallway is dim and drab like the wallpaper and carpeting.")
      (GLOBAL BEDROOM-DOOR STAIRS WALLPAPER CARPET)
      (IN TO BEDROOM IF BEDROOM-DOOR IS OPEN)
      (SOUTH TO BEDROOM IF BEDROOM-DOOR IS OPEN)
      (EAST "The people in those rooms aren't interesting.")
      (WEST "The people in those rooms aren't interesting.")
      (DOWN TO RED-BOAR-INN)
      (NORTH TO RED-BOAR-INN)
      (LINE 2)
      (STATION UPSTAIRS-HALLWAY)>

<ROOM BEDROOM
      (IN ROOMS)
      (DESC "Your Room")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"You're in your room in the Red Boar Inn. It's sparsely furnished, but
comfortable enough. To the north is the door, and there's a closet without
a door to the west.")
      (GLOBAL BEDROOM-DOOR WALLPAPER CARPET WINDOW)
      (OUT TO UPSTAIRS-HALLWAY IF BEDROOM-DOOR IS OPEN)
      (NORTH TO UPSTAIRS-HALLWAY IF BEDROOM-DOOR IS OPEN)
      (WEST PER BEDROOM-W)
      (IN PER BEDROOM-W)
      (PSEUDO "CLOTHE" CLOTHES-PSEUDO)
      (LINE 2)
      (STATION BEDROOM)
      (ACTION BEDROOM-F)>

<ROUTINE BEDROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-FLASH>
		<COND (<AND <IN? ,WEASEL ,BEDROOM>
			    <NOT <VERB? LOOK>>>
		       <JIGS-UP 
"The Weasel is rummaging through your stuff. He notices you, and
before you have a chance to react, he smiles then cuts your throat.">)
		      (,BEDROOM-MESSAGE
		       <TELL ,BEDROOM-MESSAGE>
		       <CRLF>
		       <SETG BEDROOM-MESSAGE <>>)>)
	       (<==? .RARG ,M-BEG>
		<COND (<AND <VERB? TAKE>
		     	    <PRSO? ,PSEUDO-OBJECT>>
		       <TELL-CLOTHES>)>)>>

<ROUTINE BEDROOM-W ("OPTIONAL" (PRINT? T))
	 <COND (.PRINT? <TELL "It's not a walk-in closet." CR>)>
	 <RFALSE>>

<OBJECT BED
	(IN BEDROOM)
	(DESC "bed")
	(SYNONYM BED COT MATTRE)
	(FLAGS VEHBIT SURFACEBIT CONTBIT OPENBIT TRANSBIT)
	(LDESC "A comfortable bed sits along the wall.")
	(CAPACITY 30)
	(STATION 30) ;"metal content"
	(ACTION BED-F)>

<ROUTINE BED-F ("OPTIONAL" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-BEG>
		<COND (<AND ,PRSO
			    <OR <IN? ,PRSO ,PLAYER>
			   	<IN? ,PRSO ,BED>
			   	<PRSO? ,GLOBAL-ROOM>
			   	<AND <VERB? DROP> <PRSO? ,BED>>>>
		       <RFALSE>)
		      (<AND <VERB? EXAMINE>
			    <PRSO? ,BUREAU ,CLOSET>>
		       <RFALSE>)
		      (<NOT <BED-VERB?>>
		       <TELL "You should get out of bed first." CR>
		       <RFATAL>)>)
	       (<NOT .RARG>
		<COND (<AND <VERB? BOARD>
			    <OR <FIRST? ,BED>
				<WEARING-SOMETHING?>>>
		       <TELL-NOT-COMFORTABLE>
		       ;<TELL "That would be uncomfortable." CR>)>)>>

<ROUTINE BED-VERB? ()
	 <COND (<VERB? BRIEF SUPER-BRIEF DIAGNOSE VERBOSE INVENTORY QUIT
		       RESTART RESTORE SAVE SCORE $VERIFY VERSION AGAIN
		       ;ANSWER ;REPLY ASK-ABOUT ASK-CONTEXT-ABOUT ASK-FOR
		       ASK-CONTEXT-FOR BREATHE ;BUG $CALL CALL FIND CHOMP
		       COUNT CURSES DISEMBARK GOODBYE HELLO HELP
		       ALARM LATITUDE LONGITUDE LISTEN LOOK LOOK-INSIDE
		       CHASTISE MAYBE YES NO MUMBLE ;ADVENTURE PRAY SCRIPT SIT
		       SIT-ON UNSCRIPT SMELL STAND STAY TELL SAY SLEEP TIME
		       WAIT WAIT-FOR WAVE-AT WIN YELL ;ZORK WHAT>
		<RTRUE>)
	       (T <RFALSE>)>>
 
<OBJECT BUREAU
	(IN BEDROOM)
	(DESC "dresser")
	(FDESC "In a corner of the room is a lopsided wooden dresser.")
	(SYNONYM BUREAU DRESSE DRAWER)
	(ADJECTIVE OLD WOODEN LOPSID TILTED)
	(FLAGS CONTBIT)
	(CAPACITY 20)
	(ACTION BUREAU-F)>

<ROUTINE BUREAU-F ()
	 <COND (<VERB? OPEN>
		<COND (<FSET? ,BUREAU ,OPENBIT>
		       <TELL-ALREADY "open">)
		      (T
		       <FSET ,BUREAU ,OPENBIT>
		       <TELL "Opening the " D ,BUREAU " reveals ">
		       <TELL-BUREAU-CONTENTS>)>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,BUREAU ,OPENBIT>
		       <FCLEAR ,BUREAU ,OPENBIT>
		       <TELL "Closed." CR>)
		      (T <TELL-ALREADY "closed">)>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,BUREAU>>
		<COND (<IDROP>
		       <TELL "It slides off onto the floor." CR>)>
		<RTRUE>)
	       (<VERB? EXAMINE>
	        <TELL "It's a tilted old wooden " D ,BUREAU>
		<COND (<FSET? ,BUREAU ,OPENBIT>
		       <COND (<FIRST? ,BUREAU>
			      <TELL ". In addition to your clothes, you find ">
			      <PRINT-CONTENTS ,BUREAU>
			      <TELL " inside." CR>)
			     (T <TELL ". Your clothes are in it." CR>)>)
		      (T <TELL ", which is closed." CR>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<FSET? ,BUREAU ,OPENBIT>
		       <TELL "The " D ,BUREAU " contains ">
		       <TELL-BUREAU-CONTENTS>)>)>>

<ROUTINE TELL-BUREAU-CONTENTS ()
	 <COND (<FIRST? ,BUREAU>
		<PRINT-CONTENTS ,BUREAU>
		<TELL ", as well as">)
	       (T <TELL "nothing but">)>
	 <TELL " your clothes." CR>>

<OBJECT PASSBOOK
	(IN BUREAU)
	(DESC "Mariners' Trust passbook")
	(SYNONYM PASSBOOK BANKBOOK)
	(ADJECTIVE BANK MARINE TRUST DISTIN)
	(FLAGS TAKEBIT READBIT)
	(SIZE 4)
	(VALUE 10)
	(ACTION PASSBOOK-F)>

<ROUTINE PASSBOOK-F ()
	 <COND ;(<VERB? TAKE>
		<COND (<ITAKE <>>
		       <TELL 
"Taken. You notice that it's a little too big to be carried inconspicuously."
CR>)
		      (T <RFALSE>)>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,PASSBOOK ,RMUNGBIT>
		       <TELL-SOGGY>)
		      (T
		       <TELL "This is a distinctive " D ,BANK " passbook">
		       <COND (<AND <NOT <IN? ,PASSBOOK ,MCGINTY>>
			    	   <NOT <IN? ,PASSBOOK ,WEASEL>>>
			      <TELL
" which shows a balance of $" N ,PASSBOOK-BALANCE ". The last date stamped in
it is " ,STUPID-PROBLEM-STRING>)>
		       <TELL "." CR>)>)
	       (<VERB? READ OPEN LOOK-INSIDE>
		<COND (<OR <IN? ,PASSBOOK ,WEASEL>
			   <IN? ,PASSBOOK ,MCGINTY>>
		       <START-SENTENCE <LOC ,PASSBOOK>>
		       <TELL " has it." CR>)
		      (T
		       <PERFORM ,V?EXAMINE ,PASSBOOK>
		       <RTRUE>)>)
	       (<VERB? CLOSE>
		<TELL "It's closed." CR>)>>

<GLOBAL STUPID-PROBLEM-STRING "April 23">

<OBJECT KEY
	(IN BUREAU)
	(DESC "room key")
	(SYNONYM KEY)
	(ADJECTIVE ROOM)
	(TEXT "It's your room key.")
	(FLAGS TAKEBIT TOOLBIT)
	(SIZE 4)
	(STATION 5) ;"metal content"
	(ACTION KEY-F)>

<ROUTINE KEY-F ()
	 <COND (<AND <VERB? LOCK>
		     <PRSO? ,BEDROOM-DOOR>>
		<COND (,BEDROOM-DOOR-LOCKED
		       <TELL-ALREADY "locked">
		       <RTRUE>)
		      (<FSET? ,BEDROOM-DOOR ,OPENBIT>
		       <TELL "You should close it first." CR>
		       <RTRUE>)
		      (T
		       <SETG BEDROOM-DOOR-LOCKED T>
		       <TELL-NOW ,BEDROOM-DOOR "locked">
		       <RTRUE>)>)
	       (<AND <VERB? UNLOCK>
		     <PRSO? ,BEDROOM-DOOR>>
		<COND (<NOT ,BEDROOM-DOOR-LOCKED>
		       <TELL-ALREADY "unlocked">
		       <RTRUE>)
		      (T
		       <SETG BEDROOM-DOOR-LOCKED <>>
		       <TELL-NOW ,BEDROOM-DOOR "unlocked">
		       <RTRUE>)>)
	       (<AND <VERB? OPEN>
		     <PRSO? ,BEDROOM-DOOR>>
		<PERFORM ,V?UNLOCK ,BEDROOM-DOOR ,KEY>
		<PERFORM ,V?OPEN ,BEDROOM-DOOR>
		<RTRUE>)>>

<OBJECT NOTE
	(IN BEDROOM)
	(DESC "note")
	(SYNONYM NOTE)
	(ADJECTIVE HANDWRITTEN)
	(FDESC 
"On the floor is a note that must have been slipped under the
door while you slept.")
	(TEXT 
"The note is hastily scrawled:|
|
\"If you're interested in a big deal, be at The Shanty at 8:30 this
morning.|
               -Johnny\"")
	(SIZE 4)
	(FLAGS TAKEBIT READBIT)
	(ACTION NOTE-F)>

<ROUTINE NOTE-F ()
	 <COND (<AND <VERB? EXAMINE READ>
		     <FSET? ,NOTE ,RMUNGBIT>>
		<TELL-SOGGY>)>>

<OBJECT BOOK
	(IN BUREAU)
	(DESC "book of shipwrecks")
	(SYNONYM BOOK TEXT SHIPWR)
	(ADJECTIVE SHIPWR OCEAN MARINE NAUTIC HEVLIN)
	(TEXT "This book is included in your Cutthroats package.")
	(FLAGS TAKEBIT READBIT)
	(ACTION BOOK-F)>

<ROUTINE BOOK-F ()
	 <COND (<AND <FSET? ,BOOK ,RMUNGBIT>
		     <VERB? OPEN READ EXAMINE>>
		<TELL-SOGGY>)
	       (<VERB? OPEN CLOSE>
		<PERFORM ,V?READ ,BOOK>
		<RTRUE>)>>

<ROUTINE CLOTHES-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "bunch of clothes">)
	       (<VERB? WEAR DISEMBARK>
		<TELL-CLOTHES>)>>

<ROUTINE TELL-CLOTHES ()
	 <TELL "What you have on now is fine." CR>>

<OBJECT CLOSET
	(IN BEDROOM)
	(DESC "closet")
	(SYNONYM CLOSET)
	(CAPACITY 40)
	(FLAGS CONTBIT OPENBIT)
	(DESCFCN CLOSET-F)
	(ACTION CLOSET-F)>

<ROUTINE CLOSET-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-OBJDESC>
		<RTRUE>)
	       (<VERB? OPEN CLOSE>
		<TELL "The closet has no door." CR>)
	       (<VERB? EXAMINE>
		<TELL
"It looks as if the door was torn off its hinges a long time ago. ">
		<RFALSE>)
	       (<VERB? THROUGH BOARD>
		<BEDROOM-W>
		<RTRUE>)>>

<OBJECT WET-SUIT
	(IN CLOSET)
	(DESC "wet suit")
	(SYNONYM SUIT)
	(ADJECTIVE WET SCUBA)
	(FLAGS WEARBIT TAKEBIT)
	(ACTION WET-SUIT-F)>

<ROUTINE WET-SUIT-F ()
	 <COND (<AND <VERB? DROP THROW DISEMBARK>
		     <OR <FSET? ,AIR-TANK ,WORNBIT>
			 <FSET? ,FLIPPERS ,WORNBIT>
			 <FSET? ,MASK ,WORNBIT>>>
		<TELL-YOU-CANT
"get it over the other equipment you're wearing.">)
	       (<AND <VERB? WEAR>
		     <FSET? ,DEEP-SUIT ,WORNBIT>>
		<TELL-YOU-CANT "fit that over the " <>>
		<TELL D ,DEEP-SUIT "." CR>)>>

<OBJECT FLIPPERS
	(IN CLOSET)
	(DESC "pair of flippers")
	(SYNONYM FLIPPE PAIR FINS FIN)
	(ADJECTIVE SWIM)
	(FLAGS WEARBIT TAKEBIT)
	(ACTION FLIPPERS-F)>

<ROUTINE FLIPPERS-F ()
	 <COND (<VERB? WEAR>
		<COND (<FSET? ,WET-SUIT ,WORNBIT>
		       <RFALSE>)
		      (<FSET? ,DEEP-SUIT ,WORNBIT>
		       <TELL "They don't fit with the " D ,DEEP-SUIT "." CR>)
		      (T 
		       <TELL
"The " D ,WET-SUIT " won't fit over them." CR>)>)>>

<OBJECT MASK
	(IN CLOSET)
	(DESC "diving mask")
	(SYNONYM MASK)
	(ADJECTIVE DIVING DIVER DIVERS SCUBA)
	(FLAGS WEARBIT TAKEBIT TRANSBIT)
	(ACTION MASK-F)>

<ROUTINE MASK-F ()
	 <COND (<VERB? WEAR>
		<COND (<FSET? ,WET-SUIT ,WORNBIT>
		       <RFALSE>)
		      (<FSET? ,DEEP-SUIT ,WORNBIT>
		       <TELL "It won't fit over the " D ,DEEP-SUIT "'s hood." CR>)
		      (T <TELL
"You couldn't fit the " D ,WET-SUIT " over it." CR>)>)
	       (<AND <EQUAL? <GETP ,HERE ,P?LINE>
			     ,UNDERWATER-LINE-C>
		     <FSET? ,MASK ,WORNBIT>
		     <VERB? DROP THROW DISEMBARK>
		     <NOT <AIRTIGHT-ROOM?>>>
		<JIGS-UP
"As you remove the mask, you find you can't breathe.">)>>

<OBJECT AIR-TANK
	(IN CLOSET)
	(DESC "air tank")
	(SYNONYM TANK GAUGE)
	(ADJECTIVE AIR DOUBLE ALUMIN SCUBA)
	(FLAGS TAKEBIT WEARBIT VOWELBIT)
	(STATION 25) ;"metal content"
	(ACTION AIR-TANK-F)>

<ROUTINE AIR-TANK-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This double tank made of aluminum is designed to fit over a
" D ,WET-SUIT ". Its gauge is currently at ">
		<COND (<G? ,AIR-LEFT 150>
		       <TELL "full">)
		      (<G? ,AIR-LEFT 100>
		       <TELL "fairly full">)
		      (<G? ,AIR-LEFT 50>
		       <TELL "medium">)
		      (<G? ,AIR-LEFT 15>
		       <TELL "almost empty">)
		      (T <TELL "empty">)>
		<TELL "." CR>)
	       (<VERB? FILL>
		<COND (<OR <PRSI? ,COMPRESSOR>
			   <AND <PRSI? ,AIR>
				<IN? ,COMPRESSOR ,HERE>>>
		       <COND (<G? <GETP ,COMPRESSOR ,P?NORTH> 0>
			      <TELL
"The salesman tells you to rent the compressor first." CR>)
			     (<FSET? ,AIR-TANK ,WORNBIT>
			      <TELL-CONTORT>)
			     (T
			      <SETG AIR-LEFT 160>
		       	      <TELL-NOW ,AIR-TANK "filled">)>)
		      (<PRSI? ,MM-COMPRESSOR>
		       <TELL
"There's no way to get air from this compressor to the tank." CR>)
		      (<PRSI? ,AIR>
		       <TELL "The right compressor would probably help." CR>)>)
	       (<VERB? EMPTY>
		<COND (<==? <GETP ,HERE ,P?LINE> ,UNDERWATER-LINE-C>
		       <JIGS-UP "Not a very good idea...">)
		      (<==? ,AIR-LEFT 0>
		       <TELL-ALREADY "empty">)
		      (T
		       <SETG AIR-LEFT 0>
		       <TELL-NOW ,AIR-TANK "empty">)>)
	       (<VERB? WEAR>
		<COND (<FSET? ,WET-SUIT ,WORNBIT>
		       <RFALSE>)
		      (<FSET? ,DEEP-SUIT ,WORNBIT>
		       <TELL
"This tank can't be worn with a " D ,DEEP-SUIT "." CR>)
		      (T <TELL 
"This tank should be worn outside a " D ,WET-SUIT "." CR>)>)
	       (<AND <EQUAL? <GETP ,HERE ,P?LINE>
			     ,UNDERWATER-LINE-C>
		     <VERB? DROP THROW>
		     <NOT <FSET? ,DEEP-SUIT ,WORNBIT>>
		     <NOT <AIRTIGHT-ROOM?>>>
		<JIGS-UP
"As the tank falls away, it pulls the airhose with it, making you
regret your lack of gills.">)>>

<GLOBAL AIR-LEFT 0>

;<ROUTINE WHAT-FOO (OBJ)
	 <COND (<PRSO? .OBJ>
		<TELL "What" PRSO "?" CR>)
	       (<PRSI? .OBJ>
		<TELL "What" PRSI "?" CR>)>
	 <SETG P-IT-OBJECT <>>
	 <RTRUE>>

<ROOM MCGINTY-HQ
      (IN ROOMS)
      (DESC "McGinty Salvage")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BACK-WINDOW FRONT-DOOR LOCKED-DOOR)
      (LDESC 
"You are in the McGinty Salvage office, a concern whose main business is
salvaging wrecks. The place is a mess, and the floor
is littered with chewed-on cigar stubs. To the
north lies the Wharf Road. You can't help feeling uncomfortable here.")
      (NORTH TO WHARF-ROAD-2)
      (OUT TO WHARF-ROAD-2)
      (SOUTH PER MCGINTY-HQ-S)
      (PSEUDO "CHAIR" MCGINTY-CHAIR-PSEUDO)
      (LINE 0)
      (STATION WHARF-ROAD-2)
      (ACTION MCGINTY-HQ-F)>

<ROUTINE MCGINTY-HQ-F (RARG "AUX" DEST)
	 <COND (<==? .RARG ,M-ENTER>
		<PUTP ,LOCKED-DOOR ,P?SDESC "back door">
	        <PUTP ,GLOBAL-SURFACE ,P?SDESC "desk">
		<MOVE-SHARED-OBJECTS ,MCGINTY-HQ>
		<RFALSE>)
	       (<==? .RARG ,M-FLASH>
		<COND (,MCGINTY-HQ-OCCUPIED
		       <COND (<NOT <IN? ,PASSBOOK ,PLAYER>>
			      <MCGINTY-F ,M-OBJDESC>
		       	      <CRLF>)>
		       <JIGS-UP
"As McGinty sees someone climbing through the window, he pulls out a gun
and fires. His aim is better than your luck.">)
		      (<AND <IN? ,MCGINTY ,MCGINTY-HQ>
			    <SET DEST <GET <GET ,GOAL-TABLES ,MCGINTY-C>
					   ,GOAL-S>>
			    <NOT <==? .DEST ,WHARF-ROAD-2>>>
		       <MCGINTY-ERRAND>)>)
	       (<==? .RARG ,M-BEG>
		<COND (<PRSO? ,GLOBAL-SURFACE>
		       <COND (<VERB? OPEN>
			      <TELL "It's locked." CR>)
			     (<VERB? UNLOCK>
			      <TELL-NO-KEY>)
			     (<VERB? CLOSE>
			      <TELL-ALREADY "closed">)>)>)>>

<ROUTINE MCGINTY-HQ-S ("OPTIONAL" (PRINT? T))
	 <COND (<FSET? ,BACK-WINDOW ,OPENBIT>
		<TELL-THRU-WINDOW>
		<RETURN ,BACK-ALLEY-2>)
	       (<PRSO? ,WINDOW>
		<COND (.PRINT? <TELL-CLOSED "window">)>
		<RFALSE>)
	       (T
		<COND (.PRINT? <TELL "The door is locked." CR>)>
		<RFALSE>)>>

<ROUTINE TELL-THRU-WINDOW ()
	 <TELL "You climb through the open window..." CR CR>>

<ROUTINE MCGINTY-CHAIR-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "chair">)
	       (<VERB? PUT-ON>
		<TELL "It's too lopsided." CR>)
	       (<VERB? CLIMB-ON SIT-ON>
		<TELL-WHY-BOTHER>)
	       (<VERB? EXAMINE>
		<TELL "It's an impressively beat-up chair." CR>)>>

;<OBJECT PAPERS
	(IN MCGINTY-HQ)
	(DESC "mess of old papers")
	(SYNONYM MESS PAPER PAPERS)
	(ADJECTIVE OLD CRUMPL)
	(FLAGS TRYTAKEBIT NDESCBIT READBIT)
	(ACTION PAPERS-F)>

;<ROUTINE PAPERS-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"These are old papers relating to various deals of " D ,MCGINTY
"'s. None of them
pertain to you." CR>)
	       (<VERB? TAKE>
		<COND (<AND <==? ,HERE ,MCGINTY-HQ>
			    <IN? ,MCGINTY ,MCGINTY-HQ>>
		       <TELL
D ,MCGINTY " squeals angrily. \"Keep your hands off of my private papers!\""
CR>)
		      (T <TELL "Why bother? They're not very interesting." CR>)>)>>

<OBJECT STUBS
	(IN MCGINTY-HQ)
	(DESC "cigar stub")
	(SYNONYM STUB STUBS BUTT BUTTS)
	(ADJECTIVE OLD CHEWED CIGAR SMELLY CHEAP)
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION STUBS-F)>

<ROUTINE STUBS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The floor is littered with stubs from cheap cigars." CR>)
	       (<VERB? SMELL>
		<TELL "The aroma is reminiscent of burning tires." CR>)
	       (<VERB? TAKE>
		<TELL
"You think twice and realize you don't want to carry a used cigar." CR>)>>

<OBJECT ENVELOPE
	(IN LOCAL-GLOBALS)
	(DESC "envelope")
	(SYNONYM ENVELO WRITIN)
	(ADJECTIVE BUSINE)
	(FLAGS TAKEBIT READBIT CONTBIT VOWELBIT INVISIBLE)
	(TEXT
"The business envelope has the McGinty Salvage return address,
and \"Weasel's Merchant Seaman's card - collateral for deal\" scribbled in
McGinty's hand.")
	(FDESC "An envelope with some writing on it sits on the desk.")
	(SIZE 4)
	(CAPACITY 2)
	(ACTION ENVELOPE-F)>

<ROUTINE ENVELOPE-F ("AUX" L)
	 <COND (<AND <VERB? OPEN TAKE LOOK-UNDER>
		     <==? ,HERE ,MCGINTY-HQ>
		     <IN? ,MCGINTY ,MCGINTY-HQ>
		     <NOT <IN? ,ENVELOPE ,PLAYER>>>
		<TELL
D ,MCGINTY " squeals angrily. \"Keep your hands off of my private papers!\""
CR>)
	       (<AND <VERB? TAKE>
		     <IN? ,WEASEL ,HERE>>
		<WEASEL-BEATS-YOU>)
	       (<AND <IN? ,ENVELOPE ,UNDER-BUNK>
		     <NOT <VERB? TAKE TELL ASK-ABOUT>>>
	        <TELL "It's hidden under the mattress." CR>)
	       (<AND <NOT <IN? ,ENVELOPE ,PLAYER>>
		     <FSET? <SET L <LOC ,ENVELOPE>> ,PERSON>
		     <VERB? OPEN>>
		<START-SENTENCE .L>
		<TELL " tells you to keep your hands off it." CR>)
	       (<FSET? ,ENVELOPE ,RMUNGBIT>
		<COND (<VERB? EXAMINE>
		       <TELL "It's a soggy " D ,ENVELOPE "." CR>)
		      (<VERB? READ>
		       <TELL-SOGGY>)>)>>

<ROOM VACANT-LOT
      (IN ROOMS)
      (DESC "Vacant Lot")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"You are standing on the former site of the Outfitters International warehouse,
which burned down a few months back. To the north is the Wharf Road and an
alley is to the south.")
      (GLOBAL LIGHTHOUSE)
      (NORTH TO WHARF-ROAD-3)
      (SOUTH TO BACK-ALLEY-3)
      (EAST "There's a wall in the way.")
      (WEST "There's a wall in the way.")
      (LINE 0)
      (CORRIDOR 256)
      (STATION WHARF-ROAD-3)>

<ROOM OUTFITTERS-HQ
      (IN ROOMS)
      (DESC "Outfitters Int'l")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"This is Outfitters International, a store that specializes in marine supplies.
There is a long, high counter separating the supplies and the front area. To
the north is the Wharf Road.")
      (GLOBAL TRAWLER SALVAGER FRONT-DOOR)
      (NORTH TO WHARF-ROAD-4)
      (OUT TO WHARF-ROAD-4)
      (STATION WHARF-ROAD-4)
      (LINE 1)
      (PSEUDO "MERCHA" MERCHANDISE-PSEUDO)
      (ACTION OUTFITTERS-HQ-F)>

<ROUTINE OUTFITTERS-HQ-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<MOVE ,SPEAR-CARRIER ,OUTFITTERS-HQ>
		<PUTP ,SPEAR-CARRIER ,P?SDESC "salesman">
		<PUTP ,SPEAR-CARRIER ,P?LDESC 
"A salesman stands behind the counter.">
		<PUTP ,GLOBAL-SURFACE ,P?SDESC "counter">
		<MOVE-SHARED-OBJECTS ,OUTFITTERS-HQ>
		<COND (<AND <QUEUED? I-EQUIP>
			    <NOT <IN? ,MCGINTY ,OUTFITTERS-HQ>>>
		       <SETG I-WAIT-DURATION 9>
		       <SETG I-WAIT-RTN ,I-EQUIP>)>
		<RFALSE>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<EQUAL? ,PSEUDO-OBJECT ,PRSO ,PRSI>
		       <MERCHANDISE-PSEUDO>)
		      (<PRSO? ,TRAWLER ,SALVAGER>
		       <COND (<VERB? RENT>
			      <COND (<AND ,JOHNNY-MADE-DEAL
					  <==? ,SHIP-CHOSEN ,PRSO>>
				     <TELL
"\"Johnny already took care of that.\"" CR>)
				    (T <TELL-YOU-CANT "afford that.">)>)
			     (<VERB? BUY FIND ASK-ABOUT ASK-CONTEXT-ABOUT>
			      <RFALSE>)
			     (T <GLOBAL-NOT-HERE-PRINT ,PRSO>)>)
		      (<PRSI? ,TRAWLER ,SALVAGER>
		       <COND (<VERB? ASK-ABOUT TELL>
			      <RFALSE>)
			     (T <GLOBAL-NOT-HERE-PRINT ,PRSI>)>)
		      (<AND <VERB? BUY RENT>
		       	    ,AMT-OWED>
		       <TELL
"The salesman looks sorry. \"I can't sell
you anything until you pay the $" N ,AMT-OWED " of " D ,JOHNNY "'s.\"" CR>)
		      (<AND <VERB? TAKE>
			    <==? <GETP ,PRSO ,P?NORTH> -1>
			    ,JOHNNY-MADE-DEAL
			    <NOT ,DELIVERY-MADE>
			    <NOT <IN? ,PRSO ,PLAYER>>>
		       <TELL
"The salesman says, \"Don't bother. It'll be delivered to the ship.\"" CR>)
		      (<AND <VERB? OPEN LAMP-ON>
			    <G? <GETP ,PRSO ,P?NORTH> 0>>
		       <TELL
"The salesman stops you. \"You want to play with it, you buy it.\"" CR>)>)>>

<ROUTINE MERCHANDISE-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "merchandise">)
	       (T
		<TELL-REFER-INDIVIDUAL " items">
		<RFATAL>)>>

<OBJECT PRICE-LIST
	(IN OUTFITTERS-HQ)
	(DESC "price list")
	(SYNONYM LIST LISTIN CATALO)
	(ADJECTIVE PRICE COMPLE)
	(FLAGS TAKEBIT READBIT)
	(SIZE 4)
	(TEXT "This price list is included in your Cutthroats package.")>

;"May this code rest in peace."
;<ROUTINE PRICE-LIST-F ("AUX" OBJ PRICE)
	 <COND (<VERB? EXAMINE READ>
		<TELL
"    OUTFITTERS INTERNATIONAL|
       CURRENT PRICE LIST|
|
ITEM (PRICE)" CR>
		<SET OBJ <FIRST? ,OUTFITTERS-HQ>>
		<REPEAT ()
			<COND (<NOT .OBJ>
			       <RTRUE>)
			      (<G? <SET PRICE <GETP .OBJ ,P?NORTH>> 0>
			       <TELL D .OBJ " ($" N .PRICE>
			       <COND (<FSET? .OBJ ,RENTBIT>
				      <TELL " rental">)>
			       <TELL ")" CR>)>
			<SET OBJ <NEXT? .OBJ>>>)>>

<OBJECT SPEAR-GUN
	(IN OUTFITTERS-HQ)
	(DESC "spear gun")
	(SYNONYM GUN)
	(ADJECTIVE SPEAR)
	(FLAGS NDESCBIT)
	(NORTH 1);"price - placeholder here"
	(ACTION OUT-OF-STOCK-F)>

<ROUTINE OUT-OF-STOCK-F ()
	 <COND (<VERB? BUY>
		<TELL "The salesman checks and says, ">
		<TELL-WERE-OUT>)
	       (<VERB? ASK-ABOUT>
		<COND (<==? ,HERE ,OUTFITTERS-HQ>
		       <TELL-WERE-OUT>)>)
	       (<OR <PRSO? ,SPEAR-GUN> <PRSI? ,SPEAR-GUN>>
		<GLOBAL-NOT-HERE-PRINT ,SPEAR-GUN>)
	       (<OR <PRSO? ,COMPASS> <PRSI? ,COMPASS>>
		<GLOBAL-NOT-HERE-PRINT ,COMPASS>)
	       (T <GLOBAL-NOT-HERE-PRINT ,WINCH>)>>

<ROUTINE TELL-WERE-OUT ()
	 <TELL "\"We're out of those. Try next week.\"" CR>>

<OBJECT COMPASS
	(IN OUTFITTERS-HQ)
	(DESC "compass")
	(SYNONYM COMPAS)
	(ADJECTIVE SPARE)
	(FLAGS NDESCBIT)
	(NORTH 1);"price - placeholder here"
	(ACTION OUT-OF-STOCK-F)>

<OBJECT WINCH
	(IN OUTFITTERS-HQ)
	(DESC "winch")
	(SYNONYM WINCH)
	(ADJECTIVE SPARE)
	(FLAGS NDESCBIT)
	(NORTH 1);"price - placeholder here"
	(ACTION OUT-OF-STOCK-F)>

<OBJECT DRY-CELL
	(IN OUTFITTERS-HQ)
	(DESC "dry cell")
	(SYNONYM BATTER CELL)
	(ADJECTIVE NINE VOLT DRY NINE-V AJAX POWER)
	(FLAGS NDESCBIT READBIT)
	(SIZE 3)
	(NORTH 5) ;"price"
	(TEXT "\"Ajax 9-volt dry cell.\"")
	(ACTION DRY-CELL-F)>

<ROUTINE DRY-CELL-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The ">
		<COND (<FSET? ,DRY-CELL ,RMUNGBIT>
		       <TELL "corroded ">)>
		<TELL D ,DRY-CELL " reads ">
		<RFALSE>)>>

<OBJECT NET
	(IN OUTFITTERS-HQ)
	(DESC "net")
	(SYNONYM NET)
	(FLAGS NDESCBIT)
	(NORTH 50) ;"price"
	(SIZE 10)
	(ACTION NET-F)>

<ROUTINE NET-F ()
	 <COND (<AND <VERB? PUT-ON THROW-OFF>
		     <PRSO? ,NET>>
		<MOVE ,NET ,HERE>
		<TELL "It slides off." CR>)>>

<OBJECT BATTERY
	(IN OUTFITTERS-HQ)
	(DESC "C battery")
	(SYNONYM BATTER CELL)
	(ADJECTIVE C POWER)
	(FLAGS NDESCBIT READBIT)
	(TEXT "\"Ajax C cell.\"")
	(NORTH 1) ;"price"
	(SIZE 3)
	(ACTION BATTERY-F)>

<ROUTINE BATTERY-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The ">
		<COND (<FSET? ,BATTERY ,RMUNGBIT>
		       <TELL "corroded">)
		      (T <TELL "standard">)>
		<TELL " battery reads ">
		<RFALSE>)>>

<OBJECT ANCHOR
	(IN OUTFITTERS-HQ)
	(DESC "anchor")
	(SYNONYM ANCHOR)
	(NORTH 50) ;"price"
	(FLAGS NDESCBIT VOWELBIT)
	(SIZE 80)>

<OBJECT TUBE
	(IN OUTFITTERS-HQ)
	(DESC "tube of putty")
	(SYNONYM TUBE PUTTY)
	(ADJECTIVE TUBE)
	(FLAGS NDESCBIT CONTBIT READBIT)
	(CAPACITY 4)
	(NORTH 15) ;"price"
	(TEXT
"The tube has \"Frobizz waterproof putty\" printed on the side.")
	(ACTION TUBE-F)>

<ROUTINE TUBE-F ()
	 <COND (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,TUBE>>
		<TELL "The tube refuses to accept anything." CR>)
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,GLASS-CASE>
		     <FSET? ,TUBE ,OPENBIT>
		     <IN? ,PUTTY ,TUBE>>
		<PERFORM ,V?PUT-ON ,PUTTY ,GLASS-CASE>
		<RTRUE>)
	       (<VERB? SQUEEZE>
		<COND (<AND <FSET? ,PRSO ,OPENBIT>
			    <IN? ,PUTTY ,PRSO>>
		       <MOVE ,PUTTY ,WINNER>
		       <TELL "You are now holding some putty." CR>)
		      (<FSET? ,PRSO ,OPENBIT>
		       <TELL "The tube is apparently empty." CR>)
		      (T
		       <TELL-CLOSED "tube">)>)>>

<OBJECT PUTTY
	(IN TUBE)
	(DESC "glob of putty")
	(SYNONYM PUTTY GUNK GLOB)
	(ADJECTIVE GLOB)
	(SIZE 4)
	(FLAGS TAKEBIT)
	(ACTION PUTTY-F)>

<ROUTINE PUTTY-F ()
	 <COND (<COMPILER-SUCKS-EXP>
		<COND (<IN? ,PUTTY ,GLASS-CASE>
		       <TELL-IN-CRACK>)
		      (T
		       <MOVE ,PUTTY ,GLASS-CASE>
		       <DISABLE <INT I-CASE-LEAK>>
		       <TELL "The putty seals the crack">
		       <COND (<OR <IN? ,HOLE-1 ,GLASS-CASE>
				  <IN? ,HOLE-2 ,GLASS-CASE>>
			      <TELL " and hole">)
			     (T <SETG NO-HOLE-PLUGGED T>)>
		       <TELL " in the " D ,GLASS-CASE "." CR>)>)
	       (<AND <IN? ,PUTTY ,GLASS-CASE>
		     <NOT <VERB? EXAMINE FIND>>>
		<TELL-IN-CRACK>)
	       (<OR <AND <VERB? OIL>
			 <EQUAL? ,PRSI ,PUTTY>>
		    <AND <VERB? PUT>
			 <EQUAL? ,PRSO ,PUTTY>>>
		<COND (<PRSI? ,TUBE>
		       <TELL-YOU-CANT "reverse entropy.">)
		      (T <TELL "It isn't a lubricant." CR>)>)>>

<ROUTINE COMPILER-SUCKS-EXP ()
	 <COND (<AND <VERB? PUT PUT-ON>
		     <OR <PRSI? ,GLASS-CASE>
			 <AND <PRSI? ,HOLE-1>
			      <IN? ,HOLE-1 ,GLASS-CASE>>
			 <AND <PRSI? ,HOLE-2>
			      <IN? ,HOLE-2 ,GLASS-CASE>>>>
		<RTRUE>)
	       (<AND <VERB? FILL PLUG>
		     <OR <PRSO? ,GLASS-CASE>
			 <AND <PRSO? ,HOLE-1>
			      <IN? ,HOLE-1 ,GLASS-CASE>>
			 <AND <PRSO? ,HOLE-2>
			      <IN? ,HOLE-2 ,GLASS-CASE>>>>
		<RTRUE>)
	       (T <RFALSE>)>>

<ROUTINE TELL-IN-CRACK ()
	 <TELL "The putty is already set in the crack." CR>>

<GLOBAL NO-HOLE-PLUGGED <>>

<OBJECT COMPRESSOR
	(IN OUTFITTERS-HQ)
	(DESC "small air compressor")
	(SYNONYM COMPRE)
	(ADJECTIVE AIR SMALL HEAVY SEMI-P)
	(FLAGS NDESCBIT RENTBIT)
	(TEXT
"This heavy, semi-portable air compressor can fill scuba tanks.")
	(SIZE 94)
	(STATION 75) ;"metal content"
	(NORTH 100) ;"price"
	;(ACTION COMPRESSOR-F)>

;<ROUTINE COMPRESSOR-F ()
	 <COND (<VERB? TAKE>
		<TELL "It's too heavy." CR>)>>

<OBJECT INFIDEL-BOX
	(IN OUTFITTERS-HQ)
	(DESC "location box")
	(SYNONYM BOX BUTTON)
	(ADJECTIVE BLACK LOCATI DIRECT)
	(FLAGS NDESCBIT)
	(NORTH 1000) ;"price"
	(ACTION INFIDEL-BOX-F)>

<ROUTINE INFIDEL-BOX-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This is state-of-the-art electronic equipment that automatically determines
longitude and latitude when its button is pressed." CR>)
	       (<VERB? PUSH>
		<TELL
"Nothing happens, probably because you're indoors." CR>)>>

<OBJECT DIVING-BOOK
	(IN OUTFITTERS-HQ)
	(DESC "diving book")
	(SYNONYM BOOK)
	(ADJECTIVE DIVING)
	(FLAGS NDESCBIT READBIT)
	(NORTH 20) ;"price"
	(ACTION DIVING-BOOK-F)>

<ROUTINE DIVING-BOOK-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<FSET? ,DIVING-BOOK ,RMUNGBIT>
		       <TELL-SOGGY>)
		      (T <TELL
"This book is \"Everything About Diving\" by Fritz Zamboni." CR>)>)
	       (<VERB? READ OPEN>
		<COND (<FSET? ,DIVING-BOOK ,RMUNGBIT>
		       <TELL-SOGGY>)
		      (T <TELL
"It says nothing you don't already know." CR>)>)>>

<ROUTINE TELL-SOGGY ()
	 <TELL "It's too soggy." CR>>

<OBJECT MAGNET
	(IN OUTFITTERS-HQ)
	(DESC "portable electromagnet")
	(SYNONYM ELECTR MAGNET)
	(ADJECTIVE PORTAB ELECTR)
	(FLAGS NDESCBIT TRANSBIT)
	(CONTFCN MAGNET-F)
	(DESCFCN MAGNET-F)
	(NORTH 250) ;"price"
	(STATION 20) ;"metal content"
	(ACTION MAGNET-F)>

<ROUTINE MAGNET-F ("OPTIONAL" (RARG <>) "AUX" F N OBJ)
	 <COND (<EQUAL? .RARG ,M-CONT>
		<COND (<AND <VERB? TAKE WEAR>
			    <NOT <PRSO? ,MINE>>
			    ,MAGNET-ON>
		       <TELL "The magnet's stronger than you are." CR>)
		      (<VERB? DROP THROW>
		       <TELL "It's stuck to the magnet." CR>)>)
	       (<==? .RARG ,M-OBJDESC>
		<TELL "There is a " D ,MAGNET " here." CR>
		<COND (<SET F <FIRST? ,MAGNET>>
		       <COND (<==? .F ,MINE> T)
			     (,MAGNET-ON
			      <TELL "Attached to the magnet ">
			      <COND (<NEXT? .F>
				     <TELL "are">)
				    (T <TELL "is">)>
			      <TELL " ">
			      <PRINT-CONTENTS ,MAGNET>
			      <TELL "." CR>)
			     (T
			      <DESCRIBE-OBJECT .F T 0>)>)>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<COND (<AND ,MAGNET-ON
			    <FIRST? ,MAGNET>>
		       <TELL "The " D ,MAGNET " is on and has ">
		       <PRINT-CONTENTS ,MAGNET>
		       <TELL " attached to it." CR>
		       <SETG P-IT-OBJECT ,MAGNET>)
		      (T <TELL
"The " D ,MAGNET " has a switch which is currently ">
		       <COND (,MAGNET-ON <TELL "on">)
			     (T <TELL "off">)>
		       <TELL "." CR>)>)
	       (<VERB? LAMP-ON>
		<COND (,MAGNET-ON
		       <TELL-ALREADY "on">)
		      (T
		       <SETG MAGNET-ON T>
		       <TELL-NOW ,MAGNET "on">
		       <ATTRACTION>)>)
	       (<VERB? LAMP-OFF>
		<COND (,MAGNET-ON
		       <SETG MAGNET-ON <>>
		       <TELL-NOW ,MAGNET "off." <>>
		       <COND (<SET F <FIRST? ,MAGNET>>
			      <TELL-ALL-FALL>
			      <REPEAT ()
			       <COND (<NOT .F> <RETURN>)>
			       <SET N <NEXT? .F>>
			       <MOVE .F ,HERE>
			       <COND (<EQUAL? .F ,MINE>
				      <FSET ,MINE ,RMUNGBIT>
				      <TELL CR
"The mine drifts harmlessly into a corner.">)>
			       <SET F .N>>)>
		       <CRLF>)
		      (T <TELL-ALREADY "off">)>)
	       (<VERB? DROP THROW>
		<COND (<IN? ,MINE ,MAGNET>
		       <COND (,MAGNET-ON
			      <FSET ,MINE ,RMUNGBIT>)
			     (T <MOVE ,MINE ,HERE>)>
		       <RFALSE>)
		      (<NOT ,MAGNET-ON>
		       <CLEAR-MAGNET>
		       <RFALSE>)>)
	       (<AND <VERB? TAKE>
		     <PRSO? ,MAGNET>>
		<COND (<IN? ,MINE ,MAGNET>
		       <BOOM>)>)
	       (<OR <AND <VERB? PUT-ON PUT-AGAINST>
		     	 <PRSO? ,MAGNET>
			 <SET OBJ ,PRSI>>
		    <AND <VERB? RUB>
			 <PRSI? ,MAGNET>
			 <SET OBJ ,PRSO>>>
		<COND (<FSET? .OBJ ,SURFACEBIT>
		       <CLEAR-MAGNET>
		       <RFALSE>)
		      (<OR ,MAGNET-ON
			   <==? .OBJ ,ME>
			   <GETP .OBJ ,P?CHARACTER>>
		       <TELL-WHY-BOTHER>)
		      (<IN? .OBJ ,PLAYER>
		       <TELL "The magnet is touching ">
		       <THE? ,PRSI>
		       <TELL D ,PRSI "." CR>)
		      (T
		       <COND (<SET F <FIRST? ,MAGNET>>
		       	      <MOVE .F ,HERE>)>
		       <COND(<AND <SET N <LOC .OBJ>>
			      <NOT <EQUAL? .N ,GLOBAL-OBJECTS ,LOCAL-GLOBALS>>>
			     <MOVE .OBJ ,MAGNET>)>
		       <TELL-NOW ,MAGNET "touching " <>>
		       <THE? .OBJ>
		       <TELL D .OBJ "." CR>)>)>>

<ROUTINE TELL-NOW (OBJ STR "OPTIONAL" (FINISH? T))
	 <TELL "The " D .OBJ " is now " .STR>
	 <COND (.FINISH? <TELL "." CR>)>>

<GLOBAL MAGNET-ON <>>

<ROUTINE ATTRACTION ("AUX" F N)
	 <SET F <FIRST? ,HERE>>
	 <COND (<AND <SET N <FIRST? ,MAGNET>>
		     <OR <NOT <GETP .N ,P?STATION>>
			 <NOT <FSET? .N ,TAKEBIT>>>>
		<MOVE .N ,HERE>)>
	 <REPEAT ()
	  <COND (<NOT .F> <RETURN>)>
	  <SET N <NEXT? .F>>
	  <COND (<AND <NOT <FSET? .F ,INVISIBLE>>
		      <GETP .F ,P?STATION>
		      <FSET? .F ,TAKEBIT>
		      <NOT <==? .F ,MAGNET>>>
		 <MOVE .F ,MAGNET>
		 <COND (<AND <==? .F ,IRON-BAR>
			     <==? ,HERE ,WRECK-5>>
			<JIGS-UP
"As the spikes jump toward the magnet, one of them pierces your chest!">)>
		 <TELL "The " D .F " jumps to the magnet.">
		 <COND (<EQUAL? .F ,MINE>
			<TELL
" Unfortunately, even though the spikes are spaced widely apart, one gets
pushed..." CR CR>
			<BOOM>)>
		 <CRLF>)>
	  <SET F .N>>>

<ROUTINE CLEAR-MAGNET ("AUX" F N)
	 <SET F <FIRST? ,MAGNET>>
	 <REPEAT ()
	  <COND (<NOT .F> <RETURN>)>
	  <SET N <NEXT? .F>>
	  <MOVE .F ,HERE>
	  <SET F .N>>>

<OBJECT FLASHLIGHT
	(IN OUTFITTERS-HQ)
	(DESC "flashlight")
	(SYNONYM FLASHL LIGHT LAMP LANTER)
	(ADJECTIVE SEALED WATERP PORTAB ONE-PI)
	(FLAGS NDESCBIT)
	(NORTH 24) ;"price"
	(ACTION FLASHLIGHT-F)>

<ROUTINE FLASHLIGHT-F ()
	 <COND (<VERB? LAMP-ON>
		<COND (<FSET? ,FLASHLIGHT ,ONBIT>
		       <TELL-ALREADY "on">)
		      (T
		       <FSET ,FLASHLIGHT ,ONBIT>
		       <TELL-NOW ,FLASHLIGHT "on">
		       <COND (<NOT ,LIT>
			      <SETG LIT <LIT? ,HERE>>
			      <CRLF>
			      <V-LOOK>)>
		       <RTRUE>)>)
	       (<VERB? LAMP-OFF>
		<COND (<FSET? ,FLASHLIGHT ,ONBIT>
		       <FCLEAR ,FLASHLIGHT ,ONBIT>
		       <SETG LIT <LIT? ,HERE>>
		       <TELL-NOW ,FLASHLIGHT "off">)
		      (T <TELL-ALREADY "off">)>)
	       (<VERB? EXAMINE>
		<TELL
"The sealed, waterproof " D ,FLASHLIGHT " is ">
		<COND (<FSET? ,FLASHLIGHT ,ONBIT>
		       <TELL "on">)
		      (T <TELL "off">)>
		<TELL "." CR>)
	       (<AND <VERB? AIM>
		     <PRSO? ,FLASHLIGHT>
		     <FSET? ,FLASHLIGHT ,ONBIT>>
		<TELL "The " D ,FLASHLIGHT " is shining on ">
		<THE? ,PRSI>
		<TELL D ,PRSI "." CR>)>>

<OBJECT SHARK-REPELLENT
	(IN OUTFITTERS-HQ)
	(DESC "shark repellent canister")
	(SYNONYM REPELL CAN CANIST LABEL ;LID)
	(ADJECTIVE SHARK REPELL CANIST)
	(FLAGS NDESCBIT)
	(NORTH 20) ;"price"
	(ACTION SHARK-REPELLENT-F)>

<ROUTINE SHARK-REPELLENT-F ()
	 <COND (<VERB? OPEN>
		<COND (<FSET? ,SHARK-REPELLENT ,OPENBIT>
		       <TELL-ALREADY "open">)
		      (T
		       <FSET ,SHARK-REPELLENT ,OPENBIT>
		       <TELL "Opened.">
		       <COND (<OR <L? <GETP ,HERE ,P?LINE>
				      ,UNDERWATER-LINE-C>
				  <AIRTIGHT-ROOM?>>
			      <JIGS-UP
" The canister begins to emit noxious fumes. Before you can do anything
about it, you lose consciousness.">)>
		       <CRLF>)>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,SHARK-REPELLENT ,OPENBIT>
		       <TELL "It can't be closed." CR>)
		      (T
		       <TELL-ALREADY "closed">)>)
	       (<VERB? EXAMINE>
		<TELL "The canister, which is ">
		<COND (<FSET? ,SHARK-REPELLENT ,OPENBIT>
		       <TELL "open">)
		      (T <TELL "closed">)>
		<TELL
", has a label which says, \"IMPORTANT: read this label!\"" CR>)
	       (<VERB? READ>
		<TELL
"The label says:
\"IMPORTANT: read this label!|
|
SWANZO BRAND SHARK REPELLENT|
|
This product will repel sharks, or your money back! Simply
open the canister UNDERWATER. Works for 5 hours. WARNING: Fumes
released in air may be hazardous to humans.\"" CR>)>>

;<OBJECT NEW-KNIFE
	(IN OUTFITTERS-HQ)
	(DESC "steel knife")
	(SYNONYM KNIFE)
	(ADJECTIVE NEW STEEL)
	(FLAGS NDESCBIT)
	(STATION 15) ;"metal content"
	(NORTH 45) ;"price">

<OBJECT CHARTS
	(IN OUTFITTERS-HQ)
	(DESC "set of nautical charts")
	(SYNONYM CHARTS MAPS CHART SET)
	(ADJECTIVE NAUTIC OCEAN SEA)
	(FLAGS NDESCBIT READBIT)
	(TEXT "These are charts for the Hardscrabble Island area.")
	(NORTH 150) ;"price">

<OBJECT CAGE
	(IN OUTFITTERS-HQ)
	(DESC "diving cage")
	(SYNONYM CAGE)
	(ADJECTIVE DIVING)
	(FLAGS NDESCBIT RENTBIT)
	(STATION 90) ;"metal content"
	(NORTH 650) ;"price">

<ROOM SHANTY
      (IN ROOMS)
      (DESC "The Shanty")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"This is The Shanty, a tavern which serves the locals. A wooden bar
travels the length of the place, and behind it is a mirror so dirty,
it offers no reflection. Round tables occupy the floor. The smell of
cooking food permeates the place.")
      (GLOBAL FRONT-DOOR)
      (NORTH TO WHARF-ROAD-5)
      (OUT TO WHARF-ROAD-5)
      (STATION WHARF-ROAD-5)
      (LINE 1)
      (PSEUDO "TABLES" FURNITURE-PSEUDO "CHAIRS" FURNITURE-PSEUDO)
      (ACTION SHANTY-F)>

<GLOBAL WARNING-STR
"Johnny looks around and says, \"This is no place to continue. If McGinty
finds out about this, we're sunk. We better meet at the lighthouse at 9:30.
Glad you're aboard.\"">

<ROUTINE SHANTY-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<MOVE ,FOOD ,SHANTY>
		<FSET ,FOOD ,NDESCBIT>
		<SETG SOUPS-ON <>>
		<MOVE ,DRINKING-WATER ,SHANTY>
		<FSET ,DRINKING-WATER ,NDESCBIT>
		<MOVE ,DRINK-OBJECT ,SHANTY>
		<FSET ,DRINK-OBJECT ,NDESCBIT>
		<PUTP ,DRINKING-WATER ,P?SDESC "water">
		<MOVE ,SPEAR-CARRIER ,SHANTY>
		<PUTP ,SPEAR-CARRIER ,P?SDESC "bartender">
		<PUTP ,SPEAR-CARRIER ,P?LDESC 
"A bartender behind the bar polishes glasses with a worn towel.">
		<COND (<L? ,PRESENT-TIME 541>
		       <ENABLE <QUEUE I-FIRST-MEETING -1>>)
		      (T <SETG FM-CTR 5>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? YES>
			    <==? ,FM-CTR 4>>
		       <TELL ,WARNING-STR CR>
		       <SETG FM-CTR 5>
		       <RATING-UPD 20>
		       <DISABLE <INT I-FIRST-MEETING>>
		       <SETG MEETINGS-COMPLETED 1>)
		      (<AND <VERB? NO>
			    <==? ,FM-CTR 4>>
		       <TELL-NO-CONTINUE>
		       <I-PLOT-NEVER-STARTS>
		       <SETG JOHNNY-SILENT T>
		       <DISABLE <INT I-FIRST-MEETING>>)>)>>

<GLOBAL JOHNNY-SILENT <>>

<ROUTINE TELL-NO-CONTINUE ()
	 <TELL
"The three men look at each other in disbelief. \"If you wanna ignore
the chance of a lifetime, you're nuts,\" " D ,WEASEL " states. Johnny says,
\"We'll find someone else.\" They then ignore you." CR>>

<OBJECT PARROT
	(IN SHANTY)
	(SYNONYM PARROT BIRD LEG)
	(ADJECTIVE POLLY WOODEN)
	(DESC "parrot")
	(LDESC
"A parrot with an eyepatch hobbles up and down the bar.")
	(TEXT 
"It sports an eyepatch and wooden leg and has been here since the
bartender bought it from a sailor. It's considered insane by the
local patrons.")
	(FLAGS VICBIT TRANSBIT)
	(ACTION PARROT-F)>

<ROUTINE PARROT-F ()
	 <COND (<EQUAL? ,WINNER ,PARROT>
		<SETG P-CONT <>>
		<SETG QUOTE-FLAG <>>
		<COND (<VERB? HELLO>
		       <TELL <PICK-ONE ,PARROTISMS> CR>)
		      (<AND <VERB? FIND> <PRSO? ,ME>>
		       <TELL "\"You're right here.\"" CR>)
		      (T
		       <TELL
"\"An interesting concept, but I am incapable.\"" CR>)>
		<RTRUE>)
	       (<AND <VERB? TELL>
		     ,P-CONT>
		<RFALSE>)
	       (<VERB? EXAMINE FIND>
		<RFALSE>)
	       (<NOT <==? ,HERE ,SHANTY>>
		<RFALSE>)
	       (<VERB? LOOK-UNDER>
		<TELL-NOTHING "but claw prints there" T>)
	       (<AND <VERB? ASK-ABOUT>
		     <PRSI? ,PARROT>>
		<RFALSE>)
	       (T
		<TELL <PICK-ONE ,PARROTISMS> CR>)>>

<GLOBAL PARROTISMS
	<LTABLE
"\"As my Pappy said, 'When you travel the highways of life, you do not
always get to stop and look at a roadmap.'\""
"\"I must admit that in my wide travels across this ball of wax, I have
seen many human specimens, though none quite like you.\""
"\"After due consideration, I find myself in an embarrassing position. I would
gladly accept a hard biscuit today, if you would accept payment Tuesday.\""
"\"Read any good books lately? I found 'Tropical Birds and their Native
Habitats' quite engrossing.\""
"\"Compared to salted biscuits, I like myself best.\""
"\"Hello Sailor.\"">>

<OBJECT PARROTS-PATCH
	(IN PARROT)
	(DESC "small eyepatch")
	(SYNONYM PATCH EYEPAT)
	(ADJECTIVE PARROT BLACK SMALL)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION PARROTS-PATCH-F)>

<ROUTINE PARROTS-PATCH-F ()
	 <COND (<OR <VERB? LOOK-UNDER ASK-FOR DISEMBARK>
		    <VERB? MOVE>
		    <AND <VERB? TAKE>
			 <OR <NOT ,PRSI>
			     <PRSI? ,PARROT>>>>
		<TELL "Mind your manners." CR>)
	       (<VERB? EXAMINE>
		<TELL "It's a small black eyepatch." CR>)>>

<OBJECT TABLE-OBJECT
	(IN SHANTY)
	(DESC "table")
	(SYNONYM TABLE)
	(FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT TRANSBIT)
	(CAPACITY 15)>

<OBJECT CHAIR
	(IN SHANTY)
	(DESC "chair")
	(SYNONYM CHAIR SEAT)
	(FLAGS NDESCBIT VEHBIT SURFACEBIT TRANSBIT OPENBIT)
	(CAPACITY 10)
	(ACTION CHAIR-F)>

<ROUTINE CHAIR-F ("OPTIONAL" (RARG <>) "AUX" F)
	 <COND (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? DISEMBARK>
			    <PRSO? ,CHAIR>
			    <L? ,FM-CTR 5>>
		       <TELL 
"Johnny pushes you back. \"Can't you wait a few minutes?\"" CR>
		       <RTRUE>)
		      (<AND <VERB? YES>
			    <==? ,FM-CTR 4>>
		       <TELL ,WARNING-STR CR>
		       <SETG FM-CTR 5>
		       <RATING-UPD 20>
		       <DISABLE <INT I-FIRST-MEETING>>
		       <SETG MEETINGS-COMPLETED 1>)
		      (<AND <VERB? NO>
			    <==? ,FM-CTR 4>>
		       <TELL-NO-CONTINUE>
		       <I-PLOT-NEVER-STARTS>
		       <DISABLE <INT I-FIRST-MEETING>>)>)
	       (<PRSO? ,CHAIR>
		<COND (<VERB? BOARD>
		       <COND (<SET F <FIRST? ,CHAIR>>
			      <TELL-NOT-COMFORTABLE>
			      ;<TELL "Sitting on ">
			      ;<THE? .F>
			      ;<TELL D .F " would be uncomfortable." CR>)
		             (<==? ,FM-CTR 0>
		       	      <SETG FM-CTR 1>
		       	      <DISABLE <INT I-PLOT-NEVER-STARTS>>
		       	      <RFALSE>)>)>)>>

<ROUTINE FURNITURE-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "furniture">)
	       (<VERB? EXAMINE>
		<TELL "There are a number of tables and chairs here." CR>)>>

<OBJECT BAR
	(IN SHANTY)
	(DESC "bar")
	(SYNONYM BAR SURFAC)
	(ADJECTIVE AGED WOODEN OLD HUGE WORN)
	(FLAGS SURFACEBIT CONTBIT NDESCBIT OPENBIT)
	(CAPACITY 20)
	(ACTION BAR-F)>

<ROUTINE BAR-F ("AUX" F)
	 <COND (<VERB? OPEN CLOSE>
		<TELL "Leave that to the management." CR>)
	       (<VERB? EXAMINE>
		<TELL
"It is a worn wooden bar that has had more than its share of drinks on it.
The parrot doesn't do it much good, either">
		<COND (<SET F <FIRST? ,BAR>>
		       <TELL ". Sitting on the bar ">
		       <COND (<NEXT? .F>
			      <TELL "are ">)
			     (T <TELL "is ">)>
		       <PRINT-CONTENTS ,BAR>)>
		<TELL "." CR>
		<RTRUE>)
	       (<VERB? LOOK-BEHIND>
		<TELL "The bartender is there." CR>)>>

<OBJECT MIRROR
	(IN SHANTY)
	(DESC "mirror")
	(SYNONYM MIRROR)
	(ADJECTIVE DUSTY DIRTY AGED GRIMY)
	(FLAGS NDESCBIT)
	(ACTION MIRROR-F)>

<ROUTINE MIRROR-F ()
	 <COND (<VERB? LOOK-INSIDE EXAMINE>
		<TELL "You see grime rather than a reflection." CR>)
	       (<VERB? CLEAN>
		<TELL-CANT-REACH "it to clean it">)
	       (<VERB? MUNG>
		<TELL "That would be unlucky." CR>)>>

<OBJECT FOOD
	(IN SHANTY)
	(DESC "meal")
	(SYNONYM FOOD MEAL STEW)
	(ADJECTIVE BREAKF LUNCH DINNER BEEF)
	(NORTH 5) ;"price"
	(FLAGS NDESCBIT FOODBIT)
	(ACTION FOOD-F)>

<ROUTINE FOOD-F ()
	 <COND (<AND <VERB? FIND>
		     ,P-NONOUN
		     <==? ,P-XADJN ,W?BEEF>>
		<TELL "Gimme a break!" CR>)
	       (<VERB? BUY>
		<COND (<G? <GETP ,HERE ,P?LINE> ,BACK-ALLEY-LINE-C>
		       <TELL "Free food is a benefit of this job." CR>)
		      (<==? ,HOW-HUNGRY 0>
		       <TELL-WAIT-HUNGRY>)
		      (,SOUPS-ON
		       <TELL "You only need one meal at a time." CR>)
		      (<L? ,POCKET-CHANGE 5>
		       <TELL-NO-AFFORD>)
		      (T
		       <SETG POCKET-CHANGE <- ,POCKET-CHANGE 5>>
		       <SETG SOUPS-ON T>
		       <MOVE ,FOOD ,TABLE-OBJECT>
		       <FCLEAR ,FOOD ,NDESCBIT>
		       <TELL "You have bought a meal for $5." CR>)>)
	       (<VERB? EAT>
		<COND (,SOUPS-ON
		       <COND (<0? ,HOW-HUNGRY>
			      <TELL-WAIT-HUNGRY>
			      <RTRUE>)>
		       <ENABLE <QUEUE I-HUNGER 150>>
		       <SETG HOW-HUNGRY 0>
		       <COND (<==? ,HERE ,SHANTY>
			      <SETG SOUPS-ON <>>
			      <FSET ,FOOD ,NDESCBIT>
			      <MOVE ,FOOD ,SHANTY>)>
		       <TELL "Not bad! It really hit the spot." CR>)
		      (<==? ,HERE ,SHANTY>
		       <TELL "You'll have to buy it before you can eat it." CR>)
		      (T <TELL
"You'll have to wait for Pete to finish fixing it." CR>)>)
	       (<VERB? SMELL>
		<TELL "It smells fairly tasty." CR>)
	       (<VERB? EXAMINE>
		<COND (<G? <GETP ,HERE ,P?LINE> ,BACK-ALLEY-LINE-C>
		       <TELL "It looks like a pretty standard stew." CR>)
		      (,SOUPS-ON
		       <TELL 
"This stew is a staple of " D ,SHANTY " and is edible." CR>)
		      (T <GLOBAL-NOT-HERE-PRINT ,PRSO>)>)
	       (<VERB? FIND>
		<COND (<IN? ,FOOD ,TABLE-OBJECT>
		       <TELL "It's on the table." CR>)
		      (<EQUAL? <META-LOC ,PLAYER> ,SHANTY>
		       <TELL "You can order food here." CR>)>)>>

<ROUTINE TELL-WAIT-HUNGRY ()
	 <TELL "Wait until you're a little hungrier." CR>>

<OBJECT DRINKING-WATER
	(IN SHANTY)
	;(DESC "water")
	(SDESC "water")
	(SYNONYM WATER GLASS)
	(ADJECTIVE DRINKI)
	(FLAGS NDESCBIT DRINKBIT TRYTAKEBIT)
	(ACTION DRINKING-WATER-F)>

<ROUTINE DRINKING-WATER-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<IN? ,DRINKING-WATER ,TABLE-OBJECT>
		       <TELL "It's a glass of water, what else?" CR>)
		      (<EQUAL? ,HERE ,MM-GALLEY ,NW-GALLEY>
		       <TELL
"There's a tap in the sink which dispenses bottled water." CR>)
		      (T <TELL
"You can ask the bartender for a glass." CR>)>)
	       (<VERB? DRINK>
		<COND (<OR <IN? ,DRINKING-WATER ,TABLE-OBJECT>
			   <EQUAL? ,HERE ,MM-GALLEY ,NW-GALLEY>>
		       <COND (<G? ,SLOSH-CTR 4>
			      <TELL "Are you trying to do an ocean imitation?" CR>)
			     (T
			      <SETG HOW-THIRSTY 0>
		       	      <SETG SLOSH-CTR <+ ,SLOSH-CTR 1>>
			      <ENABLE <QUEUE I-THIRST 180>>
		       	      <MOVE ,DRINKING-WATER ,HERE>
		       	      <FSET ,DRINKING-WATER ,NDESCBIT>
		       	      <PUTP ,DRINKING-WATER ,P?SDESC "water">
		       	      <TELL "You feel much refreshed." CR>)>)
		      (<EQUAL? <META-LOC ,PLAYER> ,SHANTY>
		       <TELL-ASK-FIRST>)>)
	       (<AND <VERB? BUY>
		     <EQUAL? ,HERE ,MM-GALLEY ,NW-GALLEY>>
		<TELL-JUST>)
	       (<VERB? TAKE>
		<COND (<IN? ,DRINKING-WATER ,SHANTY>
		       <TELL-ASK-FIRST>)
		      (T <TELL-JUST>)>)
	       (<VERB? FIND>
		<COND (<IN? ,DRINKING-WATER ,TABLE-OBJECT>
		       <TELL "It's on the table." CR>)
		      (<EQUAL? <META-LOC ,PLAYER> ,SHANTY>
		       <TELL "You can order water here." CR>)>)>>

<GLOBAL SLOSH-CTR 0>

<ROUTINE TELL-ASK-FIRST ()
	 <TELL "Ask the bartender for some water first." CR>>

<ROUTINE TELL-JUST ()
	 <TELL "Just drink it." CR>>

<OBJECT DRINK-OBJECT
	(IN SHANTY)
	(DESC "drink")
	(SYNONYM DRINK GROG LIQUOR BOOZE)
	(ADJECTIVE ALCOHO)
	(NORTH 2) ;"price"
	(FLAGS NDESCBIT DRINKBIT)
	(ACTION DRINK-OBJECT-F)>

<ROUTINE DRINK-OBJECT-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<IN? ,DRINK-OBJECT ,TABLE-OBJECT>
		       <TELL
"It's grog which has left many staggering." CR>)
		      (T <TELL-BUY-FIRST>)>)
	       (<VERB? BUY>
		<COND (<IN? ,DRINK-OBJECT ,TABLE-OBJECT>
		       <TELL-YOU-ALREADY "have a drink.">)
		      (<L? ,POCKET-CHANGE 2>
		       <TELL-NO-AFFORD>)
		      (T
		       <MOVE ,DRINK-OBJECT ,TABLE-OBJECT>
		       <FCLEAR ,DRINK-OBJECT ,NDESCBIT>
		       <SETG POCKET-CHANGE <- ,POCKET-CHANGE 2>>
		       <TELL "You have bought a drink for $2." CR>)>)
	       (<VERB? DRINK>
		<COND (<IN? ,DRINK-OBJECT ,TABLE-OBJECT>
		       <MOVE ,DRINK-OBJECT ,SHANTY>
		       <ENABLE <QUEUE I-THIRST 90>>
		       <SETG HOW-THIRSTY 0>
		       <FSET ,DRINK-OBJECT ,NDESCBIT>
		       <SETG BLOOD-ALCOHOL <+ ,BLOOD-ALCOHOL 6>>
		       <TELL "It burns your throat on the way down." CR>)
		      (T <TELL-BUY-FIRST>)>)
	       (<VERB? TASTE>
		<COND (<NOT <IN? ,DRINK-OBJECT ,TABLE-OBJECT>>
		       <TELL-BUY-FIRST>)>)
	       (<VERB? FIND>
		<COND (<IN? ,DRINK-OBJECT ,TABLE-OBJECT>
		       <TELL "It's on the table." CR>)
		      (<EQUAL? <META-LOC ,PLAYER> ,SHANTY>
		       <TELL "You can order grog here." CR>)>)>>

<ROUTINE TELL-BUY-FIRST ()
	 <TELL "You'll have to order one first." CR>>

<GLOBAL BLOOD-ALCOHOL 0>

<OBJECT NON-DRINK
	(IN SHANTY)
	(DESC "liquor")
	(SYNONYM WHISKY WHISKE BEER WINE)
	(ADJECTIVE SCOTCH BOURBO DRAFT RUM COFFEE)
	(FLAGS DRINKBIT NDESCBIT)
	(ACTION NON-DRINK-F)>

<ROUTINE NON-DRINK-F ()
	 <TELL-YOUD-BETTER "stick with grog.">>

<ROOM BANK
      (IN ROOMS)
      (DESC "Mariners' Trust")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"You are in Mariners' Trust, the Island's bank.
In it are a table and a teller's window.
You can see the safe beyond, and it looks pretty empty.")
      (GLOBAL WINDOW FRONT-DOOR)
      (SOUTH TO SHORE-ROAD-2)
      (OUT TO SHORE-ROAD-2)
      (PSEUDO "TABLE" TABLE-PSEUDO)
      (LINE 1)
      (STATION SHORE-ROAD-2)
      (ACTION BANK-F)>

<ROUTINE BANK-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<MOVE ,SPEAR-CARRIER ,BANK>
		<PUTP ,SPEAR-CARRIER ,P?SDESC "teller">
		<PUTP ,SPEAR-CARRIER ,P?LDESC
"A teller sits behind the window.">)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? WITHDRAW>
		       <COND ;(<PRSO? ,RIDICULOUS-MONEY-KLUDGE>
			      <TELL "You should specify an amount." CR>)
			     (<NOT <PRSO? ,INTNUM>>
			      <RFALSE>)
			     (<NOT ,P-DOLLAR-FLAG>
			      <TELL-YOU-CANT "withdraw that!">)
			     (<L? ,P-AMOUNT 1>
			      <TELL-SERIOUS>)
			     (<NOT <IN? ,PASSBOOK ,PLAYER>>
			      <TELL 
"The teller points out that you don't have your passbook." CR>)
			     (<G? ,P-AMOUNT ,PASSBOOK-BALANCE>
			      <TELL 
"The teller takes your passbook, checks the balance, tells you that there's not
enough to cover your planned withdrawal, and returns it." CR>)
			     (T
			      <SETG PASSBOOK-BALANCE <- ,PASSBOOK-BALANCE
							,P-AMOUNT>>
			      <SETG POCKET-CHANGE <+ ,POCKET-CHANGE ,P-AMOUNT>>
			      <SETG STUPID-PROBLEM-STRING "September 19">
			      <TELL 
"The teller takes your passbook, enters the withdrawal, hands you the
money and your passbook, and says \"Have a good day.\"" CR>)>)
		      (<VERB? DEPOSIT>
		       <COND (<AND ,PRSI <NOT <PRSI? ,GLOBAL-BANK>>>
			      <PERFORM ,V?PUT ,PRSO ,PRSI>
			      <RTRUE>)
			     (<OR <NOT ,P-DOLLAR-FLAG>
				  <NOT <PRSO? ,INTNUM>>>
			      <COND (<NOT <HELD? ,PRSO>>
				     <TELL-DONT-HAVE <>>
				     <THE? ,PRSO>
				     <TELL D ,PRSO "." CR>)
				    (T <TELL
"The teller looks at the " D ,PRSO " and returns it, pointing out
that you don't have a safe deposit box." CR>)>)
			     (<G? ,P-AMOUNT ,POCKET-CHANGE>
			      <TELL-YOU-CANT "deposit more than you have.">)
			     (<L? ,P-AMOUNT 1>
			      <TELL-SERIOUS>)
			     (<NOT <IN? ,PASSBOOK ,PLAYER>>
			      <TELL
"The teller points out that you need to have your passbook." CR>)
			     (T
			      <SETG PASSBOOK-BALANCE
				    <+ ,PASSBOOK-BALANCE ,P-AMOUNT>>
			      <SETG POCKET-CHANGE <- ,POCKET-CHANGE ,P-AMOUNT>>
			      <SETG STUPID-PROBLEM-STRING "September 19">
			      <TELL
"The teller takes your money and passbook, records the deposit, returns
the passbook, and says \"Thank you for banking at " D ,BANK ".\"" CR>)>)>)>>

;<ROUTINE TELL-SERIOUS ()
	 <TELL "The teller fails to smile." CR>>

<OBJECT RIDICULOUS-MONEY-KLUDGE
	(IN BANK)
	(SYNONYM MONEY CASH BILLS \$)
	(DESC "money")
	(FLAGS NDESCBIT)
	(ACTION RIDICULOUS-MONEY-KLUDGE-F)>

<ROUTINE RIDICULOUS-MONEY-KLUDGE-F ()
	 <COND (<VERB? ASK-ABOUT>
		<RFALSE>)
	       (<VERB? FIND COUNT>
		<PERFORM ,PRSA ,GLOBAL-MONEY>
		<RTRUE>)
	       (T <TELL "You should specify an amount." CR>)>>

<ROUTINE VAULT-F ();"SAFE object defined in WRECKS"
	 <COND (<AND <VERB? THROUGH>
		     <NOT <==? ,HERE ,BANK>>>
		<GLOBAL-NOT-HERE-PRINT ,SAFE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"The safe is behind the teller's window and is mostly empty." CR>)
	       (<VERB? ASK-ABOUT FIND>
		<RFALSE>)
	       (T <TELL "There's no way you can get at the safe." CR>)>>

<ROOM POINT-LOOKOUT
      (IN ROOMS)
      (DESC "Point Lookout")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"You are at Point Lookout, a small, high cliff that affords a spectacular
view of the sea. The cliff bottom is dangerous, so the only safe path is
the northwest footpath back to the Ocean Road.")
      (GLOBAL LIGHTHOUSE OCEAN ROCKS)
      (NW TO OCEAN-ROAD-3)
      (DOWN 
"If you really want to jump, say so, but do so at your own risk.")
      (CORRIDOR 32)
      (LINE 1)
      (STATION OCEAN-ROAD-3)
      (PSEUDO "CLIFF" CLIFF-PSEUDO)
      (ACTION POINT-LOOKOUT-F)>

<ROUTINE POINT-LOOKOUT-F (RARG)
	 <COND (<==? .RARG ,M-ENTER>
		<COND (<AND <==? ,MEETINGS-COMPLETED 2>
			    <L? ,PRESENT-TIME 660>>
		       <ENABLE <QUEUE I-THIRD-MEETING -1>>)>)
	       (<==? .RARG ,M-BEG>
		<COND (<VERB? LEAP>
		       <JIGS-UP 
"Your pleasant leap is interrupted as you find yourself impaled on the
jagged rocks.">)
		      (<AND <G? ,TM-CTR 0>
			    <L? ,TM-CTR 6>>
		       <COND (<VERB? YES>
			      <TELL "\"That's nice, but I'd like to see it.\"" CR>)
			     (<VERB? NO>
			      <SETG TM-CTR 4>
			      <I-THIRD-MEETING>);"kills player"
			     (<VERB? WALK>
			      <TELL 
"Johnny puts a hand on your shoulder. \"Not so fast, matey.\"" CR>)
			     (<AND <VERB? SHOW>
				   <PRSI? ,JOHNNY>>
			      <COND (<AND <OR <PRSO? ,GLOBAL-MONEY>
					      <AND <PRSO? ,INTNUM>
						   ,P-DOLLAR-FLAG>>
					  <OR <FSET? ,WET-SUIT ,WORNBIT>
					      <FSET? ,DEEP-SUIT ,WORNBIT>>>
				     <TELL-CANT-REACH "your money">
				     <RTRUE>)>
			      <COND (<PRSO? ,GLOBAL-MONEY>
				     <SETG P-AMOUNT 0>)>
			      <COND (<OR <AND <PRSO? ,GLOBAL-MONEY>
					      <G? ,POCKET-CHANGE 499>>
					 <AND <PRSO? ,INTNUM>
					      ,P-DOLLAR-FLAG
					      <G? ,P-AMOUNT 499>
					      <NOT <G? ,P-AMOUNT ,POCKET-CHANGE>>>>
				     <SETG TM-CTR 5>
				     <TELL
"He smiles and flashes a wad that represents the contributions of your
three partners." CR>)
				    (<OR <PRSO? ,GLOBAL-MONEY>
					 <AND <PRSO? ,INTNUM>
					      ,P-DOLLAR-FLAG>>
				     <COND (<G? ,P-AMOUNT ,POCKET-CHANGE>
					    <TELL 
"You haven't got that much to show him." CR>)
					   (T <JIGS-UP  
"Johnny looks disappointed. \"We need at least $500
from you. I hate to do this, but you might tell McGinty...\" Suddenly you
feel a shove in the back and see the pointy rocks below rush up to meet your
descent.">)>)>)
			     (<AND <VERB? GIVE>
				   <PRSI? ,JOHNNY>>
			      <COND (<PRSO? ,GLOBAL-MONEY>
				     <SETG P-AMOUNT 0>)>
			      <COND (<OR <AND <PRSO? ,GLOBAL-MONEY>
					      <G? ,POCKET-CHANGE 499>>
					 <AND <PRSO? ,INTNUM>
					      ,P-DOLLAR-FLAG
					      <G? ,P-AMOUNT 499>
					      <NOT <G? ,P-AMOUNT ,POCKET-CHANGE>>>>
				     <COND (<AND <NOT <FSET? ,DEEP-SUIT ,WORNBIT>>
						 <NOT <FSET? ,WET-SUIT ,WORNBIT>>>
					    <TELL 
"Johnny examines your money and returns it. \"You hold it. I needed
to make sure you had it.\" ">)>)>
			      <COND (<OR <PRSO? ,GLOBAL-MONEY>
					 <AND <PRSO? ,INTNUM>
					      ,P-DOLLAR-FLAG>>
				     <COND (<G? ,P-AMOUNT ,POCKET-CHANGE>
					    <TELL-YOU-CANT
					    "give him more than you've got.">)
					   (T
			              <PERFORM ,V?SHOW ,PRSO ,JOHNNY>
			              <RTRUE>)>)>)>)
		      (<==? ,TM-CTR 7>
		       <COND (<VERB? YES>
			      <SETG SHIP-CHOSEN ,SALVAGER>
			      <SETG TM-CTR 8>
			      <RTRUE>)
			     (<VERB? NO>
			      <SETG SHIP-CHOSEN ,TRAWLER>
			      <SETG TM-CTR 8>
			      <RTRUE>)
			     (<VERB? MAYBE>
			      <TELL "\"A wise guy, huh?\" ">)
			     (<VERB? WALK>
			      <TELL "\"Let's finish here first, huh?\" ">)>)>)>>

<GLOBAL SHIP-CHOSEN <>>

<ROUTINE CLIFF-PSEUDO ("OPTIONAL" (PARG <>))
	 <COND (<==? .PARG ,M-NAME>
		<PUTP ,PSEUDO-OBJECT ,P?SDESC "cliff">)
	       (<VERB? THROW-OFF>
		<PERFORM ,V?THROW ,PRSO ,OCEAN>
		<RTRUE>)
	       (<VERB? DISEMBARK>
		<PERFORM ,V?LEAP>)>>

<ROOM FERRY-LANDING
      (IN ROOMS)
      (DESC "Ferry Landing")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"The ferry to the mainland arrives here every two hours during the day.
People are milling about. The Shore Road starts off to the east.")
      (GLOBAL LIGHTHOUSE FERRY OCEAN)
      (EAST TO SHORE-ROAD-1)
      (CORRIDOR 128)
      (LINE 1)
      (STATION FERRY-LANDING)>

;<ROOM WHARF-1
      (IN ROOMS)
      (DESC "Wharf")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"You are at the northern end of the wharf. There is a dock to the west.")
      (GLOBAL LIGHTHOUSE OCEAN)
      (WEST TO N-DOCK-2)
      (SOUTH TO WHARF-2)
      (CORRIDOR 768)
      (LINE 1)
      (STATION WHARF-1)>

;<ROOM WHARF-2
      (IN ROOMS)
      (DESC "Wharf")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"You are on a deteriorating wharf which runs north/south.")
      (GLOBAL LIGHTHOUSE OCEAN)
      (NORTH TO WHARF-1)
      (SOUTH TO WHARF-3)
      (CORRIDOR 256)
      (LINE 1)
      (STATION WHARF-2)>

;<ROOM WHARF-3
      (IN ROOMS)
      (DESC "Wharf")
      (FLAGS RLANDBIT ONBIT)
      (LDESC 
"You are in the middle of a wharf which travels north/south. There is an aging
dock to the west.")
      (GLOBAL LIGHTHOUSE OCEAN)
      (NORTH TO WHARF-2)
      (SOUTH TO WHARF-4)
      (WEST TO S-DOCK-2)
      (CORRIDOR 1280)
      (LINE 2)
      (STATION WHARF-3)>

<ROOM WHARF
      (IN ROOMS)
      (DESC "Wharf")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL LIGHTHOUSE OCEAN SALVAGER TRAWLER)
      (SOUTH TO WHARF-ROAD-3)
      (WEST TO NW-STARBOARD-DECK IF TRAWLER-DOCKED ELSE
"It would help if a ship were berthed. If you want to take a dip in the
ocean, you'll have to say so.")
      (EAST TO MM-PORT-DECK IF SALVAGER-DOCKED ELSE
"It would help if a ship were berthed. If you want to take a dip in the
ocean, you'll have to say so.")
      (CORRIDOR 256)
      (LINE 0)
      (STATION WHARF)
      (ACTION WHARF-F)>

<ROUTINE WHARF-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
	        <TELL
"You're on Hardscrabble Island's weatherbeaten wharf, north of the "
D ,WHARF-ROAD-1 ".">
		<COND (,TRAWLER-DOCKED
		       <TELL 
" A trawler called the " D ,TRAWLER " is berthed here to the west.">)>
		<COND (,SALVAGER-DOCKED
		       <TELL
" The " D ,SALVAGER " is moored to the east.">)>
		<CRLF>)
	       (<==? .RARG ,M-BEG>
		<COND (<VERB? BOARD THROUGH>
		       <COND (<PRSO? ,TRAWLER>
			      <DO-WALK ,P?WEST>
		       	      <RTRUE>)
		       	     (<PRSO? ,SALVAGER>
			      <DO-WALK ,P?EAST>
		       	      <RTRUE>)>)>)>>
