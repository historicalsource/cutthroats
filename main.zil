"MAIN for
		           TOA #2
      Copyright (c) 1984 Infocom, Inc.  All Rights Reserved.
"

<GLOBAL PLAYER <>>

<GLOBAL P-WON <>>

<CONSTANT M-FATAL 2>
 
<CONSTANT M-HANDLED 1>   
 
<CONSTANT M-NOT-HANDLED <>>   
 
<CONSTANT M-OBJECT <>>

<CONSTANT M-BEG 1>  
 
<CONSTANT M-END 6> 
 
<CONSTANT M-ENTER 2>
 
<CONSTANT M-LOOK 3> 
 
<CONSTANT M-FLASH 4>

<CONSTANT M-OBJDESC 5>

<CONSTANT M-CONT 7>

<CONSTANT M-NAME 8>

<ROUTINE GO () 
	 <PUTB ,P-LEXV 0 59>
;"put interrupts on clock chain"
	 <ENABLE <QUEUE I-UNWOUND 20>>
	 <ENABLE <QUEUE I-BUSINESS-HOURS 60>>
	 <ENABLE <QUEUE I-FERRY-APPROACHING 117>>
	 <ENABLE <QUEUE I-FERRY 120>>
	 <ENABLE <QUEUE I-HUNGER 15>>
	 <ENABLE <QUEUE I-THIRST 25>>
	 <ENABLE <QUEUE I-TIRED 929>>
	 <ENABLE <QUEUE I-LIVER 10>>
	 <QUEUE I-DRILL 5>
	 <QUEUE I-MM-COMPRESSOR 80>
	 <ENABLE <QUEUE I-PLOT-NEVER-STARTS 60>>
;"set up and go"
	 %<COND (<NOT <GASSIGNED? PREDGEN>>
		 '(;<SETG XTELLCHAN <OPEN "READB" ,XTELLFILE>>
		   <SETG LIT T>))
		('<SETG LIT T>)>
	 <SETG SCORE 8>
	 <SETG WINNER ,ADVENTURER>
	 <SETG PLAYER ,WINNER>
	 <SETG SAMPLE-TREASURE ,GLOBAL-OBJECTS>
	 <PUT-IN-TABLE ,ENVELOPE ,MCGINTY-HQ ,GLOBAL-SURFACE>
	 <SETG HERE ,BEDROOM>
	 ;<SETG P-IT-LOC ,HERE>
	 <SETG P-IT-OBJECT <>>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<START-MOVEMENT>
		<TELL-START-STR>
		<CRLF>
		<V-VERSION>
		<CRLF>)>
	 <MOVE ,WINNER ,BED>
	 <V-LOOK>
	 ;<USL>
	 <MAIN-LOOP>
	 <AGAIN>>    


<ROUTINE MAIN-VERB-PRINT ("AUX" TMP)
	 <SET TMP <GET ,P-ITBL ,P-VERBN>>
	 <COND (,P-OFLAG
		<PRINTB <GET .TMP 0>>)
	       (T
		<WORD-PRINT <GETB .TMP 2>
		<GETB .TMP 3>>)>>

