"VERBS for
			      TOA #2
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved.
"

"SUBTITLE DESCRIBE THE UNIVERSE"

"SUBTITLE SETTINGS FOR VARIOUS LEVELS OF DESCRIPTION"

<GLOBAL VERBOSE <>>
<GLOBAL SUPER-BRIEF <>>
<GDECL (VERBOSE SUPER-BRIEF) <OR ATOM FALSE>>

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSE T>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Maximum verbosity." CR CR>
	 <V-LOOK>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSE <>>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Brief descriptions." CR>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG SUPER-BRIEF T>
	 <TELL "Super-brief descriptions." CR>>

\

"SUBTITLE DESCRIBERS"

;<ROUTINE V-RNAME ()
	 <TELL D ,HERE CR>>

;<ROUTINE V-OBJECTS ()
	 <DESCRIBE-OBJECTS T>>

;<ROUTINE V-ROOM ()
	 <DESCRIBE-ROOM T>>

<ROUTINE V-LOOK ()
	 <COND (<DESCRIBE-ROOM T>
		<DESCRIBE-OBJECTS T>)>>

<ROUTINE V-FIRST-LOOK ()
	 <COND (<DESCRIBE-ROOM>
		<COND (<NOT ,SUPER-BRIEF> <DESCRIBE-OBJECTS>)>)>>

<ROUTINE PRE-EXAMINE ()
	 <COND (<AND <NOT ,LIT>
		     <FSET? ,PRSO ,READBIT>>
		<PERFORM ,V?READ ,PRSO>
		<RTRUE>)>>

<ROUTINE V-EXAMINE ()
	 <COND (<GETP ,PRSO ,P?TEXT>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
	       (<OR <FSET? ,PRSO ,CONTBIT>
		    <FSET? ,PRSO ,DOORBIT>>
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)
	       (T
		<TELL "I see nothing special about ">
		<THE? ,PRSO>
		<TELL D ,PRSO "." CR>)>>

<GLOBAL LIT <>>

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? STR (AV <>))
	 <SET V? <OR .LOOK? ,VERBOSE>>
	 <COND (<NOT ,LIT>
		<TELL-TOO-DARK>
		<RETURN <>>)>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<FSET ,HERE ,TOUCHBIT>
		<SET V? T>)>
	 <COND (<IN? ,HERE ,ROOMS>
		<TELL D ,HERE>
		<COND (<FSET? <SET AV <LOC ,WINNER>> ,VEHBIT>
		       <TELL ", " <VEHPREP .AV> " the " D .AV>)>
		<CRLF>)>
	 <COND (<OR .LOOK? <NOT ,SUPER-BRIEF>>
		<COND (<AND .V? <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <RTRUE>)
		      (<AND .V? <SET STR <GETP ,HERE ,P?LDESC>>>
		       <TELL .STR CR>)>
		<APPLY <GETP ,HERE ,P?ACTION> ,M-FLASH>
		<COND (<AND .AV <NOT <==? ,HERE .AV>> <FSET? .AV ,VEHBIT>>
		       <APPLY <GETP .AV ,P?ACTION> ,M-LOOK>)>)>
	 <COND (<GETP ,HERE ,P?CORRIDOR> <CORRIDOR-LOOK>)>
	 T>

<ROUTINE VEHPREP (VEH)
	 <COND (<FSET? .VEH ,SURFACEBIT>
		<RETURN "on">)
	       (T <RETURN "in">)>>

<ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (V? <>))
	 <COND (,LIT
		<COND (<FIRST? ,HERE>
		       <PRINT-CONT ,HERE <SET V? <OR .V? ,VERBOSE>> -1>)>)
	       (ELSE
		<TELL "I can't see anything in the dark." CR>)>>

"DESCRIBE-OBJECT -- takes object and flag.  if flag is true will print a
long description (fdesc or ldesc), otherwise will print short."

<GLOBAL DESC-OBJECT <>>

<ROUTINE DESCRIBE-OBJECT (OBJ V? LEVEL "AUX" (STR <>) AV)
	 <SETG DESC-OBJECT .OBJ>
	 <COND (<AND <0? .LEVEL>
		     <APPLY <GETP .OBJ ,P?DESCFCN> ,M-OBJDESC>>
		<RTRUE>)
	       (<AND <0? .LEVEL>
		     <OR <AND <NOT <FSET? .OBJ ,TOUCHBIT>>
			      <SET STR <GETP .OBJ ,P?FDESC>>>
			 <SET STR <GETP .OBJ ,P?LDESC>>>>
		<TELL .STR>)
	       (<0? .LEVEL>
		<TELL "There is " A .OBJ " here.">)
	       (ELSE
		<TELL <GET ,INDENTS .LEVEL>>
		<TELL "A">
		<VOWEL? .OBJ>
		<TELL D .OBJ>
		<COND (<AND <FSET? .OBJ ,WORNBIT>
			    <IN? .OBJ ,WINNER>>
		       <TELL " (being worn)">)>
		;<COND (<AND <FLAMING? .OBJ>
			    <NOT <EQUAL? .OBJ ,MANY-MATCHES>>>
		       <TELL " (lit and burning)">)>
		;<COND (<AND <EQUAL? .OBJ ,ROPE> ,ROPE-TIED>
		       <TELL " (tied to the " D ,ROPE-TIED ")">)>)>
	 ;<COND (<AND <0? .LEVEL>
		     <SET AV <LOC ,WINNER>>
		     <FSET? .AV ,VEHBIT>>
		<TELL " (outside the " D .AV ")">)>
	 <CRLF>
	 <COND (<AND <SEE-INSIDE? .OBJ> <FIRST? .OBJ>>
		<PRINT-CONT .OBJ .V? .LEVEL>)>>

<ROUTINE PRINT-CONT (OBJ "OPTIONAL" (V? <>) (LEVEL 0) "AUX" Y 1ST? AV STR
		     (PV? <>) (INV? <>) (FLG <>))
	 <COND (<NOT <SET Y <FIRST? .OBJ>>> <RTRUE>)>
	 <COND (<AND <SET AV <LOC ,WINNER>> <FSET? .AV ,VEHBIT>>
		T)
	       (ELSE <SET AV <>>)>
	 <SET 1ST? T>
	 <COND (<EQUAL? ,WINNER .OBJ <LOC .OBJ>>
		<SET INV? T>)
	       (ELSE
		<REPEAT ()
			<COND (<NOT .Y> <RETURN <NOT .1ST?>>)
			      (<==? .Y .AV> <SET PV? T>)
			      (<==? .Y ,WINNER>)
			      (<AND <NOT <FSET? .Y ,INVISIBLE>>
				    <NOT <FSET? .Y ,TOUCHBIT>>
				    <SET STR <GETP .Y ,P?FDESC>>
				    <NOT <GETP .Y ,P?DESCFCN>>>
			       <COND (<NOT <FSET? .Y ,NDESCBIT>>
				      <TELL .STR CR>
				      <SET FLG T>
				      ;<SETG P-IT-OBJECT .Y>)>
			       <COND (<AND <SEE-INSIDE? .Y>
					   <NOT <GETP <LOC .Y> ,P?DESCFCN>>
					   <FIRST? .Y>>
				      <PRINT-CONT .Y .V? 0>)>)>
			<SET Y <NEXT? .Y>>>)>
	 <SET Y <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .Y>
			<COND (<AND .PV? .AV <FIRST? .AV>>
			       <PRINT-CONT .AV .V? .LEVEL>)>
			<RETURN <NOT .1ST?>>)
		       (<EQUAL? .Y .AV ,ADVENTURER>)
		       (<AND <NOT <FSET? .Y ,INVISIBLE>>
			     <OR .INV?
				 <FSET? .Y ,TOUCHBIT>
				 <GETP .Y ,P?DESCFCN>
				 <NOT <GETP .Y ,P?FDESC>>>>
			<COND (<NOT <FSET? .Y ,NDESCBIT>>
			       <COND (.1ST?
				      <COND (<FIRSTER .OBJ .LEVEL>
					     <SET FLG T>
					     <COND (<L? .LEVEL 0>
						    <SET LEVEL 0>)>)>
				      <SET LEVEL <+ 1 .LEVEL>>
				      <SET 1ST? <>>)>
			       <DESCRIBE-OBJECT .Y .V? .LEVEL>
			       ;<SETG P-IT-OBJECT .Y>)
			      (<AND <NOT <GETP .Y ,P?DESCFCN>>
				    <FIRST? .Y>
				    <SEE-INSIDE? .Y>>
			       <PRINT-CONT .Y .V? .LEVEL>)>)>
		 <SET Y <NEXT? .Y>>>
	 .FLG>

<ROUTINE FIRSTER (OBJ LEVEL "AUX" F)
	 <COND (<==? .OBJ ,WINNER>
		<TELL "You are carrying:" CR>)
	       (<NOT <IN? .OBJ ,ROOMS>>
		<COND (<G? .LEVEL 0>
		       <TELL <GET ,INDENTS .LEVEL>>)>
		<COND (<==? .OBJ ,MAGNET>
		       <TELL "The " D .OBJ " is touching">)
		      (<FSET? .OBJ ,SURFACEBIT>
		       <TELL "Sitting on the " D .OBJ>
		       <SET F <FIRST? .OBJ>>
		       <COND (<NEXT? .F> <TELL " are">)
			     (T <TELL" is">)>)
		      (ELSE
		       <TELL "The " D .OBJ " contains">)>
		<TELL ":" CR>)>>

"SUBTITLE SCORING"

;<GLOBAL MOVES 0>
<GLOBAL RATING 0>
<GLOBAL BASE-RATING 0>

;<GLOBAL WON-FLAG <>>

<GLOBAL RATING-MAX 250>

<ROUTINE RATING-UPD (NUM)
	 <SETG BASE-RATING <+ ,BASE-RATING .NUM>>
	 <SETG RATING <+ ,RATING .NUM>>
	 T>

<ROUTINE RATING-OBJ (OBJ "AUX" TEMP)
	 <COND (<GETP .OBJ ,P?VALUE>
		<COND (<G? <SET TEMP <GETP .OBJ ,P?VALUE>> 0>
		       <RATING-UPD .TEMP>
		       <PUTP .OBJ ,P?VALUE 0>)>)
	       (T <RTRUE>)>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	 <TELL "Your score is " N ,RATING>
	 <TELL " out of a possible " N ,RATING-MAX ".">
	 <CRLF>
	 <TELL
"This score gives you the rank of a ">
	 <COND (<G? ,RATING 245>
		<TELL "rich diver">)
	       (<G? ,RATING 190>
		<TELL "good adventurer">)
	       (<G? ,RATING 125>
		<TELL "decent diver">)
	       (<G? ,RATING 45>
		<TELL "so-so sailor">)
	       (T
		<TELL "chicken of the sea">)>
	 <TELL "." CR>
	 ,RATING>

<ROUTINE FINISH () ;("OPTIONAL" (REPEATING <>))
	 <CRLF>
	 ;<COND (<NOT .REPEATING>
		<V-SCORE>
		<USL>
		<CRLF>)>
	 <V-SCORE>
	 <USL>
	 <CRLF>
	<REPEAT ()
	 <TELL
"Would you like to restart the game from the beginning, restore a saved
game position, or end this session of the game? (Type RESTART, RESTORE,
or QUIT): >">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?RESTART>
	        <RESTART>
		<TELL-FAILED>
		;<FINISH T>)
	       (<EQUAL? <GET ,P-LEXV 1> ,W?RESTORE>
		<COND (<RESTORE>
		       <TELL-OKAY>)
		      (T
		       <TELL-FAILED>
		       ;<FINISH T>)>)
	       (<EQUAL? <GET ,P-LEXV 1> ,W?QUIT ,W?Q>
		<QUIT>)>>>

<ROUTINE V-QUIT ("OPTIONAL" (ASK? T) "AUX" SCOR)
	 <V-SCORE>
	 <COND (<OR <AND .ASK?
			 <TELL
"Do you wish to leave the game? (Y is affirmative): ">
			 <YES?>>
		    <NOT .ASK?>>
		<USL>
		<QUIT>)
	       (T <TELL-OKAY>)>>

;<ROUTINE PRE-FINISH ()
	 <V-SCORE>
	 <TELL
"Do you wish to start the game again? (Y is affirmative): ">
	 <COND (<YES?>
		<TELL "Okay. Restarting..." CR>
		<RESTART>
		<TELL "Failed. Please reboot your system." CR>
		<QUIT>)
	       (T <TELL "Ok. See you next time!" CR>
		<USL>
		<QUIT>)>>

<ROUTINE YES? ()
	 <PRINTI ">">
	 <READ ,Y-INBUF ,Y-LEXV>
	 <COND (<EQUAL? <GET ,Y-LEXV 1> ,W?YES ,W?Y>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<GLOBAL Y-INBUF <ITABLE BYTE 12>>
<GLOBAL Y-LEXV <ITABLE BYTE 10>>

<ROUTINE V-VERSION ("AUX" (CNT 17) V)
	 <SET V <BAND <GET 0 1> *3777*>>
	 <TELL
"CUTTHROATS|
Infocom interactive fiction - an adventure story|
Copyright (c) 1984 by Infocom, Inc. All rights reserved.|">
	 ;<COND (<NOT <==? <BAND <GETB 0 1> 8> 0>>
		<TELL"Licensed to Tandy Corporation. Version 00.00."N .V CR>)>
	 <TELL
"CUTTHROATS is a registered trademark of Infocom, Inc.|
Release " N .V " / Serial number ">
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> 23>
			<RETURN>)
		       (T
			<PRINTC <GETB 0 .CNT>>)>>
	 <CRLF>>

;<ROUTINE IN-HERE? (OBJ)
	 <OR <IN? .OBJ ,HERE>
	     <GLOBAL-IN? .OBJ ,HERE>>>

<ROUTINE V-AGAIN ("AUX" OBJ (N <>))
	 <COND (<AND <==? ,L-PRSO ,NOT-HERE-OBJECT> ,P-MOBY-FOUND>
		<SET N T>
		<SETG L-PRSO ,P-MOBY-FOUND>)
	       (<AND <==? ,L-PRSI ,NOT-HERE-OBJECT> ,P-MOBY-FOUND>
		<SET N T>
		<SETG L-PRSI ,P-MOBY-FOUND>)>
	 <COND (<NOT ,L-PRSA>
		<TELL "Not until you do something." CR>)
	       (<EQUAL? ,L-PRSA ,V?WALK ,V?FOLLOW>
		<PERFORM ,L-PRSA ,L-PRSO>)
	       (T
		<SET OBJ
		     <COND (<AND ,L-PRSO <NOT <VISIBLE? ,L-PRSO>>>
			    ,L-PRSO)
			   (<AND ,L-PRSI <NOT <VISIBLE? ,L-PRSI>>>
			    ,L-PRSI)>>
		<COND (<AND .OBJ 
			    <NOT <EQUAL? .OBJ ,ROOMS>>>
		       <COND (.N
			      <TELL-YOU-CANT "see " <>>
			      <COND (<NOT <==? .OBJ ,WEASEL>>
				     <TELL "any ">)>
			      <TELL D .OBJ " here." CR>)
			     (T
			      <TELL "I can't see ">
		       	      <THE? .OBJ>
		       	      <TELL D .OBJ " anymore." CR>)>
		       <SETG CLOCK-WAIT T>
		       <RFATAL>)
		      (T
		       ;<SETG WINNER ,L-WINNER>
		       <COND (<OR <==? ,L-WINNER ,PLAYER>
			          <NOT <==? <CONTACT-ESTABLISHED> ,M-FATAL>>>
			      <SETG P-WALK-DIR ,L-WALK-DIR>
		       	      <SETG P-MERGED T>
			      <SETG P-MULT <>>
			      <SET N <PERFORM ,L-PRSA ,L-PRSO ,L-PRSI>>
			      <COND (<NOT .N><SET N T>)>
			      <SETG P-MERGED <>>
			      <RETURN .N>)>)>)>>

<ROUTINE CONTACT-ESTABLISHED ("AUX" OCONT V)
	 <SET OCONT ,P-CONT>
	 <SETG P-CONT T>
	 <SETG P-MERGED T>
	 <SET V <PERFORM ,V?TELL ,L-WINNER>>
	 <SETG P-CONT .OCONT>
	 <SETG P-MERGED <>>
	 <RETURN .V>>

<GLOBAL L-WALK-DIR <>>

;<ROUTINE V-$DEBUG ()
	 <COND (,DEBUG
		<SETG DEBUG <>>
		<TELL "No longer in debug mode." CR>)
	       (T <SETG DEBUG T> <TELL "Now in debug mode." CR>)>>

;<ROUTINE V-$W1 ()
	 <SETG WRECK-FOUND 1>
	 <SETG WRECK-CHOSEN 1>
	 <MOVE ,DEEP-SUIT ,PLAYER>
	 <FSET ,DEEP-SUIT ,WORNBIT>
	 <MOVE ,AIR-HOSE ,DEEP-SUIT>
	 <MOVE ,PLAYER ,WRECK-1>
	 <SETG HERE ,WRECK-1>
	 <WRECK-1-F ,M-ENTER>
	 <MOVE ,FLASHLIGHT ,PLAYER>
	 <FCLEAR ,FLASHLIGHT ,NDESCBIT>
	 <FSET ,FLASHLIGHT ,ONBIT>
	 <MOVE ,SHARK-REPELLENT ,PLAYER>
	 <FCLEAR ,SHARK-REPELLENT ,NDESCBIT>
	 <PUTP ,SHARK-REPELLENT ,P?NORTH -1>
	 <ENABLE <QUEUE I-PENDULUM -1>>
	 <V-LOOK>>

