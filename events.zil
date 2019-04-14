"       EVENTS for TOA2
 Copyright (C) 1984 Infocom Inc.
      All rights reserved."

<ROUTINE I-UNWOUND ()
	 <SETG WATCH-WOUND <>>
	 <RFALSE>>

<ROUTINE I-BUSINESS-HOURS ()
	 <COND (,BUSINESS-HOURS?
		<SETG BUSINESS-HOURS? <>>
		<COND (<IN? ,PLAYER ,MCGINTY-HQ>
		       <MOVE ,PLAYER ,WHARF-ROAD-2>
		       <SETG HERE ,WHARF-ROAD-2>
		       <TELL
"\"Closing time,\" says " D ,MCGINTY " as he escorts you out to the
street..." CR CR>
		       <V-FIRST-LOOK>)
		      (<IN? ,PLAYER ,OUTFITTERS-HQ>
		       <MOVE ,PLAYER ,WHARF-ROAD-4>
		       <SETG HERE ,WHARF-ROAD-4>
		       <TELL
"\"Sorry, but it's closing time,\" the salesman says, then shows you out..." CR CR>
		       <V-FIRST-LOOK>)
		      (<IN? ,PLAYER ,BANK>
		       <MOVE ,PLAYER ,SHORE-ROAD-2>
		       <SETG HERE ,SHORE-ROAD-2>
		       <TELL
"The teller says, \"You'll have to leave. It's 5:00.\" A guard escorts you
out..." CR CR>
		       <V-FIRST-LOOK>)
		      (T <RFALSE>)>
		<RTRUE>)
	       (T
		<SETG BUSINESS-HOURS? T>
		<ENABLE <QUEUE I-BUSINESS-HOURS 480>>
		<RFALSE>)>>

<ROUTINE I-FERRY-APPROACHING ()
	 <ENABLE <QUEUE I-FERRY-APPROACHING -1>>
	 <FCLEAR ,FERRY ,INVISIBLE>
	 <COND (<IN? ,WEASEL ,GLOBAL-FERRY>
		<MOVE ,WEASEL ,FERRY>)>
	 <COND (<EQUAL? ,HERE ,FERRY-LANDING ,SHORE-ROAD-1 ,SHORE-ROAD-2>
		<TELL
"The ferry approaches the landing." CR>)>>

<ROUTINE I-FERRY ("AUX" (WEASEL-HERE? <>))
	 <DISABLE <INT I-FERRY-APPROACHING>>
	 <ENABLE <QUEUE I-FERRY-LEAVING 5>>
	 <ENABLE <QUEUE I-FERRY-GONE 8>>
	 <MOVE ,FERRY ,FERRY-LANDING>
	 <COND (<AND <IN? ,WEASEL ,FERRY-LANDING>
		     <NOT <QUEUED? I-TRAITOR-MEETING>>>
		<SET WEASEL-HERE? T>
		<MOVE ,WEASEL ,FERRY>)
	       (<IN? ,WEASEL ,FERRY>
		<MOVE ,WEASEL ,FERRY-LANDING>
		<COND (<AND <IN? ,JOHNNY ,FERRY-LANDING>
			    ,WEASEL-BLOWN>
		       <ROUGH-JUSTICE>)
		      (<==? ,SHIP-CHOSEN ,TRAWLER>
		       <ESTABLISH-GOAL ,WEASEL ,NW-CREW-QTRS>)
		      (<==? ,SHIP-CHOSEN ,SALVAGER>
		       <ESTABLISH-GOAL ,WEASEL ,MM-CREW-QTRS>)>)>
	 <COND (<==? ,HERE ,FERRY-LANDING>
		<TELL 
"The ferry arrives. Some passengers get off and others get on.">
		<COND (.WEASEL-HERE?
		       <TELL-FERRY-KLUDGE "boards">)
		      (<AND <IN? ,WEASEL ,FERRY-LANDING>
			    <NOT <QUEUED? I-TRAITOR-MEETING>>>
		       <TELL-FERRY-KLUDGE "disembarks">
		       <COND (<IN? ,ENVELOPE ,PLAYER>
			      <CRLF>
			      <WEASEL-BEATS-YOU>)>)>
		<CRLF>)
	       (<EQUAL? ,HERE ,SHORE-ROAD-1 ,SHORE-ROAD-2>
		<TELL "The ferry arrives at the landing." CR>)>>

<ROUTINE TELL-FERRY-KLUDGE (STR)
	 <TELL " The Weasel " .STR ".">>

<ROUTINE I-FERRY-LEAVING ()
	 <ENABLE <QUEUE I-FERRY-LEAVING -1>>
	 <MOVE ,FERRY ,LOCAL-GLOBALS>
	 <COND (<AND <IN? ,WEASEL ,FERRY>
		     <IN? ,PASSBOOK ,WEASEL>>
		<MOVE ,WEASEL ,LOCAL-GLOBALS>)>
	 <COND (<EQUAL? ,HERE ,FERRY-LANDING ,SHORE-ROAD-1 ,SHORE-ROAD-2>
		<TELL 
"The ferry pulls away, heading for the mainland." CR>)>>

<ROUTINE I-FERRY-GONE ()
	 <DISABLE <INT I-FERRY-LEAVING>>
	 <ENABLE <QUEUE I-FERRY-APPROACHING 109>>
	 <ENABLE <QUEUE I-FERRY 112>>
	 <FSET ,FERRY ,INVISIBLE>
	 <COND (<IN? ,WEASEL ,FERRY>
		<MOVE ,WEASEL ,GLOBAL-FERRY>)>
	 <RFALSE>>

<ROUTINE I-DISGUSTING-WEASEL-KLUDGE ("AUX" WGT);"make sure he goes to 1st mtg"
	 <COND (<AND <NOT <IN? ,PASSBOOK ,WEASEL>>
		     <NOT <==? <GET <SET WGT <GET ,GOAL-TABLES ,WEASEL-C>>
				    ,GOAL-F>
			  ,SHANTY>>>
		<PUT .WGT ,ATTENTION 0>
		<ESTABLISH-GOAL ,WEASEL ,SHANTY>
		<RFALSE>)>>

<ROUTINE I-FIRST-MEETING ()
	 <COND (<==? ,FM-CTR 5>
		<DISABLE <INT I-FIRST-MEETING>>
		<RFALSE>)
	       (<AND <IN? ,JOHNNY ,SHANTY>
		     <IN? ,PETE ,SHANTY>
		     <==? <META-LOC ,PLAYER> ,SHANTY>>
		<COND (<==? ,FM-CTR 0>
		       <COND (<G? ,PRESENT-TIME 535>
			      <I-PLOT-NEVER-STARTS>
			      <DISABLE <INT I-FIRST-MEETING>>
			      <RFALSE>)>
		       <SETG QCONTEXT ,JOHNNY>
		       <SETG QCONTEXT-ROOM ,HERE>
		       <TELL 
"\"Sit down and we'll talk,\" " D ,JOHNNY " says." CR>)
		      (<==? ,FM-CTR 1>
		       <COND (<IN? ,WEASEL ,SHANTY>
			      <SETG FM-CTR 2>
			      <I-FIRST-MEETING>)
			     (,WAITING-FOR-WEASEL
			      <COND (<G? ,PRESENT-TIME 525>
				     <DISABLE <INT I-FIRST-MEETING>>
				     <I-PLOT-NEVER-STARTS>
				     <SETG QCONTEXT ,JOHNNY>
				     <SETG QCONTEXT-ROOM ,HERE>
				     <TELL 
"Pete looks at Johnny and says, \"Weasel ain't gonna show.\"|
\"Guess not,\" replies Johnny. \"Without " D ,WEASEL ", there's
no deal. Who knows what that creep is up to?\"" CR>)>)
			     (T
			      <SETG QCONTEXT ,JOHNNY>
			      <SETG QCONTEXT-ROOM ,HERE>
			      <TELL 
"Johnny says, \"When " D ,WEASEL " shows, I'll tell ya what we got.\"" CR>
			      <SETG WAITING-FOR-WEASEL T>)>)
		       (<G? ,BLOOD-ALCOHOL 10>
			<DISABLE <INT I-FIRST-MEETING>>
			<I-PLOT-NEVER-STARTS>
			<TELL
"Pete turns to Johnny and says, \"This joker's drunk!\"|
\"Yeah,\" Johnny says. He looks at you. \"Some diver! We'll find
someone else.\"" CR>)
		       (<==? ,FM-CTR 2>
			<SETG QCONTEXT ,JOHNNY>
			<SETG QCONTEXT-ROOM ,HERE>
			<TELL 
"At Pete's request, " D ,WEASEL " joins you. Johnny then whispers that he's
come across some sunken " D ,GLOBAL-TREASURE "." CR>
			<SETG FM-CTR 3>
			<SETG I-WAIT-RTN ,I-FIRST-MEETING>
			<SETG I-WAIT-DURATION 2>)
		       (<==? ,FM-CTR 3>
			<COND (,I-WAIT-FLAG
			       <TELL
"Unfortunately, this interrupts Johnny's explanation of what the meeting is
about." CR>
			       <SETG I-WAIT-DURATION 2>)
			      (<AND <G? ,I-WAIT-DURATION 0>
				    <==? ,I-WAIT-RTN ,I-FIRST-MEETING>>
			       <RFALSE>)
                              (T
			       <SETG QCONTEXT ,JOHNNY>
			       <SETG QCONTEXT-ROOM ,HERE>
			       <TELL 
"Johnny explains that they need more money to get started.
They chose you because they know you've salted some money away and
you're a great diver. He asks if you're interested in the deal."
CR>
			       <SETG FM-CTR 4>)>)
		       (<==? ,FM-CTR 4>
			<COND (<AND <G? ,PRESENT-TIME 539>
				    <NOT <VERB? YES NO>>>
			       <SETG QCONTEXT ,JOHNNY>
			       <SETG QCONTEXT-ROOM ,HERE>
			       <I-PLOT-NEVER-STARTS>
			       <TELL 
"Pete turns to Johnny. \"We don't want anyone who can't decide.\"|
\"Right,\" says Johnny. \"We'll find someone else.\" He turns to
you. \"Say a word about this and you're history!\"" CR>)
			      (T
			       <SETG QCONTEXT ,JOHNNY>
			       <SETG QCONTEXT-ROOM ,HERE>
			       <TELL 
"\"Well, what is it? Yes or no?\" Pete asks anxiously." CR>)>)>)>>

<GLOBAL WAITING-FOR-WEASEL <>>

<GLOBAL I-WAIT-FLAG <>>