<ROUTINE MAIN-LOOP ("AUX" ICNT OCNT NUM CNT OBJ TBL V PTBL OBJ1 TMP PLACE) 
   #DECL ((CNT OCNT ICNT NUM) FIX (OBJ) <OR FALSE OBJECT>
	  (OBJ1) OBJECT (TBL) TABLE (PTBL) <OR FALSE ATOM>)
   <REPEAT ()
     <SET CNT 0>
     <SET OBJ <>>
     <SET PTBL T>
     <SETG WAITED? <>>
     <SETG P-WALK-DIR <>>
     ;<SETG GROGGIED <>>
     <COND (<NOT <==? ,HERE ,QCONTEXT-ROOM>>
	    <SETG QCONTEXT <>>)>
     <COND (<SETG P-WON <PARSER>>
	    <SETG LAST-PLAYER-LOC <LOC ,PLAYER>>
	    <SET ICNT <GET ,P-PRSI ,P-MATCHLEN>>
	    <SET OCNT <GET ,P-PRSO ,P-MATCHLEN>>
	    <COND (<AND ,P-IT-OBJECT <ACCESSIBLE? ,P-IT-OBJECT>>
		   <SET TMP <>>
		   <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .ICNT>
				  <RETURN>)
				 (T
				  <COND (<EQUAL? <GET ,P-PRSI .CNT> ,IT>
					 <PUT ,P-PRSI .CNT ,P-IT-OBJECT>
					 <SET TMP T>
					 <RETURN>)>)>>
		   <COND (<NOT .TMP>
			  <SET CNT 0>
			  <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .OCNT>
				  <RETURN>)
				 (T
				  <COND (<EQUAL? <GET ,P-PRSO .CNT> ,IT>
					 <PUT ,P-PRSO .CNT ,P-IT-OBJECT>
					 <RETURN>)>)>>)>
		   <SET CNT 0>)>
	    <SET NUM
		 <COND (<0? .OCNT> .OCNT)
		       (<G? .OCNT 1>
			<SET TBL ,P-PRSO>
			<COND (<0? .ICNT> <SET OBJ <>>)
			      (T <SET OBJ <GET ,P-PRSI 1>>)>
			.OCNT)
		       (<G? .ICNT 1>
			<SET PTBL <>>
			<SET TBL ,P-PRSI>
			<SET OBJ <GET ,P-PRSO 1>>
			.ICNT)
		       (T 1)>>
	    <COND (<AND <NOT .OBJ> <1? .ICNT>> <SET OBJ <GET ,P-PRSI 1>>)>
	    <COND (<AND <==? ,PRSA ,V?WALK> ,P-WALK-DIR>
		   <SET V <PERFORM ,PRSA ,PRSO>>)
		  (<0? .NUM>
		   <COND (<0? <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
			  <SET V <PERFORM ,PRSA>>
			  <SETG PRSO <>>)
			 (<NOT ,LIT>
			  <TELL-TOO-DARK>)
			 (T
;"** M"			  <COND (.OBJ
				 <COND (<==? .OBJ ,NOT-HERE-OBJECT>
					<GLOBAL-NOT-HERE-PRINT .OBJ>)
				       (<FSET? 
					<SET PLACE <LOC ,WINNER>>
				        ,VEHBIT>
					<COND (<NOT <EQUAL? .PLACE
							    ;<LOC ,WINNER>
						            <LOC .OBJ>>>
					       <TELL "You should get ">
					      <COND (<FSET? .PLACE ,SURFACEBIT>
						     <TELL "off">)
						    (T <TELL "out">)>
					       <TELL " of ">
					       <THE? .PLACE>
					       <TELL D .PLACE " first." CR>
					       <SET V <>>)>)
				       (<VERB? GIVE>
					<TELL-NOTHING "to ">
					<MAIN-VERB-PRINT>
					<TELL "." CR>
				 	<SET V <>>)
				       (<AND <FSET? .OBJ ,CONTBIT>
					     <NOT <FSET? .OBJ ,OPENBIT>>>
					<TELL "Better open the " D .OBJ
					      " first." CR>
					<SETG P-IT-OBJECT .OBJ>
					<SET V <>>)
				       (<NOT <FSET? .OBJ ,CONTBIT>>
					<TELL-NOTHING "in that" T>
					<SET V <>>)
				       (T
					<TELL "It's not in that." CR>
					<SET V <>>)>) 
			        (<VERB? $CALL>
				 <V-CALL-LOSE>
				 <SET V <>>)
				(,P-NONE
				 <TELL "I can't find any here!" CR>
				 <SET V <>>)
				(T
				 <TELL "There isn't anything to ">
				 <MAIN-VERB-PRINT>
				 <TELL " here!" CR>
				 <SET V <>>)>)>)
		  (T
		   <SETG P-NOT-HERE 0>
		   <SETG P-MULT <>>
		   <COND (<G? .NUM 1> <SETG P-MULT T>)>
		   <SET TMP <>>
		   <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .NUM>
				  <COND (<G? ,P-NOT-HERE 0>
					 <TELL "The ">
					 <COND (<NOT <EQUAL? ,P-NOT-HERE .NUM>>
						<TELL "other ">)>
					 <TELL "object">
					 <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
						<TELL "s">)>
					 <TELL " that you mentioned ">
					 <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
						<TELL "are">)
					       (T <TELL "is">)>
					 <TELL "n't here." CR>)
					(<NOT .TMP>
					 <TELL 
"I don't know what you're referring to." CR>)>
				  <RETURN>)
				 (T
				  <COND (.PTBL <SET OBJ1 <GET ,P-PRSO .CNT>>)
					(T <SET OBJ1 <GET ,P-PRSI .CNT>>)>
				  <SETG PRSO <COND (.PTBL .OBJ1) (T .OBJ)>>
				  <SETG PRSI <COND (.PTBL .OBJ) (T .OBJ1)>>
				  ;<COND (<EQUAL? ,HERE ,P-IT-LOC>
					 <COND (<EQUAL? ,PRSO ,IT>
					 	<SETG PRSO ,P-IT-OBJECT>
						<COND (.PTBL
						       <SET OBJ1 ,PRSO>
						       <PUT ,P-PRSO 
							    .CNT ,PRSO>)
						      (T
						       <SET OBJ ,PRSO>
						       <PUT ,P-PRSO 1 ,PRSO>)>)
					       (<EQUAL? ,PRSI ,IT>
					 	<SETG PRSI ,P-IT-OBJECT>
						<COND (.PTBL
						       <SET OBJ ,PRSI>
						       <PUT ,P-PRSI 1 ,PRSI>)
						      (T
						       <SET OBJ1 ,PRSI>
						       <PUT ,P-PRSI 
							    .CNT ,PRSI>)>)>)>
				  <COND ;(<VERB? COMPARE> T)
					(<G? .NUM 1>
					 <COND (<EQUAL? .OBJ1
							 ,NOT-HERE-OBJECT>
						 <SETG P-NOT-HERE
						       <+ ,P-NOT-HERE 1>>
						 <AGAIN>)
						(<AND <VERB? TAKE>
						      ,PRSI
						      <EQUAL? <GET <GET ,P-ITBL
									,P-NC1>
								   0>
							      ,W?ALL>
						      <NOT <IN? ,PRSO ,PRSI>>>
						 <AGAIN>)
						(<AND <EQUAL? ,P-GETFLAGS
							      ,P-ALL>
						      <VERB? TAKE>
						      <OR <AND <NOT <EQUAL?
								    <LOC .OBJ1>
								    ,WINNER
								    ,HERE>>
							       <NOT <FSET?
								  <LOC .OBJ1>
								  ,TRANSBIT>>>
							  <NOT <OR <FSET?
								    .OBJ1
								    ,TAKEBIT>
								   <FSET?
								    .OBJ1
							       ,TRYTAKEBIT>>>>>
						 <AGAIN>)
						(<AND <EQUAL? ,P-GETFLAGS
							      ,P-ALL>
						      <VERB? DROP>
						      <NOT <IN? .OBJ1 ,WINNER>>
						      <NOT <IN? ,P-IT-OBJECT
								,WINNER>>>
						 <AGAIN>)
						(T
						 <COND (<EQUAL? .OBJ1 ,IT>
							<DPRINT ,P-IT-OBJECT>)
						       (T <DPRINT .OBJ1>)>
						 <TELL ": ">)>)>
				  <SET V <QCONTEXT-CHECK <COND (.PTBL .OBJ1)
							(T .OBJ)>>>
				  <SET TMP T>
				  <SET V <PERFORM ,PRSA ,PRSO ,PRSI>>
				  <COND (<==? .V ,M-FATAL> <RETURN>)>)>>)>
	    <COND (<NOT <==? .V ,M-FATAL>>
		   ;<COND (<==? <LOC ,WINNER> ,PRSO>
			  <SETG PRSO <>>)>
		   ;"Removing this code should fix the problem that AGAIN
		     loses when in a vehicle and it is the PRSO."
		   <SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-END>>)>
	    <COND (<OR <VERB? AGAIN WALK FOLLOW>
		       <VERB? WAIT>
		       <GAME-COMMAND?>>
		   T)
		  (T
		   <SETG L-PRSA ,PRSA>
		   <SETG L-PRSO ,PRSO>
		   <SETG L-PRSI ,PRSI>
		   <SETG L-WALK-DIR ,P-WALK-DIR>
		   <SETG L-WINNER ,WINNER>)>
	    <COND (<==? .V ,M-FATAL> <SETG P-CONT <>>)>)
	   (T
	    <SETG P-CONT <>>)>
     <COND (,P-WON
	    <COND (<GAME-COMMAND?>
		   T)
		  (<AND <VERB? TELL>
			<NOT ,PRSI>>
		   T)
	    	  (<OR ,CLOCK-WAIT <0? ,I-WAIT-DURATION>>
		   <SET V <CLOCKER>>
		   <SET V <DETECTOR-NOISE>>)
		  (T
		   <SETG I-WAIT-FLAG <V-WAIT ,I-WAIT-DURATION <>>>
		   <COND (,I-WAIT-FLAG
		   	  <APPLY ,I-WAIT-RTN>
		   	  <SETG I-WAIT-FLAG <>>)
			 (T <SETG I-WAIT-DURATION 0> <SET V <CLOCKER>>)>
		   <SET V <DETECTOR-NOISE>>)>)>
     <SETG PRSA <>>
     <SETG PRSO <>>
     <SETG PRSI <>>>>