;<ROUTINE V-$W2 ()
	 <SETG WRECK-FOUND 2>
	 <SETG WRECK-CHOSEN 2>
	 <MOVE ,PLAYER ,WRECK-1>
	 <MOVE ,WET-SUIT ,PLAYER>
	 <FSET ,WET-SUIT ,WORNBIT>
	 <MOVE ,MASK ,PLAYER>
	 <FSET ,MASK ,WORNBIT>
	 <MOVE ,AIR-TANK ,PLAYER>
	 <FSET ,AIR-TANK ,WORNBIT>
	 <SETG AIR-LEFT 160>
	 <ENABLE <QUEUE I-AIR-SUPPLY -1>>
	 <MOVE ,FLIPPERS ,PLAYER>
	 <FSET ,FLIPPERS ,WORNBIT>
	 <SETG DEPTH 150>
	 <SETG HERE ,WRECK-1>
	 <WRECK-1-F ,M-ENTER>
	 <MOVE ,FLASHLIGHT ,PLAYER>
	 <FCLEAR ,FLASHLIGHT ,NDESCBIT>
	 <FSET ,FLASHLIGHT ,ONBIT>
	 <PUTP ,FLASHLIGHT ,P?NORTH -1>
	 <MOVE ,MAGNET ,PLAYER>
	 <FCLEAR ,MAGNET ,NDESCBIT>
	 <PUTP ,MAGNET ,P?NORTH -1>
	 <MOVE ,DRILL ,PLAYER>
	 <MOVE ,BATTERY ,DRILL>
	 <FCLEAR ,BATTERY ,NDESCBIT>
	 <PUTP ,BATTERY ,P?NORTH -1>
	 <SETG DRILL-POWERED T>
	 <MOVE ,SHARK-REPELLENT ,PLAYER>
	 <FCLEAR ,SHARK-REPELLENT ,NDESCBIT>
	 <PUTP ,SHARK-REPELLENT ,P?NORTH -1>
	 <MOVE ,TUBE ,PLAYER>
	 <FCLEAR ,TUBE ,NDESCBIT>
	 <PUTP ,TUBE ,P?NORTH -1>
	 <V-LOOK>>

;<ROUTINE V-$DIVETIME ("AUX" D)
	 <SET D <INT I-DIVETIME>>
	 <SETG CLOCK-WAIT T>
	 <COND (<GET .D ,C-ENABLED?>
		<TELL "Enabled">)
	       (T <TELL "Disabled">)>
	 <TELL " at time " N <GET .D ,C-TICK> "." CR>>

"SUBTITLE DEATH AND TRANSFIGURATION"

;<GLOBAL DEAD <>>
;<GLOBAL DEATHS 0>
;<GLOBAL LUCKY 1>

<ROUTINE JIGS-UP (DESC "OPTIONAL" (PLAYER? <>))
 	 <TELL .DESC CR>
	 <TELL "
|    ****  You have died  ****
|
|">
	 <TELL "Too bad." CR>
	 <CRLF>
	 <FINISH>>

<ROUTINE V-RESTORE ()
	 <COND (<RESTORE>
		<TELL-OKAY>
		<V-FIRST-LOOK>)
	       (T
		<TELL-FAILED>)>>

<ROUTINE TELL-FAILED () <TELL "Failed." CR>>
<ROUTINE TELL-OKAY () <TELL "Okay." CR>>

<ROUTINE V-SAVE ()
	 <COND (<SAVE>
	        <TELL-OKAY>)
	       (T
		<TELL-FAILED>)>>

<ROUTINE V-RESTART ()
	 <V-SCORE T>
	 <TELL "Do you wish to restart? (Y is affirmative): ">
	 <COND (<YES?>
		<TELL "Restarting." CR>
		<RESTART>
		<TELL-FAILED>)>>

<CONSTANT REXIT 0>
<CONSTANT UEXIT 1>
<CONSTANT NEXIT 2>
<CONSTANT FEXIT 3>
<CONSTANT CEXIT 4>
<CONSTANT DEXIT 5>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 1>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 1>

<ROUTINE V-WALK-AROUND ()
	 <TELL-SHD-DIR>
	 ;<TELL "Use " D ,INTDIR "s for movement here." CR>>

<ROUTINE V-LAUNCH ()
	  <TELL "How does one launch that?" CR>>

;<ROUTINE GO-NEXT (TBL "AUX" VAL)
	 <COND (<SET VAL <LKP ,HERE .TBL>>
		<GOTO .VAL>)>>

;<ROUTINE LKP (ITM TBL "AUX" (CNT 0) (LEN <GET .TBL 0>))
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .LEN>
			<RFALSE>)
		       (<==? <GET .TBL .CNT> .ITM>
			<COND (<==? .CNT .LEN> <RFALSE>)
			      (T
			       <RETURN <GET .TBL <+ .CNT 1>>>)>)>>>

<ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)
	 <COND (<NOT ,P-WALK-DIR>
		<PERFORM ,V?WALK-TO ,PRSO>
		<RTRUE>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<==? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <GOTO <GETB .PT ,REXIT>>)
		      (<==? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<==? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <GOTO .RM>)
			     (T
			      <RFATAL>)>)
		      (<==? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL-NO-GO T>
			      <RFATAL>)>)
		      (<==? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GETB .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <TELL .STR CR>
			      <SETG P-IT-OBJECT .OBJ>
			      <RFATAL>)
			     (T
			      <TELL-CLOSED .OBJ <>>
			      <SETG P-IT-OBJECT .OBJ>
			      <RFATAL>)>)>)
	       (<AND <NOT ,LIT> <PROB 90>>
		<JIGS-UP
"The water is too dark for you to see anything. After a moment, however, you
feel something start to munch on you. Something large.">)
	       (T
		<TELL-NO-GO T>
		<RFATAL>)>>

;<ROUTINE THIS-IS-IT (OBJ)
	 <SETG P-IT-OBJECT .OBJ>
	 ;<SETG P-IT-LOC ,HERE>>

<ROUTINE V-INVENTORY ()
	 <COND (<FIRST? ,WINNER> <PRINT-CONT ,WINNER>)
	       (T <TELL "You are empty-handed." CR>)>
	 <COND (<AND <==? ,WINNER ,PLAYER>
		     <G? ,POCKET-CHANGE 0>
		     <NOT <FSET? ,WET-SUIT ,WORNBIT>>
		     <NOT <FSET? ,DEEP-SUIT ,WORNBIT>>>
		<TELL "You have $" N ,POCKET-CHANGE " in your pocket." CR>)>>

<GLOBAL INDENTS
	<PTABLE ""
	        "  "
	        "    "
	        "      "
	        "        "
	        "          ">>

\

<ROUTINE PRE-TAKE ()
	 <COND (<PRSO? ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<AND <PRSO? ,OCEAN>
		     <PRSI? ,GLASS-CASE>>
		<RFALSE>)
	       (<PRSI? ,GLOBAL-ROOM>
		<TELL-YOURE-NOT "going anywhere.">
		<RTRUE>)
	       (<OR <PRSO? ,GLOBAL-MONEY ,RIDICULOUS-MONEY-KLUDGE>
		    <AND <PRSO? ,INTNUM> ,P-DOLLAR-FLAG>>
		<TELL-NOT-EASY>
		<RTRUE>)
	       (<AND <IN? ,PRSO ,MAGNET>
		     <OR <NOT ,PRSI>
			 <PRSI? ,MAGNET>>>
		<RFALSE>)>
	 <COND (<IN? ,PRSO ,WINNER>
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <COND (<EQUAL? <GET ,P-VTBL 0> ,W?REMOVE>
			      <PERFORM ,V?DISEMBARK ,PRSO>
			      <RTRUE>)
			     (T <TELL "You are already wearing it." CR>)>)
		      (T <TELL-YOU-ALREADY "have it.">)>)
	       (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<COND (<PRSO? ,PUTTY>
		       <RFALSE>)
		      (T
		       <TELL-CANT-REACH "that">
		       <RTRUE>)>)
	       (,PRSI
		<COND (<NOT <==? ,PRSI <LOC ,PRSO>>>
		       <COND (<AND <EQUAL? ,PRSO ,NOT-HERE-OBJECT>
				   <FSET? ,PRSI ,CONTBIT>
				   <NOT <FSET? ,PRSI ,OPENBIT>>>
			      <TELL-YOUD-BETTER "open the " <> <>>
			      <TELL D ,PRSI " first." CR>
			      <SETG P-IT-OBJECT ,PRSI>
			      <RTRUE>)
			     (<==? ,PRSO ,PRSI>
			      <TELL-SERIOUS>)
			     (<FSET? ,PRSI ,VICBIT>
			      <PERFORM ,V?ASK-FOR ,PRSI ,PRSO>
			      <RTRUE>)
			     (<AND <OR <PRSO? ,GLOBAL-MONEY
					      ,RIDICULOUS-MONEY-KLUDGE>
				       <AND <PRSO? ,INTNUM> ,P-DOLLAR-FLAG>>
				   <PRSI? ,POCKET>>
			      <TELL-WHY-BOTHER>)
			     (<AND <PRSO? ,AIR>
				   <PRSI? ,AIR-TANK>>
			      <PERFORM ,V?EMPTY ,AIR-TANK>
			      <RTRUE>)
			     (T
			      <START-SENTENCE ,PRSO>
			      <TELL " isn't in ">
			      <THE? ,PRSI>
			      <TELL D ,PRSI "." CR>)>)
		      (T
		       <SETG PRSI <>>
		       <RFALSE>)>)
	       (<==? ,PRSO <LOC ,WINNER>>
		<TELL "You are " <VEHPREP <LOC ,WINNER>> " it, loser!" CR>)>>

<ROUTINE TELL-YOURE-NOT (STR "OPTIONAL" (DONE? T))
	 <TELL "You're not " .STR>
	 <COND (.DONE? <CRLF>)>>

<ROUTINE TELL-NOT-EASY ()
	 <TELL "It's not that easy." CR>>

<ROUTINE V-TAKE ()
	 <COND (<ITAKE>
		<TELL "Taken." CR>)>>

<GLOBAL FUMBLE-NUMBER 7>

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" CNT OBJ TEMP)
	 <COND (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <TELL <PICK-ONE ,YUKS> CR>)>
		<RFALSE>)
	       (<AND <==? ,PRSO ,ENVELOPE>
		     <==? ,HERE ,MCGINTY-HQ>
		     <IN? ,MCGINTY ,MCGINTY-HQ>>
		<SET TEMP ,PRSA>
		<SETG PRSA ,V?TAKE>
		<ENVELOPE-F>
		<SETG PRSA .TEMP>
		<RFALSE>)
	       (<AND <NOT <IN? <LOC ,PRSO> ,WINNER>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,WINNER>> ,LOAD-ALLOWED>>
		<COND (.VB
		       <TELL "Your load is too heavy." CR>)>
		<RFALSE>)
	       (<G? <SET CNT <CCOUNT ,WINNER>> ,FUMBLE-NUMBER>
		<TELL "You're carrying too many things already!" CR>
		<RFALSE>)
	       (<PRSO? ,MINE>
		<BOOM>)
	       (T
		<MOVE ,PRSO ,WINNER>
		<FSET ,PRSO ,TOUCHBIT>
		<FCLEAR ,PRSO ,NDESCBIT>
		<RATING-OBJ ,PRSO>
	        <RTRUE>)>>

<ROUTINE V-PUT-ACROSS ()
	  <TELL-NO-NO>>

<ROUTINE V-PUT-ON ()
	 <COND ;(<AND <PRSI? ,GLASS-CASE>
		     <PRSO? ,PUTTY>>
		<RFALSE>)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>
		<RTRUE>)
	       (<PRSI? ,ME>
		<TELL "Sounds kinky." CR>)
	       (<FSET? ,PRSI ,VICBIT>
		<TELL "I don't think he'd appreciate it." CR>)
	       (T <TELL "There's no good surface on ">
		  <THE? ,PRSI>
		  <TELL D ,PRSI "." CR>)>>

<ROUTINE PRE-PUT ("AUX" OBJ)
	 <COND (<NOT ,PRSI>
		<TELL "Huh?" CR>)
	       (<PRSO? ,NOT-HERE-OBJECT ,GLOBAL-SELF ,MAGNET>
		<RFALSE>)
	       (<==? ,PRSI ,OCEAN>
		<PERFORM ,V?THROW ,PRSO ,OCEAN>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSO? ,ME>>
		<PERFORM ,V?WEAR ,PRSI>
		<RTRUE>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,ME>>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (<OR <PRSO? ,GLOBAL-MONEY ,RIDICULOUS-MONEY-KLUDGE>
		    <AND ,P-DOLLAR-FLAG
			 <PRSO? ,INTNUM>>>
		<COND (<PRSI? ,POCKET> <RFALSE>)
		      (T <TELL-YOU-CANT "afford to.">)>)
	       (<AND <PRSO? ,AIR-HOSE>
		     <PRSI? ,DEEP-SUIT>>
		<RFALSE>)
	       (<NOT <HELD? ,PRSO>>
		<TELL-DONT-HAVE <>>
		<THE? ,PRSO>
		<TELL D ,PRSO "." CR>)
	       (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
		    <NOT <FSET? ,PRSO ,TAKEBIT>>>
		<TELL "Nice try." CR>)>>

<ROUTINE V-PUT ()
	 <COND (<OR <FSET? ,PRSI ,OPENBIT>
		    <OPENABLE? ,PRSI>
		    <FSET? ,PRSI ,VEHBIT>>)
	       (T
		<TELL-NO-NO>
		<RTRUE>)>
	 <COND (<NOT <FSET? ,PRSI ,OPENBIT>>
		<TELL "The " D ,PRSI " isn't open." CR>)
	       (<==? ,PRSI ,PRSO>
		<TELL-HOW-THAT "do">)
	       (<IN? ,PRSO ,PRSI>
		<START-SENTENCE ,PRSO>
		<TELL " is already in ">
		<THE? ,PRSI>
		<TELL D ,PRSI "." CR>)
	       (<G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<TELL "There's no room." CR>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <NOT <ITAKE>>>
		<RTRUE>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<FCLEAR ,PRSO ,WORNBIT>
		<TELL "Done." CR>)>>

<ROUTINE PRE-DROP ()
	 <COND (<==? ,PRSO <LOC ,WINNER>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)>>

<ROUTINE PRE-GIVE ()
	 <COND (<NOT ,PRSI>
		<TELL "Huh?" CR>)
	       (<PRSO? ,NOT-HERE-OBJECT ,ME>
		<RFALSE>)
	       (<NOT <FSET? ,PRSI ,VICBIT>>
		<TELL "To " A ,PRSI "???" CR>)
	       (<AND <==? ,WINNER ,PLAYER>
		     <PRSI? ,ME>
		     ,QCONTEXT
		     <==? ,HERE ,QCONTEXT-ROOM>
		     <==? ,HERE <META-LOC ,QCONTEXT>>>
		<SETG WINNER ,QCONTEXT>
		<PERFORM ,V?GIVE ,PRSO ,PRSI>
		<SETG WINNER ,PLAYER>
		<RTRUE>)
	       (<OR <EQUAL? ,PRSI ,WINNER>
		    <AND <EQUAL? ,WINNER ,PLAYER>
			 <PRSI? ,ME>>>
		<TELL-CHARITY>)
	       (<PRSO? ,GLOBAL-MONEY ,RIDICULOUS-MONEY-KLUDGE ,INTNUM>
		<RFALSE>)
	       (<AND <PRSO? ,DRINKING-WATER>
		     <==? ,HERE ,SHANTY>
		     <PRSI? ,SPEAR-CARRIER>>
		<RFALSE>)
	       (<AND <PRSO? ,DRINK-OBJECT>
		     <IN? ,DRINK-OBJECT ,TABLE-OBJECT>>
		<RFALSE>)
	       (<NOT <HELD? ,PRSO>>
		<COND (<==? ,WINNER ,PLAYER>
		       <TELL 
"That's easy for you to say since you don't even have it." CR>)
		      (T <TELL 
"\"I don't have " A ,PRSO " to give!\" exclaims ">
		       <THE? ,WINNER>
		       <TELL D ,WINNER "." CR>)>)>>

<ROUTINE TELL-CHARITY ()
	 <TELL "I know charity begins at home, but this is ridiculous." CR>>

<ROUTINE PRE-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE HELD? (OBJ)
	 <COND (<NOT .OBJ> <RFALSE>)
	       (<IN? .OBJ ,WINNER> <RTRUE>)
	       (<EQUAL? .OBJ ,ME ,GLOBAL-SELF> <RTRUE>)
	       (T <HELD? <LOC .OBJ>>)>>

<ROUTINE V-GIVE ()
	 <COND (<AND <PRSI? ,SPEAR-CARRIER>
		     <PRSO? ,INTNUM>
		     ,P-DOLLAR-FLAG>
		<TELL "\"If you want to buy something, be specific.\"" CR>)
	       (<FSET? ,PRSI ,VICBIT>
		<START-SENTENCE ,PRSI>
		<TELL " declines your generous offer." CR>)
	       (T
		<TELL-YOU-CANT "give " <>>
		<THE? ,PRSO>
		<TELL D ,PRSO " to " A ,PRSI "!" CR>)>>

<ROUTINE V-SGIVE ()
	 <TELL "Bug." CR>>

<ROUTINE V-DROP ("OPTIONAL" (SUPPRESS <>))
	 <COND (<IDROP>
		<COND (<NOT .SUPPRESS>
		       <TELL "Dropped." CR>)>)>>

<ROUTINE PRE-THROW ()
	 <COND (<PRSO? ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<NOT <IN? ,PRSO ,WINNER>>
		<TELL-YOURE-NOT "carrying " <>>
		<THE? ,PRSO>
		<TELL D ,PRSO "." CR>
		<RTRUE>)>>

<ROUTINE V-THROW ()
	 <COND (,PRSI
		<COND (<OR <FSET? ,PRSI ,CONTBIT>
			   <FSET? ,PRSI ,CLIMBBIT>>
		       <PERFORM ,V?PUT ,PRSO ,PRSI>
		       <RTRUE>)
		      (<PRSI? ,ME>
		       <TELL "You'd probably miss." CR>
		       <RTRUE>)
		      (<PRSI? ,FIELD>
		       <START-SENTENCE ,PRSO>
		       <TELL " bounces off the weeds." CR>)
		      (T
		       <START-SENTENCE ,PRSI>
	       	       <COND (<FSET? ,PRSI ,VICBIT> <TELL " ducks">)
			     (T <TELL " doesn't duck">)>
	       	       <TELL " as the " D ,PRSO " flies by." CR>)>)>
	 <IDROP>
	 <COND (<NOT ,PRSI> <TELL "Thrown." CR>)>
	 <RTRUE>>

<ROUTINE IDROP ()
	 <COND (<AND <NOT <IN? ,PRSO ,WINNER>> <NOT <IN? <LOC ,PRSO> ,WINNER>>>
		<TELL-YOURE-NOT "carrying " <>>
		<THE? ,PRSO>
		<TELL D ,PRSO "." CR>
		<RFALSE>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL-CLOSED <LOC ,PRSO> <>>
		<RFALSE>)
	       (T
		<COND (<AND <FSET? <LOC ,PLAYER> ,VEHBIT>
			    <NOT <IN? ,PLAYER ,BED>>>
		       <MOVE ,PRSO <META-LOC ,PLAYER>>)
		      (T <MOVE ,PRSO <LOC ,WINNER>>)>
		<FCLEAR ,PRSO ,WORNBIT>
		<COND (<PRSO? ,SAFETY-LINE> <ENABLE <QUEUE I-PENDULUM 3>>)>
		<RTRUE>)>>

<ROUTINE PRE-OPEN ()
	 <COND (<AND ,PRSI
		     <NOT <FSET? ,PRSI ,TOOLBIT>>>
		<PRE-BURN>)>>

<ROUTINE V-OPEN ("AUX" F STR)
	 <COND (<NOT <FSET? ,PRSO ,CONTBIT>>
		<SAY-MUST-TELL>)
	       (<NOT <==? <GETP ,PRSO ,P?CAPACITY> 0>>
		<COND (<FSET? ,PRSO ,OPENBIT> <TELL-ALREADY "open">)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <COND (<NOT <FIRST? ,PRSO>>
			      <TELL "Opened." CR>)
			     (<AND <SET F <FIRST? ,PRSO>>
				   <NOT <NEXT? .F>>
				   <SET STR <GETP .F ,P?FDESC>>>
			      <TELL-OPENS>
			      <TELL .STR CR>)
			     (T
			      <TELL "Opening the " D ,PRSO " reveals ">
			      <PRINT-CONTENTS ,PRSO>
			      <TELL "." CR>)>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL-ALREADY "open">)
		      (T
		       <TELL-OPENS>
		       <FSET ,PRSO ,OPENBIT>)>)
	       (T <TELL "The " D ,PRSO " fails to open." CR>)>>

