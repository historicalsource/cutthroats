"PEOPLE for TOA #2
 Copyright 1984, Infocom Inc."

<OBJECT MCGINTY
	(IN MCGINTY-HQ)
	(DESC "McGinty")
	(SYNONYM MCGINTY)
	(ADJECTIVE MR MISTER)
	(DESCFCN MCGINTY-F)
	(CHARACTER 1)
	(FLAGS PERSON VICBIT)
	(TEXT
"He is wiry, hyper, and devoid of ethics. A fat cigar seems to be his
only companion, since he's the type of man who would sell his own mother if
given the opportunity.")
	(CONTFCN MCGINTY-F)
	(ACTION MCGINTY-F)>

<ROUTINE TELL-NEVER-KNEW ()
	 <TELL "\"Never heard of him.\"" CR>>

<ROUTINE MCGINTY-F ("OPTIONAL" (RARG <>) "AUX" OBJ (PFLAG 0))
	 <COND (<==? .RARG ,M-OBJDESC>
		<COND (,MCGINTY-KNOWS T)
		      (<AND <IN? ,PASSBOOK ,PLAYER>
			    <NOT <QUEUED? I-MCGINTY-FOLLOWS>>>
		       <SET PFLAG 1>
		       <MCGINTY-WILL-FOLLOW>)
		      (<IN? ,PASSBOOK ,HERE>
		       <MCGINTY-WILL-FOLLOW>
		       <MOVE ,PASSBOOK ,MCGINTY>
		       <SET PFLAG 2>)>
		<COND (<OR <IN-MOTION? ,MCGINTY>
			   <AND <QUEUED? I-MCGINTY-FOLLOWS>
				<VERB? WALK FOLLOW>
				<NOT <IN? ,MCGINTY <LOC ,PLAYER>>>>
			   <TRAITOR-TIME?>>
		       <RTRUE>)
		      (<FSET? ,MCGINTY ,TOUCHBIT>
		       <TELL D ,MCGINTY " is here, ">
		       <COND (<==? ,HERE ,OUTFITTERS-HQ>
			      <TELL "talking with the salesman">)
			     (T <TELL "smoking his cigar">)>
		       <TELL ".">)
		      (T
		       <TELL D ,MCGINTY ", a small, nervous man, is ">
		       <COND (<IN? ,MCGINTY ,MCGINTY-HQ>
			      <TELL "sitting behind a desk">)
			     (T <TELL "standing nearby">)>
		       <TELL
". His lips clamp around a cigar too large for his face.">
		       <FSET ,MCGINTY ,TOUCHBIT>)>
		<COND (<==? .PFLAG 1> <TELL-EYES-NARROW>)
		      (<==? .PFLAG 2> <TELL-TAKE-PASS " He">)>
		<CRLF>
		<RTRUE>)
	       (<==? .RARG ,M-CONT>
		<COND (<AND <VERB? TAKE>
			    <FSET? ,PRSO ,TAKEBIT>>
		       <TELL
D ,MCGINTY " pulls it back. \"I'm not gonna give that to you!\""CR>
		       <RTRUE>)
		      (T <RFALSE>)>)>
	 <COND (<==? ,WINNER ,MCGINTY>
	        <COND (<NOT <IN? ,MCGINTY <META-LOC ,PLAYER>>>
		       <SETG P-CONT <>>
		       <TELL-NOT-HERE-TALK>
		       <RFATAL>)
		      (<TRAITOR-TIME?>
		       <TELL-IN-MEETING>
		       <RFATAL>)>)>
	 <FSET ,MCGINTY ,TOUCHBIT>
	 <COND (<AND <VERB? FOLLOW>
		     <PRSO? ,MCGINTY>>
		<RFALSE>)
	       (<AND <VERB? $CALL>
		     <TRAITOR-TIME?>>
		<TELL-IN-MEETING>
		<RTRUE>)
	       (<VERB? HELLO>
		<SETG QCONTEXT ,MCGINTY>
		<SETG QCONTEXT-ROOM ,HERE>
		<TELL "\"Howdy.\"" CR>
		<RTRUE>)
	       (<VERB? GOODBYE>
		<SETG QCONTEXT ,MCGINTY>
		<SETG QCONTEXT-ROOM ,HERE>
		<TELL "\"So long.\"" CR>
		<RTRUE>)
	       (<OR <AND <VERB? TAKE>
		         <PRSI? ,MCGINTY>>
		    <AND <VERB? ASK-FOR>
			 <PRSO? ,MCGINTY>>>
		<COND (<PRSO? ,MCGINTY> <SET OBJ ,PRSI>)
		      (T <SET OBJ ,PRSO>)>
		<COND (<IN? .OBJ ,MCGINTY>
		       <TELL "\"I'm not gonna give that to you.\"" CR>)
		      (T <TELL "\"I don't have that.\"" CR>)>
		<RTRUE>)
	       (<VERB? BUY>
		<COND (<PRSO? ,FERRY-TOKEN>
		       <TELL
 "\"I don't have one. Try the bank.\"" CR>
		       <RTRUE>)>)>
	 <COND (<AND <VERB? $CALL> <==? ,WINNER ,PLAYER>> <RFALSE>)
	       (<NOT <GRAB-ATTENTION ,MCGINTY>> <RTRUE>)>
	 <COND (<AND <VERB? TELL>
		     <PRSO? ,MCGINTY>>
		<COND (<PRSI? ,GLOBAL-TREASURE ,SAMPLE-TREASURE>
		       <COND (<TRAITOR-TIME?>
			      <JIGS-UP
"The Weasel turns and yells, \"Traitor!\" Next thing you know, you've been
stabbed.">)
			     (,MCGINTY-KNOWS
			      <TELL "\"Thanks, but I already know about it.\"" CR>)
			     (T
			      <COND (<OR <IN? ,SPEAR-CARRIER ,HERE>
					 <IN? ,JOHNNY ,HERE>
					 <IN? ,PETE ,HERE>
					 <IN? ,WEASEL ,HERE>>
				     <SETG MCGINTY-KNOWS T>
		       	      	     <ZERO-ATTENTION ,MCGINTY>
			      	     <PUT <GET ,GOAL-TABLES ,MCGINTY-C>
					  ,GOAL-ENABLE T>
		       	      	     <TELL
D ,MCGINTY " looks delighted with the information.">
		       	      	     <COND (<IN? ,MCGINTY ,OUTFITTERS-HQ>
			             	  <ESTABLISH-GOAL ,MCGINTY ,MCGINTY-HQ>
			      	     	    <COND (<IN? ,JOHNNY ,OUTFITTERS-HQ>
				     	    	   <SAY-MCGINTY-KNOWS>)
				    	   	  (T 
				     	    	   <TELL " He thanks you.">
				            	   <TELL-NEED-BOAT>)>)
			     	    	   (T
			      	       <ESTABLISH-GOAL ,MCGINTY ,OUTFITTERS-HQ>
			      	     	    <ALL-GO-HOME>
			      	     	    <I-PLOT-NEVER-STARTS>
			      	     	    <DISABLE <INT I-SHOVE-OFF>>
			      	     	    <TELL
" \"Excuse me,\" he says. \"I have business to attend to.\"" CR>)>)
				    (T
				     <JIGS-UP
"\"Thanks for the info, pal, but I better make sure you don't use it.\" He
pulls out his gun and shoots.">)>)>
		       <RTRUE>)>)
	       (<AND <VERB? SHOW>
		     <PRSO? ,NOTE ,BOOK>
		     <PRSI? ,MCGINTY>>
		<PERFORM ,V?TELL ,MCGINTY ,GLOBAL-TREASURE>
		<RTRUE>)
	       (<AND <VERB? ASK-ABOUT>
		     <PRSO? ,MCGINTY>>
		<COND (<TRAITOR-TIME?>
		       <TELL-IN-MEETING>
		       <RFATAL>)
		      (<PRSI? ,GLOBAL-TREASURE>
		       <TELL
"\"I'm always looking for " D ,GLOBAL-TREASURE ",\" he says, grinning." CR>)
		      (<PRSI? ,SPEAR-CARRIER>
		       <TELL "\"He does his job.\"" CR>)
		      (<PRSI? ,PETES-PATCH>
		       <TELL "\"All I know is that Pete wears it.\"" CR>)
		      (<PRSI? ,CIGAR>
		       <TELL "\"Yeah. That's my cigar.\"" CR>)
		      (<PRSI? ,HEVLIN>
		       <TELL-NEVER-KNEW>)
		      (<PRSI? ,JOHNNY ,PETE ,WEASEL>
		       <TELL
"\"He's worked for me. He's all right.\"" CR>)
		      (<PRSI? ,ME>
		       <TELL-YOURE-DIVER>)
		      (<PRSI? ,MCGINTY>
		       <TELL-KNOW-ME>)
		      (<PRSI? ,PARROT>
		       <TELL
"\"It's the queerest bird I've ever seen.\"" CR>)
		      (<PRSI? ,TRAWLER ,SALVAGER>
		       <TELL "\"She's a nice boat.\"" CR>)
		      (T <RFALSE>)>
		<RTRUE>)>
	 <COND (<EQUAL? ,WINNER ,MCGINTY>
		<COND (<PRSO? ,GLOBAL-SELF>
		       <SETG PRSO ,MCGINTY>)>
		<COND (<PRSI? ,GLOBAL-SELF>
		       <SETG PRSI ,MCGINTY>)>
		<COND (<AND <VERB? TELL>
			    <PRSO? ,ME>>
		       <RFALSE>)
		      (<VERB? $CALL>
		       <TELL-SO-WHAT>)
		      (<VERB? WALK DISEMBARK LEAVE>
		       <TELL "\"I'll leave when I'm ready.\"" CR>)
		      (<AND <VERB? SHOW>
			    <IN? ,PRSO ,MCGINTY>
		       	    <PRSI? ,ME>>
		       <SETG WINNER ,PLAYER>
		       <PERFORM ,V?EXAMINE ,PRSO>
		       <SETG WINNER ,MCGINTY>)
		      (<VERB? YES NO MAYBE WHAT FIND SSHOW ALARM>
		       <RFALSE>)
		      (T
		       <TELL "\"I'd rather not.\"" CR>
		       <RFATAL>)>)>>

<ROUTINE ZERO-ATTENTION (PER)
	 <PUT <GET ,GOAL-TABLES <GETP .PER ,P?CHARACTER>> ,ATTENTION 0>>

<ROUTINE TELL-SO-WHAT ()
	 <COND (<FSET? ,PRSO ,VICBIT>
		<TELL "\"What about him?\"" CR>)
	       (T <V-CALL-LOSE>)>>

<ROUTINE TELL-TAKE-PASS (STR)
	 <TELL
.STR " sees the passbook, picks it up, looks at it and then at you.">>

<ROUTINE TRAITOR-TIME? ()
	 <COND (<AND <IN? ,ID-CARD ,WEASEL>
		     <QUEUED? ,I-TRAITOR-MEETING>>
		<RTRUE>)>>

<ROUTINE TELL-IN-MEETING ()
	 <TELL "He's too engrossed in his meeting to hear you." CR>>

<ROUTINE MCGINTY-ERRAND ()
	 <MOVE ,PLAYER ,WHARF-ROAD-2>
         <MOVE ,MCGINTY ,WHARF-ROAD-2>
	 <SETG HERE ,WHARF-ROAD-2>
	 <TELL
"\"I'm closing to run an errand,\" " D ,MCGINTY " says, ushering you out..."
CR CR>
	 <V-FIRST-LOOK>>

<ROUTINE I-MCGINTY ("OPTIONAL" (GARG <>) "AUX" (L <LOC ,MCGINTY>) DEST MMG
		    			       (V <>))
	 <COND (<NOT .GARG>
		<SET MMG <GET ,MOVEMENT-GOALS ,MCGINTY-C>>
		;<COND (<AND <EQUAL? <GET .MMG ,MG-ROOM> ,MM-FORE-DECK>
			    <EQUAL? ,SHIP-CHOSEN ,TRAWLER>>
		       <PUT .MMG ,MG-ROOM ,NW-FORE-DECK>)>
		<COND (<AND <IN? ,MCGINTY ,MCGINTY-HQ>
			    <IN? ,PLAYER ,MCGINTY-HQ>
			    <NOT <==? <GET .MMG ,MG-ROOM> ,MCGINTY-HQ>>>
		       <MCGINTY-ERRAND>
		       <SET V T>)>
		<COND (<==? .L ,FERRY-LANDING>
		       <SETG MCGINTY-MEETS-WEASEL <>>)>
		<IMOVEMENT ,MCGINTY I-MCGINTY>
		<RETURN .V>)
	       (<==? .GARG ,G-REACHED>
		<COND ;(<EQUAL? .L ,MM-FORE-DECK ,NW-FORE-DECK>
		       <COND (<IN? ,PLAYER .L>
			      <TELL
D ,MCGINTY " comes in, looks around, and sees you. ">)>
		       <MCGINTY-FORAY-CHECK .L>
		       <COND (,MCGINTY-RETURNS
			      <RTRUE>)
			     (T
			      <ENABLE <QUEUE I-MCGINTY-FORAY -1>>
			      <RFALSE>)>)
		      (<==? .L ,MCGINTY-HQ>
		       <COND (<IN? ,PLAYER .L>
			      <JIGS-UP
"McGinty walks in the front door, spots something in the shadows, pulls out
a gun, and fires. Unfortunately, you are what he noticed.">)
			     (<AND <IN? ,PLAYER ,WHARF-ROAD-2>
				   <==? ,LAST-PLAYER-LOC ,MCGINTY-HQ>>
			      <JIGS-UP
"A moment later, McGinty sticks his head out, asks why you were in his place,
and shoots you.">)
			     (<IN? ,ID-CARD ,MCGINTY>
			      <MOVE ,ID-CARD ,ENVELOPE>
			      <FSET ,ID-CARD ,TAKEBIT>
			      <FCLEAR ,ENVELOPE ,INVISIBLE>
			      ;<COND (<IN? ,PLAYER .L><"This can't happen.">
				     <TELL
"\"Excuse me,\" says " D ,MCGINTY
" as he scribbles something on an " D ,ENVELOPE " and
puts a card in it." CR>)>)
			     (<AND <NOT ,MCGINTY-KNOWS>
				   ,MCGINTY-MEETS-WEASEL
				   <==? <GET <GET ,MOVEMENT-GOALS ,MCGINTY-C>
					     ,MG-ROOM> ,SHANTY>>
			      <PUT ,MOVEMENT-GOALS ,MCGINTY-C
				   ,MCGINTY-MEETS-WEASEL-TABLE>
			      <IMOVEMENT ,MCGINTY I-MCGINTY>
			      <RFALSE>)>
		       <COND (<AND <IN? ,PLAYER ,BACK-ALLEY-2>
				   <FSET? ,WINDOW ,OPENBIT>>
			      <TELL "The window gets slammed shut." CR>
			      <FCLEAR ,BACK-WINDOW ,OPENBIT>)>)
		      (<==? .L ,FERRY-LANDING>
		       <ENABLE <QUEUE I-TRAITOR-MEETING -1>>
		       <COND (<IN? ,PLAYER .L>
			      <TELL
D ,MCGINTY " wanders in, looking preoccupied." CR>
			      <SET V T>)>
		       <COND (<IN? ,WEASEL .L>
			      <I-TRAITOR-MEETING>)>
		       <RETURN .V>)
		      (<==? .L ,HERE>
		       <TELL D ,MCGINTY " wanders in."
;" struts in as if he owned the whole island.">
		       <COND (<AND <IN? ,PASSBOOK ,PLAYER>
				   <NOT ,MCGINTY-KNOWS>
				   <NOT <QUEUED? I-MCGINTY-FOLLOWS>>>
			      <MCGINTY-WILL-FOLLOW>
		       	      <TELL-EYES-NARROW>)
			     (<IN? ,PASSBOOK .L>
			      <SETG MCGINTY-MEETS-WEASEL T>)>
			      <CRLF>
			      <RFATAL>)
		      (<IN? ,PASSBOOK .L>
		       <MOVE ,PASSBOOK ,MCGINTY>
		       <SETG MCGINTY-MEETS-WEASEL T>
		       <RFALSE>
		       ;<COND (,DEBUG
			      <TELL
"[McGinty has arrived at " D .L " and found the passbook.]" CR>)>)
		      ;(,DEBUG <TELL "[McGinty has arrived at " D .L ".]" CR>)>)
	       (<EQUAL? .GARG ,G-ENROUTE>
		;<SET DEST <GET <GET ,GOAL-TABLES ,MCGINTY-C> ,GOAL-F>>
		<COND ;(<EQUAL? .DEST ,MM-FORE-DECK ,NW-FORE-DECK>
		       <MCGINTY-FORAY-CHECK .L>)
	       	      (<AND <IN? ,PLAYER .L>
			    <IN? ,PASSBOOK ,PLAYER>
			    <NOT ,MCGINTY-KNOWS>
			    <NOT <QUEUED? I-MCGINTY-FOLLOWS>>>
		       <MCGINTY-WILL-FOLLOW>
		       <TELL-EYES-NARROW <>>
		       <CRLF>)
		      (<AND <IN? ,PASSBOOK .L>
			    <NOT ,MCGINTY-KNOWS>>
		       <COND (<IN? ,MCGINTY <META-LOC ,PLAYER>>
		       	      <MCGINTY-WILL-FOLLOW>
		       	      <MOVE ,PASSBOOK ,MCGINTY>
		       	      <TELL-TAKE-PASS "McGinty">
			      <CRLF>)
		      	     (T
		       	      <SETG MCGINTY-MEETS-WEASEL T>
		       	      <MOVE ,PASSBOOK ,MCGINTY>
		       	      <RFALSE>)>)>)>>

<ROUTINE TELL-EYES-NARROW ("OPTIONAL" (SPACE T))
	 <COND (<NOT ,ALREADY-FOLLOWED>
		<COND (.SPACE <TELL " ">)>
	 	<TELL
"As he looks at you, he does a double take and stares intently at your
possessions.">)>>

;<ROUTINE I-MCGINTY-FORAY ("AUX" DEST MCGL (V <>) F N)
	 <COND (<EQUAL? ,SHIP-CHOSEN ,TRAWLER>
		<SET DEST <GET ,NW-FORAY-TABLE 0>>
	 	<SETG NW-FORAY-TABLE <REST ,NW-FORAY-TABLE 2>>)
	       (T
		<SET DEST <GET ,MM-FORAY-TABLE 0>>
	 	<SETG MM-FORAY-TABLE <REST ,MM-FORAY-TABLE 2>>)>
	 <SET MCGL <LOC ,MCGINTY>>
	 <COND (<IN? .DEST ,ROOMS>
		<MOVE-PERSON ,MCGINTY .DEST>
		<SET MCGL <LOC ,MCGINTY>>
		<COND (<EQUAL? .MCGL ,MM-FORE-DECK ,NW-FORE-DECK>
		       <SET F <FIRST? ,MCGINTY>>
		       <COND (<AND <IN? ,MCGINTY <META-LOC ,PLAYER>>
				   <NEXT? .F>>
			      <SET V T>
			      <TELL
D ,MCGINTY " throws something over the " D ,RAILING
". He then sees you and says,
\"Have fun!\"" CR>)>
		       <REPEAT ()
			<SET N <NEXT? .F>>
			<COND (<NOT <==? .F ,CIGAR>>
			       <MOVE .F ,LOCAL-GLOBALS>)>
			<SET F .N>
			<COND (<NOT .F> <RETURN>)>>
		       <ESTABLISH-GOAL ,MCGINTY ,MCGINTY-HQ>
		       <DISABLE <INT I-MCGINTY-FORAY>>
		       <RETURN .V>)>
		<COND (,MCGINTY-RETURNS
		       <DISABLE <INT I-MCGINTY-FORAY>>)>
		<COND (<IN? ,PLAYER .MCGL> <RTRUE>)>)
	       (<EQUAL? .MCGL ,MM-LOCKER ,NW-LOCKER>
		<COND (,MCGINTY-RETURNS
		       <DISABLE <INT I-MCGINTY-FORAY>>
		       <COND (<IN? ,PLAYER .MCGL> <RTRUE>)
			     (T <RFALSE>)>)>
		<SET F <FIRST? .MCGL>>
		<REPEAT ()
		 <SET N <NEXT? .F>>
		 <COND (<AND <NOT <EQUAL? .F ,DEEP-SUIT>>
			     <NOT <EQUAL? .F ,METAL-DETECTOR>>
			     <NOT <FSET? .F ,PERSON>>>
			<MOVE .F ,MCGINTY>)>
		 <SET F .N>
		 <COND (<NOT .F> <RFALSE>)>>)>>

;<GLOBAL MM-FORAY-TABLE
	<TABLE MM-CREW-QTRS MM-LOCKER 0 MM-CREW-QTRS MM-FORE-DECK>>

;<GLOBAL NW-FORAY-TABLE
	<TABLE NW-CREW-QTRS NW-LOCKER 0 NW-CREW-QTRS NW-FORE-DECK>>

;<ROUTINE MCGINTY-FORAY-CHECK (MCGL)
	 <COND (<OR <IN? ,WEASEL .MCGL>
		    <IN? ,PETE .MCGL>
		    <IN? ,JOHNNY .MCGL>
		    <IN? ,PLAYER .MCGL>>
		<ESTABLISH-GOAL ,MCGINTY ,MCGINTY-HQ>
		<SETG MCGINTY-RETURNS T>
		<COND (<IN? ,PLAYER .MCGL>
		       <TELL
"\"If you're using the ship, I'll look it over later,\" he says." CR>)>)>>

;<GLOBAL MCGINTY-RETURNS <>>

<ROUTINE MCGINTY-WILL-FOLLOW ("AUX" GT)
	 <COND (,MCGINTY-KNOWS <RFALSE>)>
	 <SET GT <GET ,GOAL-TABLES ,MCGINTY-C>>
	 <PUT .GT ,GOAL-ENABLE <>>
	 ;<PUT .GT ,GOAL-QUEUED <GET .GT ,GOAL-F>>
	 <PUT .GT ,GOAL-F ,WRECK-13>
	 <PUT .GT ,ATTENTION 500>
	 <DISABLE <INT I-MCGINTY>>
	 <ENABLE <QUEUE I-MCGINTY-FOLLOWS -1>>>

<ROUTINE I-MCGINTY-FOLLOWS ("AUX" GT (MCG-LOC <LOC ,MCGINTY>))
	 <COND (<AND <G? ,PRESENT-TIME 810>
		     <NOT ,ALREADY-FOLLOWED>>
		<DISABLE <INT I-MCGINTY-FOLLOWS>>
		<PUT <SET GT <GET ,GOAL-TABLES ,MCGINTY-C>>
		     ,ATTENTION 0>
		<PUT .GT ,GOAL-ENABLE T>
		<SETG ALREADY-FOLLOWED T>
		<ESTABLISH-GOAL ,MCGINTY ,MCGINTY-HQ>
		<RFALSE>)>
	 <PUT <GET ,GOAL-TABLES ,MCGINTY-C> ,ATTENTION 5>
	 <COND (<AND <==? ,HERE ,OUTFITTERS-HQ>
		     <==? .MCG-LOC ,WHARF-ROAD-4>>
		<MOVE-PERSON ,MCGINTY ,OUTFITTERS-HQ>)
	       (<EQUAL? ,HERE .MCG-LOC ,LAST-PLAYER-LOC>
		<RFALSE>)
	       (<==? .MCG-LOC ,LAST-PLAYER-LOC>
		<RFALSE>)
	       (<NOT <EQUAL? ,LAST-PLAYER-LOC <META-LOC ,LAST-PLAYER-LOC>>>
		<RFALSE>)
	       (T <MOVE-PERSON ,MCGINTY ,LAST-PLAYER-LOC>)>>

<GLOBAL MCGINTY-MEETS-WEASEL <>>
<GLOBAL MCGINTY-MEETS-WEASEL-TABLE
	<TABLE
	 0
	 20  1 FERRY-LANDING
	 35  3 MCGINTY-HQ
	 30  5 SHANTY
	 30  5 MCGINTY-HQ
	 0>>
<GLOBAL ALREADY-FOLLOWED <>>

<OBJECT CIGAR
	(IN MCGINTY)
	(DESC "cigar")
	(SYNONYM CIGAR STOGIE CHEROO)
	(ADJECTIVE LARGE STINKIN)
	(FLAGS TRYTAKEBIT NDESCBIT)
	(TEXT "A Supremo it's not.")
	(ACTION CIGAR-F)>

<ROUTINE CIGAR-F ()
	 <COND (<VERB? TAKE>
		<TELL 
D ,MCGINTY " yanks it back, then tenderly clamps it between his teeth." CR>)
	       (<VERB? LAMP-ON>
		<TELL-ALREADY "lit">)
	       (<VERB? SMELL>
		<TELL 
"The cigar smells like a burning tire." CR>)>>

<OBJECT JOHNNY
	(IN SHANTY)
	(DESC "Johnny Red")
	(DESCFCN JOHNNY-F)
	(SYNONYM JOHNNY JOHN RED)
	(ADJECTIVE JOHNNY JOHN MISTER MR)
	(CHARACTER 2)
	(FLAGS PERSON VICBIT)
	(TEXT
"Red got his name from flame-red hair which sprouts from his head and face, and
peeks out from under his flannel shirt. He takes no guff, but he is fair and
has a sense of justice.")
	(CONTFCN JOHNNY-F)
	(ACTION JOHNNY-F)>

<ROUTINE JOHNNY-F ("OPTIONAL" (RARG <>) "AUX" TREAS)
	 <COND (<==? .RARG ,M-OBJDESC>
		<COND (<AND <QUEUED? I-PENDULUM>
			    <==? <GET <INT I-PENDULUM> ,C-TICK> -1>>
		       <RTRUE>)
		      (<IN-MOTION? ,JOHNNY>
		       <RTRUE>)
		      (<AND <EQUAL? ,HERE ,MM-AFT-DECK ,NW-AFT-DECK>
			    ,WEASEL-APPREHENDED
			    <NOT <QUEUED? I-PENDULUM>>>
		       <I-JOHNNY ,G-REACHED>);"throws line over side"
		      (<FSET? ,JOHNNY ,TOUCHBIT>
		       <TELL D ,JOHNNY " is here">
		       <COND (<IN? ,SPEAR-CARRIER ,HERE>
			      <COND (<IN? ,MCGINTY ,HERE>
			      	     <TELL ", glaring at " D ,MCGINTY>)
			            (<AND <OR <L? ,FM-CTR 2>
					      <G? ,FM-CTR 4>>
					  <NOT <==? ,PRESENT-TIME 704>>>
				     <TELL
", chatting with the " D ,SPEAR-CARRIER>)>)>
		       <TELL "." CR>)
		      (T <TELL
D ,JOHNNY " is here. Red hair sprouts from his head and from beneath his
flannel shirt." CR>
		       <FSET ,JOHNNY ,TOUCHBIT>)>
	        <RTRUE>)
	       (<==? .RARG ,M-CONT>
		<COND (<AND <VERB? TAKE>
			    <FSET? ,PRSO ,TAKEBIT>>
		       <TELL
"Johnny glares down at you. \"Get your hands off of that!\"" CR>
		       <RTRUE>)
		      (<AND <EQUAL? ,KNIFE ,PRSO ,PRSI>
			    <AND <NOT <VERB? EXAMINE FIND ASK-ABOUT>>
				 <NOT <VERB? ASK-CONTEXT-ABOUT>>>>
		       <TELL
"Johnny pulls it back. \"I'm not gonna let you give this to " D ,WEASEL ".\""
CR>
		       <RTRUE>)
		      (T <RFALSE>)>)>
	 <COND (<AND <==? ,JOHNNY ,WINNER>
		     <NOT <==? <META-LOC ,JOHNNY> <META-LOC ,PLAYER>>>>
		<SETG P-CONT <>>
		<TELL-NOT-HERE-TALK>
		<RFATAL>)>
	 <FSET ,JOHNNY ,TOUCHBIT>
	 <COND (<AND <VERB? FOLLOW>
		     <PRSO? ,JOHNNY>>
		<RFALSE>)
	       (<AND <VERB? TELL>
		     <NOT ,PRSI>>
		<RFALSE>)
	       (<OR ,MCGINTY-KNOWS ,JOHNNY-SILENT>
		<TELL D ,JOHNNY " looks right through you." CR>
		<RFATAL>)
	       (<VERB? HELLO GOODBYE>
		<SETG QCONTEXT ,JOHNNY>
		<SETG QCONTEXT-ROOM ,HERE>
		<TELL "\"Ahoy, matey.\"" CR>
		<RTRUE>)
	       (<VERB? BUY>
		<COND (<PRSO? ,FERRY-TOKEN>
		       <TELL "\"Try " D ,BANK ".\"" CR>
		       <RTRUE>)>)>
	 <COND (<AND <VERB? $CALL> <==? ,WINNER ,PLAYER>> <RFALSE>)
	       (<NOT <GRAB-ATTENTION ,JOHNNY>> <RTRUE>)>
	 <COND (<AND <VERB? GIVE SHOW>
		     <PRSO? ,CHARTS>>
		<TELL "\"No thanks. I have my own.\"" CR>
		<RTRUE>)
	       (<OR <AND <VERB? SHOW>
		     	 <PRSO? ,NOTE>>
		    <AND <VERB? ASK-ABOUT>
			 <PRSI? ,NOTE>>>
		<TELL "\"Yeah. I wrote that.\"" CR>
		<RTRUE>)
	       (<AND <VERB? GIVE>
		     <OR <PRSO? ,ENVELOPE>
			 <PRSO? ,ID-CARD>>>
		<COND (<NOT <IN? ,ID-CARD ,ENVELOPE>>
		       <TELL-RETURNS ,JOHNNY>)>
		<PERFORM ,V?SHOW ,PRSO ,JOHNNY>
		<RTRUE>)
	       (<AND <VERB? SHOW>
		     <PRSI? ,JOHNNY>>
		<COND (<AND <IN? ,ID-CARD ,ENVELOPE>
			    <OR <PRSO? ,ENVELOPE>
			        <PRSO? ,ID-CARD>>>
		       <TELL
"Johnny takes the card and " D ,ENVELOPE " and studies them. ">
		       <COND (,WEASEL-APPREHENDED
			      <TELL-ALREADY-SHOWN>
			      <TELL
",\" he says, handing the " D ,ENVELOPE " back.">)
			     (,CLUMSILY-HANDLED
			      <TELL
"\"You trying to frame " D ,WEASEL "?\" He returns the " D ,ENVELOPE ".">)
			     (T
		       	      <MOVE ,ENVELOPE ,JOHNNY>
		       	      <TELL
"\"So,\" he muses, \"" D ,WEASEL " is working with " D ,MCGINTY
". I'll take care of him.\"">
		       	      ;<COND (<AND ,AT-SEA
					  <NOT ,WEASEL-BLOWN>
					  <NOT ,MOMENT-OF-TRUTH>>
			      	     <TELL " He stops the boat.">
			      	     <DISABLE <INT I-OBSTACLES>>)>
			      <SETG WEASEL-BLOWN T>
		       	      <COND (<IN? ,WEASEL <LOC ,JOHNNY>>
			      	     <ROUGH-JUSTICE>)
			     	    (<OR <IN? ,WEASEL ,FERRY>
					 <IN? ,WEASEL ,GLOBAL-FERRY>>
				     <ESTABLISH-GOAL ,JOHNNY ,FERRY-LANDING>)
				    (T
				     <ESTABLISH-GOAL ,JOHNNY <META-LOC ,WEASEL>>)>)>
		       <CRLF>
		       <RTRUE>)
		      (<PRSO? ,ENVELOPE>
		       <COND (,WEASEL-BLOWN
			      <TELL-ALREADY-SHOWN>)
			     (T
			     <TELL "\"It's empty. It don't mean nothing">
		       	      <SETG CLUMSILY-HANDLED T>)>
		       <TELL ".\"" CR>
		       <RTRUE>)
		      (<PRSO? ,ID-CARD>
		       <COND (,WEASEL-BLOWN
			      <TELL-ALREADY-SHOWN>)
			     (T
			      <TELL
"\"That's " D ,WEASEL "'s. He'll be glad you found it">
		       	      <SETG CLUMSILY-HANDLED T>)>
		       <TELL ".\"" CR>
		       <RTRUE>)>)
	       (<AND <VERB? ASK-ABOUT>
		     <PRSO? ,JOHNNY>>
		<COND ;(<PRSI? ,GLOBAL-MEETING>
		       <COND (<IN? ,MCGINTY ,HERE>
			      <MCGINTY-WILL-FOLLOW>
			      <TELL
"Johnny looks at " D ,MCGINTY " and says, \"You mean the one tomorrow to
discuss, er, buying a ship at, uh, 3 o'clock? It'll be at the ferry landing.\""
CR>)
			     (<==? ,MEETINGS-COMPLETED 0>
			      <COND (<AND <G? ,FM-CTR 1>
					  <L? ,FM-CTR 5>>
				     <TELL "\"We're in it!\"" CR>)
				    (<L? ,PRESENT-TIME 525>
				     <COND (<==? ,FM-CTR 0>
					    <RTRUE>)
					   (T <TELL 
"\"Glad you got the note. We'll start when everyone shows.\"" CR>)>)
				    (<QUEUED? I-FIRST-MEETING>
				     <RTRUE>)
				    (T <TELL "\"It's too late.\"" CR>)>)
			     (<==? ,MEETINGS-COMPLETED 1>
			      <COND (<AND <G? ,SM-CTR 1>
					  <L? ,SM-CTR 4>>
				     <TELL
"\"This isn't a bingo game!\"" CR>)
				    (<L? ,PRESENT-TIME 586>
				     <COND (<EQUAL? ,HERE ,WINDING-ROAD-1>
					    <COND (<==? ,SM-CTR 0>
						   <RTRUE>)
						  (T <TELL
"\"It'll start when we're all here.\"" CR>)>)
					   (T <TELL
"\"9:30 at the " D ,LIGHTHOUSE ".\"" CR>)>)
				    (T <TELL "\"You missed it, turkey!\"" CR>)>)
			     (<==? ,MEETINGS-COMPLETED 2>
			      <COND (<AND <G? ,TM-CTR 0>
					  <L? ,TM-CTR 8>>
				     <TELL
"\"It's what I'm doing now. I hope you are, too.\"" CR>)
				    (<L? ,PRESENT-TIME 660>
				     <TELL
"\"Point Lookout at 10:45. Bring $500.\"" CR>)
				    (T <TELL
"\"I waited for you at Point Lookout. It's too late now.\"" CR>)>)
			     (<OR <G? ,PRESENT-TIME 870>
				  <AND <G? ,PRESENT-TIME 705>
				       <NOT ,JOHNNY-MADE-DEAL>>>
			      <TELL
"\"There are no more " D ,GLOBAL-MEETING "s.\"" CR>)
			     (<==? ,MEETINGS-COMPLETED 3>
			      <TELL
"\"We'll all meet at the ship at 2:30.\"" CR>)>)
		      (<PRSI? ,GLOBAL-TREASURE ,SAMPLE-TREASURE ,SHARK>
		       <COND (<IN? ,MCGINTY ,HERE>
			      <MCGINTY-AND-TREASURE ,GLOBAL-TREASURE>)
			     (<OR <NOT <ENABLED? I-JOHNNY>>
				  <NOT ,SAMPLE-TREASURE>>
			      <TELL
"Red scowls. \"What " D ,GLOBAL-TREASURE "?\"" CR>)
			     (<L? ,SM-CTR 2>
			      <TELL "\"All in good time.\"" CR>)
			     (<OR <L? ,TM-CTR 7>
				  <IN? ,WEASEL ,HERE>
				  <IN? ,PETE ,HERE>
				  <IN? ,SPEAR-CARRIER ,HERE>>
			      <TELL
"\"I told you. I found a " D ,SAMPLE-TREASURE " while I was cleaning a shark.\"" CR>)
			     (<PRSI? ,SHARK>
			      <TELL "\"I made that up.\"" CR>)
			     (T <TELL "\"Hevlin gave it to me.\"" CR>)>)
		      ;(<AND <PRSI? ,LEFT-BUTTON ,RIGHT-BUTTON ,DECK-CHAIR>
			    <G? <GETP ,HERE ,P?LINE>
				,BACK-ALLEY-LINE-C>>
		       <TELL-BUTTON-EXPLAIN>)
		      (<PRSI? ,BOOK>
		       <COND (<OR <L? ,TM-CTR 7>
				  <IN? ,WEASEL ,HERE>
				  <IN? ,PETE ,HERE>
				  <IN? ,SPEAR-CARRIER ,HERE>>
			      <RFALSE>)
			     (T
			      <TELL "\"That's the one Hevlin gave you.\"" CR>)>)
		      (<PRSI? ,PETES-PATCH>
		       <TELL "\"Pete's worn it a long time.\"" CR>)
		      (<PRSI? ,HEVLIN>
		       <TELL "\"He was an old friend of mine.\"" CR>)
		      (<PRSI? ,SPEAR-CARRIER>
		       <TELL "\"You know him as well as I do.\"" CR>)
		      (<PRSI? ,ME>
		       <TELL-YOURE-DIVER>)
		      (<PRSI? ,WEASEL>
		       <TELL "\"The Weasel? ">
		       <COND (,WEASEL-BLOWN
			      <TELL "Lower than a sea slug...\"">)
			     (<IN? ,WEASEL ,HERE>
			      <TELL "He's my pal.\"">
			      <TELL-FERRY-KLUDGE "grins">)
			     (T <TELL
"I wouldn't trust him farther than I could throw a whale! But he's a great
one-man crew.\"">)>
		       <CRLF>)
		      (<PRSI? ,MCGINTY>
		       <COND (<IN? ,MCGINTY ,HERE>
			      <PRINTC %<ASCII !\">>
			      <TELL 
D ,MCGINTY "'s one of my favorite people to work for!\"" CR>)
			     (T <TELL
"\"That man would sell his mother for a profit!\"" CR>)>)
		      (<PRSI? ,PETE>
		       <COND (<IN? ,PETE ,HERE>
			      <TELL "Johnny leans over and mutters, ">)>
		       <TELL 
"\"Pete's no genius, but he's dependable. He got a bad name 'cause of
what happened, him serving his mates rats for mess. But he'll
never make that mistake again!\"" CR>)
		      (<PRSI? ,JOHNNY>
		       <TELL-KNOW-ME>)
		      (<PRSI? ,PARROT>
		       <TELL "\"It's what makes " D ,SHANTY " what it is.\"" CR>)
		      (<PRSI? ,TRAWLER ,SALVAGER>
		       <TELL "\"It's one of Outfitters' boats.\"" CR>)
		      (<PRSI? ,LINE-HACK>
		       <TELL ,LINE-STR CR>)
		      (T <RFALSE>)>
		<RTRUE>)>
	 <COND (<EQUAL? ,WINNER ,JOHNNY>
		<COND (<PRSO? ,GLOBAL-SELF>
		       <SETG PRSO ,JOHNNY>)>
		<COND (<PRSI? ,GLOBAL-SELF>
		       <SETG PRSI ,JOHNNY>)>
		<COND (<IN? ,MCGINTY ,HERE>
		       <COND (<PRSO? ,GLOBAL-TREASURE ,SAMPLE-TREASURE>
			      <SET TREAS ,PRSO>)
			     (<PRSI? ,SAMPLE-TREASURE ,GLOBAL-TREASURE> 
			      <SET TREAS ,PRSI>)>
			<COND (.TREAS
			       <MCGINTY-AND-TREASURE .TREAS>
			       <RTRUE>)>)>
		<COND (<AND <VERB? TELL>
			    <PRSO? ,ME>>
		       <RFALSE>)
		      (<VERB? $CALL>
		       <TELL-SO-WHAT>)
		      (<AND <VERB? SHOW>
			    <IN? ,PRSO ,JOHNNY>
			    <PRSI? ,ME>>
		       <SETG WINNER ,PLAYER>
		       <PERFORM ,V?EXAMINE ,PRSO>
		       <SETG WINNER ,JOHNNY>)
		      (<VERB? YES NO MAYBE LATITUDE LONGITUDE WHAT FIND SSHOW 
			      ALARM>
		       <RFALSE>)
		      (T
		       <TELL "\"I'll do what I want.\"" CR>
		       <RFATAL>)>)>>

<ROUTINE MCGINTY-AND-TREASURE (TRE)
	 <MCGINTY-WILL-FOLLOW>
	 <TELL
"Johnny looks at " D ,MCGINTY " and then at you. \"What " D .TRE "?\"" CR>>

<ROUTINE TELL-RETURNS (PER)
	 <START-SENTENCE .PER>
	 <TELL " looks at the " D ,PRSO " and hands it back to you. ">>

<ROUTINE TELL-ALREADY-SHOWN ()
	 <TELL-YOU-ALREADY "showed me this" T <>>>

<ROUTINE TELL-YOU-ALREADY (STR "OPTIONAL" (QUOTE? <>) (DONE T))
	 <COND (.QUOTE? <TELL "\"">)>
	 <TELL "You already " .STR>
	 <COND (.DONE <CRLF>)>>

<ROUTINE I-JOHNNY ("OPTIONAL" (GARG <>) "AUX" (L <LOC ,JOHNNY>) JMG V)
	 <COND (<NOT .GARG>
		<COND (,WEASEL-BLOWN
		       <RFALSE>)
		      (<OR <AND <G? ,FM-CTR 1>
			    	<L? ,FM-CTR 5>>
			   <AND <G? ,TM-CTR 0>
				<L? ,TM-CTR 8>>>
		       <ENABLE <QUEUE I-JOHNNY 1>>
		       <RFALSE>)> ;"So he doesn't leave during 1st meeting"
		<SET JMG <GET ,MOVEMENT-GOALS ,JOHNNY-C>>
		<COND (<AND <EQUAL? <GET .JMG ,MG-ROOM> ,MM-CAPT-CABIN>
		       	    <EQUAL? ,SHIP-CHOSEN ,TRAWLER>>
		       <PUT .JMG ,MG-ROOM ,NW-CAPT-CABIN>)>
		<IMOVEMENT ,JOHNNY I-JOHNNY>)
	       (<==? .GARG ,G-REACHED>
		<COND (,WEASEL-APPREHENDED
		       <COND (<EQUAL? .L ,MM-LOUNGE ,NW-LOUNGE>
		       	      <COND (<IN? ,PLAYER <LOC ,WEASEL>>
				     <TELL-JOHNNY-DRAGS>)>
			      <MOVE ,WEASEL .L>
		       	      <COND (<==? ,SHIP-CHOSEN ,TRAWLER>
			      	     <ESTABLISH-GOAL ,JOHNNY ,NW-AFT-DECK>)
			     	    (T <ESTABLISH-GOAL ,JOHNNY ,MM-AFT-DECK>)>
		       	      <COND (<IN? ,PLAYER .L>
			      	     <TELL
"Johnny drags " D ,WEASEL " in, ties him up, and throws him to the floor."
CR>)>
			      <RTRUE>)
			     (<EQUAL? .L ,MM-AFT-DECK ,NW-AFT-DECK>
			      <COND (<AND <NOT <QUEUED? I-PENDULUM>>
					  <IN? ,PLAYER .L>>
				     <ENABLE <QUEUE I-PENDULUM -1>>
				     <FCLEAR ,LINE-HACK ,INVISIBLE>
				     <MOVE ,LINE-HACK .L>
				     <TELL
"Johnny approaches, throws a weighted " D ,SAFETY-LINE
" over the side, and says, " ,LINE-STR CR>
				     <RTRUE>)>)>)
		      (,WEASEL-BLOWN
		       <COND (<EQUAL? .L <META-LOC ,WEASEL>>
		       	      <ROUGH-JUSTICE>)
		       	     (<OR <IN? ,WEASEL ,GLOBAL-FERRY>
				  <IN? ,WEASEL ,FERRY>
				  <IN? ,WEASEL ,LOCAL-GLOBALS>>
			      <RFALSE>)
			     (<NOT <EQUAL? <GET <GET ,GOAL-TABLES ,JOHNNY-C>
						,GOAL-F> <META-LOC ,WEASEL>>>
			      <ESTABLISH-GOAL ,JOHNNY <META-LOC ,WEASEL>>
			      <RFALSE>)>)
		      (<AND <==? .L ,OUTFITTERS-HQ>
			    <==? ,MEETINGS-COMPLETED 3>>
		       <ENABLE <QUEUE I-EQUIP -1>>)>
		<COND (<==? .L ,HERE>
		       <COND ;(<QUEUED? I-DIVETIME>
			      <JOHNNY-SAYS-GO>
			      <RFATAL>)
	                     (T
		       	      <TELL
D ,JOHNNY " appears, striding like a proud lion." CR>
			      <COND (<QUEUED? I-THIRD-MEETING>
				     <I-THIRD-MEETING>)>
		       	      <RFATAL>)>)
		      ;(,DEBUG
		       <TELL "[Johnny Red has arrived at " D .L ".]" CR>)>)
	       (<EQUAL? .GARG ,G-ENROUTE>
		<COND (,WEASEL-BLOWN
		       <COND (,WEASEL-APPREHENDED
			      <COND (<NOT <EQUAL? <LOC ,WEASEL>
					         ,MM-LOUNGE ,NW-LOUNGE>>
			      	     <COND (<IN? ,WEASEL .L>
					    <SET V T>)>
				     <MOVE ,WEASEL .L>
			      	     <COND (<OR .V <IN? ,PLAYER .L>>
				     	    <TELL-JOHNNY-DRAGS>)>)>)
			     (T
			      <COND (<EQUAL? .L <META-LOC ,WEASEL>>
		       	      	     <ROUGH-JUSTICE>)
		             	    (<OR <IN? ,WEASEL ,GLOBAL-FERRY>
					 <IN? ,WEASEL ,FERRY>
					 <IN? ,WEASEL ,LOCAL-GLOBALS>>
				     <RFALSE>)
				    (<NOT <EQUAL?
					   <GET <GET ,GOAL-TABLES ,JOHNNY-C>
						,GOAL-F>
				    	  <META-LOC ,WEASEL>>>
			      	     <ESTABLISH-GOAL ,JOHNNY <META-LOC ,WEASEL>>
			      	     <RFALSE>)>)>)>)>>

;<GLOBAL MOMENT-OF-TRUTH <>>
<GLOBAL WEASEL-BLOWN <>>
<GLOBAL WEASEL-APPREHENDED <>>
<GLOBAL CLUMSILY-HANDLED <>>
<GLOBAL LINE-STR "\"Tie the line to the treasure when you've got it, then pull
on it and we'll pull the treasure up.\"">

<ROUTINE TELL-JOHNNY-DRAGS ()
	 <TELL "Johnny drags " D ,WEASEL " along with him." CR>>

<ROUTINE ROUGH-JUSTICE ("AUX" (PRINT? <>))
	 <COND (<IN? ,PLAYER <LOC ,JOHNNY>>
		<SET PRINT? T>
		<CRLF>
		<TELL
"Johnny grabs " D ,WEASEL " and his knife. \"All right, slime.
Thought you and " D ,MCGINTY " could rip us off, huh?\"
Before he turns to lead " D ,WEASEL " away, ">)>
	 <COND (,AT-SEA ;,MOMENT-OF-TRUTH
	        <SETG WEASEL-APPREHENDED T>
		<MOVE ,KNIFE ,JOHNNY>
		;<COND (.PRINT? <TELL
"Red tells you to meet him at the Aft Deck before you dive." CR>)>
	        <ESTABLISH-GOAL ,JOHNNY <LOC ,LOUNGE-CHAIR>>
		;<COND (<EQUAL? ,SHIP-CHOSEN ,TRAWLER>
		       <ESTABLISH-GOAL ,JOHNNY ,NW-LOUNGE>)
		      (T <ESTABLISH-GOAL ,JOHNNY ,MM-LOUNGE>)>)
	       ;(,AT-SEA
	        <COND (.PRINT? <TELL
"Red says, \"We'll turn around. I don't wanna waste my chance
without a crew.\" You head back for the Island, cursing " D ,MCGINTY " and
" D ,WEASEL "." CR>)
		      (T
		       <TELL-COMES-UP ,JOHNNY>
		       <TELL
"\"I've taken care of Weasel, but
I don't want to go on without a full crew. It would be a shame to find the
treasure and not get back with it. Maybe next time.\"" CR>)>
	        <FINISH>)
	       (T
	        <COND (.PRINT? <TELL
"Johnny says, \"We'd have to find someone else to crew. I better call it
off.\" You head for " D ,SHANTY ", wishing you had more to do today than
drink." CR>)
		      (T
		       <TELL-COMES-UP ,JOHNNY>
		       <TELL
"\"I've taken care of " D ,WEASEL ", but we can't go out without a crew.
Maybe next time.\"" CR>)>
	        <FINISH>)>>

<OBJECT PETE
	(IN SHANTY)
	(DESC "Pete the Rat")
	(DESCFCN PETE-F)
	(SYNONYM RAT COOK)
	(ADJECTIVE PETE PETER MR MISTER)
	(CHARACTER 3)
	(FLAGS PERSON VICBIT)
	(TEXT
"Pete wears an eyepatch and got his name on a far-east voyage as the cook.
The food ran out, and he did what he could to supply the crew with fresh meat.
Needless to say, he was left at the nearest port.")
	(CONTFCN PETE-F)
	(ACTION PETE-F)>

;"Unfortunately, the only meat available came in the form of the ever-present
rodent. [This sentence was the next-to-last one above, but SCF objected: 'If
someone can't figure out that the Rat in Pete's name is what he fed, then they
don't deserve to.']"

<ROUTINE TELL-COMES-UP (WHO)
	 <START-SENTENCE .WHO>
	 <TELL " comes up to you and says, ">>

;<ROUTINE TELL-MAKE-SURE ()
	 <TELL
"\"Just wanted to make sure you were standing watch.\"" CR>>

;<ROUTINE TELL-DO-WATCH ()
	 <TELL
"\"You're supposed to be up at the foredeck standing watch! Better hurry!\"" CR>>

<ROUTINE PETE-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-OBJDESC>
		<COND ;(<==? ,PETE ,SEARCHER>
		       <SETG SEARCHER <>>
		       <ESTABLISH-GOAL ,PETE <LOC ,DRINKING-WATER>>
		       ;<COND (<==? ,SHIP-CHOSEN ,SALVAGER>
			      <ESTABLISH-GOAL ,PETE ,MM-GALLEY>)
			     (T <ESTABLISH-GOAL ,PETE ,NW-GALLEY>)>
		       <COND (<IN? ,DECK-CHAIR <LOC ,PETE>>
			      <SET-NEXT-WATCH>
			      <TELL-COMES-UP ,PETE>
			      <TELL-MAKE-SURE>)
			     (T
			      <TELL-COMES-UP ,PETE>
			      <TELL-DO-WATCH>)>)
		      (<IN-MOTION? ,PETE> <RTRUE>)
		      (<EQUAL? <LOC ,PETE> ,MM-GALLEY ,NW-GALLEY>
		       <TELL D ,PETE " is watching over his stew." CR>)
		      ;(<AND <EQUAL? <LOC ,PETE> ,MM-CREW-QTRS ,NW-CREW-QTRS>
			    ,AT-SEA
			    <NOT <EQUAL? <GET <GET ,GOAL-TABLES
					    <GETP ,PETE ,P?CHARACTER>> ,GOAL-F>
				      	 ,MM-GALLEY ,NW-GALLEY>>>
		       <TELL D ,PETE " is asleep in a bunk." CR>)
		      (<OR <AND <G? ,FM-CTR 1>
			    	<L? ,FM-CTR 5>>
			   <==? ,PRESENT-TIME 704>>
		       <TELL
D ,PETE " is sitting here, listening intently." CR>)
		      (<FSET? ,PETE ,TOUCHBIT>
		       <TELL 
D ,PETE " fiddles with his eyepatch, shifting his weight
from foot to foot." CR>)
		      (T <TELL
"A man wearing an eyepatch, black turtleneck, and jeans is standing about.
He is known as " D ,PETE "." CR>
		       <FSET ,PETE ,TOUCHBIT>)>
	        <RTRUE>)
	       (<==? .RARG ,M-CONT>
		<COND (<AND <VERB? TAKE>
			    <FSET? ,PRSO ,TAKEBIT>>
		       <TELL "Pete pulls it back. \"That's mine!\"" CR>
		       <RTRUE>)
		      (T <RFALSE>)>)>
	 <COND (<AND <==? ,WINNER ,PETE>
		     <NOT <==? <META-LOC ,PETE> <META-LOC ,PLAYER>>>>
		<SETG P-CONT <>>
		<TELL-NOT-HERE-TALK>
		<RFATAL>)>
	 <FSET ,PETE ,TOUCHBIT>
	 <COND (<AND <VERB? FOLLOW>
		     <PRSO? ,PETE>>
		<RFALSE>)
	       (<VERB? HELLO>
		<SETG QCONTEXT ,PETE>
		<SETG QCONTEXT-ROOM ,HERE>
		<TELL "\"Hi.\"" CR>
		<RTRUE>)
	       (<VERB? GOODBYE>
		<SETG QCONTEXT ,PETE>
		<SETG QCONTEXT-ROOM ,HERE>
		<TELL "\"Bye.\"" CR>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL "Phew! Better stay upwind of him." CR>
		<RTRUE>)
	       (<VERB? BUY>
		<COND (<PRSO? ,FERRY-TOKEN>
		       <TELL 
"Pete checks his pockets, then holds out his empty hands." CR>
		       <RTRUE>)>)>
	 <COND (<AND <VERB? $CALL> <==? ,WINNER ,PLAYER>> <RFALSE>)
	       (<NOT <GRAB-ATTENTION ,PETE>> <RTRUE>)>
	 <COND (<AND <VERB? GIVE>
		     <OR <PRSO? ,ENVELOPE>
			 <PRSO? ,ID-CARD>>>
		<COND (<NOT <IN? ,ID-CARD ,ENVELOPE>>
		       <TELL-RETURNS ,PETE>)>
		<PERFORM ,V?SHOW ,PRSO ,PETE>
		<RTRUE>)
	       (<AND <VERB? SHOW>
		     <PRSI? ,PETE>>
		<COND (<AND <IN? ,ID-CARD ,ENVELOPE>
			    <OR <PRSO? ,ENVELOPE>
			        <PRSO? ,ID-CARD>>>
		       <TELL
"Pete takes the " D ,ENVELOPE ", studies it, then returns it. \"Looks like
" D ,WEASEL "'s card to me,\" he says." CR>		       
		       <RTRUE>)
		      (<PRSO? ,ENVELOPE>
		       <TELL "\"Looks like it's empty.\"" CR>
		       <RTRUE>)
		      (<PRSO? ,ID-CARD>
		       <TELL
"\"Looks like " D ,WEASEL "'s card. Better return it.\"" CR>
		       <RTRUE>)>)
	       (<AND <VERB? ASK-ABOUT>
		     <PRSO? ,PETE>>
		<COND ;(<PRSI? ,GLOBAL-MEETING>
		       <COND (<IN? ,MCGINTY ,HERE>
			      <MCGINTY-WILL-FOLLOW>)>
		       <COND (<AND <==? ,MEETINGS-COMPLETED 0>
				   <L? ,PRESENT-TIME 525>>
			      <COND (<G? ,FM-CTR 1>
				     <TELL "\"That's what we're having.\"" CR>)
				    (<IN? ,WEASEL ,SHANTY>
				     <TELL
"\"We can start as soon as you sit down.\"" CR>)
				    (T <TELL
"\"Yeah. Johnny wants to talk about something he found. We're waiting
for " D ,WEASEL ".\"" CR>)>)
			     (<AND <==? ,MEETINGS-COMPLETED 1>
				   <L? ,PRESENT-TIME 586>>
			      <COND (<==? ,HERE ,WINDING-ROAD-1>
				     <TELL "\"That's why we're here.\"" CR>)
				    (T <TELL 
"\"Didn't you hear Johnny? We meet at the " D ,LIGHTHOUSE " at 9:30.\"" CR>)>)
			     (<==? ,MEETINGS-COMPLETED 2>
			      <COND (<L? ,PRESENT-TIME 705>
				     <TELL
"\"The Weasel and me meet Johnny in " D ,SHANTY " at 11:45. But I don't
think you're supposed to be there.\"" CR>)
				    (T <TELL
"\"Forget it. The deal's off.\"" CR>)>)
			     (<OR <G? ,PRESENT-TIME 870>
				  <G? <GETP ,HERE ,P?LINE> ,BACK-ALLEY-LINE-C>>
			      <TELL
"\"I don't think there's any more " D ,GLOBAL-MEETING "s.\"" CR>)
			     (<==? ,MEETINGS-COMPLETED 3>
			      <TELL
"\"We're supposed to meet at 2:30 at the ship, I think.\"" CR>)
			     (T <TELL
"\"The " D ,GLOBAL-MEETING " was called off since everyone wasn't there.\""
CR>)>)
		      (<PRSI? ,GLOBAL-TREASURE>
		       <COND (<IN? ,MCGINTY ,HERE>
			      <MCGINTY-WILL-FOLLOW>)>
		       <COND (<L? ,FM-CTR 3>
			      <TELL
"\"I think that's what Johnny wants to talk about.\"" CR>)
			     (<L? <GETP ,HERE ,P?LINE> ,TRAWLER-LINE-C>
			      <TELL "\"Looks like Johnny found some.\"" CR>)
			     (T <TELL "\"That's what we're lookin' for.\"" CR>)>)
		      (<AND <PRSI? ,SAMPLE-TREASURE>
			    <IN? ,SAMPLE-TREASURE ,JOHNNY>>
		       <COND (<IN? ,MCGINTY ,HERE>
			      <MCGINTY-WILL-FOLLOW>)>
		       <TELL
"\"You saw it. You should know more about it than me.\"" CR>)
		      ;(<AND <PRSI? ,LEFT-BUTTON ,RIGHT-BUTTON ,DECK-CHAIR>
			    <G? <GETP ,HERE ,P?LINE>
				,BACK-ALLEY-LINE-C>>
		       <TELL
"\"You've never seen this setup? The " D ,LEFT-BUTTON
" tells the captain there's
danger to port, and the " D ,RIGHT-BUTTON
" means there's something to starboard.\"" CR>)
		      (<PRSI? ,PETES-PATCH>
		       <TELL
"\"That's my eyepatch. It covers my bad eye.\"" CR>)
		      (<PRSI? ,STOVE>
		       <TELL "\"There's nothing special about the " D ,STOVE ".\"" CR>)
		      (<PRSI? ,SPEAR-CARRIER>
		       <TELL "\"He's a good guy.\"" CR>)
		      (<PRSI? ,JOHNNY>
		       <TELL 
"Pete thinks for a second. \"Yeah, Red's a friend of mine.\"" CR>)
		      (<PRSI? ,MCGINTY>
		       <TELL 
"\"I done work for him, but I don't like him.\"" CR>)
		      (<PRSI? ,HEVLIN>
		       <TELL-NEVER-KNEW>)
		      (<PRSI? ,WEASEL>
		       <TELL "Pete frowns for a moment, then ">
		       <COND (<IN? ,WEASEL ,HERE>
			      <TELL "leans over and whispers">)
			     (T <TELL "says">)>
		       <TELL 
", \"The Weasel's a friend, but I don't trust him. He's awful quick
with that knife.\"" CR>)
		      (<PRSI? ,PETE>
		       <TELL-KNOW-ME>)
		      (<PRSI? ,ME>
		       <TELL-YOURE-DIVER>)
		      (<PRSI? ,PARROT>
		       <TELL "\"He's weird. He talks funny.\"" CR>)
		      (<AND <PRSI? ,FOOD>
			    <G? <GETP ,HERE ,P?LINE> ,BACK-ALLEY-LINE-C>>
		       <TELL
"\"It's a beef stew. There's nothing wrong with it.\"" CR>)
		      (<PRSI? ,SALVAGER ,TRAWLER>
		       <TELL "\"She's a boat.\"" CR>)
		      (T <RFALSE>)>
		<RTRUE>)>
	 <COND (<EQUAL? ,WINNER ,PETE>
		<COND (<PRSO? ,GLOBAL-SELF>
		       <SETG PRSO ,PETE>)>
		<COND (<PRSI? ,GLOBAL-SELF>
		       <SETG PRSI ,PETE>)>
		<COND (<AND <VERB? TELL>
			    <PRSO? ,ME>>
		       <RFALSE>)
		      (<VERB? $CALL>
		       <TELL-SO-WHAT>)
		      (<AND <VERB? SHOW>
			    <IN? ,PRSO ,PETE>
			    <PRSI? ,ME>>
		       <SETG WINNER ,PLAYER>
		       <PERFORM ,V?EXAMINE ,PRSO>
		       <SETG WINNER ,PETE>)
		      (<VERB? YES NO MAYBE LATITUDE LONGITUDE WHAT FIND SSHOW
			      ALARM>
		       <RFALSE>)
		      (T
		       <TELL "\"I don't think I can do that.\"" CR>
		       <RFATAL>)>)>>

<ROUTINE I-PETE ("OPTIONAL" (GARG <>) "AUX" (L <LOC ,PETE>) PMG)
	 <COND (<NOT .GARG>
		<COND (<AND <G? ,FM-CTR 1>
			    <L? ,FM-CTR 5>>
		       <ENABLE <QUEUE I-PETE 1>>
		       <RFALSE>)> ;"So he doesn't leave during 1st meeting"
		<SET PMG <GET ,MOVEMENT-GOALS ,PETE-C>>
		<COND (<AND <EQUAL? <GET .PMG ,MG-ROOM> ,MM-GALLEY>
			    <EQUAL? ,SHIP-CHOSEN ,TRAWLER>>
		       <PUT .PMG ,MG-ROOM ,NW-GALLEY>)>
		<IMOVEMENT ,PETE I-PETE>)
	       (<==? .GARG ,G-REACHED>
		<COND (<AND <EQUAL? .L ,MM-GALLEY ,NW-GALLEY>
			    <EQUAL? <GETP .L ,P?LINE>
				    <GETP <META-LOC ,PLAYER> ,P?LINE>>>
		       <FSET ,FOOD ,NDESCBIT>
		       <MOVE ,FOOD ,STOVE>)>
		<COND (<==? ,HERE .L>
		       <COND ;(<==? ,PETE ,SEARCHER>
		       	      <SETG SEARCHER <>>
		       	      <ESTABLISH-GOAL ,PETE <LOC ,DRINKING-WATER>>
			      ;<COND (<==? ,SHIP-CHOSEN ,SALVAGER>
			      	     <ESTABLISH-GOAL ,PETE ,MM-GALLEY>)
			     	    (T <ESTABLISH-GOAL ,PETE ,NW-GALLEY>)>
		       	      <COND (<IN? ,DECK-CHAIR .L>
				     <SET-NEXT-WATCH>
				     <TELL-COMES-UP ,PETE>
				     <TELL-MAKE-SURE>)
				    (T
				     <TELL-COMES-UP ,PETE>
				     <TELL-DO-WATCH>)>)
			     (T
			      <TELL D ,PETE
" arrives, quickly taking in the situation." CR>
			      ;<COND (<AND <EQUAL? .L ,MM-CREW-QTRS
						     ,NW-CREW-QTRS>
					  ,AT-SEA>
				     <TELL
" comes in and falls asleep in one of the bunks." CR>)
				    (T <TELL
" arrives, quickly taking in the situation." CR>)>
			      <RFATAL>)>)
		      ;(,DEBUG
		       <TELL "[Pete the Rat has arrived at " D .L ".]" CR>)>)>>

<OBJECT PETES-PATCH
	(IN PETE)
	(DESC "Pete's eyepatch")
	(SYNONYM EYEPAT PATCH)
	(ADJECTIVE PETE\'S PETES BLACK)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION PETES-PATCH-F)>

<ROUTINE PETES-PATCH-F ()
	 <COND (<OR <VERB? LOOK-UNDER ASK-FOR DISEMBARK>
		    <VERB? MOVE>
		    <AND <VERB? TAKE>
			 <OR <NOT ,PRSI>
			     <PRSI? ,PETE>>>>
		<TELL "Mind your manners." CR>)
	       (<VERB? EXAMINE>
		<TELL "It's a standard black eyepatch." CR>)>>

<OBJECT WEASEL
	(IN FERRY-LANDING)
	(DESC "the Weasel")
	(DESCFCN WEASEL-F)
	(SYNONYM WEASEL WEBSTE)
	(ADJECTIVE FRANK MR MISTER)
	(CHARACTER 4)
	(FLAGS PERSON VICBIT)
	(TEXT
"The Weasel is a small, greasy man with shifty eyes. He loves his sharp
little knife more than life itself, and would sell out anybody for a price.
Even himself.")
	(CONTFCN WEASEL-F)
	(ACTION WEASEL-F)>

;<ROUTINE TELL-WHAT-MEETING? ()
	 <TELL 
"\"What meeting? I don't know nothing about no meeting.\"" CR>>

;<ROUTINE TELL-BUTTON-EXPLAIN ()
	 <TELL
"\"Those are the buttons that tell the captain when there's danger ahead. The
" D ,LEFT-BUTTON
" means there's something to port, and the right one is for something
to starboard.\"" CR>>

;<ROUTINE TELL-MEETING-OFF ()
	  <TELL
"\"The meeting got cancelled when you didn't show.\"" CR>>

<ROUTINE WEASEL-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-OBJDESC>
		<COND (<AND <IN? ,ENVELOPE ,PLAYER> <WEASEL-BEATS-YOU>>
		       <RTRUE>)
		      ;(<==? ,SEARCHER ,WEASEL>
		       <SETG SEARCHER <>>
		       <COND (<==? ,SHIP-CHOSEN ,SALVAGER>
			      <ESTABLISH-GOAL ,WEASEL ,MM-ENGINE-ROOM>)
			     (T <ESTABLISH-GOAL ,WEASEL ,NW-ENGINE-ROOM>)>
		       <COND (<IN? ,DECK-CHAIR <LOC ,WEASEL>>
			      <SET-NEXT-WATCH>
			      <TELL
"The Weasel appears beside you. \"Glad you got here. You were late.\"" CR>)
			     (T
			      <TELL
"The Weasel stalks in. \"You better get topside and stand your
watch. Now.\"" CR>)>)
		      (,WEASEL-APPREHENDED
      		       <COND (<EQUAL? ,HERE ,MM-LOUNGE ,NW-LOUNGE>
			      <TELL-TIED>)
			     (T <TELL
"The Weasel is firmly in Johnny's grasp.">)>
		       <CRLF>)
		      (<AND <QUEUED? I-PENDULUM>
			    <==? <GET <INT I-PENDULUM> ,C-TICK> -1>>
		       <RTRUE>)
		      (<AND <==? ,HERE ,UPSTAIRS-HALLWAY>
			    <QUEUED? I-WEASEL-TO-BEDROOM>>
		       <DISABLE <INT I-WEASEL-TO-BEDROOM>>
		       <TELL "The Weasel sees you come up">
		       <TELL-WEASEL-EXCUSE>)
		      (<OR <AND <G? ,FM-CTR 1>
			    	<L? ,FM-CTR 5>>
			   <AND <==? ,PRESENT-TIME 704>
				<==? ,HERE ,SHANTY>>>
		       <TELL "The Weasel is sitting here, eyes darting." CR>)
		      (<OR <IN-MOTION? ,WEASEL>
			   <TRAITOR-TIME?>>
		       <RTRUE>)
		      (<FSET? ,WEASEL ,TOUCHBIT>
		       <COND ;(<EQUAL? ,HERE ,MM-ENGINE-ROOM ,NW-ENGINE-ROOM>
			      <TELL
"The Weasel is tinkering with the engines." CR>)
			     (<AND <EQUAL? <LOC ,WEASEL> ,MM-AFT-DECK
					   		 ,NW-AFT-DECK>
				   ,AT-SEA ;,MOMENT-OF-TRUTH
				   <NOT ,WEASEL-APPREHENDED>
				   <NOT <QUEUED? I-PENDULUM>>>
			      <ENABLE <QUEUE I-PENDULUM -1>>
		       	      <TELL-WEASEL-TOSSES>);"throws line over side"
			     ;(<AND <EQUAL? <LOC ,WEASEL> ,MM-CREW-QTRS
					   		 ,NW-CREW-QTRS>
				   ,AT-SEA
				   <NOT <EQUAL? <GET <GET ,GOAL-TABLES
						   <GETP ,WEASEL ,P?CHARACTER>>
						    ,GOAL-F> ,MM-ENGINE-ROOM
							     ,NW-ENGINE-ROOM>>>
			      <TELL "The Weasel is asleep in a bunk." CR>)
			     (T <TELL
"The Weasel is picking his teeth with a nasty knife, looking around furtively." CR>)>)
		      (T <TELL 
"A short, wiry guy known only as \"" D ,WEASEL
"\" is over in a corner, picking
his teeth with a knife." CR>
		       <FSET ,WEASEL ,TOUCHBIT>)>
		<RTRUE>)
	       (<==? .RARG ,M-CONT>
		<COND (<AND <VERB? TAKE>
			    <FSET? ,PRSO ,TAKEBIT>>
		       <TELL
"The Weasel glares at you. \"I ain't gonna give that to ya!\"" CR>
		       <RTRUE>)
		      (T <RFALSE>)>)>
	 <COND (<==? ,WINNER ,WEASEL>
		<COND (<NOT <==? <META-LOC ,WEASEL> <META-LOC ,PLAYER>>>
		       <SETG P-CONT <>>
		       <TELL-NOT-HERE-TALK>
		       <RFATAL>)
		      (<TRAITOR-TIME?>
		       <TELL-IN-MEETING>
		       <RFATAL>)>)>
	 <FSET ,WEASEL ,TOUCHBIT>
	 <COND (<AND <VERB? FOLLOW>
		     <PRSO? ,WEASEL>>
		<RFALSE>)
	       (<AND <VERB? $CALL>
		     <TRAITOR-TIME?>>
		<TELL-IN-MEETING>
		<RTRUE>)
	       (<AND <VERB? UNTIE>
		     ,WEASEL-APPREHENDED
		     <EQUAL? ,HERE ,MM-LOUNGE ,NW-LOUNGE>>
		<JIGS-UP
"The Weasel, quite panic-stricken, doesn't stop to thank you before he
pulls a small knife from his ankle and kills you.">)
	       (<VERB? SEARCH>
		<COND (,WEASEL-APPREHENDED
		       <COND (<IN? ,PASSBOOK ,WEASEL>
			      <MOVE ,PASSBOOK ,PLAYER>
			      <TELL "You take back your passbook." CR>)
			     (T <TELL
"Despite his writhing, you search him fruitlessly." CR>)>)
		      (,WEASEL-PISSED
		       <JIGS-UP 
"The Weasel glares at you and says, \"I don't take this from no one!\" He
pulls out his knife, touches its too-sharp point with a finger, then introduces
it to your chest.">)
		      (T
		       <SETG WEASEL-PISSED T>
		       <TELL 
"The Weasel shrinks back and says, \"Hey, don't you trust me? I don't gotta
take this from you!\"" CR>)>
		<RTRUE>)
	       (,WEASEL-APPREHENDED
		<COND (<VERB? EXAMINE>
		       <TELL-TIED>)
		      (<AND <VERB? ASK-ABOUT TELL>
			    <PRSI? ,WEASEL>
			    <NOT <PRSO? ,WEASEL>>>
		       <RFALSE>)
		      (<NOT <IN? ,WEASEL ,HERE>>
		       <RFALSE>)
		      (<VERB? FIND>
		       <RFALSE>)
		      (T <TELL "The Weasel just glares at you.">)>
		<CRLF>
		<COND (<AND <VERB? TELL ASK-ABOUT>
			    <PRSO? ,WEASEL>>
		       <SETG QCONTEXT ,WEASEL>
		       <SETG QCONTEXT-ROOM ,HERE>)>
		<RFATAL>)
	       (<VERB? HELLO>
	        <SETG QCONTEXT ,WEASEL>
		<SETG QCONTEXT-ROOM ,HERE>
		<TELL "\"Yeah. Hi.\"" CR>
		<RTRUE>)
	       (<VERB? GOODBYE>
		<SETG QCONTEXT ,WEASEL>
		<SETG QCONTEXT-ROOM ,HERE>
		<TELL "\"Yeah. Bye.\"" CR>
		<RTRUE>)
	       (<OR <AND <VERB? ASK-FOR>
		     	 <PRSO? ,WEASEL>>
		    <AND <VERB? TAKE>
			 <PRSI? ,WEASEL>>>
		<COND (<EQUAL? ,KNIFE ,PRSI ,PRSO>
		       <RFALSE>)
		      (T
		       <TELL "\"If I got it, I ain't gonna give it to ya.\"" CR>)>
		<RTRUE>)
	       (<VERB? BUY>
		<COND (<PRSO? ,FERRY-TOKEN>
		       <TELL "\"I might need it. Try the bank.\"" CR>
		       <RTRUE>)>)>
	 <COND (<AND <VERB? $CALL> <==? ,WINNER ,PLAYER>> <RFALSE>)
	       (<NOT <GRAB-ATTENTION ,WEASEL>> <RTRUE>)>
	 <COND (<AND <VERB? GIVE>
		     <OR <PRSO? ,ENVELOPE>
			 <PRSO? ,ID-CARD>>>
		<PERFORM ,V?SHOW ,PRSO ,WEASEL>
		<RTRUE>)
	       (<AND <VERB? SHOW>
		     <PRSI? ,WEASEL>>
		<COND (<AND <IN? ,ID-CARD ,ENVELOPE>
			    <OR <PRSO? ,ENVELOPE>
			        <PRSO? ,ID-CARD>>>
		       <MOVE ,ENVELOPE ,WEASEL>
		       <TELL
"The Weasel takes the " D ,ENVELOPE ". \"Thanks. I was wonderin' what
happened to my card.\"" CR>
		       <RTRUE>)
		      (<PRSO? ,ENVELOPE>
		       <TELL
"The Weasel shoves it back at you. \"I dunno nothin' about this. Could be old.\"" CR>
		       <RTRUE>)
		      (<PRSO? ,ID-CARD>
		       <MOVE ,ID-CARD ,WEASEL>
		       <TELL
"The Weasel takes the card. \"Thanks. I'd be in trouble without this.\"" CR>
		       <RTRUE>)>)
	       (<AND <VERB? ASK-ABOUT>
		     <PRSO? ,WEASEL>>
		<COND (<TRAITOR-TIME?>
		       <TELL-IN-MEETING>
		       <RFATAL>)
		      ;(<PRSI? ,GLOBAL-MEETING>
		       <COND (<IN? ,MCGINTY ,HERE>
			      <MCGINTY-WILL-FOLLOW>
			      <TELL
"The Weasel glances at " D ,MCGINTY ", gives you a dirty look, and says, ">
			      <TELL-WHAT-MEETING?>
			      <RTRUE>)
			     (<WEASEL-SHUFFLE>)>
		       <COND (<==? ,MEETINGS-COMPLETED 0>
			      <COND (<IN? ,PASSBOOK ,WEASEL>
				     <TELL-WHAT-MEETING?>)
				    (<L? ,PRESENT-TIME 525>
				     <COND (<EQUAL? ,HERE ,SHANTY>
					    <TELL
"\"That's what we're here for.\"" CR>)
					   (T <TELL
"\"Yeah. " D ,JOHNNY " thinks he's found a big score and needs our help.\""
CR>)>)
				    (<QUEUED? I-FIRST-MEETING>
				     <TELL "\"When you sit down...\"" CR>)
				    (T <TELL-MEETING-OFF>)>)
			     (<==? ,MEETINGS-COMPLETED 1>
			      <COND (<L? ,PRESENT-TIME 586>
				     <COND (<EQUAL? ,HERE ,WINDING-ROAD-1>
					    <TELL
"\"That's what we're here for.\"" CR>)
					   (T
					    <TELL "\"Weren't you listening">
					    <COND (<NOT <EQUAL? 
							 ,HERE
							 <META-LOC ,SHANTY>>>
						   <TELL " in " D ,SHANTY>)>
					    <TELL
"? We're " D ,GLOBAL-MEETING " at the " D ,LIGHTHOUSE " at 9:30.\"" CR>)>)
				    (T <TELL-MEETING-OFF>)>)
			     (T
			      <TELL "\"We don't meet again.">
			      <COND (<L? ,PRESENT-TIME 870>
				     <TELL " I'll see ya when we cast off.">)>
			      <TELL "\"" CR>)>)
		      (<PRSI? ,GLOBAL-TREASURE>
		       <COND (<IN? ,MCGINTY ,HERE>
			      <MCGINTY-WILL-FOLLOW>
			      <TELL
"The Weasel glances at " D ,MCGINTY " and says, \"What " D ,GLOBAL-TREASURE
"?\"" CR>)
			     (<L? ,FM-CTR 3>
			      <TELL
"\"That could be what Johnny wants to talk about.\"" CR>)
			     (T <TELL
"\"I guess that's what we're lookin' for.\"" CR>)>)
		      ;(<AND <PRSI? ,LEFT-BUTTON ,RIGHT-BUTTON ,DECK-CHAIR>
			    <G? <GETP ,HERE ,P?LINE> ,BACK-ALLEY-LINE-C>>
		       <TELL-BUTTON-EXPLAIN>)
		      (<PRSI? ,KNIFE>
		       <TELL "\"Yeah. That's my knife.\"" CR>)
		      (<PRSI? ,HEVLIN>
		       <TELL-NEVER-KNEW>)
		      (<PRSI? ,PETES-PATCH>
		       <TELL "\"Pete's worn it as long as I've known him.\"" CR>)
		      (<PRSI? ,SALVAGER ,TRAWLER>
		       <TELL "\"It's a decent boat.\"" CR>)
		      (<PRSI? ,SPEAR-CARRIER>
		       <TELL "\"I guess he's okay.\"" CR>)
		      (<PRSI? ,JOHNNY>
		       <TELL "\"Yeah. Red's okay.\"" CR>)
		      (<PRSI? ,ME>
		       <TELL-YOURE-DIVER>)
		      (<PRSI? ,PETE>
		       <TELL
"\"Pete's a good guy. Just don't eat his chow.\"" CR>)
		      (<PRSI? ,MCGINTY>
		       <WEASEL-SHUFFLE>
		       <TELL
"\"He's all right. I work with him now and then.\"" CR>)
		      (<PRSI? ,WEASEL>
		       <TELL-KNOW-ME>)
		      (<PRSI? ,PARROT>
		       <TELL "\"She is one strange bird.\"" CR>)
		      (<PRSI? ,FERRY ,GLOBAL-FERRY>
		       <WEASEL-SHUFFLE>;"?"
		       <TELL "\"I use it to go home on the mainland.\"" CR>)
		      (<PRSI? ,LINE-HACK>
		       <TELL ,LINE-STR CR>)
		      (T <RFALSE>)>
		<RTRUE>)>
	 <COND (<EQUAL? ,WINNER ,WEASEL>
		<COND (<PRSO? ,GLOBAL-SELF>
		       <SETG PRSO ,WEASEL>)>
		<COND (<PRSI? ,GLOBAL-SELF>
		       <SETG PRSI ,WEASEL>)>
		<COND (<AND <VERB? TELL>
			    <PRSO? ,ME>>
		       <RFALSE>)
		      (<VERB? $CALL>
		       <TELL-SO-WHAT>)
		      (<AND <VERB? SHOW>
			    <IN? ,PRSO ,WEASEL>
			    <NOT <PRSO? ,ENVELOPE ,PASSBOOK>>
			    <PRSI? ,ME>>
		       <SETG WINNER ,PLAYER>
		       <PERFORM ,V?EXAMINE ,PRSO>
		       <SETG WINNER ,WEASEL>)
		      (<AND <==? ,FM-CTR 2>
			    <VERB? SIT SIT-ON>>
		       <TELL "\"Wait a second.\"" CR>)
		      (<VERB? YES NO MAYBE LATITUDE LONGITUDE WHAT FIND SSHOW
			      ALARM>
		       <RFALSE>)
		      (T
		       <TELL "\"I don't wanna do that.\"" CR>
		       <RFATAL>)>)>>

<ROUTINE WEASEL-SHUFFLE ()
	 <COND (<AND <G? ,PRESENT-TIME 840>
		     <NOT <IN? ,ENVELOPE ,LOCAL-GLOBALS>>>
		<TELL "The Weasel's eyes dart as he shuffles his feet. ">)>>

<ROUTINE TELL-TIED ()
	 <TELL "The Weasel is tied up and squirming.">>

<ROUTINE I-WEASEL ("OPTIONAL" (GARG <>) "AUX" (L <LOC ,WEASEL>)(VAL <>) GT)
	 <COND (<NOT .GARG>
		<COND (<AND <G? ,FM-CTR 1>
			    <L? ,FM-CTR 5>>
		       <ENABLE <QUEUE I-JOHNNY 1>>
		       <RFALSE>)> ;"So he doesn't leave during 1st meeting"
		<IMOVEMENT ,WEASEL I-WEASEL>)
	       (<==? .GARG ,G-REACHED>
		<COND (<AND <EQUAL? .L <META-LOC ,PLAYER>>
			    <IN? ,ENVELOPE ,PLAYER>
		       	    <WEASEL-BEATS-YOU>>
		       <RTRUE>)
		      (<AND <==? .L ,BANK>
			    <IN? ,PASSBOOK ,WEASEL>>
		       <SETG PASSBOOK-BALANCE 0>
		       <SETG STUPID-PROBLEM-STRING "September 19">)
		      ;(<AND <EQUAL? .L ,MM-AFT-DECK ,NW-AFT-DECK>
			    <IN? ,PLAYER .L>
			    <NOT <QUEUED? I-PENDULUM>>>
		       <ENABLE <QUEUE I-PENDULUM -1>>
		       <TELL-WEASEL-TOSSES>
		       <SET VAL T>)
		      (<==? .L ,UPSTAIRS-HALLWAY>
		       <COND (<AND <IN? ,PASSBOOK ,UPSTAIRS-HALLWAY>
				   <G? ,PASSBOOK-BALANCE 99>
				   <NOT <IN? ,PLAYER ,UPSTAIRS-HALLWAY>>>
			      <MOVE ,PASSBOOK ,WEASEL>
			      <PUT ,MOVEMENT-GOALS ,WEASEL-C
				   ,WEASEL-RETIRES-TABLE>
			      <IMOVEMENT ,WEASEL I-WEASEL>)
			     (<==? <META-LOC ,PLAYER> ,BEDROOM>
			      <COND (<FSET? ,BEDROOM-DOOR ,OPENBIT>
				     <MOVE ,WEASEL ,BEDROOM>
				     <COND (<G? ,PRESENT-TIME 540>
					    <TELL
"The Weasel comes in, and fear flashes across his face. \"Don't forget to
meet Johnny later,\" he says." CR>)
					   (T <TELL 
"You hear something at the door and ">
					    <COND (<OR <NOT <VERB? OPEN>>
						   <NOT <PRSO? ,BEDROOM-DOOR>>>
						   <TELL "turn to ">)>
					    <TELL
"see " D ,WEASEL " walk in. Fear flashes across his face, but only for an
instant. He says, \"Oh, hi. I was just wonderin' if you was comin' to
the meeting. Looks like we found the real thing this
time.\"" CR>)>
				     <ESTABLISH-GOAL ,WEASEL ,SHANTY>)
				    (T
				     <ENABLE <QUEUE I-WEASEL-TO-BEDROOM 2>>
				     <TELL "You hear a knock at the door." CR>
				     <SETG P-IT-OBJECT ,BEDROOM-DOOR>)>
			      <SET VAL ,M-FATAL>)
			     (<==? ,HERE ,UPSTAIRS-HALLWAY>
			      <TELL
"The Weasel gets to the top of the stairs, sees you,">
			      <TELL-WEASEL-EXCUSE>
			     ;<COND (<NOT ,BEDROOM-MESSAGE>
				     <TELL
"The Weasel gets to the top of the stairs, sees you,">
				     <TELL-WEASEL-EXCUSE>)
				    (T <TELL 
"The Weasel enters the hallway from your room. His hands are jammed deep
into his pockets as he looks at the floor." CR>)>
			      <SET VAL ,M-FATAL>)
			     (T
			      ;<COND (,DEBUG
			    <TELL "[The Weasel has arrived at " D .L ".]" CR>)>
			      <COND (<FSET? ,BEDROOM-DOOR ,OPENBIT>
				     <WEASEL-ALONE-IN-BEDROOM>)
				    (T <ENABLE <QUEUE I-WEASEL-TO-BEDROOM 2>>)>)>)
		      (<==? .L ,HERE>
		       <COND ;(<==? ,SEARCHER ,WEASEL>
		       	      <SETG SEARCHER <>>
		       	      <COND (<==? ,SHIP-CHOSEN ,SALVAGER>
			      	     <ESTABLISH-GOAL ,WEASEL ,MM-ENGINE-ROOM>)
			     	    (T <ESTABLISH-GOAL ,WEASEL ,NW-ENGINE-ROOM>)>
			      <COND (<IN? ,DECK-CHAIR .L>
				     <SET-NEXT-WATCH>
				     <TELL
"The Weasel appears beside you. \"Glad you got up here. You were late.\"" CR>)
				    (T
				     <TELL
"The Weasel stalks in, looking angry. \"You better get topside and stand your
watch. Now.\"" CR>)>)
			     (T
		       	      <TELL
"The Weasel approaches, glancing around furtively." CR>
			      ;<COND (<AND <EQUAL? .L ,MM-CREW-QTRS
						     ,NW-CREW-QTRS>
					  ,AT-SEA>
				     <TELL
"The Weasel comes in and climbs into a bunk for some sleep." CR>)
				    (T <TELL
"The Weasel approaches, glancing around furtively." CR>)>
		              <SET VAL ,M-FATAL>)>)
		      ;(,DEBUG
		       <TELL "[The Weasel has arrived at " D .L ".]" CR>)>
		<WEASEL-CHECK ,ENVELOPE .L>
		<WEASEL-CHECK ,ID-CARD .L>
		<RETURN .VAL>)
	       (<EQUAL? .GARG ,G-ENROUTE>
		<COND (<AND <==? ,HERE ,UPSTAIRS-HALLWAY>
			    ,BEDROOM-MESSAGE>
		       <SETG BEDROOM-DOOR-LOCKED <>>)>
	        <COND (<AND <IN? ,PASSBOOK .L>
			    <G? ,PASSBOOK-BALANCE 99>
			    <NOT <IN? ,WEASEL <META-LOC ,PLAYER>>>>
		       <MOVE ,PASSBOOK ,WEASEL>
		       <SET GT <GET ,GOAL-TABLES ,WEASEL-C>>
		       <COND (<==? <GET .GT ,GOAL-F> ,FERRY-LANDING>
			      <ESTABLISH-GOAL ,WEASEL ,BACK-ALLEY-5>)>
		       <COND (<L? <GETP .L ,P?LINE> ,TRAWLER-LINE-C>
			      <PUT ,MOVEMENT-GOALS ,WEASEL-C
				   ,WEASEL-RETIRES-TABLE>
		       	      <IMOVEMENT ,WEASEL I-WEASEL>)>)>
	        <COND (<AND <IN? ,ENVELOPE ,PLAYER>
			    <EQUAL? .L <META-LOC ,PLAYER>>
		       	    <WEASEL-BEATS-YOU>>
		       <RTRUE>)
		      (T <WEASEL-CHECK ,ENVELOPE .L>)>
	        <WEASEL-CHECK ,ID-CARD .L>)>>

<ROUTINE TELL-WEASEL-PICKUP (STR)
	 <TELL "The Weasel picks up " .STR "." CR>>

<ROUTINE TELL-WEASEL-EXCUSE ()
	 <ESTABLISH-GOAL ,WEASEL ,SHANTY>
	 <TELL " and says, ">
	 <COND (<G? ,PRESENT-TIME 540>
		<TELL
"\"Umm, well, better not forget to meet with Johnny.\"" CR>)
	       (T <TELL
"\"Oh. I was just checkin' to see if you're goin' to the meeting at "
D ,SHANTY ".\" He looks slightly disappointed." CR>)>>

;<ROUTINE ENVELOPE-CHECK (L)
	 <COND (<OR <AND <NOT <IN? ,ENVELOPE ,UNDER-BUNK>>
			 <==? <META-LOC ,ENVELOPE> .L>
			 <NOT <FSET? <LOC ,ENVELOPE> ,PERSON>>>
		    <REALLY-HERE? ,ENVELOPE .L>>
		<MOVE ,ENVELOPE ,WEASEL>
		<COND (<EQUAL? .L <META-LOC ,PLAYER>>
		       <TELL-WEASEL-PICKUP "the envelope">)>)>>

<ROUTINE WEASEL-CHECK (OBJ L)
	 <COND (<OR <AND <NOT <EQUAL? <LOC .OBJ> ,ENVELOPE ,UNDER-BUNK>>
			 <==? <META-LOC .OBJ> .L>
			 <NOT <FSET? <LOC .OBJ> ,PERSON>>>
		    <REALLY-HERE? .OBJ .L>>
	        <MOVE .OBJ ,WEASEL>
		<COND (<EQUAL? .L <META-LOC ,PLAYER>>
		       <COND (<==? .L ,ID-CARD>
			      <TELL-WEASEL-PICKUP "his card">)
			     (T <TELL-WEASEL-PICKUP "the envelope">)>)>)>>

<ROUTINE REALLY-HERE? (OBJ L "AUX" (CTR 0))
	 <REPEAT ()
		 <COND (<G? .CTR 44> <RETURN>)
		       (<AND <==? <GET ,SHARED-OBJECT-TABLE .CTR> .OBJ>
			     <==? <GET ,SHARED-OBJECT-TABLE <+ .CTR 1>> .L>
			     <NOT <==? <GET ,SHARED-OBJECT-TABLE <+ .CTR 2>>
				       ,UNDER-BUNK>>>
			<PUT ,SHARED-OBJECT-TABLE .CTR 0>
			<PUT ,SHARED-OBJECT-TABLE <+ .CTR 1> 0>
			<PUT ,SHARED-OBJECT-TABLE <+ .CTR 2> 0>
			<RTRUE>)>
		 <SET CTR <+ .CTR 3>>>
	 <RFALSE>>

<ROUTINE I-WEASEL-TO-BEDROOM ()
	 <COND (,BEDROOM-DOOR-LOCKED
		<ESTABLISH-GOAL ,WEASEL ,SHANTY>
		<RFALSE>)
	       (T
		<COND (<==? <META-LOC ,PLAYER> ,BEDROOM>
		       <MOVE ,WEASEL ,BEDROOM>
		       <TELL
"The door opens and " D ,WEASEL " walks in. He sees you and says, \"Oh. Hi.
I just wanted to make sure you ">
		       <COND (<G? ,PRESENT-TIME 540>
			      <TELL "remembered to meet Johnny later.\"">)
			      (T
			       <TELL
"knew about the meetin' at " D ,SHANTY ".">
		       	       <COND (<FSET? ,NOTE ,TOUCHBIT>
			      	      <TELL " You got Johnny's note, right?\"">)
			     	     (T <TELL 
"\" He points to the note on the floor. \"You better read this note.\"">)>)>
		       <CRLF>
		       <ESTABLISH-GOAL ,WEASEL ,SHANTY>)
		      (T <WEASEL-ALONE-IN-BEDROOM> <RFALSE>)>)>>

<ROUTINE WEASEL-ALONE-IN-BEDROOM ("AUX" WGT)
	 <SET WGT <GET ,GOAL-TABLES ,WEASEL-C>>
	 <MOVE ,WEASEL ,BEDROOM>
	 <PUT .WGT ,ATTENTION 5>
	 <FSET ,BUREAU ,OPENBIT>
	 <COND (<AND <EQUAL? <META-LOC ,PASSBOOK> ,BEDROOM>
		     <G? ,PASSBOOK-BALANCE 99>>
	        <MOVE ,PASSBOOK ,WEASEL>
	        <PUT ,MOVEMENT-GOALS ,WEASEL-C ,WEASEL-RETIRES-TABLE>
		<IMOVEMENT ,WEASEL I-WEASEL>)
	       (T <ESTABLISH-GOAL ,WEASEL ,SHANTY>)>
	 <PUT .WGT ,GOAL-ENABLE <>>
	 <SETG BEDROOM-MESSAGE
"You can't help notice that your dresser has been opened and the contents
messed up.">>

<ROUTINE WEASEL-BEATS-YOU ()
	 <COND (,WEASEL-APPREHENDED
		<RFALSE>)
	       (T
		<TELL-COMES-UP ,WEASEL>
		<JIGS-UP
"\"That's one of McGinty's envelopes!
Traitor!\" Before you can respond, the Weasel's knife has violated the
sanctity of your body.">)>>

<OBJECT KNIFE
	(IN WEASEL)
	(DESC "Weasel's knife")
	(SYNONYM KNIFE BLADE)
	(ADJECTIVE OLD WEASEL USED WELL-W SHARP)
	(FLAGS TRYTAKEBIT NDESCBIT WEAPONBIT)
	(ACTION KNIFE-F)>

<ROUTINE KNIFE-F ()
	 <COND (<OR <VERB? TAKE>
		    <AND <VERB? ASK-FOR>
			 <PRSO? ,WEASEL>>>
		<COND (<IN? ,KNIFE ,WEASEL>
		       <TELL 
"The Weasel pulls it away. \"Don't mess with my
knife,\" he warns, \"or I'll give it to ya in a way ya won't much like.\"" CR>)>)
	       (<VERB? EXAMINE>
		<TELL "This knife ">
		<COND (<IN? ,KNIFE ,WEASEL>
		       <TELL "is">)
		      (T <TELL "was">)>
		<TELL
" " D ,WEASEL "'s, and it's razor sharp." CR>)>>

<OBJECT ID-CARD
	(IN LOCAL-GLOBALS)
	(DESC "Merchant Seaman's card")
	(SYNONYM CARD)
	(ADJECTIVE MERCHA SEAMAN ID WEASEL)
	(FLAGS READBIT TAKEBIT)
	(TEXT "The card says:|
   \"Frank Webster|
   Seaman First Class|
   No. 2626868\"")
	(SIZE 2)>

<OBJECT WATCH
	(IN ADVENTURER)
	(DESC "wrist watch")
	(SYNONYM WATCH WRISTW TIMEPI)
	(ADJECTIVE WRIST)
	(FLAGS WEARBIT WORNBIT TAKEBIT TURNBIT)
	(ACTION WATCH-F)>

<ROUTINE WATCH-F ()
	 <COND (<VERB? READ EXAMINE>
		<TELL 
"Your trusty old wind-up diver's watch is waterproof to 350 fathoms. It
currently shows ">
		<WATCH-TIME>
		<TELL " a.m. (The AM/PM indicator never did work.)">
		<COND (<NOT ,WATCH-WOUND>
		       <TELL " The sweep hand isn't moving on it.">)>
		<CRLF>)
	       (<VERB? LISTEN>
		<COND (,WATCH-WOUND
		       <TELL "It's ticking." CR>)
		      (T <TELL 
"The " D ,WATCH " makes no sound. And it's not battery-operated." CR>)>)
	       (<AND <VERB? WIND>
		     <PRSO? ,WATCH>>
		<SETG WATCH-WOUND T>
		<ENABLE <QUEUE I-UNWOUND 1500>>
		<TELL "Okay. You've wound the watch." CR>)
	       (<VERB? SHAKE>
		<TELL
"Shaken. It's not self-winding, but it is shock-proof." CR>)
	       (<VERB? TURN>
		<COND (<NOT ,PRSI>
		       <TELL 
"If you want to set the watch, specify the time to which you want it set." CR>)
		      (<PRSI? ,INTNUM>
		       <COND (<OR <G? ,SET-HR 23>
			          <G? ,SET-MIN 59>>
		              <TELL 
"Try setting it to a more reasonable time." CR>
		              <RTRUE>)
		             (<G? ,SET-HR 11>
		              <SETG SET-HR <- ,SET-HR 12>>)>
		       <SETG WATCH-SCORE ,SET-HR>
		       <SETG WATCH-MOVES ,SET-MIN>
		       <SETG SET-MIN 60>
		       <TELL-NOW ,WATCH "set to " <>>
		       <WATCH-TIME>
		       <TELL "." CR>
		       <RTRUE>)>)>>

<ROUTINE WATCH-TIME ("AUX" HR)
	 <COND (<0? ,WATCH-SCORE>
		<SET HR 12>)
	       (T <SET HR ,WATCH-SCORE>)>
	 <TELL N .HR ":">
	 <COND (<L? ,WATCH-MOVES 10>
		<TELL "0">)>
	 <TELL N ,WATCH-MOVES>>

<OBJECT DELIVERY-BOY
	(IN LOCAL-GLOBALS)
	(SYNONYM BOY KID)
	(ADJECTIVE DELIVE)
	(DESC "Outfitters' delivery boy")
	(DESCFCN DELIVERY-BOY-F)
	(FLAGS VICBIT VOWELBIT)
	(CHARACTER 5)
	(ACTION DELIVERY-BOY-F)>

<ROUTINE DELIVERY-BOY-F ("OPTIONAL" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-OBJDESC>
		<COND (<IN-MOTION? ,DELIVERY-BOY> <RTRUE>)
		      (T <TELL
"The " D ,DELIVERY-BOY " is here." CR>)>)
	       (<VERB? EXAMINE>
		<TELL
"The " D ,DELIVERY-BOY " is young. He's pushing a cart which is ">
		<COND (,DELIVERY-MADE
		       <TELL "currently empty">)
		      (T <TELL "loaded with stuff">)>
		<TELL "." CR>)
	       (<OR <EQUAL? ,DELIVERY-BOY ,WINNER>
		    <VERB? HELLO GOODBYE>
		    <AND <VERB? TELL> <PRSO? ,DELIVERY-BOY>>>
		<SETG QCONTEXT ,DELIVERY-BOY>
		<SETG QCONTEXT-ROOM ,HERE>
		<TELL "\"I can't stop now. I'm working!\"" CR>
		<SETG P-CONT <>>
		<SETG QUOTE-FLAG <>>
		<RTRUE>)>>

<ROUTINE I-DELIVERY-BOY ("OPTIONAL" (GARG <>) "AUX" (L <LOC ,DELIVERY-BOY>)
			                            DMG OBJ DEST)
	 <COND (<NOT .GARG>
		<SET DMG <GET ,MOVEMENT-GOALS ,DELIVERY-BOY-C>>
		<COND (<L? ,PRESENT-TIME 485> T)
		      (<OR <NOT <0? ,AMT-OWED>>
			   <NOT ,JOHNNY-MADE-DEAL>>
		       <RFALSE>)
		      (<EQUAL? <GET .DMG ,MG-ROOM> ,MM-LOCKER>
		       <MOVE ,DELIVERY-BOY ,OUTFITTERS-HQ>
		       <COND (<EQUAL? ,SHIP-CHOSEN ,TRAWLER>
		       	      <PUT .DMG ,MG-ROOM ,NW-LOCKER>)>)>
		<IMOVEMENT ,DELIVERY-BOY I-DELIVERY-BOY>)
	       (<==? .GARG ,G-REACHED>
		<COND (<==? .L ,OUTFITTERS-HQ>
		       <MOVE ,DELIVERY-BOY ,LOCAL-GLOBALS>)>
		<COND (<EQUAL? .L ,MM-LOCKER ,NW-LOCKER>
		       <REPEAT ()
			<SETG DT-PTR <- ,DT-PTR 2>>
			<COND (<L? ,DT-PTR 0> <RETURN>)>
			<MOVE <SET OBJ <GET ,DELIVERY-TABLE ,DT-PTR>> .L>
			<COND (<NOT <==? .OBJ ,COMPRESSOR>>
			       <FSET .OBJ ,TAKEBIT>)>
			<FCLEAR .OBJ ,TRYTAKEBIT>
			<FCLEAR .OBJ ,NDESCBIT>>
		       <SETG DELIVERY-MADE T>
		       <ESTABLISH-GOAL ,DELIVERY-BOY ,OUTFITTERS-HQ>
		       <COND (<==? .L ,HERE>
			      <TELL
"The " D ,DELIVERY-BOY" arrives with a cartful of stuff which he unloads." CR>
			      <RFATAL>)>)
		      (<==? .L ,HERE>
		       <TELL "The " D ,DELIVERY-BOY " walks in." CR>
		       <RFATAL>)
		      ;(,DEBUG
		       <TELL "[The delivery boy has arrived at " D .L ".]" CR>)>)
	       (<==? .GARG ,G-ENROUTE>
		<COND (<AND <EQUAL? .L ,MM-GALLEY ,NW-GALLEY>
			    <NOT ,WATER-DELIVERED>>
		       <SETG WATER-DELIVERED T>
		       <PUT
			<GET ,GOAL-TABLES ,DELIVERY-BOY-C> ,ATTENTION 2>
		       <COND (<==? <GETP .L ,P?LINE>
				   <GETP <META-LOC ,WINNER> ,P?LINE>>
			      <MOVE ,DRINKING-WATER .L>
		       	      <FSET ,DRINKING-WATER ,NDESCBIT>)>
		       <COND (<IN? ,PLAYER .L>
			      <TELL
"The delivery boy stops to drop off some stuff." CR>)>)>)>>

<GLOBAL DELIVERY-MADE <>>
<GLOBAL WATER-DELIVERED <>>

<OBJECT SPEAR-CARRIER
	(IN RED-BOAR-INN)
	(SYNONYM CLERK SALESM BARTEN TELLER)
	(ADJECTIVE ROOM DESK BANK)
	(SDESC "desk clerk")
	(LDESC "A desk clerk is sitting behind the counter.")
	(FLAGS VICBIT)
	(ACTION SPEAR-CARRIER-F)>

<ROUTINE SPEAR-CARRIER-F ("AUX" CHANGE COST)
	 <COND (<VERB? HELLO>
		<SETG QCONTEXT ,SPEAR-CARRIER>
		<SETG QCONTEXT-ROOM ,HERE>
		<TELL "\"Hi there! What can I do for you?\"" CR>
		<RTRUE>)
	       (<VERB? GOODBYE>
		<SETG QCONTEXT ,SPEAR-CARRIER>
		<SETG QCONTEXT-ROOM ,HERE>
		<TELL "\"So long. See you around.\"" CR>
		<RTRUE>)
	       (<VERB? ALARM>
		<RFALSE>)
	       (<OR <VERB? TIME>
		    <AND <VERB? WHAT>
			 <PRSO? ,GLOBAL-TIME>>>
		<PERFORM ,V?ASK-ABOUT ,SPEAR-CARRIER ,GLOBAL-TIME>
		<RTRUE>)
	       (<==? ,WINNER ,SPEAR-CARRIER>
		<COND (<PRSO? ,GLOBAL-SELF>
		       <SETG PRSO ,SPEAR-CARRIER>)>
	        <COND (<PRSI? ,GLOBAL-SELF>
		       <SETG PRSI ,SPEAR-CARRIER>)>
		<COND (<AND <VERB? FIND>
			    <PRSO? ,GLOBAL-BANK>>
		       <COND (<==? ,HERE ,BANK>
			      <TELL "\"This is the bank!\"" CR>)
			     (T
		       	      <SETG WINNER ,PLAYER>
		       	      <PERFORM ,V?ASK-ABOUT ,SPEAR-CARRIER ,GLOBAL-BANK>
		       	      <SETG WINNER ,SPEAR-CARRIER>)>
		       <RTRUE>)
		      (<VERB? $CALL>
		       <TELL-SO-WHAT>
		       <RTRUE>)
		      (<VERB? SGIVE SSHOW WHAT FIND YES NO MAYBE>
		       <RFALSE>)
		      (<AND <VERB? ASK-ABOUT ASK-FOR>
			    <PRSI? ,GLOBAL-TIME>>
		       <RFALSE>)
		      (<AND <VERB? GIVE>
			    <PRSI? ,ME>>
		       <SETG WINNER ,PLAYER>
		       <PERFORM ,V?ASK-FOR ,SPEAR-CARRIER ,PRSO>
		       <SETG WINNER ,SPEAR-CARRIER>
		       <RTRUE>)
		      (<AND <VERB? TELL>
			    <PRSO? ,ME>>
		       <COND (,PRSI
			      <SETG WINNER ,PLAYER>
		       	      <PERFORM ,V?ASK-ABOUT ,SPEAR-CARRIER ,PRSI>
		       	      <SETG WINNER ,SPEAR-CARRIER>
		       	      <RTRUE>)
			     (T <RFALSE>)>)
		      (<VERB? HELLO>
		       <TELL "\"Hi there! What can I do for you?\"" CR>
		       <RTRUE>)
	       	      (<VERB? GOODBYE>
		       <TELL "\"So long. See you around.\"" CR>
		       <RTRUE>)
		      (<AND <VERB? WITHDRAW>
			    <==? ,HERE ,BANK>>
		       <RFALSE>)
		      (<AND <VERB? SHOW>
			    <PRSI? ,ME>>
		       <TELL "\"Examine it " D ,GLOBAL-SELF ".\"" CR>
		       <RTRUE>)
		      (T
		       <TELL "\"I can't do that while I'm on the job.\"" CR>
		       <RTRUE>)>)
	       (<AND <VERB? TELL>
		     <NOT ,PRSI>>
		<RFALSE>)
	       (<AND <VERB? BUY>
		     <PRSO? ,FERRY-TOKEN>>
		<NO-TOKENS ,HERE>
		<RTRUE>)
	       (<VERB? SEARCH>
		<TELL-YOU-CANT "reach behind the " <>>
		<COND (<IN? ,BAR ,HERE>
		       <TELL D ,BAR>)
		      (<IN? ,WINDOW ,HERE>
		       <TELL D ,WINDOW>)
		      (T <TELL D ,GLOBAL-SURFACE>)>
		<TELL "." CR>
		<RTRUE>)
	       (<AND <VERB? ASK-ABOUT>
		     <PRSO? ,SPEAR-CARRIER>>
		<SETG QCONTEXT ,SPEAR-CARRIER>
		<SETG QCONTEXT-ROOM ,HERE>
		<COND (<PRSI? ,SPEAR-CARRIER>
		       <TELL 
"\"Just another of the people who keep this island running.\"" CR>
		       <RTRUE>)
		      (<PRSI? ,ME>
		       <TELL-YOURE-DIVER>
		       <RTRUE>)
		      (<FSET? ,PRSI ,PERSON>
		       <TELL "\"You know " D ,PRSI ".\"" CR>
		       <RTRUE>)
		      (<PRSI? ,GLOBAL-BANK>
		       <COND (<EQUAL? ,HERE ,BANK>
			      <TELL 
"\"It's the " D ,BANK ", a savings bank which has served Hardscrabble
Island for over forty years.\"" CR>)
			     (T <TELL 
"\"It's at the eastern end of the " D ,SHORE-ROAD-1 ".\"" CR>)>
		       <RTRUE>)
		      (<PRSI? ,GLOBAL-MONEY>
		       <TELL
"\"That's what makes the world go around. Right?\"" CR>
		       <RTRUE>)
		      (<PRSI? ,RIDICULOUS-MONEY-KLUDGE>
		       <TELL 
"He smiles. \"Money is our most important product.\"" CR>
		       <RTRUE>)
		      (<PRSI? ,PARROT>
		       <COND (<EQUAL? ,HERE ,SHANTY>
			      <TELL
"\"Isn't it great? I bought it from a passing sailor some years back. I never
did figure out why it has a wooden leg and an eyepatch.\"" CR>)
			     (T <TELL
"\"The one in " D ,SHANTY "? I can't imagine the island without it!\"" CR>)>
		       <RTRUE>)
		      (<==? ,HERE ,RED-BOAR-INN>
		       <COND (<PRSI? ,HEVLIN>
			      <TELL
"\"He came in here last night looking for you.\"" CR>
			      <RTRUE>)>)
		      (<EQUAL? ,HERE ,OUTFITTERS-HQ>
		       <COND (<PRSI? ,DELIVERY-BOY>
		       	      <TELL "\"">
			      <COND (<NOT <IN-MOTION? ,DELIVERY-BOY>>
				     <TELL
"He's probably in the back room setting up the next delivery. ">)>
			      <TELL "He's very conscientious, you know.\"" CR>
		       	      <RTRUE>)
		             (<PRSI? ,PRICE-LIST>
			      <TELL "\"It's up to date.\"" CR>
			      <RTRUE>)
			     (<PRSI? ,TRAWLER ,SALVAGER>
			      <TELL
"\"She's a great boat. You can read all about her in the " D ,PRICE-LIST ".\""
CR>
			      <RTRUE>)
			     (<AND <GETP ,PRSI ,P?NORTH>
				   <NOT <IN? ,PRSI ,ROOMS>>
				   <NOT <PRSI? ,FOOD ,DRINK-OBJECT>>>
			      <TELL "\"It's a great " D ,PRSI ".\"" CR>
			      <RTRUE>)>)>)>
	 <COND ;(<EQUAL? ,WINNER ,SPEAR-CARRIER>)
	       (<VERB? WALK>
		<TELL "He indicates that he'd rather stay where he is." CR>
		<RTRUE>)
	       (<AND <EQUAL? ,HERE ,BANK>
		     <PRSI? ,SPEAR-CARRIER>>
		<COND (<VERB? GIVE>
		       <TELL "The teller examines the ">
		       <COND (<PRSO? ,PASSBOOK>
			      <TELL "passbook, says">
			      <TELL-OUR-PASSBOOK>
			      <TELL
" If you want to withdraw some money, say so,\" and hands it back to you." CR>
		       	      <RTRUE>)
		      	     (T <TELL 
D ,PRSO ", thinks for a moment, and then hands it
back to you, pointing out that you have no safe deposit box." CR>
		       		<RTRUE>)>)
		      (<AND <VERB? SHOW>
			    <PRSO? ,PASSBOOK>>
		       <TELL "The teller says,">
		       <TELL-OUR-PASSBOOK>
		       <TELL "\"" CR>
		       <RTRUE>)>)
	       (<EQUAL? ,HERE ,RED-BOAR-INN>
		<COND (<VERB? ASK-FOR>
		       <COND (<PRSI? ,GLOBAL-ROOM>
		       	      <TELL
"\"We're full. Your current room will have to do.\"" CR>)
			     (<PRSI? ,PSEUDO-OBJECT>
			      <TELL "\"Nope. No messages.\"" CR>)>)
		      (<AND <VERB? GIVE>
			    <PRSO? ,KEY>>
		       <TELL
"The desk clerk hands you back the key. \"You've paid for another week.\"" CR>)>)
	       (<EQUAL? ,HERE ,BANK>
		<COND (<AND <VERB? ASK-FOR>
			    <PRSI? ,RIDICULOUS-MONEY-KLUDGE ,INTNUM>>
		       <COND (<G? ,PASSBOOK-BALANCE 0>
			      <TELL 
"\"If you want to make a withdrawal, be specific.\"" CR>
			      <RTRUE>)
			     (T <TELL 
"\"I'm afraid that the loan officer is out today.\"" CR>
			      <RTRUE>)>)>)
	       (<AND <EQUAL? ,HERE ,OUTFITTERS-HQ>
		     <VERB? ASK-FOR>
		     <PRSO? ,SPEAR-CARRIER>>
		<COND (<G? <SET COST <GETP ,PRSO ,P?NORTH>> 0>
		       <TELL "\"You want it, you buy it.\"" CR>
		       <RTRUE>)
		      (<L? .COST 0>
		       <TELL-YOU-ALREADY "bought it.\"" T>
		       <RTRUE>)>)
	       (<AND <EQUAL? ,HERE ,OUTFITTERS-HQ>
		     <PRSI? ,SPEAR-CARRIER>>
		<COND (<VERB? GIVE>
		       <COND (<AND <PRSO? ,INTNUM> ,P-DOLLAR-FLAG>
			      <COND (<OR <FSET? ,WET-SUIT ,WORNBIT>
					 <FSET? ,DEEP-SUIT ,WORNBIT>>
				     <TELL-YOU-CANT "get at your money.">
				     <RTRUE>)
				    (<G? ,P-AMOUNT ,POCKET-CHANGE>
				     <TELL "You haven't got that much." CR>
				     <RTRUE>)
				    (,AMT-OWED
				     <COND (<L? ,P-AMOUNT ,AMT-OWED>
					    <SETG AMT-OWED
						  <- ,AMT-OWED ,P-AMOUNT>>
					    <SETG POCKET-CHANGE
						  <- ,POCKET-CHANGE ,P-AMOUNT>>
					    <TELL
"The salesman takes the money and says, \"You still owe me $" N ,AMT-OWED ".\""
CR>)
					   (T
					    <COND (<G? ,P-AMOUNT ,AMT-OWED>
						   <SET CHANGE
						       <- ,P-AMOUNT ,AMT-OWED>>
					    	   <TELL
"The salesman takes the money, counts it, and hands you back $" N .CHANGE ". ">)>
					    <SETG POCKET-CHANGE
						  <- ,POCKET-CHANGE ,AMT-OWED>>
					    <SETG AMT-OWED 0>
					    <TELL
"\"Thank you very much. Let me know what else you want.\"" CR>)>)
				    (T <TELL
"The salesman hands it back to you. \"If you want to buy anything, please be
specific.\"" CR>)>)
			     (<PRSO? ,GLOBAL-MONEY>
			      <SETG P-AMOUNT ,AMT-OWED>
			      <SETG P-DOLLAR-FLAG T>
			      <PERFORM ,V?GIVE ,INTNUM ,PRSI>
			      <SETG P-IT-OBJECT ,GLOBAL-MONEY>
			      <RTRUE>)
			     (T
		       	      <TELL "The salesman looks at ">
		       	      <THE? ,PRSO>
		       	      <TELL D ,PRSO ", then returns it." CR>)>
		       <RTRUE>)>)
	       (<EQUAL? ,SHANTY ,HERE>
		<COND (<OR <AND <VERB? ASK-FOR>
		            	<PRSI? ,DRINKING-WATER>>
			   <AND <VERB? BUY>
				<PRSO? ,DRINKING-WATER>>>
		       <COND (<IN? ,DRINKING-WATER ,TABLE-OBJECT>
			      <TELL "\"One glass to a customer.\"" CR>)
			     (T
			      <MOVE ,DRINKING-WATER ,TABLE-OBJECT>
			      <FCLEAR ,DRINKING-WATER ,NDESCBIT>
			      <PUTP ,DRINKING-WATER ,P?SDESC "glass of water">
			      <TELL
"The bartender puts a glass of water on the table." CR>)>)
		      (<VERB? ASK-FOR ASK-ABOUT>
		       <COND (<PRSI? ,FOOD>
		       	      <TELL
"\"It's beef stew today. You can buy it for $5.\"" CR>)
			     (<PRSI? ,DRINK-OBJECT>
			      <TELL "\"Grog is $2.\"" CR>)>)>)>>

<ROUTINE TELL-OUR-PASSBOOK ()
	  <TELL " \"Yes. That's one of our passbooks.">>

<ROUTINE TELL-NOT-HERE-TALK ()
	 <TELL-YOU-CANT "talk to someone who's not here.">>

<ROUTINE TELL-YOURE-DIVER () <TELL "\"You're a diver!\"" CR>>

<ROUTINE TELL-KNOW-ME ()
	 <TELL "\"You know me.\"" CR>>

<OBJECT HEVLIN
	(IN GLOBAL-OBJECTS)
	(DESC "dead man")
	(SYNONYM HEVLIN MAN)
	(ADJECTIVE DEAD)
	(ACTION HEVLIN-F)>

<ROUTINE HEVLIN-F ("AUX" OWINNER)
	 <COND (<OR <VERB? ASK-ABOUT ASK-CONTEXT-ABOUT ASK-FOR>
		    <VERB? ASK-CONTEXT-FOR>
		    <AND <VERB? TELL>
			 <NOT <PRSO? ,ME ,HEVLIN>>>>
		<RFALSE>)
	       (<VERB? WHAT>
		<SET OWINNER ,WINNER>
		<SETG WINNER ,PLAYER>
		<PERFORM ,V?ASK-ABOUT .OWINNER ,HEVLIN>
		<SETG WINNER .OWINNER>
		<RTRUE>)
	       (<VERB? FIND>
		<COND (<OR <==? ,WINNER ,JOHNNY>
			   <AND <==? ,WINNER ,SPEAR-CARRIER>
			    	<==? ,HERE ,RED-BOAR-INN>>>
		       <TELL "\"He was killed last night.\"" CR>)
		      (<==? ,WINNER ,PLAYER>
		       <TELL-HES-DEAD>)
		      (T <TELL-NEVER-KNEW>)>)
	       (<VERB? FIND HELP PRAY>
		<TELL-HES-DEAD>
		<RFATAL>)
	       (T <GLOBAL-NOT-HERE-PRINT ,HEVLIN>)>>

<ROUTINE TELL-HES-DEAD ()
	 <TELL "Hevlin is dead." CR>>