<ROUTINE GAME-COMMAND? ()
	 <COND (<VERB? BRIEF SUPER-BRIEF VERBOSE SAVE RESTORE RESTART
		       QUIT SCRIPT UNSCRIPT $VERIFY VERSION SCORE TIME>
		<RTRUE>)>>

<ROUTINE QCONTEXT-CHECK (PRSO "AUX" OTHER (WHO <>) (N 0))
	 <COND (<OR <VERB? HELP LATITUDE LONGITUDE>
		    <AND <VERB? SHOW TELL GIVE> <==? .PRSO ,PLAYER>>> ;"? more?"
		<SET OTHER <FIRST? ,HERE>>
		<REPEAT ()
			<COND (<NOT .OTHER> <RETURN>)
			      (<AND <FSET? .OTHER ,PERSON>
				    <NOT <==? .OTHER ,PLAYER>>>
			       <SET N <+ 1 .N>>
			       <SET WHO .OTHER>)>
			<SET OTHER <NEXT? .OTHER>>>
		<COND (<AND <==? 1 .N> <NOT ,QCONTEXT>>
		       <SAID-TO .WHO>)>
		<COND (<AND ,QCONTEXT
			    <IN? ,QCONTEXT ,HERE>
			    <==? ,QCONTEXT-ROOM ,HERE>
			    <==? ,WINNER ,PLAYER>> ;"? more?"
		       <SETG WINNER ,QCONTEXT>
		       <TELL "(said to " D ,QCONTEXT ")" CR>)>)>>