<ROUTINE TELL-OPENS ()
	 <TELL "The " D ,PRSO " opens." CR>>

<ROUTINE SAY-MUST-TELL ()
	 <TELL "You must tell me how to do that to ">
	 <THE? ,PRSO>
	 <TELL D ,PRSO "." CR>>

<ROUTINE PRINT-CONTENTS (OBJ "AUX" F N (1ST? T) (2ND <>))
	 <COND (<SET F <FIRST? .OBJ>>
		<COND (<NOT <NEXT? .F>>
		       <SETG P-IT-OBJECT .F>)>
		<REPEAT ()
			<SET N <NEXT? .F>>
			<COND (.1ST? <SET 1ST? <>> <SET 2ND T>)
			      (T
			       <COND (<OR .N <NOT .2ND>>
				      <SET 2ND <>>
				      <TELL ",">)>
			       <TELL " ">
			       <COND (<NOT .N> <TELL "and ">)>)>
			<TELL A .F>
			<SET F .N>
			<COND (<NOT .F> <RETURN>)>>)>>

<ROUTINE V-ASK-ABOUT ()
	 <COND (<PRSO? ,PLAYER ,ME>
		<TELL-NO-INFO>)
	       (<NOT <FSET? ,PRSO ,VICBIT>>
		<SUDDENLY-REALIZE-TALKING ,PRSO>
		<RTRUE>)
	       (T
		<TELL "After a moment's thought, ">
		<THE? ,PRSO>
		<TELL D ,PRSO " disavows any knowledge of that." CR>)>>

<ROUTINE SUDDENLY-REALIZE-TALKING (OBJ)
	<TELL 
"You suddenly realize that you're talking to " A .OBJ "." CR>>

<ROUTINE TELL-NO-INFO ()
	 <TELL
"You find that you can provide " D ,GLOBAL-SELF " with no new information."
CR>>

<ROUTINE PRE-ASK-CONTEXT-ABOUT ("AUX" P)
 <COND (<AND ,QCONTEXT
	     <==? ,HERE ,QCONTEXT-ROOM>
	     <==? ,HERE <META-LOC ,QCONTEXT>>>
	<TELL "(said to " D ,QCONTEXT ")" CR>
	<PERFORM ,V?ASK-ABOUT ,QCONTEXT ,PRSO>
	<RTRUE>)
       ;(<SET P <FIND-FLAG ,HERE ,PERSON ,WINNER>>
	<PERFORM ,V?ASK-ABOUT .P ,PRSO>
	<RTRUE>)>>

<ROUTINE V-ASK-CONTEXT-ABOUT ()
	<V-ASK-CONTEXT-FOR>>

<ROUTINE V-ASK-FOR ()
	 <COND (<PRSO? ,PLAYER ,ME>
		<TELL-NO-INFO>)
	       (<FSET? ,PRSO ,VICBIT>
		<COND (<==? ,PRSO ,PLAYER>
		       <COND (<IN? ,PRSI ,PLAYER>
			      <TELL-YOU-ALREADY "have it.">)
			     (T <TELL-DONT-HAVE "it">)>)
		      (<OR <PRSI? ,KNIFE ,GLOBAL-MONEY
				  ,RIDICULOUS-MONEY-KLUDGE>
			   <AND <PRSI? ,INTNUM> ,P-DOLLAR-FLAG>>
		       <START-SENTENCE ,PRSO>
		       <TELL " refuses." CR>)
		      (<AND <PRSO? ,SPEAR-CARRIER>
			    <G? <GETP ,PRSI ,P?NORTH> 0>>
		       <TELL-CHARITY>)
		      (T
		       <START-SENTENCE ,PRSO>
		       <COND (<IN? ,PRSI ,PRSO>
			      <TELL " hands you the " D ,PRSI "." CR>
			      <MOVE ,PRSI ,WINNER>)
			     (T <TELL " doesn't have that." CR>)>)>)
	       (T
		<SUDDENLY-REALIZE-TALKING ,PRSO>)>>

<ROUTINE PRE-ASK-CONTEXT-FOR ("AUX" P)
 <COND (<AND ,QCONTEXT
	     <==? ,HERE ,QCONTEXT-ROOM>
	     <==? ,HERE <META-LOC ,QCONTEXT>>>
	<TELL "(said to " D ,QCONTEXT ")" CR>
	<PERFORM ,V?ASK-FOR ,QCONTEXT ,PRSO>
	<RTRUE>)
       ;(<SET P <FIND-FLAG ,HERE ,PERSON ,WINNER>>
	<PERFORM ,V?ASK-FOR .P ,PRSO>
	<RTRUE>)>>

<ROUTINE V-ASK-CONTEXT-FOR ()
	<TELL-YOURE-NOT "talking to anyone!">>

<ROUTINE V-CALL ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<PERFORM ,V?$CALL ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSO ,VICBIT>
		<SETG QCONTEXT ,PRSO>
		<SETG QCONTEXT-ROOM ,HERE>
		<TELL "The " D ,PRSO>
		<TELL-LISTENING>)
	       (T <TELL "There's no response." CR>)>>

<ROUTINE V-CALL-LOSE ()
	 <SETG CLOCK-WAIT T>
	 <TELL "You must use a verb!" CR>>

<ROUTINE PRE-$CALL ()
	 <COND (<PRSO? ,INTDIR>
		<PERFORM ,V?WALK ,P-WALK-DIR>
		<RTRUE>)
	       (<NOT <FSET? ,PRSO ,VICBIT>>
		<V-CALL-LOSE>)>>

<ROUTINE V-$CALL ("AUX" ;PER (MOT <>))
	 <COND (<PRSO? ,ME ,PLAYER>
		<V-CALL-LOSE>)
	       (<FSET? ,PRSO ,PERSON>
		;<SET PER <GET ,CHARACTER-TABLE <GETP ,PRSO ,P?CHARACTER>>>
		<COND (<IN-MOTION? ,PRSO> <SET MOT T>)>
		<COND (<OR <==? <META-LOC ,PRSO> ,HERE> <CORRIDOR-LOOK ,PRSO>>
		       <START-SENTENCE ,PRSO>
		       <COND (<GRAB-ATTENTION ,PRSO>
			      <FSET ,PRSO ,TOUCHBIT>
			      ;<SETG QCONTEXT ,PRSO> ;"done in GRAB-ATTENTION"
			      <SETG QCONTEXT-ROOM <META-LOC ,PRSO>>
			      <COND (.MOT
				     <TELL " stops and turns toward you." CR>)
			      	    (T <TELL-LISTENING>)>)
			     (T
			      <TELL " ignores you." CR>)>)
		      (T <TELL "You don't see " D ,PRSO " here." CR>)>)
	       (<AND <PRSO? ,SPEAR-CARRIER>
		     <IN? ,SPEAR-CARRIER ,HERE>>
		<SETG QCONTEXT ,SPEAR-CARRIER>
		<SETG QCONTEXT-ROOM ,HERE>
		<TELL "The " D ,PRSO>
		<TELL-LISTENING>)
	       (T <V-CALL-LOSE>)>>

<ROUTINE TELL-LISTENING ()
	 <TELL " is listening." CR>>

<ROUTINE V-CLOSE ()
	 <COND (<NOT <FSET? ,PRSO ,CONTBIT>>
		<SAY-MUST-TELL>)
	       (<AND <NOT <FSET? ,PRSO ,SURFACEBIT>>
		     <NOT <==? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Closed." CR>)
		      (T <TELL-ALREADY "closed">)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL-NOW ,PRSO "closed">
		       <FCLEAR ,PRSO ,OPENBIT>)
		      (T <TELL-ALREADY "closed">)>)
	       (T <TELL-YOU-CANT "close that.">)>>

<ROUTINE CCOUNT (OBJ "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<NOT <FSET? .X ,WORNBIT>>
			       <SET CNT <+ .CNT 1>>)>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

"WEIGHT:  Get sum of SIZEs of supplied object, recursing to the nth level."

<ROUTINE WEIGHT
	 (OBJ "AUX" CONT (WT 0))
	 <COND (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<AND <==? .OBJ ,WINNER> <FSET? .CONT ,WEARBIT>>
			       <SET WT <+ .WT 1>>)
			      (T <SET WT <+ .WT <WEIGHT .CONT>>>)>
			<COND (<NOT <SET CONT <NEXT? .CONT>>> <RETURN>)>>)>
	 <+ .WT <GETP .OBJ ,P?SIZE>>>

<ROUTINE V-BREATHE ()
	 <COND (<AND ,PRSO <NOT <PRSO? ,AIR>>>
		<TELL "Stick to air." CR>)
	       (T <TELL "If you stop breathing, I'll let you know." CR>)>>

;<ROUTINE V-BUG ()
	 <TELL
"If there is a problem here, it is unintentional. You may report
your problem to the address provided in your documentation." CR>>

<GLOBAL COPR-NOTICE
" a transcript of interaction with CUTTHROATS.|
CUTTHROATS is a registered trademark of Infocom, Inc.|
Copyright (c) 1984, Infocom, Inc. All rights reserved.|">

<ROUTINE V-SCRIPT ()
	<PUT 0 8 <BOR <GET 0 8> 1>>
	<TELL "Here begins" ,COPR-NOTICE CR>>

<ROUTINE V-UNSCRIPT ()
	<TELL "Here ends" ,COPR-NOTICE CR>
	<PUT 0 8 <BAND <GET 0 8> -2>>
	<RTRUE>>

<ROUTINE PRE-MOVE ()
	 <COND (<PRSO? ,SAFETY-LINE> <RFALSE>)
	       (<IN? ,PLAYER ,PRSO> <TELL-CONTORT>)
	       (<HELD? ,PRSO> <TELL "I don't juggle objects!" CR>)>>

<ROUTINE V-MOVE ()
	 <COND (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Moving the " D ,PRSO " reveals nothing." CR>)
	       (<FSET? ,PRSO ,PUSHBIT>
		<TELL-MOVES-BIT>)
	       (T <TELL-YOU-CANT "move " <>>
		  <THE? ,PRSO>
		  <TELL D ,PRSO "." CR>)>>

<ROUTINE V-LAMP-ON ()
	 <COND (<FSET? ,PRSO ,VICBIT>
		<TELL "Restrain yourself." CR>)
	       (T <TELL-YOU-CANT "turn that on.">)>>

;<ROUTINE FLAMING? (OBJ)
	 <COND (<FSET? .OBJ ,FLAMEBIT>
		<RTRUE>)>>

;<ROUTINE LIGHT-THE (OBJECT SUPPRESS?)
	 <FSET .OBJECT ,ONBIT>
	 ;<FSET .OBJECT ,FLAMEBIT>
	 <COND (<NOT .SUPPRESS?>
		<TELL "The " D .OBJECT " is now lit." CR>)>
	 <COND (<NOT ,LIT>
		<SETG LIT <LIT? ,HERE>>
		<CRLF>
		<V-LOOK>)>>

<ROUTINE V-LAMP-OFF ()
	 <TELL-YOU-CANT "turn that off.">>

<ROUTINE TELL-PASSES () <TELL "Time passes..." CR>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 10) (NOT-INT? T) (WHO <>)
		 "AUX" (INTERRUPTED <>))
	 <COND (.NOT-INT?
		<TELL-PASSES>
		<COND (<G? ,I-WAIT-DURATION 0>
		       <RFALSE>)>)>
	 <REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0> <RETURN>)
		       (<CLOCKER> <SET INTERRUPTED T> <RETURN>)
		       (<AND .WHO <IN? .WHO ,HERE>>
			<SET INTERRUPTED T> <RETURN>)>
		 <USL>>
	 <COND (.NOT-INT? <SETG CLOCK-WAIT T>)
	       (T .INTERRUPTED)>>

<ROUTINE V-WAIT-FOR ()
	 <COND (<==? ,PRSO ,INTNUM>
		<COND ;(<G? ,P-NUMBER ,PRESENT-TIME> <V-WAIT-UNTIL> <RTRUE>)
		      (<G? ,P-NUMBER 180>
		       <TELL "That's too long to wait." CR>)
		      (T <V-WAIT ,P-NUMBER>)>)
	       ;(<==? ,PRSO ,MIDNIGHT> <V-WAIT-UNTIL> <RTRUE>)
	       (<PRSO? ,ME ,PLAYER> <TELL "You're already here!" CR>)
	       (<OR <FSET? ,PRSO ,PERSON>
		    <==? ,PRSO ,DELIVERY-BOY>>
		<COND (<IN? ,PRSO ,HERE>
		       <TELL "He's already here!" CR>)
		      (T <TELL-PASSES>
		       <REPEAT ()
			       <COND (<V-WAIT 30 <> ,PRSO>
				      <COND (<IN? ,PRSO ,HERE>
					     <FSET ,PRSO ,TOUCHBIT>
			       		     <START-SENTENCE ,PRSO>
					     <TELL
", for whom you were waiting, has arrived." CR>
			       		     <SETG P-IT-OBJECT ,PRSO>
					     <RETURN>)>)>
			       <START-SENTENCE ,PRSO>
			       <TELL
" isn't here yet. Do you want to keep waiting? (YES or NO?)">
			       <COND (<NOT <YES?>>
				      <TELL "If you say so..." CR>
				      <RETURN>)>>
		       <SETG CLOCK-WAIT T>)>)
	       (<FSET? ,PRSO ,VICBIT>
		<TELL "I don't think he's going anywhere." CR>)
	       (T <TELL "Why? It's not going anywhere." CR>)>>

;<ROUTINE V-WAIT-UNTIL ("AUX" NUM)	;"?? time?"
	 <COND ;(<==? ,PRSO ,MIDNIGHT>
		<SETG P-NUMBER 720>
		<SETG PRSO ,INTNUM>)
	       (<L? ,P-NUMBER 24>
		<SETG P-NUMBER <* ,P-NUMBER 60>>)>
	 <COND (<==? ,PRSO ,INTNUM>
		<SET NUM ,P-NUMBER>
		<TELL-PASSES>
		<REPEAT ()
			<COND (<G? .NUM ,PRESENT-TIME>
		       	       <COND (<V-WAIT <- .NUM ,PRESENT-TIME> <>>
				      <TELL
"Do you want to keep waiting? (YES or NO?)">
				      <COND (<NOT <YES?>> <RTRUE>)
					    (T <SET NUM <- .NUM 1440>>)>)
			       	     (T <RTRUE>)>)
		      	      (T <SET NUM <+ .NUM 720>>)>>
		<V-TIME>)
	       (T <TELL "Wash your brain out with soap!" CR>)>>