<GLOBAL I-WAIT-DURATION 0>

<GLOBAL I-WAIT-RTN <>>

<GLOBAL FM-CTR 0>  "counter for throughout first meeting:
		    0-waiting for player to sit down
		    1-waiting for the Weasel to show up
		    2-Johnny mentions treasure
		    3-Johnny pitches the deal
	    	    4-waiting for player to accept
		      (handled in CHAIR-F, SHANTY-F)
		    5-no meeting or meeting concluded"

<GLOBAL SAMPLE-TREASURE <>>

<OBJECT GOLD-COIN
	(IN LOCAL-GLOBALS)
	(SYNONYM COIN DOUBLO ESCUDO)
	(ADJECTIVE GOLD PORTUG)
	(DESC "gold coin")
	(TEXT
"It is dated 1680 and stamped with a portrait of King Peter II of Portugal.")
	(FLAGS TRYTAKEBIT READBIT)
	(ACTION RED-HERRING-F)>

<OBJECT DINNER-PLATE
	(IN LOCAL-GLOBALS)
	(SYNONYM PLATE DISH)
	(ADJECTIVE DINNER SUPPER)
	(DESC "dinner plate")
	(TEXT
"It bears the Hollywood Cruise Lines markings.")
	(FLAGS TRYTAKEBIT READBIT)
	(ACTION RED-HERRING-F)>

;<OBJECT DINNER-PLATE
	(IN LOCAL-GLOBALS)
	(SYNONYM TRAY ASHTRA)
	(ADJECTIVE ASH)
	(SDESC "ashtray")
	(TEXT
"This is an ashtray with the markings of the Hollywood Cruise Lines.")
	(FLAGS TRYTAKEBIT VOWELBIT)
	(ACTION SAMPLE-TREASURE-F)>

;<OBJECT DINNER-PLATE
	(IN LOCAL-GLOBALS)
	(SYNONYM FORK)
	(ADJECTIVE SILVER SALAD)
	(SDESC "salad fork")
	(TEXT
"This is a salad fork with the markings of the Hollywood Cruise Lines.")
	(FLAGS TRYTAKEBIT)
	(ACTION SAMPLE-TREASURE-F)>

;<OBJECT DINNER-PLATE
	(IN LOCAL-GLOBALS)
	(SYNONYM KNIFE)
	(ADJECTIVE BUTTER SILVER)
	(SDESC "dinner plate")
	(TEXT
"This is a butter knife with the markings of the Hollywood Cruise Lines.")
	(FLAGS TRYTAKEBIT)
	(ACTION SAMPLE-TREASURE-F)>

;<OBJECT DINNER-PLATE
	(IN LOCAL-GLOBALS)
	(SYNONYM SPOON)
	(ADJECTIVE SOUP SILVER)
	(SDESC "soup spoon")
	(TEXT
"This is a soup spoon with the markings of the Hollywood Cruise Lines.")
	(FLAGS TRYTAKEBIT)
	(ACTION RED-HERRING-F)>

<ROUTINE SAMPLE-TREASURE-F ()
	 <COND (<OR <VERB? TAKE>
		    <AND <VERB? ASK-FOR>
			 <PRSO? ,JOHNNY>>>
		<COND (<IN? ,MCGINTY ,HERE>
		       <PERFORM ,V?TELL ,MCGINTY ,SAMPLE-TREASURE>
		       <RTRUE>)
		      (T <TELL 
"Red pulls it back. \"If we get the loot, there'll be plenty for all.\"" CR>)>)
	       (<VERB? TURN>
		<TELL D ,JOHNNY " has it." CR>)>>