<ROUTINE SAID-TO (WHO)
 <SETG WINNER .WHO>
 <SETG QCONTEXT .WHO>
 <SETG QCONTEXT-ROOM ,HERE>>
 
<GLOBAL P-MULT <>>

<GLOBAL P-NOT-HERE 0>

<GLOBAL L-PRSA <>>  
 
<GLOBAL L-PRSO <>>  
 
<GLOBAL L-PRSI <>>

<GLOBAL L-WINNER <>>

<GLOBAL LAST-PLAYER-LOC <>>  

;"PERFORM without DEBUG"
<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI) 
	#DECL ((A) FIX (O) <OR FALSE OBJECT FIX> (I) <OR FALSE OBJECT> (V) ANY)
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<COND (<AND <NOT <==? .A ,V?WALK>>
		    <EQUAL? ,IT .I .O>>
	       ;<AND <EQUAL? ,IT .I .O>
		    <NOT <EQUAL? ,P-IT-LOC ,HERE>>>
	       <TELL "I don't see what you are referring to." CR>
	       <RFATAL>)>
	;<COND (<==? .O ,IT> <SET O ,P-IT-OBJECT>)>
	;<COND (<==? .I ,IT> <SET I ,P-IT-OBJECT>)>
	<SETG PRSA .A>
	<SETG PRSO .O>
	<COND (<AND ,PRSO <NOT <EQUAL? ,PRSI ,IT>> <NOT <VERB? WALK>>>
	       <SETG P-IT-OBJECT ,PRSO>
	       ;<SETG P-IT-LOC ,HERE>)>
	<SETG PRSI .I>
	<COND (<AND <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
		    <NOT <VERB? WALK>>
		    <SET V <NOT-HERE-OBJECT-F>>>
	       <SETG P-WON <>>
	       .V)
	      (T
	       <SET O ,PRSO>
	       <SET I ,PRSI>
	       <COND
		(<SET V <APPLY <GETP ,WINNER ,P?ACTION>>> .V)
		(<SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-BEG>> .V)
		(<SET V <APPLY <GET ,PREACTIONS .A>>> .V)
		(<AND <SET I ,PRSI> .I <SET V <APPLY <GETP .I ,P?ACTION>>>> .V)
		(<AND .O
		      <NOT <==? .A ,V?WALK>>
		      <LOC .O>
		      <SET V <APPLY <GETP <LOC .O> ,P?CONTFCN> ,M-CONT>>>
		 .V)
		(<AND .O
		      <NOT <==? .A ,V?WALK>>
		      <SET V <APPLY <GETP .O ,P?ACTION>>>>
		 .V)
		(<SET V <APPLY <GET ,ACTIONS .A>>> .V)>)>
	<COND (<NOT <==? .V ,M-FATAL>>
	       <COND (<==? <LOC ,WINNER> ,PRSO>
		      <SETG PRSO <>>)>
	       <SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-END>>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>

;"PERFORM with DEBUG"
;<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI) 
	#DECL ((A) FIX (O) <OR FALSE OBJECT FIX> (I) <OR FALSE OBJECT> (V) ANY)
	<COND (,DEBUG
	       <TELL "** PERFORM: PRSA = ">
	       %<COND (<GASSIGNED? PREDGEN> '<TELL N .A>)
		      (T '<PRINC <NTH ,ACTIONS <+ <* .A 2> 1>>>)>
	       <COND (<AND .O <NOT <==? .A ,V?WALK>>>
		      <TELL "/PRSO = " D .O>)>
	       <COND (.I <TELL "/PRSI = " D .I>)>)>
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<COND (<AND <NOT <==? .A ,V?WALK>>
		    <EQUAL? ,IT .I .O>>
	       ;<AND <EQUAL? ,IT .I .O>
		    <NOT <EQUAL? ,P-IT-LOC ,HERE>>>
	       <TELL "I don't see what you are referring to." CR>
	       <RFATAL>)>
	;<COND (<==? .O ,IT> <SET O ,P-IT-OBJECT>)>
	;<COND (<==? .I ,IT> <SET I ,P-IT-OBJECT>)>
	<SETG PRSA .A>
	<SETG PRSO .O>
	<COND (<AND ,PRSO <NOT <EQUAL? ,PRSI ,IT>> <NOT <VERB? WALK>>>
	       <SETG P-IT-OBJECT ,PRSO>
	       ;<SETG P-IT-LOC ,HERE>)>
	<SETG PRSI .I>
	<COND (<AND <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
		    <NOT <VERB? WALK>>
		    <SET V <D-APPLY "Not Here" ,NOT-HERE-OBJECT-F>>>
	       <SETG P-WON <>>
	       .V)
	      (T
	       <SET O ,PRSO>
	       <SET I ,PRSI>
	       <COND (<SET V <DD-APPLY "Actor" ,WINNER
				      <GETP ,WINNER ,P?ACTION>>> .V)
		     (<SET V <D-APPLY "Room (M-BEG)"
				      <GETP <LOC ,WINNER> ,P?ACTION>
				      ,M-BEG>> .V)
		     (<SET V <D-APPLY "Preaction"
				      <GET ,PREACTIONS .A>>> .V)
		     (<AND <SET I ,PRSI> .I <SET V <D-APPLY "PRSI"
					      <GETP .I ,P?ACTION>>>> .V)
		     (<AND .O
			   <NOT <==? .A ,V?WALK>>
			   <LOC .O>
			   <GETP <LOC .O> ,P?CONTFCN>
			   <SET V <DD-APPLY "Container" <LOC .O>
					  <GETP <LOC .O> ,P?CONTFCN>>>>
		      .V)
		     (<AND .O
			   <NOT <==? .A ,V?WALK>>
			   <SET V <D-APPLY "PRSO"
					   <GETP .O ,P?ACTION>>>>
		      .V)
		     (<SET V <D-APPLY <>
				      <GET ,ACTIONS .A>>> .V)>)>
	<COND (<NOT <==? .V ,M-FATAL>>
	       <COND (<==? <LOC ,WINNER> ,PRSO>
		      <SETG PRSO <>>)>
	       <SET V <D-APPLY "Room (M-END)"
			       <GETP <LOC ,WINNER> ,P?ACTION> ,M-END>>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>

;"Next 2 routines for use with DEBUG"
;<ROUTINE DD-APPLY (STR OBJ FCN "OPTIONAL" (FOO <>))
	<COND (,DEBUG <TELL "[" D .OBJ "=]">)>
	<D-APPLY .STR .FCN .FOO>>

;<ROUTINE D-APPLY (STR FCN "OPTIONAL" (FOO <>) "AUX" RES)
	<COND (<NOT .FCN> <>)
	      (T
	       <COND (,DEBUG
		      <COND (<NOT .STR>
			     <TELL "[Action:]" CR>)
			    (T <TELL "[" .STR ": ">)>)>
	       <COND (<==? .STR "Container">
		      <SET FOO ,M-CONT>)>
	       <SET RES
		    <COND (.FOO <APPLY .FCN .FOO>)
			  (T <APPLY .FCN>)>>
	       <COND (<AND ,DEBUG .STR>
		      <COND (<==? .RES ,M-FATAL>
			     <TELL "Fatal]" CR>)
			    (<NOT .RES>
			     <TELL "Not handled]" CR>)
			    (T <TELL "Handled]" CR>)>)>
	       .RES)>>
 
<ROUTINE TELL-START-STR () ;"submitted by a committee"
	 <TELL
"Nights on Hardscrabble Island are lonely and cold when the lighthouse
barely pierces the gloom. You sit on your bed, thinking of better times
and far-off places. A knock on your door stirs you, and Hevlin, a shipmate
you haven't seen for years, staggers in.|
|
\"I'm in trouble,\" he says. \"I had a few too many at The Shanty.
I was looking for Red, but he wasn't around, and I started talking about ...
here,\" he says, handing you a slim volume that you recognize
as a shipwreck book written years ago by the Historical Society.|
|
You smile. Every diver on the island has looked for those wrecks,
without even an old boot to show for it. You open the door, hoping the
drunken fool will leave. \"I know what you're thinkin',\" Hevlin scowls,
\"but look!\" He points to the familiar map, and you see new locations
marked for two of the wrecks.|
|
\"Keep it for me,\" he says. \"Just for tonight. It'll be safe here with
you. Don't let -- \" He stops and broods for a moment. \"I've got to go
find Red!\" And with that, Hevlin leaves.|
|
You put the book in your dresser and think about following Hevlin. Then you
hear a scuffle outside. You look through your window and see two men
struggling. One falls to the ground in a heap. The other man bends
down beside him, then turns as if startled and runs away. Another man then
approaches the wounded figure. He kneels beside him for a long moment,
then takes off after the other man.|
|
It isn't long before the police arrive to tell you that Hevlin's been
murdered. You don't mention the book, and hours later, as you lie awake
in your bed, you wonder if the book could really be what it seems." CR>>

<ROUTINE ACCESSIBLE? (OBJ "AUX" (L <LOC .OBJ>)) ;"can player TOUCH object?"
	 ;"revised 5/2/84 by SEM and SWG"
	 <COND (<FSET? .OBJ ,INVISIBLE>	<RFALSE>)
	       (<EQUAL? .OBJ ,PSEUDO-OBJECT>
		<COND (<EQUAL? <GETP ,PSEUDO-OBJECT ,P?DESCFCN> ,HERE>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<NOT .L> <RFALSE>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS> <RTRUE>)	       
	       (<AND <EQUAL? .L ,LOCAL-GLOBALS>
		     <GLOBAL-IN? .OBJ ,HERE>>
		<RTRUE>)
	       (<NOT <EQUAL? <META-LOC .OBJ> ,HERE>> <RFALSE>)
	       (<EQUAL? .L ,WINNER ,HERE> <RTRUE>)
	       (<AND <OR <FSET? .L ,OPENBIT>
			 <FSET? .L ,PERSON>>
		     <ACCESSIBLE? .L>>
		<RTRUE>)
	       (T <RFALSE>)>>

<ROUTINE VISIBLE? (OBJ "AUX" (L <LOC .OBJ>)) ;"can player SEE object"
	 ;"revised 5/2/84 by SEM and SWG"
	 <COND (<ACCESSIBLE? .OBJ>
		<RTRUE>)
	       (<AND <SEE-INSIDE? .L>
		     <VISIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE META-LOC (OBJ)
	 <REPEAT ()
		 <COND (<NOT .OBJ> <RFALSE>)
		       (<EQUAL? .OBJ ,GLOBAL-OBJECTS ,LOCAL-GLOBALS>
			<RETURN .OBJ>)>
		 <COND (<IN? .OBJ ,ROOMS>
			<RETURN .OBJ>)
		       (ELSE
			<SET OBJ <LOC .OBJ>>)>>>