<ROUTINE PRE-BOARD ("AUX" AV)
	 <SET AV <LOC ,WINNER>>
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<COND (<FSET? .AV ,VEHBIT>
		       <TELL
"You are already " <VEHPREP .AV> " the " D .AV "!" CR>)
		      (T <RFALSE>)>)
	       (<FSET? ,PRSO ,WEARBIT>
		<PERFORM ,V?WEAR ,PRSO>)
	       (<PRSO? ,NOT-HERE-OBJECT ,CLOSET ,FIELD ,OCEAN ,REDS-BUNK
		       ,BACK-WINDOW>
		<RFALSE>)
	       (T
		<TELL "I suppose you have a theory on getting into ">
		<THE? ,PRSO>
		<TELL D ,PRSO "." CR>)>
	 <RFATAL>>

<ROUTINE V-BOARD ()
	 <TELL "You are now " <VEHPREP ,PRSO> " the " D ,PRSO "." CR>
	 <MOVE ,WINNER ,PRSO>
	 ;<APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
	 <RTRUE>>

<GLOBAL STOOD-UP <>>

<ROUTINE V-DISEMBARK ()
	 <COND (<FSET? ,PRSO ,WORNBIT>
		<UNWEAR>
		<RTRUE>)
	       (<NOT <==? <LOC ,WINNER> ,PRSO>>
		<TELL-YOURE-NOT "in that!">
		<RFATAL>)
	       (<FSET? ,HERE ,RLANDBIT>
		<COND (<NOT ,STOOD-UP>
		       <TELL "You get out of bed." CR>
		       <SETG STOOD-UP T>)
		      (T
		       <TELL "You are on your feet again." CR>)>
		<MOVE ,WINNER ,HERE>)
	       (T
		<TELL
;"You realize, just in time, that getting out here would probably be fatal."
		 "A bad idea." CR>;"I don't think this case happens"
		<RFATAL>)>>

;<ROUTINE V-BLAST ()
	 <TELL-YOU-CANT "blast anything by using words.">>

<ROUTINE PRE-BUY ()
	 <COND (<AND <NOT <PRSO? ,DRINKING-WATER>>
		     <OR <FSET? ,WET-SUIT ,WORNBIT>
		    	 <FSET? ,DEEP-SUIT ,WORNBIT>>>
		<TELL-YOU-CANT "get at your money.">)>>

<ROUTINE V-BUY ("OPTIONAL" (RENT <>) "AUX" COST)
	 <COND (<AND <NOT <IN? ,PRSO ,ROOMS>>
		     <SET COST <GETP ,PRSO ,P?NORTH>>
		     <G? .COST 0>>
		<COND (<AND <ENABLED? I-EQUIP>
			    <NOT <IN? ,MCGINTY ,OUTFITTERS-HQ>>>
		       <TELL "The salesman is too busy with Johnny right now." CR>)
		      (<AND <FSET? ,PRSO ,RENTBIT>
			    <NOT .RENT>>
		       <TELL
"That's not for sale, but you might try renting it." CR>)
		      (<G? .COST ,POCKET-CHANGE>
		       <TELL-NO-AFFORD>)
		      (T
		       <SETG POCKET-CHANGE <- ,POCKET-CHANGE .COST>>
		       <PUTP ,PRSO ,P?NORTH -1>
		       <COND (<AND ,JOHNNY-MADE-DEAL
				   <NOT ,DELIVERY-MADE>>
			      <FSET ,PRSO ,TRYTAKEBIT>
			      <PUT ,DELIVERY-TABLE ,DT-PTR ,PRSO>
			      <SETG DT-PTR <+ ,DT-PTR 2>>)
			     (T
			      <FSET ,PRSO ,TAKEBIT>
			      <FCLEAR ,PRSO ,NDESCBIT>
			      <COND (<OR <G?
					  <+ <WEIGHT ,PRSO> <WEIGHT ,WINNER>>
					  ,LOAD-ALLOWED>
					 <G? <CCOUNT ,WINNER> ,FUMBLE-NUMBER>>
				     <MOVE ,PRSO ,GLOBAL-SURFACE>)
				    (T <MOVE ,PRSO ,WINNER>)>)>
		       <TELL "You have ">
		       <COND (.RENT <TELL "rented">)
			     (T <TELL "purchased">)>
		       <TELL " " A ,PRSO " for $" N .COST>
		       <COND (<IN? ,PRSO ,GLOBAL-SURFACE>
			      <TELL
". Since you can't currently carry it, the salesman leaves it on the counter">)>
		       <TELL "." CR>)>)
	       (<==? .COST -1>
		<COND (<FSET? ,PRSO ,RENTBIT>
		       <TELL "You've already rented it." CR>)
		      (T <TELL-ONLY-ONCE "had to buy">)>)
	       (<PRSO? ,DRINKING-WATER>
		<COND (<EQUAL? ,HERE ,MM-GALLEY ,NW-GALLEY>
		       <TELL "Get it " D ,GLOBAL-SELF "." CR>)
		      (T
		       <PERFORM ,V?ASK-FOR ,SPEAR-CARRIER ,DRINKING-WATER>
		       <SETG P-IT-OBJECT ,DRINKING-WATER>
		       <RTRUE>)>)
	       (T <TELL "That's not for sale." CR>)>>

<ROUTINE TELL-ONLY-ONCE (STR)
	 <TELL "You only " .STR " it once." CR>>

<ROUTINE V-RENT ("AUX" COST)
	 <COND (<AND <NOT <IN? ,PRSO ,ROOMS>>
		     <SET COST <GETP ,PRSO ,P?NORTH>>
		     <G? .COST 0>>
		<COND (<NOT <FSET? ,PRSO ,RENTBIT>>
		       <TELL
"That's not available for rental. You might try buying it." CR>)
		      (T <V-BUY T>)>)
	       (<==? .COST -1>
		<COND (<FSET? ,PRSO ,RENTBIT>
		       <TELL-ONLY-ONCE "need to rent">)
		      (T <TELL-YOU-ALREADY "bought it!">)>)
	       (T <TELL-YOU-CANT "rent that.">)>>

<ROUTINE GOTO (RM "OPTIONAL" (V? T)
	       "AUX" (LB <FSET? .RM ,RLANDBIT>) (WLOC <LOC ,WINNER>)
	             (AV <>) OLIT F N)
	 <SET OLIT ,LIT>
	 <COND (<FSET? .WLOC ,VEHBIT>
		<TELL-YOUD-BETTER "get " <> <>>
		<COND (<FSET? .WLOC ,SURFACEBIT>
		       <TELL "off">)
		      (T <TELL "out">)>
		<TELL " of the " D .WLOC " first." CR>
		<RFATAL>
		;<SET AV <GETP .WLOC ,P?VTYPE>>)>
	 <COND ;(<OR <AND <NOT .LB> <OR <NOT .AV> <NOT <FSET? .RM .AV>>>>
		    <AND <FSET? ,HERE ,RLANDBIT>
			 .LB
			 .AV
			 <NOT <==? .AV ,RLANDBIT>>
			 <NOT <FSET? .RM .AV>>>>
		<COND (.AV
		       <TELL-YOU-CANT "go there in " <>>
		       <TELL A .WLOC ".">)
		      (T <TELL-YOU-CANT "go there without a vehicle." <>>)>
		<CRLF>
		<RFALSE>)
	       ;(<FSET? .RM ,RMUNGBIT> <TELL <GETP .RM ,P?LDESC> CR> <RFALSE>)
	       (T
		;<COND (.AV <MOVE .WLOC .RM>)
		      (T
		       <MOVE ,WINNER .RM>)>
		<MOVE ,WINNER .RM>
		<SETG HERE .RM>
		<SETG LIT <LIT? ,HERE>>
		<COND (<AND <NOT .OLIT>
			    <NOT ,LIT>
			    <PROB 90>>
		       <JIGS-UP
"You suddenly bump into something in the darkness. You find that this something
has long, sharp teeth that feel uncomfortable when they enter your body.">)>
		<APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
		<RATING-OBJ .RM>
		<COND (<NOT <==? ,HERE .RM>> <RTRUE>)
		      (<NOT <==? ,ADVENTURER ,WINNER>>
		       <START-SENTENCE ,WINNER>
		       <TELL " leaves the room." CR>
		       <RFATAL>)
		      (.V?
		       <V-FIRST-LOOK>
		       <COND (<IN? ,MAGNET ,PLAYER>
			      <COND (,MAGNET-ON
				     <ATTRACTION>)
				    (<SET F <FIRST? ,MAGNET>>
				     <MOVE .F .WLOC>)>)>)>
		<RTRUE>)>>

<ROUTINE V-BACK ()
	 <TELL "Sorry, my memory isn't that good. ">
	 <TELL-SHD-DIR>>

<ROUTINE POURABLE? (OBJ)
	 <COND (<EQUAL? .OBJ ,DRINKING-WATER ,DRINK-OBJECT>
		<RTRUE>)
	       (T <RFALSE>)>>

<ROUTINE V-POUR ()
	 <COND (<PRSO? ,OCEAN>
	        <TELL-YOURE-NOT "Moses!">)
	       (<NOT <POURABLE? ,PRSO>>
		<TELL-YOU-CANT "pour that.">
		<RTRUE>)
	       (<AND <==? ,HERE ,SHANTY>
		     <NOT <IN? ,PRSO ,TABLE-OBJECT>>>
		<TELL-BUY-FIRST>)
	       (T
		<MOVE ,PRSO ,HERE>
		<FSET ,PRSO ,NDESCBIT>
		<TELL "It evaporates immediately." CR>)>>

<ROUTINE V-POUR-IN ("AUX" L)
	 <COND (<NOT <POURABLE? ,PRSO>>
		<TELL "I don't think you can pour " A ,PRSO ".">)
	       (<NOT <FSET? ,PRSI ,CONTBIT>>
	        <TELL
"You'd have a lot of trouble pouring the " D ,PRSO " into ">		
		<THE? ,PRSI>
		<TELL D ,PRSI "." CR>
		<RTRUE>)
	       (T
		<TELL-WHY-BOTHER>)>>
	        
<ROUTINE V-POUR-ON ()
	 <COND (<POURABLE? ,PRSO>
		<TELL-WHY-BOTHER>)
	       (T <TELL-YOU-CANT "pour that.">)>>

<ROUTINE V-SHOW ()
	 <COND (<NOT ,PRSI>
		<TELL "Huh?" CR>)
	       (<PRSI? ,PLAYER ,ME>
		<TELL "Do you often talk to " D ,GLOBAL-SELF "?" CR>)
	       (<NOT <FSET? ,PRSI ,VICBIT>>
		<TELL "Don't wait for ">
		<THE? ,PRSI>
		<TELL D ,PRSI " to applaud." CR>)
	       (<==? ,PRSI ,PRSO>
		<TELL "He's already aware of his own presence." CR>)
	       (T
		<TELL "Although ">
		<THE? ,PRSI>
		<TELL D ,PRSI " takes a look, he seems disinterested." CR>)>>

<ROUTINE PRE-SSHOW ()
	 <SETG P-MERGED T>
	 <PERFORM ,V?SHOW ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SSHOW () <TELL "Bug.">>

<ROUTINE V-SPRAY () <V-SQUEEZE>>
<ROUTINE V-SSPRAY () <PERFORM ,V?SPRAY ,PRSI ,PRSO>>

<ROUTINE V-SQUEEZE ()
	  <TELL "How singularly useless." CR>>

;<ROUTINE PRE-OIL ()
	 <TELL "You probably put spinach in your gas tank, too." CR>>

<ROUTINE V-OIL () <TELL "That's not very useful." CR>>

<ROUTINE V-FILL ()
	 <TELL-NO-NO>>

;<ROUTINE V-ADVENTURE () <TELL "A hollow voice says \"Fool.\"" CR>>

<ROUTINE PRE-DRILL ()
	 <COND (<NOT ,PRSI>
		<SETG PRSI ,DRILL>)>
	 <COND (<NOT <PRSI? ,DRILL>>
		<PRE-BURN>)
	       (<NOT <IN? ,DRILL ,PLAYER>>
		<TELL-YOURE-NOT "holding the drill.">)>>

<ROUTINE V-DRILL ()
	 <TELL-YOU-CANT "drill that!">>

<ROUTINE PRE-DRILL-IN ()
	 <COND (<NOT <IN? ,DRILL ,PLAYER>>
		<TELL "A drill might help." CR>)
	       (<OR <PRSO? ,HOLE ,HOLE-1 ,HOLE-2>
		    <PRSO? ,JAGGED-HOLE ,CEILING-HOLE-1 ,CEILING-HOLE-2>
		    <PRSO? ,FLOOR-HOLE-1 ,FLOOR-HOLE-2>>
		<TELL "(with the " D ,DRILL ")" CR>
		<PERFORM ,V?DRILL ,PRSI ,DRILL>
		<RTRUE>)
	       (T
		<SETG CLOCK-WAIT T>
		<TELL "I can't figure out what you mean." CR>)>>

<ROUTINE V-DRILL-IN ()
	 <TELL "Bug." CR>>

<ROUTINE PRE-DRINK ()
	 <COND (<NOT <==? ,WINNER ,PLAYER>>
		<TELL "\"I'm not thirsty.\"" CR>)
	       (<FSET? ,PRSO ,DRINKBIT>
		<COND (<FSET? ,DEEP-SUIT ,WORNBIT>
		       <TELL-IN-WAY>)
		      (<FSET? ,MASK ,WORNBIT>
		       <TELL-IN-WAY <>>)
		      (T <RFALSE>)>)
	       (T <TELL-YOU-CANT "drink that.">)>>

<ROUTINE V-DRINK ()
	 <TELL "I don't think ">
	 <THE? ,PRSO>
	 <TELL D ,PRSO " would go down very well." CR>>

<ROUTINE TELL-IN-WAY ("OPTIONAL" (HOOD? T))
	 <TELL "The ">
	 <COND (.HOOD? <TELL "hood">)
	       (T <TELL D ,MASK>)>
	 <TELL " would get in the way." CR>>

<ROUTINE PRE-EAT ()
	 <COND (<NOT <==? ,WINNER ,PLAYER>>
		<TELL "\"I'm not hungry.\"" CR>)
	       (<AND ,SOUPS-ON
		     <FSET? ,PRSO ,FOODBIT>>
		<COND (<FSET? ,DEEP-SUIT ,WORNBIT>
		       <TELL-IN-WAY>)
		      (<FSET? ,MASK ,WORNBIT>
		       <TELL-IN-WAY <>>)
		      (T <RFALSE>)>)
	       (<AND <==? ,HERE ,SHANTY>
		     <FSET? ,PRSO ,FOODBIT>>
		<TELL "You'll have to buy it first." CR>)
	       (<FSET? ,PRSO ,DRINKBIT>
		<TELL "Try drinking it." CR>)>
	      ;<COND (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <FSET? ,PRSO ,FOODBIT>>
		<COND (<EQUAL? <ITAKE <>> T>
		       <TELL "(Taken)" CR>
		       <RFALSE>)
		      (T <RTRUE>)>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <EQUAL? ,PRSO ,ME ,WINNER ,ADVENTURER>>
		     <FSET? ,PRSO ,FOODBIT>>
		<TELL-YOURE-NOT "holding " <>>
		<THE? ,PRSO>
		<TELL D ,PRSO "." CR>
		<RTRUE>)>>

<ROUTINE V-EAT ()
	 <COND ;(<FSET? ,PRSO ,FOODBIT>
		<REMOVE ,PRSO>
		<TELL "That really hit the spot." CR>)
	       (<FSET? ,PRSO ,PERSON>
		<TELL 
"Cannibalism isn't a good idea. Especially when you're more likely to be the
dinner than the diner." CR>)
	       (T
		<TELL "I don't think that ">
		<THE? ,PRSO>
		<TELL D ,PRSO " would agree with you." CR>)>>

<ROUTINE V-CURSES ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,VICBIT>
		       <TELL "Insults of this nature won't help you." CR>)
		      (T
		       <TELL "And to think that ">
		       <THE? ,PRSO>
		       <TELL D ,PRSO " never said anything bad about you..." CR>)>)
	       (T
		<TELL "You really don't have to swear like a sailor." CR>)>>

<ROUTINE V-LISTEN ()
	 <COND (<FSET? ,PRSO ,VICBIT>
		<TELL "If ">
		<THE? ,PRSO>
		<TELL D ,PRSO " says anything useful, I'll let you know." CR>)
	       (T
		<START-SENTENCE ,PRSO>
		<TELL " makes no sound." CR>)>>

<ROUTINE V-FOLLOW ("AUX" CN CHR COR PCOR L)
	 <SETG L-PRSO ,PRSO>
	 <SETG L-PRSA ,PRSA>
	 <COND (<NOT <==? ,WINNER ,PLAYER>>
		<TELL-FREE-WILL>
		<RFATAL>)
	       (<==? ,PRSO ,PLAYER>
		<TELL "It's not clear whom you're talking to." CR>)
	       (<AND <NOT <FSET? ,PRSO ,PERSON>>
		     <NOT <==? ,PRSO ,DELIVERY-BOY>>>
		<TELL "That doesn't sound very exciting." CR>)
	       (<==? ,HERE <SET L <LOC ,PRSO>>>
		<TELL "You're in the same place as ">
		<THE? ,PRSO>
		<TELL D ,PRSO "!" CR>)
	       (<AND <SET COR <GETP ,HERE ,P?CORRIDOR>>
		     <SET PCOR <GETP .L ,P?CORRIDOR>>
		     <NOT <==? <BAND .COR .PCOR> 0>>>
		<SETG PRSO <COR-DIR ,HERE .L>>
		<SETG P-WALK-DIR ,PRSO>
		<V-WALK>)
	       (<IN? ,PRSO ,FERRY>
		<TELL-CANT-BOARD>)
	       (T
		<TELL "You seem to have lost track of ">
		<THE? ,PRSO>
		<TELL D ,PRSO "." CR>)>>