<ROUTINE I-SECOND-MEETING ()
	 <COND (<AND <G? ,PRESENT-TIME 585>
		     <OR <L? ,SM-CTR 2>
			 <G? ,HOW-HUNGRY 3>>>
		<ALL-GO-HOME>
		<I-PLOT-NEVER-STARTS>
		<SETG SM-CTR 4>)>
	 <COND (<==? ,SM-CTR 4>
		<DISABLE <INT I-SECOND-MEETING>>)
	       (<NOT <==? ,HERE ,WINDING-ROAD-1>>
		<DISABLE <INT I-SECOND-MEETING>>)
	       (<AND <G? ,SM-CTR 1>
		     <OR <IN? ,MCGINTY ,WINDING-ROAD-1>
		         <IN? ,MCGINTY ,WINDING-ROAD-2>>>
		<JIGS-UP
"Pete spots McGinty, who is near enough to overhear! While Johnny
chases McGinty, Pete accuses you of bringing McGinty along. Before you
respond, the Weasel plunges his knife into your heart.">)
	       (<L? ,SM-CTR 2>
		<COND (<AND <IN? ,WEASEL ,WINDING-ROAD-1>
			    <IN? ,JOHNNY ,WINDING-ROAD-1>
			    <IN? ,PETE ,WINDING-ROAD-1>>
		       <SETG SM-CTR 2>
		       <I-SECOND-MEETING>
		       <RTRUE>)
	       	      (<==? ,SM-CTR 0>
		       <COND (<IN? ,JOHNNY ,WINDING-ROAD-1>
		       	      <SETG SM-CTR 1>
		       	      <SETG QCONTEXT ,JOHNNY>
			      <SETG QCONTEXT-ROOM ,HERE>
			      <TELL 
"Johnny says, \"We'll start when everyone's here.\"" CR>)>)>)
	       (<G? ,BLOOD-ALCOHOL 10>
		<SETG SM-CTR 4>
		<DISABLE <INT I-SECOND-MEETING>>
		<SETG QCONTEXT ,JOHNNY>
		<SETG QCONTEXT-ROOM ,HERE>
		<ALL-GO-HOME>
		<I-PLOT-NEVER-STARTS>
		<TELL
"\"I won't risk everything on a drunk diver!\" " D ,WEASEL " says.|
\"You're right,\" says Johnny. \"We're calling this off.\"" CR>)
	       (<==? ,SM-CTR 2>
		<SETG WRECK-FOUND <RANDOM 2>>
		<COND (<==? ,WRECK-FOUND 1>
		       <SETG SAMPLE-TREASURE ,GOLD-COIN>)
		      (T <SETG SAMPLE-TREASURE ,DINNER-PLATE>)>
		<PUTP ,SAMPLE-TREASURE ,P?ACTION SAMPLE-TREASURE-F>
		<MOVE ,SAMPLE-TREASURE ,JOHNNY>
		;<FCLEAR ,SAMPLE-TREASURE ,INVISIBLE>
		<SETG P-IT-OBJECT ,SAMPLE-TREASURE>
		<SETG SM-CTR 3>
		<SETG I-WAIT-DURATION 6>
		<SETG I-WAIT-RTN ,I-SECOND-MEETING>
		<SETG QCONTEXT ,JOHNNY>
		<SETG QCONTEXT-ROOM ,HERE>
		<TELL 
"Johnny nods, then pulls out " A ,SAMPLE-TREASURE " he says he came across
while on a shark hunt." CR>)
	       (<==? ,SM-CTR 3>
		<COND (,I-WAIT-FLAG
		       <TELL 
"This interrupts Johnny's explanation, which makes him angry." CR>
		       <SETG I-WAIT-DURATION 6>)
		      (<AND <G? ,I-WAIT-DURATION 0>
			    <==? ,I-WAIT-RTN ,I-SECOND-MEETING>>
		       <RFALSE>)
		      (T
		       <DISABLE <INT I-SECOND-MEETING>>
		       <ENABLE <QUEUE I-OTHERS-MEET <- 705 ,PRESENT-TIME>>>
		       <SETG SM-CTR 4>
		       <SETG MEETINGS-COMPLETED 2>
		       <PUT ,MOVEMENT-GOALS ,JOHNNY-C ,JOHNNY-CONTINUES-TABLE>
		       <IMOVEMENT ,JOHNNY I-JOHNNY>
		       <RATING-UPD 20>
		       <SETG QCONTEXT ,JOHNNY>
		       <SETG QCONTEXT-ROOM ,HERE>
		       <CRLF>
		       <TELL 
"\"We're not sure which wreck to salvage,\" Johnny says.
\"Since you're joining up, we're hoping you'll identify where
the " D ,SAMPLE-TREASURE " came from, and then do the dive for us. I'll
captain, Pete will cook, and " D ,WEASEL " will crew.|
|
Johnny winks at you. \"We'll need you to supply the minutes of longitude and
latitude of the wreck. Get $500 and meet me at Point Lookout at 10:45. Then
we'll provision the boat.\"|
|
He turns to the others. \"We'll meet in " D ,SHANTY " at 11:45 to discuss final
arrangements.|
|
\"We're all in this now,\" Johnny says to the group. \"I'm not gonna chance
this operation if one of you doesn't show. We need everyone to pull this off.
If anyone tries anything stupid, you won't live to regret it.\"" CR>)>)>>

<GLOBAL SM-CTR 0>  "counter for throughout second meeting:
		    0-Johnny not here
		    1-waiting for Weasel and/or Pete
		    2-Johnny shows treasure
		    3-Johnny shoots deal
		    4-meeting's over" 

<ROUTINE I-THIRD-MEETING ("AUX" JMG)
	 <COND (<NOT <EQUAL? ,HERE ,POINT-LOOKOUT>>
		<DISABLE <INT I-THIRD-MEETING>>
		<RFALSE>)
	       (<IN? ,JOHNNY ,POINT-LOOKOUT>
		<COND (<L? ,TM-CTR 6> <SETG TM-CTR <+ ,TM-CTR 1>>)>)
	       (T <RFALSE>)>
	 <COND (<IN? ,MCGINTY ,POINT-LOOKOUT>
		<JIGS-UP
"Johnny glares at McGinty. \"Trying to cash in on my work again,
huh? You probably killed Hevlin, too!\" And with that, he pushes McGinty off
the cliff.|
|
\"I can't leave witnesses,\" he mumbles.
Before you can react, you're on your way down to join what's left of
McGinty.">)
	       (<AND <IN? ,MCGINTY ,OCEAN-ROAD-3>
		     <NOT <IN-MOTION? ,MCGINTY>>>
		<JIGS-UP
"Johnny sees McGinty on the road. \"You brought McGinty, you traitor! You
probably killed Hevlin, too!\" A moment later, you're falling
down to the rocks.">)
	       (<==? ,TM-CTR 1>
		<SETG QCONTEXT ,JOHNNY>
		<SETG QCONTEXT-ROOM ,HERE>
		<TELL 
"Johnny turns toward you. \"Well? Did you bring the money?\"" CR>)
	       (<G? ,BLOOD-ALCOHOL 10>
		<JIGS-UP
"Johnny stares at you in disgust. \"A drunk diving for us? You'll probably
tell McGinty, too. I'll make sure you don't.\" He pushes you off the cliff.
Although you feel no pain, your landing is fatal.">)
	       (<==? ,TM-CTR 4>
		<TELL 
"Johnny glares at you as if you were a sea slug." CR>)
	       (<==? ,TM-CTR 5>
		<JIGS-UP 
"Johnny looks disgusted. \"No money? You probably told McGinty already.
Traitor!\" He pushes you off the cliff, and you scream as
the pointy rocks rush up to meet you.">)
	       (<==? ,TM-CTR 6>
		<SETG TM-CTR 7>
                <RATING-UPD 20>
		<SETG QCONTEXT ,JOHNNY>
		<SETG QCONTEXT-ROOM ,HERE>
		<CRLF>
		<TELL
"\"Glad you're with us. Since you're okay, I'll level with you. Before
Hevlin died, he told me he gave you the book. He also said you could handle
this job. He's the one who gave me the " D ,SAMPLE-TREASURE ". I didn't want
to say anything in front of Pete and " D ,WEASEL " just in case.|
|
\"We're gonna need a boat, but I don't know which one. If
you need deep-sea diving gear, it'll have to be
the " D ,SALVAGER ". Is the " D ,GLOBAL-TREASURE " more than 200 feet deep?\""
CR>)
	       (<==? ,TM-CTR 7>
		<COND (<G? ,PRESENT-TIME 675>
		       <JIGS-UP
"Johnny looks disgusted. \"I can't wait all day...\" You feel a shove and then
find yourself on your way down to the rocks below.">)>
		<SETG QCONTEXT ,JOHNNY>
		<SETG QCONTEXT-ROOM ,HERE>
		<TELL 
"Johnny looks impatient. \"Don't confuse things. A yes or no will do.\""
CR>)
	       (<==? ,TM-CTR 8>
		<ESTABLISH-GOAL ,JOHNNY ,OUTFITTERS-HQ>
		<PUT ,MOVEMENT-GOALS ,JOHNNY-C ,JOHNNY-COMPLETES-TABLE>
		<SET JMG <GET ,MOVEMENT-GOALS ,JOHNNY-C>>
		<PUT .JMG ,MG-TIME <- 838 ,PRESENT-TIME>>
		<IMOVEMENT ,JOHNNY I-JOHNNY>
		<DISABLE <INT I-THIRD-MEETING>>
		<SETG MEETINGS-COMPLETED 3>
		<TELL
"\"We'll rent the " D ,SHIP-CHOSEN ". Let's go get what we need.\"" CR>)>>

<GLOBAL TM-CTR 0>  "Counter for third meeting (incremented every move thru 5):
		    0 - no meeting yet
		    1 - Johnny wants to see money
		    2-5 - Johnny is waiting to see money
		    	  (on 5, he's waited long enough and kills you)
		    6 - money shown; Johnny asks which ship to rent
		    7 - waiting for answer about ship
		    8 - meeting's over"

<ROUTINE I-EQUIP ("AUX" MCG-GT (V <>))
	 <COND (<IN? ,PLAYER ,OUTFITTERS-HQ>
		<COND (<IN? ,MCGINTY ,OUTFITTERS-HQ>
		       <SETG WARNING-CTR <+ ,WARNING-CTR 1>>
		       <COND (<==? ,WARNING-CTR 7>
			      <TELL
"Johnny leans over and whispers, \"Let's wait out McGinty. He should leave soon.\"" CR>
			      <SET V T>)>
		       <COND (<G? ,I-WAIT-DURATION 0>
			      <SETG I-WAIT-DURATION 0>
			      <SETG I-WAIT-RTN <>>
			      <TELL 
"Johnny ends his conversation, and " D ,MCGINTY
" asks the salesman some questions." CR>)
			     (<AND <GET <SET MCG-GT
					    <GET ,GOAL-TABLES ,MCGINTY-C>>
					,GOAL-ENABLE>
				   <==? <GET .MCG-GT ,GOAL-F> ,MCGINTY-HQ>>
			      <COND (<NOT ,MCGINTY-KNOWS>
				     <SETG MCGINTY-MEETS-WEASEL T>)>
			      <SETG I-WAIT-DURATION 9>
			      <SETG I-WAIT-RTN ,I-EQUIP>
			      <RFALSE>)
			     (<AND <VERB? BUY RENT>
				   <NOT <PRSO? ,FERRY-TOKEN>>>
			      <SETG MCGINTY-KNOWS T>
			      <DISABLE <INT I-MCGINTY-FOLLOWS>>
			      <DISABLE <INT I-EQUIP>>
			      <MOVE ,MCGINTY ,WHARF-ROAD-4>
			      ;<MOVE ,JOHNNY ,WHARF-ROAD-3>
			      ;<ESTABLISH-GOAL ,JOHNNY ,SHANTY>
			      <ESTABLISH-GOAL ,MCGINTY ,MCGINTY-HQ>
			      <TELL D ,MCGINTY
" grins as he realizes what you're up to.">
			      <SAY-MCGINTY-KNOWS>)
			     (<G? ,PRESENT-TIME 699>
			      <COND (<IN? ,JOHNNY ,OUTFITTERS-HQ>
				     <ESTABLISH-GOAL ,JOHNNY ,SHANTY>
			      	     <TELL
"Johnny glares at " D ,MCGINTY
" and then at his watch. \"There's no way.\" He turns
to you. \"Forget it. We can't get this done in time.\"" CR>)
				    (T
				     <DISABLE <INT I-MCGINTY-FOLLOWS>>
				     <ESTABLISH-GOAL ,MCGINTY ,MCGINTY-HQ>
				     <DISABLE <INT I-EQUIP>>
				     <TELL
D ,MCGINTY
" turns to the salesman. \"I think... yeah! I will need that boat after
all.\" He turns to you and grins." CR>)>)
			     (<NOT <OR <VERB? WAIT WAIT-FOR>
				       <VERB? LOOK WALK>>>
			      <TELL
"Johnny glances nervously at " D ,MCGINTY "." CR>)
			     (T <RETURN .V>)>)
		      (,MCGINTY-KNOWS
		       <DISABLE <INT I-EQUIP>>
		       <RFALSE>)
		      (,I-WAIT-FLAG
		       <TELL 
"Johnny seems unhappy to have his conversation interrupted." CR>
		       <SETG I-WAIT-DURATION 9>)
		      (<==? ,I-WAIT-RTN ,I-EQUIP>
		       <COND (<G? ,I-WAIT-DURATION 0>
			      <RFALSE>)
			     (T
			      <ESTABLISH-GOAL ,JOHNNY ,SHANTY>
			      <ENABLE <QUEUE I-SHOVE-OFF <- 870 ,PRESENT-TIME>>>
			      <DISABLE <INT I-EQUIP>>
		              <COND (<EQUAL? ,SHIP-CHOSEN ,TRAWLER>
				     <SETG AMT-OWED <+ 50 <RANDOM 50>>>)
				    (T <SETG AMT-OWED <+ 400 <RANDOM 50>>>)>
			      <SETG JOHNNY-MADE-DEAL T>
			      <RATING-UPD 20>
			      <TELL
"Johnny hands him a list and the salesman quotes a price.
Johnny gives him the money he has, then says to you, \"You'll need to chip
in $" N ,AMT-OWED " plus the money for your stuff. We'll leave on the "
D ,SHIP-CHOSEN " at high tide.\"|
|
He tells the " D ,SPEAR-CARRIER ", \"Deliver the stuff half an hour before high
tide.\" He turns back to you. \"Better be on board then to watch
the stuff.\"" CR>)>)
		      (<NOT <IN? ,MCGINTY ,WHARF-ROAD-4>>
		       <SETG I-WAIT-DURATION 9>
		       <SETG I-WAIT-RTN ,I-EQUIP>
		       <RFALSE>)>)
	       (T
		<SETG I-WAIT-DURATION 0>
		<COND (<L? <GET <INT I-EQUIP> ,C-TICK> -15>
		       <DISABLE <INT I-EQUIP>>
		       <COND (<IN? ,JOHNNY ,OUTFITTERS-HQ>
		       	      <ESTABLISH-GOAL ,JOHNNY ,SHANTY>)>
		       <I-PLOT-NEVER-STARTS>
		       <RFALSE>)>)>>

<GLOBAL WARNING-CTR 0>

<GLOBAL AMT-OWED 0>

<GLOBAL MCGINTY-KNOWS <>>

<GLOBAL JOHNNY-MADE-DEAL <>>

<ROUTINE TELL-NEED-BOAT ()
	 <TELL
" \"We will need that boat after all,\" he says to the salesman as he
leaves." CR>>

<ROUTINE SAY-MCGINTY-KNOWS ()
	 <TELL-NEED-BOAT>
	 <MOVE ,JOHNNY ,WHARF-ROAD-3>
	 <ZERO-ATTENTION ,JOHNNY>
	 <ESTABLISH-GOAL ,JOHNNY ,SHANTY>
	 <TELL CR
"Johnny glares at you. \"That was stupid! Now he's stopped us from renting
the boat we need.\" He storms out.
You can't help feeling fortunate that someone else happened to be here." CR>>

<ROUTINE I-OTHERS-MEET ("AUX" (V T))
	 <COND (<G? ,PRESENT-TIME 720>
		<DISABLE <INT I-OTHERS-MEET>>
		<I-PLOT-NEVER-STARTS>
		<COND (<IN? ,PLAYER ,CHAIR>
		       <TELL "Johnny tells Pete the deal's off." CR>)
		      (<IN? ,PLAYER ,SHANTY>
		       <TELL "Johnny says something to Pete." CR>)
		      (T <SET V <>>)>
		<RETURN .V>)
	       (<OR <NOT <IN? ,JOHNNY ,SHANTY>>
		    <NOT <IN? ,PETE ,SHANTY>>
		    <NOT <IN? ,WEASEL ,SHANTY>>>
		<ENABLE <QUEUE I-OTHERS-MEET 1>>
		<RFALSE>)
	       (<NOT ,JOHNNY-MADE-DEAL>
		<I-PLOT-NEVER-STARTS>)>
	 <COND (<IN? ,PLAYER ,CHAIR>
		<TELL "Johnny tells Pete and " D ,WEASEL " the deal's ">
		<COND (,JOHNNY-MADE-DEAL
		       <TELL "on and to be at the " D ,SHIP-CHOSEN " at 2:30">)
		      (T <TELL "off">)>
		<TELL "." CR>)
	       (<IN? ,PLAYER ,SHANTY>
		<TELL
"Johnny, Pete, and " D ,WEASEL " are talking at a corner table." CR>)>>

<ROUTINE I-TRAITOR-MEETING ("AUX" (FERRY-HERE <>))
	 <COND (<OR <IN? ,WEASEL ,FERRY>
		    ,MCGINTY-KNOWS
		    <NOT <IN? ,MCGINTY ,FERRY-LANDING>>>
		<DISABLE <INT I-TRAITOR-MEETING>>
		<RFALSE>)
	       (<NOT <IN? ,WEASEL ,FERRY-LANDING>>
		<RFALSE>)
	       (<IN? ,ID-CARD ,WEASEL>
		<COND (<IN? ,PASSBOOK .WEASEL>
		       <COND (<IN? ,FERRY ,FERRY-LANDING>
		       	      <MOVE ,WEASEL ,FERRY>
		       	      <SET FERRY-HERE T>)>
		       <DISABLE <INT I-TRAITOR-MEETING>>
		       <COND (<IN? ,PLAYER ,FERRY-LANDING>
			      <TELL-CORNER .FERRY-HERE "shakes his head">)>)
		      (T
		       <MOVE ,ID-CARD ,MCGINTY>
		       <COND (<IN? ,FERRY ,FERRY-LANDING>
		       	      <MOVE ,WEASEL ,FERRY>
		       	      <SET FERRY-HERE T>)>
		       <DISABLE <INT I-TRAITOR-MEETING>>
		       <COND (<IN? ,PLAYER ,FERRY-LANDING>
		       	      <TELL-CORNER .FERRY-HERE
					   "hands something to McGinty">)>)>)
	       (T
		<MOVE ,ID-CARD ,WEASEL>
		<SETG MCGINTY-MEETS-WEASEL <>>
		<COND (<IN? ,PLAYER ,FERRY-LANDING>
		       <TELL
D ,MCGINTY " takes " D ,WEASEL
" to a corner of the landing, where they talk." CR>)>)>>

<ROUTINE TELL-CORNER (FERRY-HERE STR)
	 <TELL
D ,MCGINTY " and " D ,WEASEL
" are talking in a corner. The Weasel " .STR " and ">
	 <COND (.FERRY-HERE
	 	<TELL "then boards the ferry">)
	       (T <TELL "they separate">)>
	 <TELL "." CR>>

<ROUTINE I-SHOVE-OFF ("AUX" L)
	 <COND (<NOT <ENABLED? I-JOHNNY>>
		<RFALSE>)
	       (<==? <GETP <META-LOC ,PLAYER> ,P?LINE>
		     <GETP ,SHIP-CHOSEN ,P?LINE>>
		<COND (<AND <G? ,PRESENT-TIME 930>
			    <NOT ,LATITUDE-SET>
			    <NOT ,LONGITUDE-SET>>
		       <ALL-GO-HOME>
		       <RFALSE>)
		      (<IN? ,JOHNNY <META-LOC ,PLAYER>>
		       <TELL D ,JOHNNY " turns to">)
		      (T
		       <SET L <LOC ,JOHNNY>>
		       <MOVE ,JOHNNY <META-LOC ,PLAYER>>
	 	       <ESTABLISH-GOAL ,JOHNNY .L>
	 	       <TELL D ,JOHNNY " walks up behind">)>
		<TELL " you and says, \"">
		<COND (<NOT ,DELIVERY-MADE>
		       <TELL
"We're gonna have to forget it. Outfitters never delivered the stuff." CR>
		       <ALL-GO-HOME>
		       <RTRUE>)
		      (<EQUAL? 0 ,LATITUDE-SET ,LONGITUDE-SET>
		       <TELL
"If we're gonna go, you have to tell me the minutes of ">
		       <COND (<==? ,LATITUDE-SET 0>
			      <TELL "latitude">
			      <COND (<==? ,LONGITUDE-SET 0>
				     <TELL " and ">)>)>
		       <COND (<==? ,LONGITUDE-SET 0>
			      <TELL "longitude">)>
		       <TELL ".\"" CR>
	 	       <GRAB-ATTENTION ,JOHNNY>
		       <ENABLE <QUEUE I-SHOVE-OFF <+ 30 <RANDOM 10>>>>
		       <RTRUE>)
		      (T <TELL
"We'll be leaving shortly. Get some sleep.\"" CR>)>
		;<COND (<AND <==? ,LATITUDE-SET
				 <GET ,LATITUDE-TABLE ,WRECK-FOUND>>
			    <==? ,LONGITUDE-SET
				 <GET ,LONGITUDE-TABLE ,WRECK-FOUND>>>
		       <SETG AT-WRECK? T>)>
		<COND (<==? ,SHIP-CHOSEN ,SALVAGER>
		       <ESTABLISH-GOAL ,JOHNNY ,MM-WHEELHOUSE>)
		      (T
		       <ESTABLISH-GOAL ,JOHNNY ,NW-WHEELHOUSE>)>
		<COND (<NOT <EQUAL? <LOC ,WEASEL>
				    ,FERRY ,GLOBAL-FERRY ,LOCAL-GLOBALS>>
		       <ESTABLISH-GOAL ,WEASEL <LOC ,DECK-CHAIR>>)>
		<COND (<0? ,AMT-OWED>
		       <ENABLE <QUEUE I-BOAT-TRIP 10>>
		       <RFALSE>)>)
	       (<G? ,PRESENT-TIME 900>
		<ALL-GO-HOME>
		<RFALSE>)
	       (T <ENABLE <QUEUE I-SHOVE-OFF <+ 30 <RANDOM 10>>>>
		<RFALSE>)>>

<ROUTINE ALL-GO-HOME ()
	 <ESTABLISH-GOAL ,PETE ,SHANTY>
	 <COND (<AND <NOT <IN? ,WEASEL ,FERRY>>
		     <NOT <IN? ,WEASEL ,GLOBAL-FERRY>>
		     <NOT <IN? ,WEASEL ,LOCAL-GLOBALS>>>
		<ESTABLISH-GOAL ,WEASEL ,SHANTY>)>
	 <SETG JOHNNY-SILENT T>
	 <ESTABLISH-GOAL ,JOHNNY ,SHANTY>>

<ROUTINE I-BOAT-TRIP ("AUX" BOAT OT EXCESS)
	 <COND (,ASLEEP <RFALSE>)
	       (<EQUAL? <GETP <META-LOC ,PLAYER> ,P?LINE>
			<SET BOAT <GETP ,SHIP-CHOSEN ,P?LINE>>>
		<COND (<NOT <==? <GETP <LOC ,WEASEL> ,P?LINE> .BOAT>>
		       <TELL-COMES-UP ,JOHNNY>
		       <TELL
"\"The Weasel's not on board. The deal's off.\"" CR>
		       <FINISH>)
		      (<==? <GETP <LOC ,MCGINTY> ,P?LINE> .BOAT>
		       <TELL-COMES-UP ,WEASEL>
		       <JIGS-UP
"\"You brought McGinty!\" Next thing you know, your throat's been slit.">)
		      (<IN? ,ENVELOPE ,JOHNNY>
		       <MOVE ,JOHNNY <LOC ,WEASEL>>
		       <ROUGH-JUSTICE>)>
		;<ENABLE <QUEUE I-CHANGE-WATCH <- 1075 ,PRESENT-TIME>>>
		;<ENABLE <QUEUE I-OBSTACLES <RANDOM 90>>>
		;<SETG HOW-TIRED 2>
		<DISABLE <INT I-MCGINTY-FOLLOWS>>
		<SETG SOUPS-ON T>
		<RATING-UPD 20>
		<COND (<AND <==? ,LATITUDE-SET 20>
			    <==? ,LONGITUDE-SET 25>>
		       <TELL-COMES-UP ,JOHNNY>
		       <JIGS-UP
"\"What kind of joke is this, giving me the coordinates of the island?\"">)>
		<COND (<EQUAL? <META-LOC ,PLAYER> ,MM-GALLEY ,NW-GALLEY>
		       <TELL "Pete announces that the stew is ready." CR>)>
		<COND (<EQUAL? ,SHIP-CHOSEN ,TRAWLER>
		       <SETG TRAWLER-DOCKED <>>)
		      (T <SETG SALVAGER-DOCKED <>>)>
		<SETG AT-SEA T>
		;<SETG ON-WATCH ,WEASEL>
		;<SET-NEXT-WATCH>
		<COND (<IN? ,PLAYER ,DECK-CHAIR>
		       <MOVE ,PLAYER <LOC ,DECK-CHAIR>>)>
		;<MOVE ,WEASEL ,DECK-CHAIR>
		<COND (<GLOBAL-IN? ,RAILING <LOC ,PLAYER>>
		       <TELL
"As the engines roar to life, you go to the " D ,RAILING
" to watch the shoreline recede.">
		       <COND (<IN? ,DECK-CHAIR <LOC ,PLAYER>>
			      <TELL-FERRY-KLUDGE "sits down for his watch">)>
		       <TELL
" As the boat leaves the wharf, y">)
		      (T <TELL
"The boat begins to move through the waves. Y">)>
		<TELL "ou feel the thrill of being out to sea once again." CR>
		<CRLF>
		<COND (<NOT <IN? ,PLAYER ,BUNK>>
		       <TELL "You ">
		       <COND (<NOT <IN? ,PLAYER <LOC ,BUNK>>>
			      <SETG HERE <LOC ,BUNK>>
			      <MOVE-SHARED-OBJECTS ,HERE>
			      <COND (<IN? ,AIR-HOSE ,DEEP-SUIT>
				     <MOVE ,AIR-HOSE ,MM-COMPRESSOR>
				     <TELL "disconnect the " D ,AIR-HOSE ", ">)>
			      <TELL "go to the crew's quarters and ">)>
		       <MOVE ,PLAYER ,BUNK>
		       <TELL "climb into your bunk">
		       <STRIP-EQUIPMENT>
		       <TELL ". " CR>)>
		<TELL
"In no time, the rhythm of the ocean lulls you to sleep..." CR CR>
		<MOVE ,PETE ,DECK-CHAIR>
		<MOVE ,JOHNNY ,HERE>
		<COND (<==? ,SHIP-CHOSEN ,SALVAGER>
		       <MOVE ,WEASEL ,MM-AFT-DECK>)
		      (T <MOVE ,WEASEL ,NW-AFT-DECK>)>
		<COND (<AND <==? <GETP <META-LOC ,ENVELOPE> ,P?LINE> .BOAT>
			    <NOT <IN? ,ENVELOPE ,UNDER-BUNK>>>
		       <MOVE ,ENVELOPE ,WEASEL>)>
		<SET OT ,PRESENT-TIME>
		<SETG PRESENT-TIME <+ 345 <RANDOM 15>>>
		;<DISABLE <INT I-FERRY>>
		;<DISABLE <INT I-FERRY-APPROACHING>>
		;<DISABLE <INT I-FERRY-LEAVING>>
		;<DISABLE <INT I-FERRY-GONE>>
		<INTERRUPT-CHECK <SET EXCESS <- <+ ,PRESENT-TIME 1440> .OT>>>
		<COND (,WATCH-WOUND
		       <SETG WATCH-MOVES <+ ,WATCH-MOVES <MOD .EXCESS 60>>>
		       <COND (<G? ,WATCH-MOVES 59>
			      <SETG WATCH-MOVES <- ,WATCH-MOVES 60>>
			      <SETG WATCH-SCORE <+ ,WATCH-SCORE 1>>)>
		       <SETG WATCH-SCORE <+ ,WATCH-SCORE </ .EXCESS 60>>>
		       <REPEAT ()
			       <COND (<G? ,WATCH-SCORE 11>
				      <SETG WATCH-SCORE <- ,WATCH-SCORE 12>>)
				     (T <RETURN>)>>)>
		<WATCH-UPDATE>
		<COND (<AND <==? ,LATITUDE-SET 40>
		       	    <==? ,LONGITUDE-SET 45>>
		       <SETG WRECK-CHOSEN 1>
		       <SETG OCEAN-BOTTOM 400>)
	       	      (<AND <==? ,LATITUDE-SET 25>
		     	    <==? ,LONGITUDE-SET 25>>
		       <SETG WRECK-CHOSEN 2>
		       <SETG OCEAN-BOTTOM 150>)
	       	      (<AND <==? ,LATITUDE-SET 15>
		     	    <==? ,LONGITUDE-SET 50>>
		       <SETG WRECK-CHOSEN 3>
		       <SETG OCEAN-BOTTOM 350>)
		      (<NOT <SETG OCEAN-BOTTOM <OCEAN-BOTTOM-FCN>>>
		       <JIGS-UP
"You are awakened by what feels like your ship running aground. You are put
back to a permanent sleep by the Weasel's knife.">)>
		<SETG HOW-TIRED 1>
		<COND (<L? ,HOW-HUNGRY 2>
		       <SETG HOW-HUNGRY 1>)>
	 	<COND (<L? ,HOW-THIRSTY 2>
		       <SETG HOW-THIRSTY 1>)>
	 	<ENABLE <QUEUE I-HUNGER 10>>
	 	<ENABLE <QUEUE I-THIRST 15>>
	 	<ENABLE <QUEUE I-TIRED 869>>
		<ENABLE <QUEUE I-ENDIT <- 720 ,PRESENT-TIME>>>
		<TELL D ,JOHNNY " shakes your shoulder and wakes you. ">
	 	<COND (<EQUAL? ,SHIP-CHOSEN ,TRAWLER>
		       <ESTABLISH-GOAL ,JOHNNY ,NW-CAPT-CABIN>)
	       	      (T <ESTABLISH-GOAL ,JOHNNY ,MM-CAPT-CABIN>)>
	        ;<SETG MOMENT-OF-TRUTH T>
	 	<DISABLE <INT I-BOAT-TRIP>>
	 	<TELL "\"We've arrived. You're up as soon as you're ready.\"" CR>)>>    

<ROUTINE STRIP-EQUIPMENT ("AUX" F N (V <>))
	 <SET F <FIRST? ,PLAYER>>
	 <REPEAT ()
	  <COND (<NOT .F> <RETURN>)>
	  <SET N <NEXT? .F>>
	  <COND (<NOT <==? .F ,WATCH>>
		 <MOVE .F <LOC ,BUNK>>
		 <FCLEAR .F ,WORNBIT>
		 <SET V T>)>
	  <SET F .N>>
	 <COND (.V <TELL ", dropping your equipment">)>>

<ROUTINE INTERRUPT-CHECK (DUR "AUX" C E TICK FOO R)
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SETG ASLEEP T>
	 <REPEAT ()
		 <COND (<==? .C .E> <RETURN>)
		       (<NOT <0? <GET .C ,C-ENABLED?>>>
			<SET TICK <GET .C ,C-TICK>>
			<COND (<0? .TICK>)
			      (T
			       <SET FOO <- .TICK .DUR>>
			       <COND (<L? .FOO 2>
				      <APPLY <GET .C ,C-RTN>>
				      <PUT .C ,C-TICK <- .TICK 1>>)
				     (T <PUT .C ,C-TICK .FOO>)>
			       ;<COND (<AND <NOT <G? .TICK 1>>
				           <SET VAL <APPLY <GET .C ,C-RTN>>>>
				      <COND (,DEBUG
					     <TELL "[Interrupt returning T.]" CR>)>
				      <COND (<OR <NOT .FLG>
						 <==? .VAL ,M-FATAL>>
					     <SET FLG .VAL>)>)>)>)>
		 <SET C <REST .C ,C-INTLEN>>>
	 <SETG ASLEEP <>>>

<GLOBAL ASLEEP <>>

<ROUTINE LE? (LAT LON CNST)
	 <NOT <G? <+ <* .LAT ,LATITUDE-SET> <* .LON ,LONGITUDE-SET>> .CNST>>>

<ROUTINE GE? (LAT LON CNST)
	 <NOT <L? <+ <* .LAT ,LATITUDE-SET> <* .LON ,LONGITUDE-SET>> .CNST>>>

<ROUTINE OCEAN-BOTTOM-FCN ()
	 <COND (<OR <L? ,LONGITUDE-SET 5>
		    <G? ,LONGITUDE-SET 55>
		    <L? ,LATITUDE-SET 5>
		    <G? ,LATITUDE-SET 45>>
		<JIGS-UP
"Your boat is lost in a sudden squall while you sleep.">)
	       (<AND <NOT <G? ,LATITUDE-SET 17>>
		     <LE? 2 -5 -11>
		     <LE? 1 1 30>>
		<RFALSE>)
	       (<AND <NOT <G? ,LATITUDE-SET 6>>
		     <NOT <G? ,LONGITUDE-SET 36>>
		     <NOT <L? ,LONGITUDE-SET 34>>>
		<RFALSE>)
	       (<AND <NOT <G? ,LONGITUDE-SET 34>>
		     <NOT <G? ,LATITUDE-SET 7>>
		     <LE? 1 -1 -26>>
		<RFALSE>)
	       (<GE? 2 1 115>
		<RETURN 400>)
	       (<AND <GE? 1 1 68>
		     <LE? 1 -2 -91>>
		<RETURN 400>)
	       (<OR <NOT <L? ,LATITUDE-SET 40>>
		    <GE? 15 4 680>
		    <GE? 2 1 107>
		    <GE? 1 1 76>
		    <AND <NOT <L? ,LONGITUDE-SET 44>>
			 <GE? 2 1 70>
			 <OR <NOT <L? ,LONGITUDE-SET 52>>
			     <LE? 5 -3 -57>
			     <LE? 1 -1 -31>>>>
	        <RETURN 350>)
	       (<OR <G? ,LATITUDE-SET 37>
		    <GE? 6 1 240>
		    <GE? 13 6 635>
		    <GE? 1 1 72>
		    <AND <NOT <L? ,LONGITUDE-SET 41>>
			 <GE? 13 8 497>
			 <OR <NOT <L? ,LONGITUDE-SET 49>>
			     <LE? 6 -5 -121>
			     <LE? 2 -3 -103>>>>
		<RETURN 300>)
	       (<OR <NOT <L? ,LATITUDE-SET 35>>
		    <GE? 2 -1 57>
		    <GE? 44 15 1810>
		    <GE? 4 3 230>
		    <AND <NOT <L? ,LONGITUDE-SET 37>>
			 <GE? 13 7 415>
			 <OR <NOT <L? ,LONGITUDE-SET 46>>
			     <LE? 3 -2 -32>>>>
		<RETURN 250>)
	       (<OR <AND <NOT <G? ,LATITUDE-SET 19>>
			 <LE? 5 3 131>
			 <LE? 7 6 214>>
		    <AND <NOT <G? ,LATITUDE-SET 7>>
			 <NOT <G? ,LONGITUDE-SET 35>>>
		    <AND <NOT <G? ,LATITUDE-SET 8>>
			 <LE? 2 -1 -16>
			 <LE? 1 1 45>
			 <LE? 2 1 51>>>
		<RETURN 50>)
	       (<OR <AND <NOT <G? ,LATITUDE-SET 20>>
			 <LE? 2 1 50>
			 <LE? 10 7 286>>
		    <AND <NOT <G? ,LATITUDE-SET 9>>
			 <LE? 3 2 99>>>
		<RETURN 100>)
	       (<OR <AND <NOT <G? ,LATITUDE-SET 22>>
			 <OR <LE? 5 3 140>
			     <LE? 7 3 172>>>
		    <AND <NOT <G? ,LATITUDE-SET 10>>
			 <LE? 9 5 270>>>
		<RETURN 150>)
	       (<AND <NOT <G? ,LONGITUDE-SET 29>>
		     <NOT <L? ,LONGITUDE-SET 18>>
		     <NOT <G? ,LATITUDE-SET 24>>
		     <NOT <L? ,LATITUDE-SET 19>>
		     <LE? 9 4 296>
		     <GE? 4 1 102>
		     <GE? 2 1 62>>
		<RETURN 50>)
	       (<AND <NOT <G? ,LATITUDE-SET 28>>
		     <NOT <L? ,LATITUDE-SET 17>>
		     <NOT <G? ,LONGITUDE-SET 34>>
		     <NOT <L? ,LONGITUDE-SET 15>>
		     <LE? 1 -1 11>
		     <GE? 1 1 39>
		     <GE? 5 2 141>
		     <GE? 1 -1 -15>
		     <OR <LE? 4 1 118>
		     	 <LE? 6 5 268>>>
		<RETURN 100>)
	       (<AND <NOT <G? ,LATITUDE-SET 32>>
		     <NOT <L? ,LATITUDE-SET 16>>
		     <NOT <G? ,LONGITUDE-SET 38>>
		     <GE? 5 -3 -19>
		     <GE? 7 3 196>
		     <GE? 3 7 164>
		     <LE? 1 -1 18>
		     <OR <LE? 7 6 344>
			 <LE? 11 4 394>>>
		<RETURN 150>)
	       (T <RETURN 200>)>>

;<ROUTINE V-DEPTH-CHECK ("AUX" DEP LAT LON)
	 <SET LAT 5>
	 <SET LON 5>
	 <REPEAT ()
	  <TELL "Latitude:" N .LAT " Longitude:" N .LON " Depth:">
	  <SETG LATITUDE-SET .LAT>
	  <SETG LONGITUDE-SET .LON>
	  <COND (<SET DEP <OCEAN-BOTTOM-FCN>>
		 <TELL N .DEP>)
		(T <TELL "0">)>
	  <CRLF>
	  <COND (<G? <SET LON <+ .LON 5>> 55>
		 <COND (<G? <SET LAT <+ .LAT 5>> 45>
			<RETURN>)>
		 <SET LON 5>)>>>

;<ROUTINE I-DIVETIME ()
	 <COND (<IN-MOTION? ,JOHNNY>
		<COND (<NOT <EQUAL? <GET <GET ,GOAL-TABLES
					 <GETP ,JOHNNY ,P?CHARACTER>> ,GOAL-F>
				    <META-LOC ,PLAYER>>>
		       <ESTABLISH-GOAL ,JOHNNY <META-LOC ,PLAYER>>)>
		<RFALSE>)>
	 <COND (<EQUAL? ,SHIP-CHOSEN ,TRAWLER>
		<ESTABLISH-GOAL ,WEASEL ,NW-AFT-DECK>)
	       (T <ESTABLISH-GOAL ,WEASEL ,MM-AFT-DECK>)>
	 <DISABLE <INT I-OBSTACLES>>
	 <COND (<IN? ,JOHNNY <META-LOC ,PLAYER>>
		<JOHNNY-SAYS-GO>
		<RFATAL>)
	       (T
		<ESTABLISH-GOAL ,JOHNNY <META-LOC ,PLAYER>>
		<ENABLE <QUEUE I-DIVETIME -1>>
		<RFALSE>)>>

<GLOBAL AT-SEA <>>

<ROUTINE I-HUNGER ("AUX" N)
	 <COND (,ASLEEP <RFALSE>)>
	 <SETG HOW-HUNGRY <+ ,HOW-HUNGRY 1>>
	 <COND (<==? ,HOW-HUNGRY 1>
		<ENABLE <QUEUE I-HUNGER 300>>
		<RFALSE>)
	       (<==? ,HOW-HUNGRY 2>
		<ENABLE <QUEUE I-HUNGER 20>>
		<TELL "You begin to feel hungry." CR>
		<RFALSE>)
	       (<==? ,HOW-HUNGRY 3>
		<ENABLE <QUEUE I-HUNGER 20>>
		<TELL "Your stomach begins to bother you. Better ">
		<COND (<EQUAL? <META-LOC ,PLAYER> <META-LOC ,FOOD>>
		       <TELL "do something about it">)
		      (T <TELL "find some food">)>
		<TELL "!" CR>
		<RFALSE>)
	       (<G? ,HOW-HUNGRY 3>
		<COND (<==? ,HERE ,SHANTY>
		       <SET N 2>)
		      (T <SET N 6>)>
		<ENABLE <QUEUE I-HUNGER .N>>
		<TELL "Your stomach is growling loudly." CR>
		<RFATAL>)>>

<ROUTINE I-THIRST ()
	 <COND (,ASLEEP <RFALSE>)>
	 <SETG HOW-THIRSTY <+ ,HOW-THIRSTY 1>>
	 <COND (<==? ,HOW-THIRSTY 1>
		<ENABLE <QUEUE I-THIRST 110>>
		<TELL "Your throat starts to feel dry." CR>
		<RFALSE>)
	       (<==? ,HOW-THIRSTY 2>
		<ENABLE <QUEUE I-THIRST 115>>
		<TELL "You feel fairly thirsty." CR>
		<RFALSE>)
	       (<==? ,HOW-THIRSTY 3>
		<ENABLE <QUEUE I-THIRST 15>>
		<TELL-YOUD-BETTER "find something to drink soon!">
		<RFALSE>)
	       (<G? ,HOW-THIRSTY 3>
		<ENABLE <QUEUE I-THIRST 4>>
		<TELL "You lick your lips and clear your throat." CR>
		<RFATAL>)>>

<GLOBAL HOW-THIRSTY 0>

<ROUTINE I-TIRED ()
	 <COND (,ASLEEP <RFALSE>)
	       (<L? ,HOW-TIRED 6>
		<SETG HOW-TIRED <+ ,HOW-TIRED 1>>)>
	 <COND (<==? ,HOW-TIRED 1>
		<ENABLE <QUEUE I-TIRED 479>>
		<RFALSE>)
	       (<==? ,HOW-TIRED 2>
		<ENABLE <QUEUE I-TIRED 1>>
		<RFALSE>)
	       (<==? ,HOW-TIRED 3>
		<ENABLE <QUEUE I-TIRED 30>>
		<TELL "You yawn as you begin to feel drowsy." CR>)
	       (<==? ,HOW-TIRED 4>
		<ENABLE <QUEUE I-TIRED 20>>
		<TELL "You are starting to feel tired." CR>
		<RFALSE>)
	       (<==? ,HOW-TIRED 5>
		<ENABLE <QUEUE I-TIRED 10>>
		<TELL 
"You yawn and feel very tired. Think about going to bed." CR>)
	       (<==? ,HOW-TIRED 6>
		<TELL
"Exhaustion overwhelms you. Keeping your eyes open is painful.">
		<COND (<NOT ,AT-SEA>
		       <TELL " ">
		       <V-SLEEP>)
		      (T
		       <ENABLE <QUEUE I-TIRED 6>>
		       <CRLF>)>
		<RFATAL>)>>

;<ROUTINE I-OBSTACLES ("AUX" (UPFRONT? <>))
	 <SETG O-CTR <+ ,O-CTR 1>>
	 <COND (<AND <EQUAL? <META-LOC ,PLAYER> ,MM-FORE-DECK ,NW-FORE-DECK>
		     <NOT ,ASLEEP?>>
		<SET UPFRONT? T>)>;"Historical note: The compiler sucks."
	 <COND (<==? ,O-CTR 1>
		<ENABLE <QUEUE I-OBSTACLES -1>>
		<SETG O-NUM <RANDOM 3>>
		<SETG O-SIDE <RANDOM 2>>
		<COND (<QUEUED? I-USELESS-TURN>
		       <I-USELESS-TURN>)>
		<COND (.UPFRONT?
		       <OPRINT>
		       <RFATAL>)>)
	       (<==? ,O-CTR 2>
		<COND (.UPFRONT?
		       <OPRINT>
		       <COND (<AND ,ON-WATCH
				   <NOT <EQUAL? ,ON-WATCH ,PLAYER>>>
			      <SETG BUTTON-PUSHED ,O-SIDE>
			      <START-SENTENCE ,ON-WATCH>
			      <TELL " pushes the button to his ">
			      <COND (<==? ,O-SIDE 1>
				     <TELL "left">)
				    (T <TELL "right">)>
			      <TELL "." CR>)
			     (T <RFATAL>)>
		       <RTRUE>)
		      (<AND ,ON-WATCH
			    <NOT <EQUAL? ,ON-WATCH ,PLAYER>>>
		       <SETG BUTTON-PUSHED ,O-SIDE>
		       <COND (<AND <EQUAL? ,HERE ,MM-WHEELHOUSE ,NW-WHEELHOUSE>
			           <G? ,BUTTON-PUSHED 0>>
		       	      <TELL 
"A tone sounds. Johnny spins the wheel ">
		       	      <COND (<==? ,BUTTON-PUSHED 1> <TELL "right">)
			     	    (T <TELL "left">)>
		       	      <TELL "." CR>)>)>)
	       (<G? ,O-CTR 2>
		<COND (.UPFRONT?
		       <COND (<==? ,BUTTON-PUSHED 0>
			      <TELL 
"You watch in horror as the " D ,SHIP-CHOSEN " collides with" <OPRINT> "! ">
			      <JIGS-UP
"As the boat rapidly sinks, you see several sharks in the area. Mercifully,
you black out before you meet your fate.">)
			     (T
			      <TELL "The boat veers to ">
			      <COND (<==? ,BUTTON-PUSHED 1> <TELL "starboard">)
				    (T <TELL "port">)>
			      <COND (<==? ,O-SIDE ,BUTTON-PUSHED>
				     <SETG BUTTON-PUSHED 0>
				     <TELL ", away from" <OPRINT> "." CR>
				     <SETG O-CTR 0>
				     <ENABLE <QUEUE I-OBSTACLES
						    <+ 15 <RANDOM 130>>>>
				     <RTRUE>)
				    (T <TELL
". Unfortunately, this puts you directly on a collision course! ">
				     <SETG BUTTON-PUSHED 0>
				     <I-OBSTACLES>)>)>)
		      (<NOT <EQUAL? ,O-SIDE ,BUTTON-PUSHED>>
			    <TELL
"You feel the boat list to ">
			    <COND (<==? ,O-SIDE 1> <TELL "port">)
				  (T <TELL "starboard">)>
			    <JIGS-UP
", and then start to sink! The water rises before you can respond.">)
		      (T
		       <SETG O-CTR 0>
		       <SETG BUTTON-PUSHED 0>
		       <ENABLE <QUEUE I-OBSTACLES <+ 15 <RANDOM 130>>>>
		       <COND (<AND <NOT <EQUAL? ,ON-WATCH ,WEASEL>>
				   <0? ,WATCH-CHANGE-CTR>>
			      <COND (<EQUAL? ,SHIP-CHOSEN ,SALVAGER>
				     <COND (<IN? ,WEASEL ,MM-ENGINE-ROOM>
					    <ESTABLISH-GOAL ,WEASEL
							    ,MM-CREW-QTRS>)
				    	   (T <ESTABLISH-GOAL ,WEASEL
							    ,MM-ENGINE-ROOM>)>)
				    (T
				     <COND (<IN? ,WEASEL ,NW-ENGINE-ROOM>
					    <ESTABLISH-GOAL ,WEASEL
							    ,NW-CREW-QTRS>)
					   (T <ESTABLISH-GOAL ,WEASEL
							 ,NW-ENGINE-ROOM>)>)>)>
		       <COND (<AND <NOT <EQUAL? ,ON-WATCH ,PETE>>
				   <0? ,WATCH-CHANGE-CTR>>
			      <COND (<IN? ,PETE <LOC ,DRINKING-WATER>>
				     <ESTABLISH-GOAL ,PETE <LOC ,BUNK>>)
				    (T
				 <ESTABLISH-GOAL ,PETE <LOC ,DRINKING-WATER>>)>
			      ;<COND (<EQUAL? ,SHIP-CHOSEN ,SALVAGER>
				     <COND (<IN? ,PETE ,MM-GALLEY>
					    <ESTABLISH-GOAL ,PETE
							    ,MM-CREW-QTRS>)
				    	   (T <ESTABLISH-GOAL ,PETE
							      ,MM-GALLEY>)>)
				    (T
				     <COND (<IN? ,PETE ,NW-GALLEY>
					    <ESTABLISH-GOAL ,PETE
							    ,NW-CREW-QTRS>)
					   (T <ESTABLISH-GOAL ,PETE
							      ,NW-GALLEY>)>)>)>
		       <RFALSE>)>)>>

;<ROUTINE OPRINT ("AUX" SIDE)
	 <COND (<==? ,O-SIDE 1> <SET SIDE "port">)
	       (T <SET SIDE "starboard">)>
	 <COND (<==? ,O-NUM 1>
		<COND (<==? ,O-CTR 1>
		       <TELL
"Some debris approaches the " .SIDE " bow of the boat!" CR>)
		      (<==? ,O-CTR 2>
		       <TELL
"To " .SIDE ", some floating wreckage heads for the boat!" CR>)
		      (<VERB? WALK> <RETURN " some debris">)
		      (T <RETURN " the debris">)>)
	       (<==? ,O-NUM 2>
		<COND (<==? ,O-CTR 1>
		       <TELL
"You can see a coral reef ahead and off the " .SIDE " bow!" CR>)
		      (<==? ,O-CTR 2>
		       <TELL
"A large, jagged coral reef looms ahead and to " .SIDE "!" CR>)
		      (<VERB? WALK> <RETURN " a coral reef">)
		      (T <RETURN " the coral reef">)>)
	       (<==? ,O-NUM 3>
		<COND (<==? ,O-CTR 1>
		       <TELL
"To " .SIDE ", a boat on a collision course approaches!" CR>)
		      (<==? ,O-CTR 2>
		       <TELL
"A boat comes directly at your " .SIDE " bow!" CR>)
		      (<VERB? WALK> <RETURN " a boat">)
		      (T <RETURN " the boat">)>)>>

;<GLOBAL ON-WATCH <>>

;<GLOBAL O-NUM 0>

;<GLOBAL O-SIDE 0>

;<GLOBAL O-CTR 0>

;<GLOBAL BUTTON-PUSHED 0>

;<GLOBAL USELESS-TURNS 0>

;<ROUTINE I-USELESS-TURN ("AUX" (V <>))
	 <COND (<NOT ,AT-SEA>
		<SETG BUTTON-PUSHED 0>
		<DISABLE <INT I-USELESS-TURN>>
		<RFALSE>)>
	 <SETG USELESS-TURNS <+ ,USELESS-TURNS 1>>
	 <COND (<G? ,O-CTR 1>
		<RFALSE>)
	       (<AND <VERB? PUSH>
		     <PRSO? ,LEFT-BUTTON ,RIGHT-BUTTON>>
		T)
	       (T
		<COND (<AND <EQUAL? <META-LOC ,PLAYER> ,MM-FORE-DECK
				    		       ,NW-FORE-DECK>
			    <NOT ,ASLEEP?>>
		       <TELL "The boat veers to ">
		       <COND (<==? ,BUTTON-PUSHED 1> <TELL "starboard">)
		      	     (T <TELL "port">)>
		       <TELL "." CR>
		       <SET V T>)>
	 	<SETG BUTTON-PUSHED 0>)>
	 <DISABLE <INT I-USELESS-TURN>>
	 .V>

;<ROUTINE I-CHANGE-WATCH ("AUX" NEXT-UP (V <>))
	 <COND (<AND <G? ,O-CTR 0>
		     ,ON-WATCH>
		<COND (<NOT <QUEUED? I-CHANGE-WATCH>>
		       <ENABLE <QUEUE I-CHANGE-WATCH 1>>)>
		<RFALSE>)>
	 <SET NEXT-UP <GET ,WATCH-TABLE ,WT-PERSON>>
	 <COND (<==? .NEXT-UP ,PLAYER>
		<COND (<IN? ,PLAYER <LOC ,DECK-CHAIR>>
		       <COND (<AND ,ON-WATCH
				   <NOT <==? ,ON-WATCH ,PLAYER>>
				   <NOT ,SEARCHER>>
			      <SET V T>
			      <START-SENTENCE ,ON-WATCH>
		       	      <TELL
" says to you, \"Your watch,\" stands, then goes down the ladder." CR>
		       	      <MOVE ,ON-WATCH <LOC ,BUNK>>)>
		       <SETG ON-WATCH ,PLAYER>
		       <COND (<NOT ,SEARCHER>
			      <SET-NEXT-WATCH>
			      <RETURN .V>)>)>
		<SETG WATCH-CHANGE-CTR <+ ,WATCH-CHANGE-CTR 1>>
		<COND (<==? ,WATCH-CHANGE-CTR 1>
		       <ENABLE <QUEUE I-CHANGE-WATCH -1>>
		       <COND (<EQUAL? <META-LOC ,PLAYER> ,MM-CREW-QTRS
				      			 ,NW-CREW-QTRS>
			      <COND (,ASLEEP?
				     <TELL "You are awakened by ">)
				    (T <TELL "You hear ">)>
			      <TELL
D ,ON-WATCH " yelling down that it's your watch." CR>)
			     (<AND <GLOBAL-IN? ,RAILING ,HERE>
				   <NOT <IN? ,DECK-CHAIR ,HERE>>>
			      <TELL
"You hear " D ,ON-WATCH " yelling that it's your watch." CR>)>)
		      (<==? ,WATCH-CHANGE-CTR 5>
		       <COND (<EQUAL? <META-LOC ,PLAYER> ,MM-CREW-QTRS
				      			 ,NW-CREW-QTRS>
			      <RFALSE>)>
		       <SETG SEARCHER ,ON-WATCH>
		       <SETG ON-WATCH <>>
		       <MOVE ,SEARCHER <LOC ,DECK-CHAIR>>
		       <ESTABLISH-GOAL ,SEARCHER <META-LOC ,PLAYER>>
		       <RFALSE>)
		      (<G? ,WATCH-CHANGE-CTR 5>
		       <COND (<EQUAL? ,ON-WATCH ,PETE ,WEASEL>
			      <MOVE ,ON-WATCH <META-LOC ,PLAYER>>
			      <SETG QCONTEXT ,ON-WATCH>
			      <SETG QCONTEXT-ROOM <META-LOC ,PLAYER>>
			      <COND (<IN? ,PLAYER ,BUNK>
				     <TELL
"A hand shakes you. \"Get up and get topside!\" " D ,ON-WATCH " says.
\"You're on watch!\"" CR>)
				    (T
				     <START-SENTENCE ,ON-WATCH>
				     <TELL
" walks in. \"Get to the foredeck!\" he says. \"It's your watch!\"" CR>)>
			      <SETG ON-WATCH <>>
			      <RTRUE>)
			     (<NOT ,SEARCHER> <RFALSE>)
			     (<NOT <EQUAL? <GET <GET ,GOAL-TABLES
						<GETP ,SEARCHER ,P?CHARACTER>>
					   ,GOAL-F>
					   <META-LOC ,PLAYER>>>
			      <ESTABLISH-GOAL ,SEARCHER <META-LOC ,PLAYER>>
			      <RFALSE>)>)>)
	       (T
		<SETG WATCH-CHANGE-CTR <+ ,WATCH-CHANGE-CTR 1>>
		<COND (<==? ,WATCH-CHANGE-CTR 1>
		       <ENABLE <QUEUE I-CHANGE-WATCH -1>>
		       <COND (<AND <EQUAL? <META-LOC ,PLAYER> ,MM-CREW-QTRS
				     			      ,NW-CREW-QTRS>
				   <NOT <EQUAL? ,ON-WATCH ,PLAYER>>>
			      <COND (,ASLEEP?
				     <TELL "You are awakened by ">)
				    (T <TELL "You hear ">)>
			      <TELL
D ,ON-WATCH " yelling to " D .NEXT-UP " that it's his watch." CR>
			      <SET V T>)>
		       <ESTABLISH-GOAL .NEXT-UP <LOC ,DECK-CHAIR>>
		       .V)
		      (<IN? .NEXT-UP <LOC ,DECK-CHAIR>>
		       <COND (<==? ,ON-WATCH ,PLAYER>
			      <COND (<IN? ,PLAYER ,DECK-CHAIR>
				     <SETG QCONTEXT .NEXT-UP>
				     <SETG QCONTEXT-ROOM <LOC ,DECK-CHAIR>>
				     <TELL-COMES-UP .NEXT-UP>
				     <TELL "\"Get up and I'll relieve you.\"" CR>)
				    (T
				     <SETG ON-WATCH .NEXT-UP>
				     <MOVE ,ON-WATCH ,DECK-CHAIR>
				     <COND (<L? ,HOW-TIRED 2>
					    <SETG HOW-TIRED 2>)>
				     <SET-NEXT-WATCH>
				     <COND (<IN? ,PLAYER <LOC ,DECK-CHAIR>>
					    <START-SENTENCE ,ON-WATCH>
					    <TELL " sits in the chair." CR>)>)>)
			     (T
			      <COND (<IN? ,PLAYER <LOC ,DECK-CHAIR>>
				     <START-SENTENCE .NEXT-UP>
				     <TELL
" comes up and says to " D ,ON-WATCH ", \"I'm here to stand watch.\" ">
				     <START-SENTENCE ,ON-WATCH>
				     <TELL
" gets up and " D .NEXT-UP " sits in the lookout's chair." CR>
				     <SET V T>)>
			      <MOVE ,ON-WATCH <LOC ,DECK-CHAIR>>
			      <MOVE .NEXT-UP ,DECK-CHAIR>
			      <COND (<==? ,SHIP-CHOSEN ,SALVAGER>
				     <ESTABLISH-GOAL ,ON-WATCH ,MM-GALLEY>)
				    (T <ESTABLISH-GOAL ,ON-WATCH ,NW-GALLEY>)>
			      <SETG ON-WATCH .NEXT-UP>
			      <SET-NEXT-WATCH>
			      .V)>)>)>>

;<ROUTINE SET-NEXT-WATCH ("AUX" NEXT-TIME)
	 <SETG WATCH-CHANGE-CTR 0>
	 <COND (<GET ,WATCH-TABLE ,WT-NEXT>
		<COND (<L? <SET NEXT-TIME <GET ,WATCH-TABLE ,WT-TIME>>
			   ,PRESENT-TIME>
		       <SET NEXT-TIME <+ .NEXT-TIME 1440>>)>
		<ENABLE <QUEUE I-CHANGE-WATCH <- .NEXT-TIME ,PRESENT-TIME>>>
	 	<SETG WATCH-TABLE <REST ,WATCH-TABLE ,WT-REST>>)
	       (T
		<DISABLE <INT I-CHANGE-WATCH>>
		<ENABLE <QUEUE I-DIVETIME <+ 165 <RANDOM 15>>>>)>>	 

;<GLOBAL SEARCHER <>>

;<GLOBAL WATCH-CHANGE-CTR 0>

;<GLOBAL WATCH-TABLE
	<TABLE WEASEL     1075
	       PETE       1255
	       ADVENTURER 1435
	       WEASEL     175
	       PETE       355
	       0>>

;<CONSTANT WT-PERSON 0>
;<CONSTANT WT-TIME 1>
;<CONSTANT WT-REST 4>
;<CONSTANT WT-NEXT 2>

<ROUTINE I-SQUID ("AUX" (L <LOC ,SQUID>))
	 <COND (<==? <META-LOC ,PLAYER> .L>
		<JIGS-UP
"The giant squid stirs and sees what disturbed it. When the huge eyes spot
you, it moves toward you and hugs you with its tentacles. You squirm in an
attempt to get away, but more arms surround you and one disconnects your
airhose.">)
	       (T
		<DISABLE <INT I-SQUID>>
		<RFALSE>)>>

<ROUTINE I-SHARK ()
	 <COND (<L? <GETP ,HERE ,P?LINE> ,UNDERWATER-LINE-C>
		<DISABLE <INT I-SHARK>>
		<MOVE ,SHARK ,LOCAL-GLOBALS>
		<FCLEAR ,SHARK ,ONBIT>
		<RFALSE>)
	       (<IN? ,SHARK ,UNDERWATER>
		<COND (<AND <IN? ,SHARK-REPELLENT ,PLAYER>
			    <FSET? ,SHARK-REPELLENT ,OPENBIT>>
		       <MOVE ,SHARK ,WINDING-ROAD-2>;"now useless location"
		       <DISABLE <INT I-SHARK>>
		       <COND (<NOT ,LIT>
			      <RFALSE>)
			     (<FSET? ,SHARK ,ONBIT>
			      <TELL "The shark continues">)
			     (T <TELL "A shark swims">)>
		       <TELL
" toward you, then stops. It turns and swims away." CR>)
		      (T
		       <COND (<FSET? ,SHARK ,ONBIT>
			      <TELL "The shark">)
			     (,LIT <TELL "A shark">)
			     (T <TELL "Something">)>
		       <JIGS-UP " swims up to you and starts nibbling.">)>)
	       (T
		<MOVE ,SHARK ,UNDERWATER>
		<ENABLE <QUEUE I-SHARK -1>>
		<COND (,LIT
		       <FSET ,SHARK ,ONBIT>
		       <TELL "A shark swims toward you!" CR>)>)>>

<ROUTINE I-PLUMMET ()
	 <SETG CRIMP-CTR <+ ,CRIMP-CTR 1>>
	 <COND (<==? ,CRIMP-CTR 1>
		<ENABLE <QUEUE I-PLUMMET -1>>
		<COND (<GLOBAL-IN? ,FALLEN-BUNK ,HERE>
		       <SETG P-IT-OBJECT ,FALLEN-BUNK>
		       <TELL
"The row of bunks you moved starts to fall." CR>)>)
	       (<==? ,CRIMP-CTR 2>
		<COND (<GLOBAL-IN? ,FALLEN-BUNK ,HERE>
		       <SETG P-IT-OBJECT ,FALLEN-BUNK>
		       <TELL "The row of bunks falls toward the doorway">
		       <COND (<EQUAL? ,HERE ,WRECK-8>
			      <TELL
			       ", threatening to pinch your " D ,AIR-HOSE "!">)
			     (T <TELL ".">)>
		       <CRLF>)>)
	       (<==? ,CRIMP-CTR 3>
		<COND (<GLOBAL-IN? ,FALLEN-BUNK ,HERE>
		       <COND (<EQUAL? ,HERE ,WRECK-8>
			      <JIGS-UP
"The row of fallen bunks pinches your airhose. A few moments later,
it is impossible to breathe.">)
			     (T
			      <SETG BUNKS-MOVED <>>
			      <SETG P-IT-OBJECT ,FALLEN-BUNK>
			      <TELL
"The bunks fall back into the doorway, blocking the passage." CR>)>)
		      (<OR <EQUAL? ,HERE ,WRECK-1 ,WRECK-2 ,WRECK-3>
			   <EQUAL? ,HERE ,WRECK-4 ,WRECK-5 ,WRECK-6>
			   <EQUAL? ,HERE ,UNDERWATER>>
		       <SETG BUNKS-MOVED <>>
		       <RFALSE>)
		      (T
		       <JIGS-UP
"You find yourself gasping for air, but there's none to breathe!">)>)>>

<GLOBAL CRIMP-CTR 0>

<ROUTINE I-LIVER ()
	 <COND (<G? ,BLOOD-ALCOHOL 0>
		<SETG BLOOD-ALCOHOL <- ,BLOOD-ALCOHOL 1>>)>
	 <COND (<G? ,SLOSH-CTR 0>
		<SETG SLOSH-CTR <- ,SLOSH-CTR 1>>)>
	 <ENABLE <QUEUE I-LIVER 10>>
	 <COND (<G? ,BLOOD-ALCOHOL 15>
	        <TELL "Your head swims for a minute." CR>
		<RFATAL>)>
	 <RFALSE>>

<ROUTINE I-PENDULUM ("AUX" (DIR <>))
	 <QUEUE I-PENDULUM -2>
	 <COND (<==? ,LINE-LOC 5>
		<SETG LINE-LOC-INC -1>)
	       (<==? ,LINE-LOC 1>
		<SETG LINE-LOC-INC 1>)
	       (<IN? ,SAFETY-LINE <META-LOC ,PLAYER>>
		<COND (<EQUAL? ,LINE-LOC-INC 1>
		       <SET DIR "north">)
		      (T <SET DIR "south">)>)>
	 <SETG LINE-LOC <+ ,LINE-LOC ,LINE-LOC-INC>>
	 <COND (<==? ,LINE-LOC 2>
		<MOVE ,SAFETY-LINE ,WEST-OF-WRECK-9>
		<COND (<==? ,HERE ,WEST-OF-WRECK-9>
		       <TELL-LINE-SWINGS>)>)
	       (<==? ,LINE-LOC 4>
		<MOVE ,SAFETY-LINE ,WEST-OF-WRECK-11>
		<COND (<==? ,HERE ,WEST-OF-WRECK-11>
		       <TELL-LINE-SWINGS>)>)
	       (T
		<MOVE ,SAFETY-LINE ,LOCAL-GLOBALS>
		<COND (.DIR
		       <TELL "The line swings away to the " .DIR "." CR>)>)>>

<ROUTINE TELL-LINE-SWINGS ()
	 <TELL "The " D ,SAFETY-LINE " from above swings in from the ">
	 <COND (<EQUAL? ,LINE-LOC-INC 1>
		<TELL "south">)
	       (T <TELL "north">)>
	 <TELL "." CR>>

<GLOBAL LINE-LOC 1>
<GLOBAL LINE-LOC-INC 1>

<ROUTINE I-CASE-LEAK ("AUX" (ALREADY <>))
	 <SETG WATER-IN-CASE <+ ,WATER-IN-CASE 1>>
	 <COND (<G? ,WATER-IN-CASE 9>
		<COND (<FSET? ,STAMPS ,RMUNGBIT>
		       <SET ALREADY T>)>
		<FSET ,STAMPS ,RMUNGBIT>
		<DISABLE <INT I-CASE-LEAK>>)>
	 <COND (<IN? ,GLASS-CASE ,PLAYER>
		<TELL "The water level in the " D ,GLASS-CASE " rises.">
		<COND (<AND <FSET? ,STAMPS ,RMUNGBIT>
			    <NOT .ALREADY>>
		       <TELL " As it reaches the stamps, it soaks them.">)>
		<CRLF>)>>

<GLOBAL WATER-IN-CASE 0>

<ROUTINE I-DRILL ()
	 <FSET ,BATTERY ,RMUNGBIT>
	 <SETG DRILL-POWERED <>>
	 <DISABLE <INT I-DRILL>>
	 <TELL "The " D ,DRILL " sputters, and the bit stops turning." CR>>

<ROUTINE I-AIR-SUPPLY ()
	 <COND (<AND <==? <GETP ,HERE ,P?LINE> ,UNDERWATER-LINE-C>
		     <IN? ,AIR-TANK ,PLAYER>
		     <NOT <AIRTIGHT-ROOM?>>>
		<SETG AIR-LEFT <- ,AIR-LEFT </ <+ ,DEPTH 33> 44>>>
		<COND (<L? ,AIR-LEFT 1>
		       <JIGS-UP "You've used all your air.">)
		      (<L? ,AIR-LEFT 15>
		       <TELL "Your air supply is dangerously low." CR>
		       <COND (<==? ,WAITED? 1>
			      <RTRUE>)
			     (T <RFATAL>)>)>)>>

<ROUTINE I-MM-COMPRESSOR ()
	 <ENABLE <QUEUE I-LAST-GASP 10>>
	 <COND (<==? <GETP ,HERE ,P?LINE> ,UNDERWATER-LINE-C>
		<TELL
"You have to breathe harder. Maybe you'd better surface." CR>
		<RFATAL>)>>

<ROUTINE I-LAST-GASP ()
	 <COND (<==? <GETP ,HERE ,P?LINE> ,UNDERWATER-LINE-C>
		<JIGS-UP
"There's not enough air to breathe!">)
	       (T
		<DISABLE <QUEUE I-LAST-GASP 1>>)>>

<ROUTINE I-PLOT-NEVER-STARTS ()
	 <DISABLE <INT I-JOHNNY>>
	 <DISABLE <INT I-PETE>>
	 <COND (<IN? ,WEASEL ,SHANTY>
		<DISABLE <INT I-WEASEL>>)>
	 <SETG FM-CTR 5>
	 <RFALSE>>

<ROUTINE I-ENDIT ()
	 <COND (<L? <GETP ,HERE ,P?LINE> ,UNDERWATER-LINE-C>
		<JIGS-UP
"You suddenly find Red's hands around your throat as he makes a comment
about hating cowards and Hevlin being wrong.">)>>