<ROUTINE TELL-FREE-WILL () <TELL "\"I'll go where I want!\"" CR>>

<ROUTINE V-STAY ()
	 <COND (<==? ,WINNER ,PLAYER>
		<TELL "I'm not going anywhere." CR>)
	       (T
	        <TELL-FREE-WILL>
		<RFATAL>)>>

<ROUTINE V-PRAY ()
	 <TELL "If you pray enough, your prayers may be answered." CR>>

;<ROUTINE V-PRICE ("AUX" COST)
	 <COND (<AND <NOT <IN? ,PRSO ,ROOMS>>
		     <SET COST <GETP ,PRSO ,P?NORTH>>
		     <G? .COST 0>>
		<TELL "The " D ,PRSO " will cost $" N .COST "." CR>)
	       (T <TELL "That's not for sale." CR>)>>

<ROUTINE V-LEAP ("AUX" Z S)
	 <COND (<AND ,PRSO
		     <NOT <PRSO? ,INTDIR>>>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (<SET Z <GETPT ,HERE ,P?DOWN>>
		<SET S <PTSIZE .Z>>
		<COND (<OR <==? .S 2>					 ;NEXIT
			   <AND <==? .S 4>				 ;CEXIT
				<NOT <VALUE <GETB .Z 1>>>>>
		       <JIGS-UP
"This was not a very safe place to try jumping.">)
		      (T <V-SKIP>)>)
	       (T <V-SKIP>)>>

<ROUTINE V-SKIP ()
	 <COND (<FSET? <LOC ,PLAYER> ,VEHBIT>
		<TELL "That would be tough from your current position." CR>)
	       (T <TELL <PICK-ONE ,WHEEEEE> CR>)>>

<ROUTINE V-LEAVE () <DO-WALK ,P?OUT>>

;<GLOBAL HS 0>

<ROUTINE V-HELLO ()
	 <COND (,PRSO
		<TELL-NO-RESPONSE>)
	       (ELSE <TELL <PICK-ONE ,HELLOS> CR>)>>

<ROUTINE V-GOODBYE ()
	 <V-HELLO>
	 ;<COND (,PRSO
		<TELL
"I think that only lunatics say \"Goodbye\" to " A ,PRSO "." CR>)
	       (ELSE <TELL <PICK-ONE ,HELLOS> CR>)>>

<ROUTINE TELL-NO-RESPONSE ()
	 <START-SENTENCE ,PRSO>
	 <TELL " fails to respond." CR>>

<GLOBAL HELLOS
	<PLTABLE "Hello."
	       "Good day."
	       "Nice weather we've been having lately."
	       "Goodbye.">>

<GLOBAL WHEEEEE
	<PLTABLE "Very good. Now you can go to the second grade."
	       "I hope you enjoyed that as much as I did."
	       "Are you enjoying yourself?"
	       "Wheeeeeeeeee!!!!!"
	       "Do you expect me to applaud?">>

;<GLOBAL JUMPLOSS
	<LTABLE "You should have looked before you leaped."
	       "I'm afraid that leap was a bit much for your weak frame."
	       "In the movies, your life would be passing in front of your eyes."
	       "Geronimo.....">>

<ROUTINE PRE-READ ()
	 <COND (<NOT ,LIT> <TELL "It is impossible to read in the dark." CR>)
	       (,PRSI 
		<TELL "How does one look through " A ,PRSI "?" CR>)>>

<ROUTINE V-READ ()
	 <COND (<NOT <FSET? ,PRSO ,READBIT>>
		<TELL "How can I read " A ,PRSO "?" CR>)
	       (T
		<FSET ,PRSO ,TOUCHBIT>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)>>

<ROUTINE V-LOOK-UNDER ()
	 <COND (<FSET? ,PRSO ,VICBIT>
		<TELL "His feet are on the floor." CR>)
	       (<PRSO? ,FOOD ,DRINK-OBJECT ,LIGHTHOUSE ,CLOSET ,GROUND ,OCEAN>
		<TELL <PICK-ONE ,YUKS> CR>)
	       (<IN? ,PRSO ,PLAYER>
		<TELL "You have it." CR>)
	       (T
		<TELL-NOTHING "but ">
	 	<COND (<==? <GETP ,HERE ,P?LINE> ,UNDERWATER-LINE-C>
		       <TELL "seaweed">)
	       	      (<PRSO? ,TRAWLER ,SALVAGER ,FERRY ,GLOBAL-FERRY>
		       <TELL "water">)
		      (T <TELL "dust">)>
	 	<TELL " there." CR>)>>

;<ROUTINE V-LOOK-DOWN () <TELL "You can't see anything down there." CR>>

<ROUTINE V-LOOK-BEHIND ()
	 <TELL-NOTHING "behind ">
	 <THE? ,PRSO>
	 <TELL D ,PRSO "." CR>>

<ROUTINE TELL-NOTHING (STR "OPTIONAL" (DONE? <>))
	 <TELL "There's nothing " .STR>
	 <COND (.DONE? <TELL "." CR>)>>

<ROUTINE PRE-LOOK-IN ()
	 <COND (<FSET? ,PRSO ,SURFACEBIT>
		<TELL "It's solid." CR>)>>

<ROUTINE PRE-LOOK-ON ()
	 <COND (<AND <FSET? ,PRSO ,CONTBIT>
		     <NOT <FSET? ,PRSO ,SURFACEBIT>>>
		<TELL-NOTHING "on ">
		<THE? ,PRSO>
		<TELL D ,PRSO "." CR>)>>

<ROUTINE V-LOOK-INSIDE ("OPTIONAL" (REACH? <>))
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "The " D ,PRSO " is ">
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "open, but you can't tell what's beyond it">)
		      (T <TELL "closed">)>
		<TELL "." CR>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,VICBIT>
		       <TELL-NOTHING "special to be ">
		       <COND (.REACH?
			      <TELL "felt">)
			     (T
			      <TELL "seen">)>
		       <TELL "." CR>)
		      (<SEE-INSIDE? ,PRSO>
		       <COND (<AND <FIRST? ,PRSO> <PRINT-CONT ,PRSO>>
			      <RTRUE>)
			     (<FSET? ,PRSO ,WORNBIT>
			      <TELL "You're wearing it." CR>
			      <RTRUE>)
			     (<FSET? ,PRSO ,SURFACEBIT>
			      <COND (<IN? ,WINNER ,PRSO>
				     <TELL "You're on it!" CR>
				     <RTRUE>)
				    (T
				     <TELL-NOTHING "on the ">
				     <TELL D ,PRSO "." CR>
				     <RTRUE>)>)
			     (T
			      <TELL "The " D ,PRSO " is empty." CR>
			      <RTRUE>)>)
		      (T <TELL-CLOSED ,PRSO <>>)>)
	       (T <TELL "I don't know how to do that." CR>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND <NOT <FSET? .OBJ ,INVISIBLE>>
	      <OR <FSET? .OBJ ,OPENBIT>
		  <FSET? .OBJ ,TRANSBIT>>>>

;<ROUTINE V-REPENT () <TELL "It could very well be too late!" CR>>

<ROUTINE PRE-BURN ()
	 <COND (<NOT ,PRSI>
		<TELL "Huh?" CR>)
	       (T <TELL "With " A ,PRSI "??!?" CR>)>>

<ROUTINE V-BURN ()
	 <TELL-NO-NO>>

<ROUTINE PRE-TURN ()
	 <COND (<PRSO? ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<AND <PRSO? ,PSEUDO-OBJECT>
		     <EQUAL? ,HERE ,MM-WHEELHOUSE ,NW-WHEELHOUSE>>
		<RFALSE>)
	       (<NOT <FSET? ,PRSO ,TURNBIT>>
		<TELL-WHY-BOTHER>)
	       (<AND ,PRSI
		     <EQUAL? ,PRSI ,INTDIR>>
		<TELL-YOU-CANT "turn things to a specific direction.">)>>

<ROUTINE V-TURN () <TELL-NO-EFFECT>>

<ROUTINE TELL-NO-EFFECT () <TELL "This has no effect." CR>>

<ROUTINE V-PUMP ()
	 <TELL "I really don't see how." CR>>

<ROUTINE V-INFLATE () <TELL-HOW-THAT "inflate">>

<ROUTINE V-DEFLATE () <TELL "Come on, now!" CR>>

<ROUTINE V-LOCK () <TELL "It doesn't seem to work." CR>>

<ROUTINE V-PICK () <TELL-YOU-CANT "pick that.">>

<ROUTINE PRE-UNLOCK ()
	 <COND (<PRSO? ,SAFE>
		<RFALSE>)
	       (<AND <NOT ,PRSI>
		     <IN? ,KEY ,PLAYER>>
		<SETG PRSI ,KEY>
		<TELL "(with the room key)" CR>
		<RFALSE>)>>

<ROUTINE V-UNLOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "It's not locked." CR>)
	       (T <V-LOCK>)>>

<ROUTINE V-CUT ()
	 <COND (<NOT ,PRSI>
		<TELL "Huh?" CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL "Not with " A ,PRSI "!" CR>)
	       (<OR <FSET? ,PRSO ,VICBIT>
		    <PRSO? ,SQUID>>
		<IKILL "cut">)
	       (T
		<TELL "Strange concept, cutting " A ,PRSO "..." CR>)>>

<ROUTINE V-KILL ()
	 <IKILL "kill">>

<ROUTINE IKILL (STR)
	 <COND (<NOT ,PRSO>
		<TELL-NOTHING "here to ">
		<TELL .STR "." CR>)
	       (<PRSO? ,SQUID>
		<JIGS-UP
"The squid, angered and wounded, starts wrapping tentacles around you. As you
attempt another foray, you find that the squid's strength is too much for you.">)
	       (<NOT <FSET? ,PRSO ,VICBIT>>
		<TELL 
		    "I've known strange people, but fighting " A ,PRSO "?" CR>)
	       (<OR <NOT ,PRSI>
		    <PRSI? ,ME ,GLOBAL-SELF>>
		<TELL
"Trying to " .STR " " A ,PRSO " with your bare hands is suicidal." CR>)
	       (<NOT <IN? ,PRSI ,WINNER>>
		<TELL "You aren't even holding ">
		<THE? ,PRSI>
		<TELL D ,PRSI "." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL "Trying to " .STR " ">
		<THE? ,PRSO>
		<TELL D ,PRSO " with " A ,PRSI " is suicidal." CR>)
	       (T <TELL-NOT-SMART>)>>

<ROUTINE V-ATTACK () <IKILL "attack">>

<ROUTINE V-SWING ()
	 <COND (<NOT <HELD? ,PRSO>>
		<TELL-YOURE-NOT "Benny Goodman">)
	       (T
		<TELL "Whoosh!" CR>)>>

<ROUTINE V-KICK ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL-NOT-SMART>)
	       (T <HACK-HACK "Kicking">)>>

<ROUTINE TELL-NOT-SMART ()
	 <TELL "That wouldn't be too smart." CR>>

<ROUTINE V-WAVE () <HACK-HACK "Waving">>

<ROUTINE V-WAVE-AT ()
	 <COND (<AND ,PRSO
		     <FSET? ,PRSO ,VICBIT>>
		<START-SENTENCE ,PRSO>
		<TELL " acknowledges your greeting." CR>)
	       (T
		<TELL-NO-RESPONSE>)>>

;<ROUTINE V-RAISE () <HACK-HACK "Playing in this way with">>

<ROUTINE V-LOWER () <HACK-HACK "Playing in this way with">>

<ROUTINE V-RUB ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL-HANDS-OFF>)
	       (T <HACK-HACK "Fiddling with">)>>

<ROUTINE TELL-HANDS-OFF ()
	 <TELL "\"Get your hands off me!\"" CR>>

<ROUTINE V-PUSH ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL-HANDS-OFF>)
	       (<IN? ,WINNER ,PRSO>
		<TELL-CONTORT>)
	       (<FSET? ,PRSO ,PUSHBIT>
		<TELL-MOVES-BIT>)
	       (T <HACK-HACK "Pushing">)>>

<ROUTINE TELL-MOVES-BIT ()
	 <START-SENTENCE ,PRSO>
	 <TELL " moves a bit." CR>>

<ROUTINE V-PUSH-OFF ()
	 <COND (<AND <FSET? ,PRSI ,SURFACEBIT>
		     <IN? ,PRSO ,PRSI>>
		<MOVE ,PRSO <LOC ,PRSI>>
		<TELL-NOW ,PRSO "on the floor">)
	       (T <TELL "A ludicrous idea at best." CR>)>>

;<ROUTINE PRE-PUSH-TO ()
	 <COND (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
		    <IN? ,PRSO ,LOCAL-GLOBALS>>
		<TELL "Nice try." CR>)
	       (<PRSO? ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<PRSO? ,SARCOPH>
		<TELL "Be serious. Any idea what that must weigh?" CR>
		<RTRUE>)
	       (<AND <NOT <IN? ,PRSO <LOC ,WINNER>>>
		     <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <EQUAL? ,PRSO ,NOT-HERE-OBJECT>>>
		<START-SENTENCE ,PRSO>
		<TELL "? Get serious." CR>)>>

<ROUTINE V-PUSH-TO ("AUX" (FALLEN <>) OH F)
	 <COND (<IN? ,WINNER ,PRSO>
		<TELL-CONTORT>)
	       (<NOT <FSET? ,PRSO ,PUSHBIT>>
		<COND (<FSET? ,PRSO ,TAKEBIT>
		       <TELL 
"There's no need for that. Why not just pick it up and then carry it there?" 
			CR>
		       <RTRUE>)
	       	      (<PRSO? ,ME>
		       <TELL "Do it yourself." CR>)
		      (<FSET? ,PRSO ,VICBIT>
		       <TELL-HANDS-OFF>)
		      (T
		       <TELL "You push and strain, but can't budge ">
		       <THE? ,PRSO>
		       <TELL D ,PRSO "." CR>)>)
	       (<NOT <EQUAL? ,PRSI ,INTDIR>>
		<TELL-YOU-CANT "push things to that.">
		<RTRUE>)
	       (<AND <SET OH ,HERE>
		     <NOT <==? <DO-WALK ,P-WALK-DIR> ,M-FATAL>>>
		<REPEAT ()
		   <COND (<SET F <FIRST? ,PRSO>>
			  <MOVE .F .OH>
			  <SET FALLEN T>)
			 (T <RETURN>)>>
		<MOVE ,PRSO ,HERE>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL "You bring the " D ,PRSO " along with you.">
		<COND (.FALLEN <TELL-ALL-FALL>)>
		<CRLF>)>>

<ROUTINE TELL-CONTORT ()
	 <TELL "That would require some impressive contortions." CR>>

<ROUTINE TELL-ALL-FALL ()
	 <TELL " Everything that was on it falls off.">>

<ROUTINE PRE-CHIP ()
	 <COND (<AND <EQUAL? <GET ,P-VTBL 0> ,W?CHIP>
		     <IN? ,SPEAR-CARRIER ,HERE>
		     <PRSO? ,INTNUM>
		     ,P-DOLLAR-FLAG>
		<PERFORM ,V?GIVE ,PRSO ,SPEAR-CARRIER>)
	       (T <PERFORM ,V?MUNG ,PRSO>)>
	 <RTRUE>>

<ROUTINE V-CHIP ()
	 <TELL "Bug." CR>>

<ROUTINE PRE-MUNG ()
	 <COND (<PRSO? ,NOT-HERE-OBJECT ,ME ,WINNER ,ADVENTURER ,GLOBAL-BANK
		       ,MIRROR>
		<RFALSE>)
	       (<AND ,PRSI <FSET? ,PRSI ,WEAPONBIT>>
		<RFALSE>)
	       (<AND <NOT <FSET? ,PRSO ,VICBIT>>
		     <NOT <PRSO? ,SQUID>>>
		<HACK-HACK "Trying to destroy">
		<RTRUE>)>
	 <TELL "Trying to destroy ">
	 <THE? ,PRSO>
	 <TELL D ,PRSO " with ">
	 <COND (<NOT ,PRSI>
		<TELL "your bare hands is suicidal">)
	       (T
		<TELL A ,PRSI " is insane">)>
	 <TELL "." CR>>

<ROUTINE V-MUNG ()
	 <COND (<OR <FSET? ,PRSO ,VICBIT>
		    <PRSO? ,SQUID>>
		<IKILL "attack">)
	       (T <TELL "Nothing much happens." CR>)>>

<ROUTINE HACK-HACK
	 (STR)
	 <COND (<AND <IN? ,PRSO ,GLOBAL-OBJECTS> <VERB? WAVE LOWER>>
		<TELL "Unfortunately, ">
		<THE? ,PRSO>
		<TELL D ,PRSO " isn't here." CR>)
	       (T <TELL .STR " ">
		  <THE? ,PRSO>
		  <TELL D ,PRSO <PICK-ONE ,HO-HUM> CR>)>>

<GLOBAL HO-HUM
	<LTABLE
	 " doesn't seem to work."
	 " isn't notably helpful."
	 " doesn't work."
	 " has no effect.">>

;<ROUTINE WORD-TYPE
	 (OBJ WORD "AUX" SYNS)
	 <ZMEMQ .WORD
		<SET SYNS <GETPT .OBJ ,P?SYNONYM>>
		<- </ <PTSIZE .SYNS> 2> 1>>>

<ROUTINE V-KNOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL-NO-ANSWER>)
	       (T <TELL "Why knock on " A ,PRSO "?" CR>)>>

<ROUTINE V-CHOMP ()
	 <TELL "I don't know how to do that. I win in all cases!" CR>>

;<ROUTINE V-FROBOZZ
	 ()
	 <TELL
"The FROBOZZ Corporation created, owns, and operates this programmer." CR>>

<ROUTINE V-WIN () <TELL "Naturally!" CR>>

<ROUTINE V-YELL ()
	 <COND (,PRSO
		<TELL "You could be more polite and lower your voice." CR>)
	       (T <TELL "Aarrrrrgggggggghhhhhhhhhhh!" CR>)>>

<ROUTINE V-PLUG () <TELL-NO-EFFECT>>

;<ROUTINE V-EXORCISE () <TELL "What a bizarre concept!" CR>>

\

;<ROUTINE PRE-LATITUDE ("AUX" P)
 <COND (<NOT <==? ,WINNER ,PLAYER>>
	<RFALSE>)
       (<AND ,QCONTEXT
	     <==? ,HERE ,QCONTEXT-ROOM>
	     <==? ,HERE <META-LOC ,QCONTEXT>>>
	<SETG WINNER ,QCONTEXT>
	<PERFORM ,PRSA ,PRSO>
	<SETG WINNER ,PLAYER>
	<RTRUE>)
       ;(<SET P <FIND-FLAG ,HERE ,PERSON ,WINNER>>
	<PERFORM ,V?ASK-ABOUT .P ,PRSO>
	<RTRUE>)>>

<ROUTINE V-LATITUDE ("OPTIONAL" (LAT T) "AUX" STR (NEW <>))
	 <COND (.LAT <SET STR "latitude">)
	       (T <SET STR "longitude">)>
	 <COND (<==? ,WINNER ,PLAYER>
		<TELL "Why don't you tell someone who cares?" CR>
		<RFATAL>)
	       (<L? ,MEETINGS-COMPLETED 2>
		<START-SENTENCE ,WINNER>
		<TELL
" looks bewildered. \"What does that have to do with anything?\" he asks." CR>
		<RFATAL>)
	       (<NOT <==? ,WINNER ,JOHNNY>>
		<START-SENTENCE ,WINNER>
		<TELL
" says, \"That's nice. Why don't you let the captain know?\"" CR>
		<RFATAL>)
	       (<NOT <==? ,PRSO ,INTNUM>>
		<TELL
"Johnny looks at you strangely. \"What kind of a " .STR " is that?\"" CR>)
	       (<G? ,P-NUMBER 59>
		<TELL "\"There are 60 minutes in a degree.\"" CR>)
	       (T
		<COND (.LAT
		       <COND (,LATITUDE-SET
			      <COND (<==? ,LATITUDE-SET ,P-NUMBER>
				     <SET NEW ,M-FATAL>)
				    (T <SET NEW T>)>)>
		       <SETG LATITUDE-SET ,P-NUMBER>)
		      (T
		       <COND (,LONGITUDE-SET
			      <COND (<==? ,LONGITUDE-SET ,P-NUMBER>
				     <SET NEW ,M-FATAL>)
				    (T <SET NEW T>)>)>
		       <SETG LONGITUDE-SET ,P-NUMBER>)>
		<COND (<==? .NEW ,M-FATAL>
		       <TELL-YOU-ALREADY "told me that.\"" T>)
		      (.NEW
		       <TELL "\"Now the " .STR " is " N ,P-NUMBER ", huh?\"" CR>)
		      (T <TELL "\"Okay. The " .STR " is " N ,P-NUMBER ".\"" CR>)>)>>

<ROUTINE V-LONGITUDE ()
	 <V-LATITUDE <>>>

<GLOBAL LATITUDE-SET 0>
<GLOBAL LONGITUDE-SET 0>

<ROUTINE V-EMPTY ("AUX" X)
	 <COND (<NOT <FSET? ,PRSO ,CONTBIT>>
		<TELL-YOU-CANT "empty that!">)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL-YOU-CANT "empty it when it's closed!">)
	       (<FIRST? ,PRSO>
		       <REPEAT ()
			       <COND (<SET X <FIRST? ,PRSO>>
			              <MOVE .X ,HERE>)
			             (ELSE <RETURN>)>>
		       <TELL-NOW ,PRSO "empty">)
	       (T
		<TELL-NOTHING "in the ">
		<TELL D ,PRSO "." CR>)>>

<ROUTINE V-SHAKE ("AUX" X)
	 <COND (<FSET? ,PRSO ,VICBIT>
		<TELL-NO-EFFECT>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<TELL-YOU-CANT "take it; thus, you can't shake it!">)
	       (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
		     <FIRST? ,PRSO>>
		<TELL "It sounds as if there is something inside the "
		      D
		      ,PRSO
		      "."
		      CR>)
	       (<AND <FSET? ,PRSO ,OPENBIT> <FIRST? ,PRSO>>
		<REPEAT ()
			<COND (<SET X <FIRST? ,PRSO>> <MOVE .X ,HERE>)
			      (ELSE <RETURN>)>>
	        <TELL "All of the objects spill onto the ">
		<SPILL-WHERE?>)
	       (T
		<TELL-NOTHING "in the ">
		<TELL D ,PRSO "." CR>)>>

<ROUTINE SPILL-WHERE? ()
	 <COND (<IN? ,WINNER ,BED>
		<TELL
		 "floor by your bed.">)
	       (<G? <GETP ,HERE ,P?LINE> ,BACK-ALLEY-LINE-C>
		<TELL
		 "deck by your feet.">)
	       (T <TELL "floor.">)>
	 <CRLF>>

<ROUTINE V-DIAGNOSE ()
	 <TELL "You are ">
	 <COND (<G? ,HOW-HUNGRY 3>
		<TELL "extremely">)
	       (<==? ,HOW-HUNGRY 0>
		<TELL "not">)
	       (<==? ,HOW-HUNGRY 1>
		<TELL "a bit">)
	       (<==? ,HOW-HUNGRY 2>
		<TELL "pretty">)
	       (<==? ,HOW-HUNGRY 3>
		<TELL "very">)>
	 <TELL " hungry, ">
	 <COND (<==? ,HOW-THIRSTY 0>
		<TELL "not thirsty">)
	       (<==? ,HOW-THIRSTY 1>
		<TELL "a little thirsty">)
	       (<==? ,HOW-THIRSTY 2>
		<TELL "fairly thirsty">)
	       (<==? ,HOW-THIRSTY 3>
		<TELL "very thirsty">)
	       (<G? ,HOW-THIRSTY 3>
		<TELL "utterly parched">)>
	 <TELL ", and ">
	 <COND (<==? ,HOW-TIRED 0>
		<TELL "half-awake">)
	       (<L? ,HOW-TIRED 3>
		<TELL "wide-awake">)
	       (<==? ,HOW-TIRED 3>
		<TELL "a bit drowsy">)
	       (<==? ,HOW-TIRED 4>
		<TELL "fairly tired">)
	       (<==? ,HOW-TIRED 5>
		<TELL "very sleepy">)
	       (<==? ,HOW-TIRED 6>
		<TELL "dead on your feet">)>
	 <TELL "." CR>>

<ROUTINE PRE-DIG () 
	 <COND (<PRSO? ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<NOT ,PRSI>
		<TELL "Huh?" CR>)
	       (<FSET? ,PRSI ,TOOLBIT>
		<RFALSE>)
	       (T
		<TELL "Digging with ">
		<THE? ,PRSI>
		<TELL D ,PRSI " is very silly." CR>)>>

<ROUTINE V-AIM ()
	 <TELL "That would be pointless." CR>>

<ROUTINE V-DIG ()
	 <TELL-YOU-CANT "dig it, man.">>

<ROUTINE PRE-SMELL ()
	 <COND (<OR <FSET? ,MASK ,WORNBIT>
		    <FSET? ,DEEP-SUIT ,WORNBIT>>
		<TELL-YOU-CANT "smell anything beyond your mask.">)>>

<ROUTINE V-SMELL ()
	 <COND (<FSET? ,PRSO ,VICBIT>
		<TELL "Nothing a good deodorant couldn't fix." CR>)
	       (T <TELL "It smells just like " A ,PRSO "." CR>)>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" Z)
	 <COND (<SET Z <GETPT .OBJ2 ,P?GLOBAL>>
		<ZMEMQB .OBJ1 .Z <- <PTSIZE .Z> 1>>)>>

<ROUTINE V-SWIM ()
	 <COND (<==? <GETP ,HERE ,P?LINE> ,UNDERWATER-LINE-C>
		<COND (<==? ,PRSO ,INTDIR>
		       <DO-WALK ,P-WALK-DIR>)
		      (T <TELL-SHD-DIR>
			 ;<TELL "You should supply a " D ,INTDIR "." CR>)>)
	       (T <TELL "I think you're all wet." CR>)>>

<ROUTINE V-DIVE ()
	 <COND (<AND ,PRSO <NOT <PRSO? ,OCEAN>>>
		<TELL "This isn't a circus!" CR>)
	       (<==? <GETP ,HERE ,P?LINE> ,UNDERWATER-LINE-C>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<AND <GLOBAL-IN? ,OCEAN <LOC ,PLAYER>>
		     <NOT <EQUAL? ,HERE ,MM-WHEELHOUSE ,NW-WHEELHOUSE>>>
		<COND (<AND <L? <GETP ,HERE ,P?LINE> ,TRAWLER-LINE-C>
			    <NOT <EQUAL? ,HERE ,FERRY-LANDING ,WHARF>>>
		       <PERFORM ,V?BOARD ,OCEAN>
		       <RTRUE>)
		      (<AND <NOT <FSET? ,DEEP-SUIT ,WORNBIT>>
			    <OR <NOT <FSET? ,WET-SUIT ,WORNBIT>>
				<NOT <IN? ,AIR-TANK ,PLAYER>>
				<NOT <FSET? ,MASK ,WORNBIT>>
				<NOT <FSET? ,FLIPPERS ,WORNBIT>>>>
		       <JIGS-UP
"You find that diving here is a bad idea without the proper equipment.">)
		      (<AND <FSET? ,DEEP-SUIT ,WORNBIT>
			    <OR <NOT <IN? ,AIR-HOSE ,DEEP-SUIT>>
				<NOT <FSET? ,MM-COMPRESSOR ,ONBIT>>>>
		       <JIGS-UP
"You find that the lack of oxygen you quickly encounter is fatally frustrating.">)
		      (<NOT ,AT-SEA>
		       <JIGS-UP
"You find the water here too shallow for diving.">)
		      (T
		       ;<COND (<AND <L? ,TIME-SLEPT 300>
		     	           <L? ,HOW-TIRED 4>>
		      	      <SETG HOW-TIRED 4>
			      <ENABLE <QUEUE I-TIRED 5>>)>
		       <COND (<==? ,OCEAN-BOTTOM 50>
			      <SETG HERE ,OCEAN-FLOOR>
			      <MOVE ,PLAYER ,OCEAN-FLOOR>)
			     (T
			      <MOVE ,PLAYER ,UNDERWATER>
		       	      <SETG HERE ,UNDERWATER>
			      <UNDERWATER-F ,M-ENTER>)>
		       <FCLEAR ,OCEAN ,VEHBIT>
		       <DISABLE <INT I-ENDIT>>
		       <SETG DEPTH 50>
		       <COND (<IN? ,PASSBOOK ,PLAYER>
			      <FSET ,PASSBOOK ,RMUNGBIT>)>
		       <COND (<IN? ,DIVING-BOOK ,PLAYER>
			      <FSET ,DIVING-BOOK ,RMUNGBIT>)>
		       <COND (<IN? ,NOTE ,PLAYER>
			      <FSET ,NOTE ,RMUNGBIT>)>
		       <COND (<IN? ,BOOK ,PLAYER>
			      <FSET ,BOOK ,RMUNGBIT>)>
		       <COND (<IN? ,ENVELOPE ,PLAYER>
			      <FSET ,ENVELOPE ,RMUNGBIT>)>
		       <COND (<OR <IN? ,BATTERY ,PLAYER>
				  <AND <IN? ,BATTERY ,DRILL>
				       <FSET? ,DRILL ,OPENBIT>>>
			      <FSET ,BATTERY ,RMUNGBIT>
			      <SETG ,DRILL-POWERED <>>)>
		       <COND (<OR <IN? ,DRY-CELL ,PLAYER>
				  <AND <IN? ,DRY-CELL ,DETECTOR-COMPARTMENT>
				       <FSET? ,DETECTOR-COMPARTMENT ,OPENBIT>>>
			      <FSET ,DRY-CELL ,RMUNGBIT>
			      <SETG ,DETECTOR-POWERED <>>)>
		       <COND (<AND <IN? ,AIR-TANK ,PLAYER>
				   <NOT <FSET? ,DEEP-SUIT ,WORNBIT>>>
			      <ENABLE <QUEUE I-AIR-SUPPLY -1>>)
			     (<G? <GET <INT I-MM-COMPRESSOR> ,C-TICK> 0>
			      <ENABLE <INT I-MM-COMPRESSOR>>)
			     (T <ENABLE <INT I-LAST-GASP>>)>
		       <V-LOOK>)>)
	       (T <TELL
"Consulting your years of experience, you come to the conclusion that the lack
of water here would make this a lousy place to try diving." CR>)>>

<ROUTINE V-UNTIE ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL <PICK-ONE ,YUKS> CR>)
	       (T <TELL "This cannot be tied, so it cannot be untied!" CR>)>>

<ROUTINE PRE-TIE ()
	 <COND (<PRSO? ,AIR-HOSE>
		<RFALSE>)
	       (<AND <NOT <PRSO? ,SAFETY-LINE ,ROPE>>
		     <NOT <PRSI? ,SAFETY-LINE ,ROPE>>>
		<TELL "Even if I knew how to do that, I wouldn't." CR>)
	       (<OR <PRSI? ,WINNER>
		    <PRSO? ,WINNER>>
		<TELL-YOU-CANT "tie it to yourself.">)>>

<ROUTINE V-TIE ()
	 <TELL "Don't bother." CR>>

<ROUTINE V-TIE-UP () <TELL "You could certainly never tie it with that!" CR>>

<ROUTINE V-MELT () <TELL "I'm not sure that " A ,PRSO " can be melted." CR>>

<ROUTINE V-MUMBLE
	 ()
	 <TELL "You'll have to speak up if you expect me to hear you!" CR>>

<ROUTINE V-ALARM ()
	 <COND (<OR <AND <PRSO? ,ROOMS>
			 <NOT <==? ,WINNER ,PLAYER>>>
		    <AND <FSET? ,PRSO ,VICBIT>
			 <NOT <PRSO? ,ME>>>>
		<TELL "He's wide awake, or haven't you noticed?" CR>
		;<COND (<OR <IN? ,PRSO ,MM-CREW-QTRS>
			   <IN? ,PRSO ,NW-CREW-QTRS>>
		       <START-SENTENCE ,PRSO>
		       <TELL
" turns over, looks at you, mumbles something, and falls back asleep." CR>)
		      (T <TELL "He's wide awake, or haven't you noticed?" CR>)>)
	       (<PRSO? ,ROOMS>
		<TELL "You're already awake." CR>)
	       (T
		<START-SENTENCE ,PRSO>
		<TELL " isn't sleeping." CR>)>>

;<ROUTINE V-ZORK () <TELL "I highly recommend it." CR>>

\

;<ROUTINE MUNG-ROOM (RM STR)
	 <FSET .RM ,RMUNGBIT>
	 <PUTP .RM ,P?LDESC .STR>>

;<ROUTINE V-COMMAND ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL "You notice that " D ,PRSO " pays no attention." CR>)
	       (T
		<TELL-NO-RESPONSE>)>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<OR <FSET? ,PRSO ,CLIMBBIT>
		    <FSET? ,PRSO ,VEHBIT>>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (T
		<TELL-YOU-CANT "climb onto " <>>
	 	<THE? ,PRSO>
	 	<TELL D ,PRSO "." CR>)>>

<ROUTINE V-CLIMB-FOO ()
	 <COND (<PRSO? ,ROOMS>
		<V-CLIMB-UP>)
	       ;(<EQUAL? ,PRSO ,INTDIR>
		<TELL-YOU-CANT "climb a direction!">
		<RFATAL>)
	       (<AND <NOT <FSET? ,PRSO ,CLIMBBIT>>
		     <NOT <FSET? ,PRSO ,VEHBIT>>>
		<TELL-YOU-CANT "climb " <>>
		<TELL A ,PRSO "!" CR>
		<RFATAL>)
	       (T
		<V-CLIMB-UP ,P?UP T>)>>

<ROUTINE V-CLIMB-UP ("OPTIONAL" (DIR ,P?UP) (OBJ <>) "AUX" X)
	 <COND (<GETPT ,HERE .DIR>
		<DO-WALK .DIR>
		<RTRUE>)
	       (<NOT .OBJ>
		<TELL-NO-GO T>)
	       (<AND .OBJ
		     <ZMEMQ ,W?WALLS
			    <SET X <GETPT ,PRSO ,P?SYNONYM>> <PTSIZE .X>>>
		<TELL "Climbing the walls is to no avail." CR>)
	       (T <TELL "Bizarre!" CR>)>>

<ROUTINE V-CLIMB-DOWN ()
	 <V-CLIMB-UP ,P?DOWN>>

<ROUTINE V-SEND ()
	 <COND (<FSET? ,PRSO ,VICBIT>
		<TELL "I doubt that ">
		<THE? ,PRSO>
		<TELL D ,PRSO " is at your beck and call." CR>)
	       (T <TELL "That doesn't make sends." CR>)>>

<ROUTINE V-WIND ()
	 <TELL "You cannot wind up " A ,PRSO "." CR>>

<ROUTINE V-COUNT ()
	 <TELL "I can't deal with those numbers." CR>>

<ROUTINE PRE-BRACE ()
	 <PERFORM ,V?PUT-UNDER ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-BRACE ()
	 <TELL "Bug." CR>>

<ROUTINE V-PUT-UNDER ()
         <COND (<AND <FSET? ,PRSI ,DOORBIT>
		     <L? <GETP ,PRSO ,P?SIZE> 5>>
		<COND (<FSET? ,PRSI ,OPENBIT>
		       <TELL-WHY-BOTHER>)
		      (<IDROP>
		       <MOVE ,PRSO <OTHER-SIDE ,PRSI T>>
		       <TELL "Done." CR>)>)
	       (T <TELL-NO-NO>)>>

<ROUTINE V-PUSH-UNDER ()
	 <COND (<OR <FSET? ,PRSO ,TAKEBIT>
		    <FSET? ,PRSO ,PUSHBIT>>
		<PERFORM ,V?PUT-UNDER ,PRSO ,PRSI>
		<RTRUE>)
	       (T <TELL-NO-NO>)>>

<ROUTINE V-PLAY ()
         <COND (<FSET? ,PRSO ,VICBIT>
	        <TELL "You are so engrossed in the role of ">
		<THE? ,PRSO>
		<TELL D ,PRSO>
	        <JIGS-UP " that you kill yourself, just as he would have done!">)
	       (T <TELL "How peculiar!" CR>)>>

<ROUTINE V-MAKE ()
    	<TELL-NO-NO>>

<ROUTINE V-ENTER ()
	 <COND (<EQUAL? ,HERE ,WINDING-ROAD-1>
	        <PERFORM ,V?THROUGH ,LIGHTHOUSE>
		<RTRUE>)
	       (T <DO-WALK ,P?IN>)>>

<ROUTINE V-EXIT ()
	 <DO-WALK ,P?OUT>>

<ROUTINE V-CROSS ()
	 <TELL-YOU-CANT "cross that!">>

<ROUTINE V-SEARCH ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<START-SENTENCE ,PRSO>
		<TELL " glares at you. \"Get away from me!\" he growls." CR>)
	       (<FSET? ,PRSO ,CONTBIT>
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)
	       (T <TELL "You find nothing unusual." CR>)>>

<ROUTINE V-FIND ("AUX" (L <LOC ,PRSO>))
	 <COND (<NOT <==? ,WINNER ,PLAYER>>
		<TELL "\"Find ">
		<COND (<FSET? ,PRSO ,VICBIT>
		       <TELL "him ">)
		      (T <TELL "it ">)>
		<TELL D ,GLOBAL-SELF ".\"" CR>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<TELL "Why don't you try finding it " D ,GLOBAL-SELF "?" CR>)
	       (<IN? ,PRSO ,WINNER>
		<TELL "You have it." CR>)
	       (<OR <IN? ,PRSO ,HERE>
		    <==? ,PRSO ,PSEUDO-OBJECT>>
		<COND (<FSET? ,PRSO ,VICBIT>
		       <TELL "He's">)
		      (T <TELL "It's">)>
		<TELL " right here." CR>)
	       (<OR <IN? .L ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>>
		<COND (<FSET? .L ,PERSON>
		       <TELL "You notice that " D .L " has it." CR>)
		      (<FSET? .L ,CONTBIT>
		       <TELL "It's " <VEHPREP .L> " the " D .L "." CR>)
		      (<==? .L ,FERRY>
		       <TELL "He's on the ferry." CR>)
		      (T <TELL "It's around here somewhere." CR>)>)
	       (T
		<TELL "Find ">
		<COND (<FSET? ,PRSO ,VICBIT>
		       <TELL "him">)
		      (T <TELL "it">)>
		<TELL " " D ,GLOBAL-SELF "." CR>)>>

<ROUTINE PRE-TELL ()
	 <COND (<AND ,PRSI
		     <EQUAL? ,PRSO ,ME ,PLAYER>>
		<COND (<NOT <==? ,WINNER ,PLAYER>>
		       <SETG PRSA ,V?ASK-ABOUT>
		       <PERFORM ,V?ASK-ABOUT ,WINNER ,PRSI>)
		      (T
		       <SETG PRSA ,V?ASK-CONTEXT-ABOUT>
		       <PERFORM ,V?ASK-CONTEXT-ABOUT ,PRSI>)>
		<RTRUE>)
	       (<AND <NOT ,PRSI>
		     <NOT <FSET? ,PRSO ,VICBIT>>>
		<TELL-NO-TELL>)>>

<ROUTINE V-TELL ()
	 <COND (,PRSI
		<COND (<FSET? ,PRSO ,PERSON>
		       <START-SENTENCE ,PRSO>
		       <TELL 
" seems less than impressed with this information." CR>)
		      (<OR <FSET? ,PRSO ,VICBIT>
			   <==? ,PRSO ,SQUID>>
		       <TELL "The " D ,PRSO " ignores what you have to say." CR>)
		      (T
		       <TELL-NO-RESPONSE>)>)
	       (<AND <==? ,WINNER ,PLAYER>
		     <EQUAL? ,PRSO ,ME ,WINNER>>
		<TELL
"Talking to " D ,GLOBAL-SELF " is diverting, but unnecessary." CR>
		<RFATAL>)
	       (<PRSO? ,ME ,PLAYER>
		<TELL "\"What in the world are you trying to say?\"" CR>
		<RFATAL>)
	       (<FSET? ,PRSO ,VICBIT>
		<COND (<NOT <==? <META-LOC ,PRSO> ,HERE>>
		       <GLOBAL-NOT-HERE-PRINT ,PRSO>
		       <RFATAL>)
		      (<AND <NOT <==? ,WINNER ,PLAYER>>
			    <NOT ,P-CONT>>
		       <TELL "\"I'll talk to whoever I want.\"" CR>
		       <RFATAL>)>
		<SETG WINNER ,PRSO>
		<SETG HERE <META-LOC ,WINNER>>
		<SETG QCONTEXT ,WINNER>
		<SETG QCONTEXT-ROOM ,HERE>
		<COND (<NOT ,P-CONT>
		       <START-SENTENCE ,PRSO>
		       <TELL 
" turns and looks at you as though he thought you were about to say something." CR>
		       <RFATAL>)>)
	       (T
		<TELL-NO-TELL>)>>

<ROUTINE TELL-NO-TELL ()
	 <TELL-YOU-CANT "talk to " <>>
	 <THE? ,PRSO>
	 <TELL D ,PRSO "!" CR>
	 <SETG QUOTE-FLAG <>>
	 <SETG P-CONT <>>
	 <RFATAL>>

;<ROUTINE V-ANSWER ()
	 <TELL "Nobody seems to be awaiting your answer." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

;<ROUTINE V-REPLY ()
	 <TELL "It is hardly likely that the " D ,PRSO " is interested." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

;<ROUTINE V-IS-IN ()
	 <COND (<IN? ,PRSO ,PRSI>
		<TELL "Yes, it is ">
		<COND (<FSET? ,PRSI ,SURFACEBIT>
		       <TELL "on">)
		      (T <TELL "in">)>
		<TELL " the " D ,PRSI "." CR>)
	       (T <TELL "No, it isn't." CR>)>>

<ROUTINE V-KISS ()
	 <TELL "I'd sooner kiss a parrot." CR>>

<ROUTINE V-RAPE ()
	 <TELL "An ugly idea from an ugly person." CR>>

<ROUTINE FIND-IN (WHERE WHAT "AUX" W (R <>));"returns FALSE if no matches, the
			      		      match if 1, or M-FATAL if >1"
	 <SET W <FIRST? .WHERE>>
	 <COND (<NOT .W> <RFALSE>)>
	 <REPEAT ()
		 <COND (<FSET? .W .WHAT>
			<COND (.R <RFATAL>)
			      (T <SET R .W>)>)
		       (<NOT <SET W <NEXT? .W>>> <RETURN>)>>
	 <RETURN .R>>

<ROUTINE V-SAY ("AUX" V)
	 <COND (<SET V <FIND-IN ,HERE ,VICBIT>>
		<TELL "You must address ">
		<COND (<==? .V ,M-FATAL>
		       <TELL "someone">)
		      (T
		       <THE? .V>
		       <TELL D .V>)>
		<TELL " directly." CR>
		<RFATAL>)
	       (<==? <GET ,P-LEXV ,P-CONT> ,W?HELLO>
		<SETG QUOTE-FLAG <>>
		<RTRUE>)
	       (ELSE
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<TELL
"Talking to " D ,GLOBAL-SELF
" is said to be a sign of impending mental collapse." CR>)>>

;<ROUTINE V-INCANT ()
	 <TELL
"The incantation echoes back faintly, but nothing else happens." CR>
	 <SETG QUOTE-FLAG <>>
	 <SETG P-CONT <>>
	 <RTRUE>>

<ROUTINE V-SPIN ()
	 <TELL-YOU-CANT "spin that!">>

<ROUTINE V-THROUGH ("AUX" M)
	<COND (<FSET? ,PRSO ,DOORBIT>
	       <DO-WALK <OTHER-SIDE ,PRSO>>
	       <RTRUE>)
	      (<OR <FSET? ,PRSO ,VEHBIT>
		   <AND <==? ,HERE ,MCGINTY-HQ>
			<PRSO? ,PSEUDO-OBJECT>>>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<AND <NOT <IN? ,PRSO ,GLOBAL-OBJECTS>>
		    <NOT <==? <META-LOC ,PRSO> ,HERE>>
		    <NOT <GLOBAL-IN? ,PRSO ,HERE>>>
	       <GLOBAL-NOT-HERE-PRINT ,PRSO>)
	      (<NOT <FSET? ,PRSO ,TAKEBIT>>
	       <TELL "You hit your head against ">
	       <THE? ,PRSO>
	       <TELL D ,PRSO " as you attempt this feat." CR>)
	      (<IN? ,PRSO ,WINNER>
	       <TELL-CONTORT>)
	      (T <TELL <PICK-ONE ,YUKS> CR>)>>

<GLOBAL YUKS
	<PLTABLE "Not a chance."
		"No way. At least not in this reality."
		"Did you say that just to impress me?"
		"An interesting concept, but beyond this reality."
    		"I'll give you the benefit of the doubt and just ignore that."
		"A fishy idea..."
		"What a concept!"
		"Not a prayer.">>

<ROUTINE V-STEP ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (<PRSO? ,GROUND>
		<TELL "Fred Astaire you're not." CR>)
	       (T <TELL "That sounds pretty useless." CR>)>>

<ROUTINE V-WEAR ()
	 <COND (<NOT <FSET? ,PRSO ,WEARBIT>>
		<TELL-YOU-CANT "wear " <>>
		<THE? ,PRSO>
		<TELL D ,PRSO "." CR>)
	       (<FSET? ,PRSO ,WORNBIT>
		<TELL "You are already wearing it." CR>)
	       (<OR <IN? ,PRSO ,WINNER>
		    <ITAKE>>
		<FSET ,PRSO ,WORNBIT>
		<TELL "You are now wearing ">
		<THE? ,PRSO>
		<TELL D ,PRSO "." CR>)>>

<ROUTINE UNWEAR ()
	 <COND (<FSET? ,PRSO ,WORNBIT>
		<FCLEAR ,PRSO ,WORNBIT>
		<TELL "You are now holding ">
		<THE? ,PRSO>
		<TELL D ,PRSO "." CR>)
	       (T <TELL-YOURE-NOT "wearing that!">)>>

<ROUTINE V-WITHDRAW ()
	 <COND (<NOT <PRSO? ,INTNUM>>
		<PERFORM ,V?TAKE ,PRSO>)
	       (T <TELL-YOU-CANT "make a withdrawal here!">)>>

<ROUTINE V-DEPOSIT ()
	 <COND (<NOT <PRSO? ,INTNUM>>
		<PERFORM ,V?PUT ,PRSO ,PRSI>)
	       (T <TELL-YOU-CANT "make a deposit here!">)>>

<ROUTINE V-THROW-OFF ()
	 <TELL-YOU-CANT "throw anything off that!">>

<ROUTINE V-$VERIFY ()
	 <TELL "Verifying game..." CR>
	 <COND (<VERIFY> <TELL "Yup. Game correct." CR>)
	       (T <TELL "** UH OH! Game File Failure. **" CR>)>>

<ROUTINE V-STAND ()
	 <COND (,PRSO
		<COND (<OR <PRSO? ,GLOBAL-BANK>
		    	   <FSET? ,PRSO ,VICBIT>>
		       <PERFORM ,V?ROB ,PRSO>
		       <RTRUE>)
	       	      (<FSET? ,PRSO ,VEHBIT>
		       <PERFORM ,V?BOARD ,PRSO>
		       <RTRUE>)
		      (<NOT <PRSO? ,ROOMS>>
		       <HACK-HACK "Playing in this way with">
		       <RTRUE>)>)>
	 <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (T <TELL "You are already standing, I think." CR>)>>

<ROUTINE V-HIDE ()
	 <TELL "That's not a good hiding place." CR>>

<ROUTINE V-HIDE-UNDER ()
	 <V-HIDE>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <COND (<==? <PERFORM ,V?WALK .DIR> ,M-FATAL>
		<RFATAL>)
	       (T <RTRUE>)>>

<ROUTINE V-WALK-TO ()
	 <COND (<PRSO? ,INTDIR>
		<DO-WALK ,P-WALK-DIR>)
	       (<OR <IN? ,PRSO ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>>
		<COND (<FSET? ,PRSO ,VICBIT>
		       <TELL "He">)
		      (T <TELL "It">)>
		<TELL "'s here!" CR>)
	       (T <TELL-SHD-DIR>)>>

<ROUTINE TELL-SHD-DIR ()
	 <TELL "You should supply a " D ,INTDIR "!" CR>>

;"Finds the room on the other side of a door"

<ROUTINE OTHER-SIDE (DOBJ "OPTIONAL" (RM? <>) "AUX" (P 0) Z)
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RETURN <>>)
		       (ELSE
			<SET Z <GETPT ,HERE .P>>
			<COND (<AND <EQUAL? <PTSIZE .Z> ,DEXIT>
				    <EQUAL? <GETB .Z ,DEXITOBJ> .DOBJ>>
			       <COND (.RM?
				      <RETURN <GETB .Z 0>>)
				     (T <RETURN .P>)>)>)>>>

<ROUTINE V-LEAN-ON ()
	 <TELL "Are you so very tired, then?" CR>>

;<ROUTINE V-DIP-IN ()
	 <COND (<AND <EQUAL? ,PRSI ,GLOBAL-WATER ,NILE-RIBBAH>
		     <EQUAL? ,PRSO ,CANTEEN>>
		<PERFORM ,V?FILL ,PRSO ,GLOBAL-WATER>
		<RTRUE>)
	       (<NOT <EQUAL? ,PRSI ,OIL-JAR ,LIQUID>>
		<TELL "You can't dip the " D ,PRSO " in that!" CR>)
	       (<OR <FLAMING? ,PRSO>
		    <FLAMING? ,PRSI>>
		<JIGS-UP
"Poof. There's no need to get burned up about it though...">)
	       (<NOT <EQUAL? ,PRSO ,TORCH>>
		<TELL "Huh? Dip the " D ,PRSO "!?" CR>
		<RTRUE>)
	       (T
		<PERFORM ,V?POUR-ON ,OIL-JAR ,TORCH>
		<RTRUE>)>>

<ROUTINE V-PUT-AGAINST ()
	 <TELL-NO-NO>>

<ROUTINE V-TASTE ()
	 <COND (<FSET? ,PRSO ,FOODBIT>
		<PERFORM ,V?EAT ,PRSO>)
	       (T <TELL "It tastes just like " A ,PRSO "." CR>)>>

;<ROUTINE V-ROLL () <TELL-WHY-BOTHER>>

<ROUTINE TELL-WHY-BOTHER ()
	 <TELL "Why bother?" CR>>

<ROUTINE V-ROB ()
	 <COND (<OR <FSET? ,PRSO ,PERSON>
		    <PRSO? ,SPEAR-CARRIER>>
		<TELL "Even as you begin to make your move, ">
		<THE? ,PRSO>
		<TELL D ,PRSO>
		<JIGS-UP
" knocks you out. About all you feel after that is a cold knife drawing warm
blood from your throat.">)
	       (T 
		<TELL "No wonder you never made the Ten Most Wanted list." CR>)>>

<ROUTINE V-PUSH-THROUGH ()
	 <TELL "Pushing ">
	 <THE? ,PRSO>
	 <TELL D ,PRSO " in that way isn't particularly helpful." CR>>

<ROUTINE HOW? (OBJ)
	 <TELL "I don't know how to do that to " A .OBJ "." CR>>

<ROUTINE VOWEL? (OBJ)
	 <COND (<FSET? .OBJ ,VOWELBIT>
		<TELL "n">)>
	 <TELL " ">>

;<ROUTINE HUH? ("OPTIONAL" (RARG <>))
	 <COND (<VERB? OPEN CLOSE>
		<HOW? ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SMOKE ()
	 <TELL "Smoking is bad for your health." CR>>

<ROUTINE V-UNFOLD ()
	 <HOW? ,PRSO>>

<ROUTINE V-FOLD ()
	 <V-UNFOLD>>

<ROUTINE V-HOLE-DIG ()
	 <TELL "I can't dig in ">
	 <THE? ,PRSI>
	 <TELL D ,PRSI "." CR>
	 ;<COND (T
		<TELL "I don't know how to dig " A ,PRSO "." CR>)
	       (ELSE
		<TELL "I can't dig in the " D ,PRSI "." CR>
		<RTRUE>)>>

<ROUTINE V-TURN-OVER ()
	 <COND (<IN? ,PRSO ,WINNER>
		<TELL-NOTHING "of interest there" T>)
	       (<FSET? ,PRSO ,TAKEBIT>
		<TELL-YOUD-BETTER "pick it up" T>)
	       (T
		<TELL "Good luck!" CR>)>>
		
<ROUTINE V-READ-INSIDE ()
	 <TELL-NOTHING "to read there" T>>

<ROUTINE PRE-REACH-IN ()
	 <COND (<PRSO? ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<NOT <FSET? ,PRSO ,CONTBIT>>
		<TELL-CANT-REACH "into that">
		<RTRUE>)>
	 <COND (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL-CLOSED ,PRSO <>>)>>

<ROUTINE V-REACH-IN ()
	 <PERFORM ,V?LOOK-INSIDE ,PRSO>>

<ROUTINE TELL-CLOSED (ARG "OPTIONAL" (STR? T))
	 <TELL "The ">
	 <COND (.STR? <TELL .ARG>)
	       (T <TELL D .ARG>)>
	 <TELL " is closed." CR>>

<ROUTINE V-CLEAN ()
	 <TELL
"Cleanliness may be next to godliness, but there are limits." CR>>



;<ROUTINE V-THROW-DOWN ("AUX" FOO)
	 <COND (<STAIRWAY-CHECK?>
		<RTRUE>)
	       (<NOT <EQUAL? ,PRSO ,ROPE>>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<AND <EQUAL? ,PRSI ,INTDIR>
		     <EQUAL? ,P-DIRECTION ,P?NORTH>>
		<SET FOO ,NORTH-STAIRS>)
	       (<AND <EQUAL? ,PRSI ,INTDIR>
		     <EQUAL? ,P-DIRECTION ,P?SOUTH>>
		<SET FOO ,SOUTH-STAIRS>)
	       (<AND <EQUAL? ,PRSI ,INTDIR>
		     <EQUAL? ,P-DIRECTION ,P?EAST>>
		<SET FOO ,EAST-STAIRS>)
	       (<AND <EQUAL? ,PRSI ,INTDIR>
		     <EQUAL? ,P-DIRECTION ,P?WEST>>
		<SET FOO ,WEST-STAIRS>)
	       (ELSE
		<SET FOO ,GROUND>)>
	 <PERFORM ,V?PUT ,PRSO .FOO>
	 <RTRUE>>

<ROUTINE V-TIME ()
	 <COND (<OR <IN? ,WATCH ,WINNER>
		    <IN? ,WATCH ,HERE>>
		<TELL "Your watch says it's ">
		<WATCH-TIME>
		<TELL "." CR>)
	       (T <TELL-YOU-CANT "tell without your watch.">)>>

;<ROUTINE V-$TIME ()
	 <TELL "The \"real\" time is ">
	 <TIME-PRINT ,PRESENT-TIME>
	 <CRLF>>

;<ROUTINE PRE-COMPARE ("AUX" (FLG <>))
	 <COND (<PRSO? ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<NOT <GETP ,PRSO ,P?MAP>>
		<SET FLG T>)
	       (<NOT <EQUAL? <GETP ,PRSO ,P?MAP>
			     <GETP ,PRSI ,P?MAP>>>
		<SET FLG T>)>
	 <COND (.FLG
		<TELL "Comparisons between the " D ,PRSO " and the " D ,PRSI
		      " would not really help." CR>
		<RTRUE>)
	       (ELSE
		<RFALSE>)>>

;<ROUTINE V-COMPARE ()
	 <COND (<PRSO? ,ROCK-LOCK ,STONE-KEY>
		<TELL 
"It looks as if the small cube would fit into the opening almost exactly." CR>)
	       (<EQUAL? <GETP ,PRSO ,P?MAP> 1> ;"CUPS"
		<TELL
"The two chalices are of exactly the same size and dimensions, though empty
they have different weights." CR>)
	       (<AND <EQUAL? <GETP ,PRSO ,P?MAP> 3 4> ;"Book & L AREA"
		     <EQUAL? <GETP ,PRSO ,P?MAP> <GETP ,PRSI ,P?MAP>>>
		<TELL "Looks as if the area is just big enough to hold it." CR>)
	       (<AND <EQUAL? <GETP ,PRSO ,P?MAP> 3 4> ;"Book & L AREA"
		     <NOT <EQUAL? <GETP ,PRSO ,P?MAP> <GETP ,PRSI ,P?MAP>>>>
		<TELL "Well, the match up between them wasn't made in heaven."
		      CR>)
	       (T
		<TELL "The " D ,PRSO " and the " D ,PRSI " are the same size."
		      CR>)>>

;<ROUTINE V-FOO-COMPARE ()
	 <COND (<L? <GET ,P-PRSO 0> 2>
		<TELL "You have to compare the " D ,PRSO " to something else."
		      CR>
		<RTRUE>)
	       (T
	        <PERFORM ,V?COMPARE <GET ,P-PRSO 1> <GET ,P-PRSO 2>>
		<RFATAL>)>>

<ROUTINE V-WEIGH ()
	 <COND (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Tough to do without a scale." CR>)
	       (T
		<TELL "Now that's bizarre!" CR>)>>

<ROUTINE V-CHASTISE ()
	 <COND (<PRSO? ,INTDIR>
		<TELL
"The best way to see what's happening there is to go there." CR>)
	       (T
		<TELL 
"Please be more specific. LOOKing AT, BEHIND, UNDER, THROUGH, INSIDE, ON, DOWN,
FOR, or any other method of LOOKing mean different things to me. Please
specify which preposition you'd like to use next time, like LOOK AT ">
	        <COND (<NOT <FSET? ,PRSO ,PERSON>>
		       <TELL "THE ">)>
	 	<TELL D ,PRSO ", or LOOK INSIDE ">
	 	<COND (<NOT <FSET? ,PRSO ,PERSON>>
		       <TELL "THE ">)>
	 	<TELL D ,PRSO "." CR>)>>

;<ROUTINE V-LOOK-UP ()
	 <TELL "I can't. There's a crick in me neck!" CR>>

<ROUTINE V-HELP ()
	 <COND (,PRSO
		<COND (<NOT <EQUAL? ,PRSO ,WINNER>>
		       <TELL "It seems that ">
		       <THE? ,PRSO>
		       <TELL D ,PRSO " doesn't need any help." CR>)>)>
	 <TELL
"I'm afraid you'll have to figure this out " D ,GLOBAL-SELF ".|
[If you really need help, you can order an InvisiClues Hint Booklet
and a complete map by using the order form that came in your package.]" CR>>

<ROUTINE GET-COMFORTABLE (OBJ)
	<COND (<OR <FIRST? .OBJ>
		   <WEARING-SOMETHING?>>
	       <TELL-NOT-COMFORTABLE>)
	      (T
	       <MOVE ,WINNER .OBJ>
	       <TELL "You get into the " D .OBJ " and try to get comfortable. ">
	       <V-SLEEP>)>>

<ROUTINE TELL-NOT-COMFORTABLE ()
	<TELL "That doesn't sound very comfortable." CR>>

<ROUTINE V-SLEEP ()
	 <COND (<==? ,HOW-TIRED 6>
		<COND (<L? <GETP ,HERE ,P?LINE> ,UNDERWATER-LINE-C>
		       <SLEEP-LOSE>)
		      (T <JIGS-UP "You fall asleep and run out of air.">)>)
	       (<AND ,PRSO
		     <NOT <PRSO? ,ROOMS ,BED ,BUNK>>>
		<TELL-NOT-COMFORTABLE>)
	       (<OR <IN? ,WINNER ,BED>
		    <IN? ,WINNER ,BUNK>>
		<COND (<NOT <==? ,HOW-TIRED 1>>
		       <COND (<IN? ,WINNER ,BED>
			      <SLEEP-LOSE>)
			     ;(T
			      <SLEEP-WIN>)>)
		      (T <TELL 
"You close your eyes, but your mind is too active to let you sleep." CR>)>)
	       (<IN? ,BED ,HERE>
		<GET-COMFORTABLE ,BED>
		<RTRUE>)
	       (<IN? ,BUNK ,HERE>
		<GET-COMFORTABLE ,BUNK>
		<RTRUE>)
	       (,PRSO
		<TELL-NOT-COMFORTABLE>)
	       (<L? ,HOW-TIRED 2>
		<TELL-YOURE-NOT "tired.">)
	       (T
		<TELL "Better find a good place to lie down." CR>)>>

;<GLOBAL ASLEEP? <>>

<ROUTINE SLEEP-LOSE ()
	 <TELL 
"You drift off to sleep.|
|
You wake up. Once again, you find " D ,GLOBAL-SELF " with the usual nothing to
do. It seems as if you are destined to spend the rest of your days on this
island, waiting for a break that may never come." CR>
	 <FINISH>>

;<ROUTINE SLEEP-WIN ("OPTIONAL" (DOWNTIME 480) "AUX" TIRED-AGAIN START-TIME)
	 <COND (<G? .DOWNTIME 300>
		<SET TIRED-AGAIN 869>
		<TELL "You drift ">
		<COND (<==? ,HOW-TIRED 0>
		       <TELL "back">)
		      (T <TELL "off">)>
		<TELL " to sleep.">)
	       (T
		<SET TIRED-AGAIN 479>
		<TELL "You fall into an uncomfortable sleep ">
		<COND (<IN? ,PLAYER ,DECK-CHAIR>
		       <TELL "in the chair.">)
		      (T <TELL "on the deck.">)>)>
	 <CRLF>
	 <CRLF>
	 <SETG ASLEEP? T>
	 <DISABLE <INT I-TIRED>>
	 <SET START-TIME ,PRESENT-TIME>
	 <COND (<V-WAIT .DOWNTIME <>>
		<COND (,MOMENT-OF-TRUTH
		       <SETG HOW-TIRED 1>
		       <ENABLE <QUEUE I-TIRED .TIRED-AGAIN>>)
		      (T
		       <SETG HOW-TIRED 0>
		       <ENABLE <QUEUE I-TIRED 5>>)>)
	       (T
		<SETG HOW-TIRED 1>
		<ENABLE <QUEUE I-TIRED .TIRED-AGAIN>>
		<TELL "You wake up refreshed." CR>)>
	 <COND (<G? .START-TIME ,PRESENT-TIME>
		<SETG TIME-SLEPT <+ ,TIME-SLEPT ,PRESENT-TIME
				    <- 1440 .START-TIME>>>)
	       (T <SETG TIME-SLEPT <+ ,TIME-SLEPT <- ,PRESENT-TIME .START-TIME>>>)>
	 <SETG ASLEEP? <>>
	 <SETG HOW-HUNGRY 1>
	 <SETG HOW-THIRSTY 1>
	 <ENABLE <QUEUE I-HUNGER 10>>
	 <ENABLE <QUEUE I-THIRST 15>>
	 ;<TELL 
"You wake up to find that you're still on the ship, which has made considerable
progress toward its destination." CR>
	 <RTRUE>>

;<GLOBAL TIME-SLEPT 0>

;<ROUTINE V-WET ()
	  <PERFORM ,V?POUR-ON ,PRSI ,PRSO>
	  <SETG P-IT-OBJECT ,PRSO>
	  <RTRUE>>

<ROUTINE PRE-WHAT ()
	 <COND (<AND ,PRSI
		     <NOT <PRSO? ,GLOBAL-TIME ,GLOBAL-DAY>>
		     <NOT <PRSI? ,IT ,P-IT-OBJECT>>>
		<TELL "I'm afraid that question is beyond me." CR>
		<RFATAL>)>>

<ROUTINE V-WHAT ()
	 <COND (<OR <NOT <==? ,WINNER ,PLAYER>>
		    <AND ,QCONTEXT
		     	 <==? ,HERE ,QCONTEXT-ROOM>
		     	 <==? ,HERE <META-LOC ,QCONTEXT>>
		     	 <FSET? ,QCONTEXT ,PERSON>>>		    
		<TELL "\"Isn't it obvious?\"" CR>)
	       (<NOT ,PRSO>
		<TELL "Huh?" CR>)
	       (<FSET? ,PRSO ,PERSON>
		<TELL "Try asking that person." CR>)
	       (T <TELL "Are you talking to " D ,GLOBAL-SELF " again?" CR>)>>

<ROUTINE V-YES ()
	 <TELL-RATHER "positive">>

<ROUTINE V-MAYBE ()
	 <TELL-RATHER "ambivalent">>

<ROUTINE V-NO ()
	 <TELL-RATHER "negative">>

<ROUTINE TELL-RATHER (STR)
	 <TELL "You sound rather " .STR "." CR>>

<ROUTINE V-SIT ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<PERFORM ,V?SIT-WITH ,PRSO>)
	       (T <PERFORM ,V?SIT-ON ,PRSO>)>>

<ROUTINE V-SIT-ON ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,GROUND ;,SAND ,DECK>
		<COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		       <MOVE ,WINNER ,HERE>)>
		<TELL "After a moment, you stand back up." CR>)
	       (T
		<TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE V-SIT-WITH ()
	 <COND (<NOT <FSET? ,PRSO ,PERSON>>
		<TELL <PICK-ONE ,YUKS> CR>)
	       (<AND <IN? ,PLAYER ,SHANTY>
		     <IN? ,PRSO ,SHANTY>>
		<PERFORM ,V?SIT-ON ,CHAIR>)
	       (T <TELL "There's no place to sit with " D ,PRSO "." CR>)>>

;<ROUTINE TBL-TO-INSIDE (OBJ TBL "OPTIONAL" STR "AUX" (OFFS 0) MAX)
	 <COND (<NOT <FSET? .OBJ ,SURFACEBIT>>
		<TELL "The " D .OBJ " is already open." CR>
		<RTRUE>)>
	 <COND (<FIRST? .OBJ>
		<OBJS-SLIDE-OFF .OBJ>)>
	 <SET MAX <GET .TBL 0>>
	 <COND (<NOT .STR>
		<TELL "Opened.">)
	       (T <TELL .STR>)>
	 <FCLEAR .OBJ ,SURFACEBIT>
	 <REPEAT ()
		 <SET OFFS <+ .OFFS 1>>
		 <COND (<G? .OFFS .MAX>
			<RETURN>)
		       (<NOT <EQUAL? <GET .TBL .OFFS> 0>>
			<MOVE <GET .TBL .OFFS> .OBJ>
			<PUT .TBL .OFFS 0>)>>
	 <COND (<FIRST? .OBJ>
		<TELL " Opening the " D .OBJ " reveals ">
		<PRINT-CONTENTS .OBJ>
		<TELL ".">)>
	 <CRLF>>

;<ROUTINE INSIDE-OBJ-TO (TBL OBJ "AUX" (OFFS 0) F N)
	 <COND (<FSET? .OBJ ,SURFACEBIT>
		<TELL "The " D .OBJ " is already closed." CR>
		<RTRUE>)>
	 <FSET .OBJ ,SURFACEBIT>
	 <TELL "Closed." CR>
	 <COND (<NOT <FIRST? .OBJ>>
		<RTRUE>)>
	 <SET F <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .F>
			<RETURN>)
		       (T
			<SET N .F>
			<SET F <NEXT? .N>>
			<REMOVE .N>
			<REPEAT ()
				<SET OFFS <+ .OFFS 1>>
				<COND (<EQUAL? <GET .TBL .OFFS> 0>
				       <PUT .TBL .OFFS .N>
				       <RETURN>)>>)>>>
	       
;<ROUTINE OBJS-SLIDE-OFF (OBJ "AUX" F N THERE)
	 <SET THERE <LOC .OBJ>>
	 <COND (<EQUAL? .THERE ,WINNER>
		<SET THERE ,HERE>)>
	 <SET F <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .F>
			<RETURN>)
		       (T
			<SET N .F>
			<SET F <NEXT? .N>>
			<MOVE .N .THERE>)>>
	 <TELL "Everything on the " D .OBJ " slides off its top." CR>
	 <CRLF>>

;<ROUTINE V-JUMP-ROPE ()
	 <COND (<NOT <EQUAL? ,PRSO ,ROPE>>
		<TELL "I can jump rope, and that's about all." CR>)
	       (T
		<TELL "Well, it takes all kinds of weirdos..." CR>)>>

;<ROUTINE EMPTY-THE (OBJ "OPTIONAL" (BURN? T) "AUX" F N (FLG <>))
	 <SET F <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .F>
			<RETURN>)
		       (T
			<SET N .F>
			<SET F <NEXT? .N>>
			<SET FLG 1>
			;<COND (<AND <EQUAL? ,HERE ,WEST-END-OF-PASSAGE>
				    <NOT <FSET? ,PIT ,INVISIBLE>>>
			       <REMOVE .N>
			       <SET FLG 1>)
			      (T
			       <MOVE .N ,HERE>
			       <SET FLG 2>)>)>>
	 <COND (<NOT .FLG>
		<RTRUE>)
	       (T
		<TELL " Whatever was inside the " D .OBJ>
		<COND (<EQUAL? .FLG 1>
		       <TELL " has fallen out." CR>)
		      (<EQUAL? .FLG 2>
		       <TELL " falls into the pit." CR>)>)>>

<ROUTINE TELL-ALREADY (STR)
	 <TELL "It's already " .STR "." CR>>

<ROUTINE TELL-YOUD-BETTER (STR "OPTIONAL" (1ST <>) (DONE T))
	 <TELL "You'd better " .STR>
	 <COND (.1ST <TELL " first.">)>
	 <COND (.DONE <CRLF>)>>

;<ROUTINE V-$FORCE ("AUX" I (TM 0))
	 <COND (,PRSO
		<SET TM ,P-NUMBER>)>
	 <COND (<ENABLED? I-DIVETIME>
		<SET I <INT I-DIVETIME>>)
	       (T <SET I <INT I-CHANGE-WATCH>>)>
	 <ENABLE <QUEUE I-OBSTACLES <SET TM <- <GET .I ,C-TICK> .TM>>>>
	 <TELL "Queued for " N .TM "." CR>>

<ROUTINE FIXED-FONT-ON () <PUT 0 8 <BOR <GET 0 8> 2>>>

<ROUTINE FIXED-FONT-OFF() <PUT 0 8 <BAND <GET 0 8> -3>>>
