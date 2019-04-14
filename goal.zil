"GOAL for
			     TOA #2
	Copyright 1984 Infocom, Inc.  All rights reserved.
"

"This code is the local T system."

<GLOBAL DIR-STRINGS
	<PTABLE  P?NORTH "north" P?SOUTH "south"
		P?EAST "east" P?WEST "west"
		P?NW "northwest" P?NE "northeast"
		P?SW "southwest" P?SE "southeast"
		P?DOWN "downstairs" P?UP "upstairs"
		P?IN "in" P?OUT "out">>

<GLOBAL NAUTICAL-DIR-STRINGS
	<PTABLE  P?NORTH "forward" P?SOUTH "aft"
		P?EAST "starboard" P?WEST "port"
		P?NW "northwest" P?NE "northeast"
		P?SW "southwest" P?SE "southeast"
		P?DOWN "below" P?UP "above"
		P?IN "in" P?OUT "out">>

<ROUTINE DIR-PRINT (DIR "AUX" (CNT 0) TBL (DRY <>))
	 #DECL ((DIR CNT) FIX)
	 <COND (<NOT .DIR>
		<TELL "out of view">
		<RTRUE>)
	       (<G? <GETP ,HERE ,P?LINE> ,BACK-ALLEY-LINE-C>
		<SET TBL ,NAUTICAL-DIR-STRINGS>)
	       (T
		<SET TBL ,DIR-STRINGS>
		<SET DRY T>)>
	 <REPEAT ()
		 <COND (<==? <GET .TBL .CNT> .DIR>
			<COND (<AND .DRY
				    <NOT <EQUAL? .DIR ,P?UP ,P?DOWN>>>
			       <TELL "the ">)>
			<PRINT <GET .TBL <+ .CNT 1>>>
			<RTRUE>)>
		 <SET CNT <+ .CNT 1>>>>

"Rapid Transit Line Definitions and Identifiers"

<CONSTANT ROAD-WHARF-LINE-C 0>
<CONSTANT EAST-ROAD-LINE-C 1>
<CONSTANT BEDROOM-LINE-C 2>
<CONSTANT BACK-ALLEY-LINE-C 3>
<CONSTANT TRAWLER-LINE-C 4>
<CONSTANT SALVAGER-LINE-C 5>
<CONSTANT UNDERWATER-LINE-C 6>

<GLOBAL ROAD-WHARF-LINE
	<PTABLE 0 WINDING-ROAD-1 P?SE
	       P?NW WINDING-ROAD-2 P?NE
	       P?SW WINDING-ROAD-3 P?NE
	       P?SW WHARF-ROAD-1 P?EAST
	       P?WEST WHARF-ROAD-2 P?EAST
	       P?WEST WHARF-ROAD-3 P?NORTH
	       P?SOUTH WHARF 0>>
	       
<GLOBAL EAST-ROAD-LINE
	<PTABLE 0 WHARF-ROAD-4 P?EAST
	       P?WEST WHARF-ROAD-5 P?SE
	       P?NW OCEAN-ROAD-1 P?SOUTH
	       P?NORTH OCEAN-ROAD-2 P?SOUTH
	       P?NORTH OCEAN-ROAD-3 P?SW
	       P?NE SHORE-ROAD-2 P?WEST
	       P?EAST SHORE-ROAD-1 P?WEST
	       P?EAST FERRY-LANDING 0>>

<GLOBAL BEDROOM-LINE
	<PTABLE 0 RED-BOAR-INN P?UP
	       P?DOWN UPSTAIRS-HALLWAY P?SOUTH
	       P?NORTH BEDROOM 0>>

<GLOBAL BACK-ALLEY-LINE
	<PTABLE 0 BACK-ALLEY-1 P?EAST
	       P?WEST BACK-ALLEY-2 P?EAST
	       P?WEST BACK-ALLEY-3 P?EAST
	       P?WEST BACK-ALLEY-4 P?EAST
	       P?WEST BACK-ALLEY-5 0>>

<GLOBAL TRAWLER-LINE
	<PTABLE 0 NW-PORT-DECK P?NE
	       P?SW NW-FORE-DECK P?SE
	       P?NW NW-STARBOARD-DECK P?SW
	       P?NE NW-AFT-DECK P?DOWN
	       P?UP NW-LOUNGE P?NORTH
	       P?SOUTH NW-GALLEY P?NORTH
	       P?SOUTH NW-CREW-QTRS 0>>

<GLOBAL SALVAGER-LINE
	<PTABLE 0 MM-STARBOARD-DECK P?NW
	       P?SE MM-FORE-DECK P?SW
	       P?NE MM-PORT-DECK P?SE
	       P?NW MM-AFT-DECK P?DOWN
	       P?UP MM-LOUNGE P?NORTH
	       P?SOUTH MM-GALLEY P?NORTH
	       P?SOUTH MM-CREW-QTRS 0>>

<GLOBAL TRANSFER-TABLE
	<PTABLE 0 0
	       WHARF-ROAD-3 WHARF-ROAD-4
	       WHARF-ROAD-1 RED-BOAR-INN
	       WHARF-ROAD-3 WHARF-ROAD-4
	       WHARF NW-STARBOARD-DECK
	       WHARF MM-PORT-DECK

	       WHARF-ROAD-4 WHARF-ROAD-3
	       0 0
	       WHARF-ROAD-4 WHARF-ROAD-3
	       OCEAN-ROAD-1 BACK-ALLEY-5
	       WHARF-ROAD-4 WHARF-ROAD-3
	       WHARF-ROAD-4 WHARF-ROAD-3

	       RED-BOAR-INN WHARF-ROAD-1
	       RED-BOAR-INN WHARF-ROAD-1
	       0 0
	       RED-BOAR-INN WHARF-ROAD-1
	       RED-BOAR-INN WHARF-ROAD-1
	       RED-BOAR-INN WHARF-ROAD-1

	       BACK-ALLEY-5 OCEAN-ROAD-1
	       BACK-ALLEY-5 OCEAN-ROAD-1
	       BACK-ALLEY-5 OCEAN-ROAD-1
	       0 0
	       BACK-ALLEY-5 OCEAN-ROAD-1
	       BACK-ALLEY-5 OCEAN-ROAD-1

	       NW-STARBOARD-DECK WHARF
	       NW-STARBOARD-DECK WHARF
	       NW-STARBOARD-DECK WHARF
	       NW-STARBOARD-DECK WHARF
	       0 0
	       NW-STARBOARD-DECK WHARF

	       MM-PORT-DECK WHARF
	       MM-PORT-DECK WHARF
	       MM-PORT-DECK WHARF
	       MM-PORT-DECK WHARF
	       MM-PORT-DECK WHARF
	       0 0>>

<GLOBAL COR-1
	<PTABLE P?NW P?SE
	       WINDING-ROAD-1 WINDING-ROAD-2 0>>

<GLOBAL COR-2
	<PTABLE P?SW P?NE
	       WINDING-ROAD-2 WINDING-ROAD-3 WHARF-ROAD-1 0>>

<GLOBAL COR-4
	<PTABLE P?WEST P?EAST
	       WHARF-ROAD-1 WHARF-ROAD-2 WHARF-ROAD-3 WHARF-ROAD-4
	       WHARF-ROAD-5 0>>

<GLOBAL COR-8
	<PTABLE P?NW P?SE
	       WHARF-ROAD-5 OCEAN-ROAD-1 0>>

<GLOBAL COR-16
	<PTABLE P?NORTH P?SOUTH
	       OCEAN-ROAD-1 OCEAN-ROAD-2 OCEAN-ROAD-3 0>>

<GLOBAL COR-32
	<PTABLE P?NW P?SE
	       OCEAN-ROAD-3 POINT-LOOKOUT 0>>

<GLOBAL COR-64
	<PTABLE P?SW P?NE
	       SHORE-ROAD-2 OCEAN-ROAD-3 0>>

<GLOBAL COR-128
	<PTABLE P?WEST P?EAST
	       FERRY-LANDING SHORE-ROAD-1 SHORE-ROAD-2 0>>

<GLOBAL COR-256
	<PTABLE P?NORTH P?SOUTH
	       WHARF WHARF-ROAD-3 VACANT-LOT BACK-ALLEY-3 0>>

<GLOBAL COR-512
	<PTABLE P?WEST P?EAST
	       BACK-ALLEY-1 BACK-ALLEY-2 BACK-ALLEY-3 BACK-ALLEY-4
	       BACK-ALLEY-5 0>>

;"up to 16 corridors (65536)"

"CODE"

<ROUTINE FOLLOW-GOAL (PERSON "AUX" (HERE <LOC .PERSON>) LINE LN RM GT GOAL FLG
		      		   (GOAL-FLAG <>) (IGOAL <>) LOC (CNT 1) DIR)
	 #DECL ((PERSON HERE LOC RM) OBJECT (LN CNT) FIX
		(GOAL-FLAG) <OR ATOM FALSE>)
	 <SET GT <GET ,GOAL-TABLES <GETP .PERSON ,P?CHARACTER>>>
	 <COND (<==? .HERE <GET .GT ,GOAL-F>>
		<PUT .GT ,GOAL-S <>>
		<RETURN <>>)
	       (<NOT <GET .GT ,GOAL-ENABLE>> <RFALSE>)>
	 <COND (<NOT <EQUAL? <SET LOC <GETP .HERE ,P?STATION>>
			     .HERE>>
		<RETURN <MOVE-PERSON .PERSON .LOC>>)>
	 ;%<COND (<GASSIGNED? PREDGEN>
		 '<>)
		(T
		 '<COND (<NOT <EQUAL? <SET LOC ,<GETP .HERE ,P?STATION>>
				      .HERE>>
			 <RETURN <MOVE-PERSON .PERSON .LOC>>)>)>
	 <COND (<==? <SET GOAL <GET ,TRANSFER-TABLE
				    <SET IGOAL <GET .GT ,GOAL-I>>>> 0>
		<SET IGOAL <>>
		<SET GOAL <GET .GT ,GOAL-S>>)>
	 <COND (<NOT .GOAL> <RFALSE>)
	       (<==? .HERE .GOAL>
		<COND (.IGOAL
		       <SET FLG <MOVE-PERSON .PERSON
				             <GET ,TRANSFER-TABLE
						  <+ .IGOAL 1>>>>
		       <ESTABLISH-GOAL .PERSON <GET .GT ,GOAL-F>>
		       <RETURN .FLG>)
		      (<NOT <==? .HERE <GET .GT ,GOAL-F>>>
		       <PUT .GT ,GOAL-S <>>
		       <SET FLG <MOVE-PERSON .PERSON <GET .GT ,GOAL-F>>>
		       <RETURN .FLG>)
		      (T
		       <PUT .GT ,GOAL-S <>>
		       <RETURN <>>)>)>
	 <SET LINE <GET-LINE <GETP .GOAL ,P?LINE>>>
	 <REPEAT ()
		 <COND (<==? <SET RM <GET .LINE .CNT>> .HERE>
		        <COND (.GOAL-FLAG
			       <SET LOC <GET .LINE <- .CNT 3>>>)
			      (T
			       <SET LOC <GET .LINE <+ .CNT 3>>>)>
			<RETURN <MOVE-PERSON .PERSON .LOC>>)
		       (<==? .RM .GOAL>
			<SET GOAL-FLAG T>)>
		 <SET CNT <+ .CNT 3>>>>

<ROUTINE COR-DIR (HERE THERE "AUX" COR RM (PAST 0) (CNT 2))
	 <SET COR <GET-COR <BAND <GETP .THERE ,P?CORRIDOR>
				 <GETP .HERE ,P?CORRIDOR>>>>
	 <REPEAT ()
		 <COND (<==? <SET RM <GET .COR .CNT>> .HERE>
			<SET PAST 1>
			<RETURN>)
		       (<==? .RM .THERE>
			<RETURN>)>
		 <SET CNT <+ .CNT 1>>>
	 <GET .COR .PAST>>

<ROUTINE GET-LINE (LN)
	 <COND (<==? .LN 0> ,ROAD-WHARF-LINE)
	       (<==? .LN 1> ,EAST-ROAD-LINE)
	       (<==? .LN 2> ,BEDROOM-LINE)
	       (<==? .LN 3> ,BACK-ALLEY-LINE)
	       (<==? .LN 4> ,TRAWLER-LINE)
	       (<==? .LN 5> ,SALVAGER-LINE)>>

<ROUTINE GET-COR (NUM)
	 #DECL ((NUM) FIX)
	 <COND (<==? .NUM 1> ,COR-1)
	       (<==? .NUM 2> ,COR-2)
	       (<==? .NUM 4> ,COR-4)
	       (<==? .NUM 8> ,COR-8)
	       (<==? .NUM 16> ,COR-16)
	       (<==? .NUM 32> ,COR-32)
	       (<==? .NUM 64> ,COR-64)
	       (<==? .NUM 128> ,COR-128)
	       (<==? .NUM 256> ,COR-256)
	       (T ,COR-512)>>

"Goal tables for the 4 characters (plus delivery boy), offset by a constant,
which, for a given character, is the P?CHARACTER property of the object."

<GLOBAL GOAL-TABLES
	<TABLE <TABLE <> <> <> 1 <> I-FOLLOW 5 5>
	       <TABLE <> <> <> 1 <> I-MCGINTY 5 5>
	       <TABLE <> <> <> 1 <> I-JOHNNY 5 5>
	       <TABLE <> <> <> 1 <> I-PETE 5 5>
	       <TABLE <> <> <> 1 <> I-WEASEL 5 5>
	       <TABLE <> <> <> 1 <> I-DELIVERY-BOY 0 0>>>

<CONSTANT CHARACTER-MAX 5>
<CONSTANT MCGINTY-C 1>
<CONSTANT JOHNNY-C 2>
<CONSTANT PETE-C 3>
<CONSTANT WEASEL-C 4>
<CONSTANT DELIVERY-BOY-C 5>

"Offsets into GOAL-TABLEs"

<CONSTANT GOAL-F 0> ;"final goal"
<CONSTANT GOAL-S 1> ;"station of final goal"
<CONSTANT GOAL-I 2> ;"intermediate goal (transfer point)"
<CONSTANT GOAL-ENABLE 3> ;"character can move; usually false only when he's
			   interrupted enroute"
<CONSTANT GOAL-QUEUED 4> ;"secondary goal to go to when current, higher-
			   priority one has been reached"
<CONSTANT GOAL-FUNCTION 5> ;"routine to apply on arrival"
<CONSTANT ATTENTION-SPAN 6> ;"how long character will wait when interrupted"
<CONSTANT ATTENTION 7> ;"used to count down from ATTENTION-SPAN to 0"

"Goal-function constants, similar to M-xxx in MAIN"

<CONSTANT G-REACHED 1>
<CONSTANT G-ENROUTE 2>

"Routines to do looking down corridors"

<ROUTINE CORRIDOR-LOOK ("OPTIONAL" (ITM <>) "AUX" C Z COR VAL (FOUND <>))
	 <COND (<SET C <GETP ,HERE ,P?CORRIDOR>>
		<REPEAT ()
			<COND ;(<NOT <L? <SET Z <- .C 1024>> 0>>
			       <SET COR ,COR-1024>)
			      (<NOT <L? <SET Z <- .C 512>> 0>>
			       <SET COR ,COR-512>)
			      (<NOT <L? <SET Z <- .C 256>> 0>>
			       <SET COR ,COR-256>)
			      (<NOT <L? <SET Z <- .C 128>> 0>>
			       <SET COR ,COR-128>)
			      (<NOT <L? <SET Z <- .C 64>> 0>>
			       <SET COR ,COR-64>)
			      (<NOT <L? <SET Z <- .C 32>> 0>>
			       <SET COR ,COR-32>)
			      (<NOT <L? <SET Z <- .C 16>> 0>>
			       <SET COR ,COR-16>)
			      (<NOT <L? <SET Z <- .C 8>> 0>>
			       <SET COR ,COR-8>)
			      (<NOT <L? <SET Z <- .C 4>> 0>>
			       <SET COR ,COR-4>)
			      (<NOT <L? <SET Z <- .C 2>> 0>>
			       <SET COR ,COR-2>)
			      (<NOT <L? <SET Z <- .C 1>> 0>>
			       <SET COR ,COR-1>)
			      (T <RETURN>)>
			<SET VAL <CORRIDOR-CHECK .COR .ITM>>
			<COND (<NOT .FOUND> <SET FOUND .VAL>)>
			<SET C .Z>>
		.FOUND)>>

<ROUTINE CORRIDOR-CHECK (COR ITM "AUX" (CNT 2) (PAST 0) (FOUND <>) RM OBJ)
	 <REPEAT ()
		 <COND (<==? <SET RM <GET .COR .CNT>> 0>
			<RFALSE>)
		       (<==? .RM ,HERE> <SET PAST 1>)
		       (<SET OBJ <FIRST? .RM>>
			<REPEAT ()
				<COND (.ITM
				       <COND (<==? .OBJ .ITM>
					      <SET FOUND <GET .COR .PAST>>
					      <RETURN>)>)
				      (<AND <GETP .OBJ ,P?CHARACTER>
					    <NOT <IN-MOTION? .OBJ>>
					    <OR <NOT <==? .OBJ ,MCGINTY>>
						<NOT <QUEUED?
						      I-MCGINTY-FOLLOWS>>
						<NOT <VERB? WALK FOLLOW>>>>
				       <START-SENTENCE .OBJ>
				       <TELL " is ">
				       ;<COND (<IN-MOTION? .OBJ>
					      <TELL "in motion ">)>
				       <TELL "off to ">
				       <DIR-PRINT <GET .COR .PAST>>
				       <TELL ".">
				       <CRLF>)>
				<SET OBJ <NEXT? .OBJ>>
				<COND (<NOT .OBJ> <RETURN>)>>
			<COND (.FOUND <RETURN .FOUND>)>)>
		 <SET CNT <+ .CNT 1>>>>

<GLOBAL CHARACTER-TABLE <PTABLE PLAYER MCGINTY JOHNNY PETE WEASEL DELIVERY-BOY>>

"Goal tables for the 6 characters (including PLAYER), offset
by the preceding constants, which, for a given character,
is the P?CHARACTER property of the object."

"The ATTENTION-TABLE is now a thing of the past. ATTENTION
in the GOAL-TABLES is used instead."

"Here's how the movement goals are done:  For each player is
a table which consists of triplets, a number of minutes until
the next movement (an clock interrupt number), a number of
minutes allowed variation (for a bit of randomness), and a
room toward which to start. All movement is controlled by
the GOAL-ENABLE flag in the GOAL-TABLE for a character."

"Time starts at 8AM. Characters are at that point in their
starting positions, as reflected in PEOPLE."

<GLOBAL MOVEMENT-GOALS <TABLE
	;"PLAYER"
	<TABLE 0 0 0>
	;"MCGINTY"
	<TABLE 0
	       58  2 SHANTY
	       15  1 MCGINTY-HQ
	       65  2 BANK
	       16  5 OUTFITTERS-HQ
	       30  3 MCGINTY-HQ
	       75  5 SHANTY
	       30  5 MCGINTY-HQ
	       ;69  ;2 ;MM-FORE-DECK
	       0>
	;"JOHNNY"
	<TABLE 0
	       61  2 WINDING-ROAD-1
	       75  5 SHANTY
	       0>
	;"PETE"
	<TABLE 0
	       72  2 WINDING-ROAD-1
	       81  5 SHANTY
	       197 5 MM-GALLEY
	       0>
	;"WEASEL"
	<TABLE 0
	       8   5 UPSTAIRS-HALLWAY
	       58  2 WINDING-ROAD-1
	       78  5 UPSTAIRS-HALLWAY
	       85  1 FERRY-LANDING
	       0>
	;"DELIVERY-BOY"
	<TABLE 0
	       345 1 MM-LOCKER
	       0>>>

<GLOBAL WEASEL-RETIRES-TABLE
	<TABLE 0
	       5  1  BACK-ALLEY-5
	       45 5  BANK
	       10 5  FERRY-LANDING
	       0>>

<GLOBAL JOHNNY-CONTINUES-TABLE
	<TABLE 0
	       5  1  OUTFITTERS-HQ
	       60 5  POINT-LOOKOUT
	       25 1  SHANTY
	       0>>

<GLOBAL JOHNNY-COMPLETES-TABLE
	<TABLE 0
	       200 5 MM-CAPT-CABIN
	       0>>

<ROUTINE IN-MOTION? (PERSON "AUX" GT)
	 <SET GT <GET ,GOAL-TABLES <GETP .PERSON ,P?CHARACTER>>>
	 <COND (<AND <OR <GET .GT ,GOAL-ENABLE>
			 <==? <GET .GT ,ATTENTION> 1>>
		     <GET .GT ,GOAL-S>
		     <NOT <==? <LOC .PERSON> <GET .GT ,GOAL-F>>>>
		<RTRUE>)
	       (T <RFALSE>)>>

<ROUTINE START-MOVEMENT ()
	 <ENABLE <QUEUE I-MCGINTY 1>>
	 <ENABLE <QUEUE I-JOHNNY 1>>
	 <ENABLE <QUEUE I-PETE 1>>
	 <ENABLE <QUEUE I-WEASEL 1>>
	 <ENABLE <QUEUE I-DELIVERY-BOY 1>>
	 <ENABLE <QUEUE I-FOLLOW -1>>
	 <ENABLE <QUEUE I-ATTENTION -1>>
	 <ENABLE <QUEUE I-DISGUSTING-WEASEL-KLUDGE 35>>>

"This routine does the interrupt-driven goal establishment
for the various characters, using the MOVEMENT-GOALS table."

<CONSTANT MG-ROOM 0>
<CONSTANT MG-TIME 1>
<CONSTANT MG-VARIATION 2>
<CONSTANT MG-LENGTH <* 3 2>>
<CONSTANT MG-NEXT 4>

<ROUTINE IMOVEMENT (PERSON INT "AUX" TB VAR DIS TIM ID RM GT)
	 #DECL ((PERSON) OBJECT (TB) <PRIMTYPE VECTOR> (ID VAR DIS TIM) FIX)
	 <SET TB <GET ,MOVEMENT-GOALS <SET ID <GETP .PERSON ,P?CHARACTER>>>>
	 <SET GT <GET ,GOAL-TABLES .ID>>
	 <COND (<NOT <==? 0 <SET RM <GET .TB ,MG-ROOM>>>>
		<COND (<GET .GT ,GOAL-QUEUED>
		       <PUT .GT ,GOAL-QUEUED .RM>)
		      (T
		       <ESTABLISH-GOAL .PERSON .RM>)>)>
	 <COND (<NOT <==? 0 <SET TIM <GET .TB ,MG-TIME>>>>
		<SET VAR <GET .TB ,MG-VARIATION>>
		<SET DIS <RANDOM <* .VAR 2>>>
	        <QUEUE .INT <+ .TIM <- .DIS .VAR>>>
		<PUT ,MOVEMENT-GOALS .ID <REST .TB ,MG-LENGTH>>
		<COND (<NOT <==? 0 <GET .TB ,MG-NEXT>>>
		       <PUT .TB
			    ,MG-NEXT
			    <+ <GET .TB ,MG-NEXT> <- .VAR .DIS>>>)>)>
	 <RFALSE>>

<ROUTINE I-FOLLOW ("AUX" (FLG <>) (CNT 0) GT VAL)
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> ,CHARACTER-MAX>
			<RETURN>)
		       (<AND <GET <SET GT <GET ,GOAL-TABLES .CNT>> ,GOAL-S>
			     <OR <GET .GT ,GOAL-ENABLE>
				 <0? <GET .GT ,ATTENTION>>>>
			<PUT .GT ,GOAL-ENABLE T>
			<COND (<SET VAL
				    <FOLLOW-GOAL <GET ,CHARACTER-TABLE .CNT>>>
			       <COND (<NOT <==? .FLG ,M-FATAL>>
				      <SET FLG .VAL>)>)>)>>
	 .FLG>

<ROUTINE I-ATTENTION ("AUX" (FLG <>) (CNT 0) ATT GT)
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> ,CHARACTER-MAX> <RETURN>)
	       	       (<0? <SET ATT <- <GET
					  <SET GT <GET ,GOAL-TABLES .CNT>>
					  ,ATTENTION> 1>>>
			<PUT .GT ,GOAL-ENABLE T>)
		       ;(<==? <SET ATT <- <GET
					  <SET GT <GET ,GOAL-TABLES .CNT>>
					  ,ATTENTION> 1>> 1>
			<COND (<AND <IN? <GET ,CHARACTER-TABLE .CNT> ,HERE>
				    <NOT ,ASLEEP?>>
			       <START-SENTENCE <GET ,CHARACTER-TABLE .CNT>>
			       <TELL " is acting impatient." CR>
			       <SET FLG T>)>)
		       ;(<==? .ATT 0>
			<PUT .GT ,GOAL-ENABLE T>)>
		 <PUT .GT ,ATTENTION .ATT>>
	 .FLG>

<ROUTINE GRAB-ATTENTION (PERSON "AUX" (CHR<GETP .PERSON ,P?CHARACTER>) GT ATT)
	 #DECL ((PERSON) OBJECT (ATT) FIX)
	 <SET GT <GET ,GOAL-TABLES .CHR>>
	 <COND (<GET .GT ,GOAL-S>
		<PUT .GT ,ATTENTION <SET ATT <GET .GT ,ATTENTION-SPAN>>>
		<COND (<==? .ATT 0>
		       <PUT .GT ,GOAL-ENABLE T>
		       <RFALSE>)
		      (<GET .GT ,GOAL-ENABLE>
		       <PUT .GT ,GOAL-ENABLE <>>)>)>
	 <SETG QCONTEXT .PERSON>
	 <SETG QCONTEXT-ROOM ,HERE>
	 <RTRUE>>

"Movement etc."

;<ROUTINE UNPRIORITIZE (PERSON "AUX" GT)
	 <SET GT <GET ,GOAL-TABLES <GETP .PERSON ,P?CHARACTER>>>
	 <COND (<GET .GT ,GOAL-QUEUED>
		<ESTABLISH-GOAL .PERSON <GET .GT ,GOAL-QUEUED>>
		<PUT .GT ,GOAL-QUEUED <>>)>>

<ROUTINE ESTABLISH-GOAL (PERSON GOAL "OPTIONAL" (PRIORITY <>)
			 	     "AUX" (HERE <LOC .PERSON>) HL GL GT)
	 #DECL ((PERSON GOAL HERE) OBJECT (HL GL) FIX
		(PRIORITY) <OR FALSE ATOM>)
	 ;<COND (<==? .HERE .GOAL>
		<RETURN .HERE>)>
	 <SET GT <GET ,GOAL-TABLES <GETP .PERSON ,P?CHARACTER>>>
	 <COND (.PRIORITY
		<PUT .GT ,GOAL-ENABLE T>
		<PUT .GT ,GOAL-QUEUED .HERE>)>
	 <PUT .GT ,GOAL-I <+ <* <GETP .HERE ,P?LINE> 12>
			     <* <GETP .GOAL ,P?LINE> 2>>>
	 <PUT .GT
	      ,GOAL-S
	      <GETP .GOAL ,P?STATION>
	      ;%<COND (<GASSIGNED? PREDGEN> '<>)
		     (T			  ',<GETP .GOAL ,P?STATION>)>>
	 <PUT .GT ,GOAL-F .GOAL>
	 <LOC .PERSON>>

<ROUTINE GOAL-REACHED (PERSON "AUX" GT)
	 #DECL ((PERSON) OBJECT)
	 <PUT <SET GT <GET ,GOAL-TABLES <GETP .PERSON ,P?CHARACTER>>>
	      ,GOAL-S <>>
	 <APPLY <GET .GT ,GOAL-FUNCTION>
		,G-REACHED>>

<ROUTINE MOVE-PERSON (PERSON WHERE "AUX" DIR GT OL COR PCOR CHR PUSHCART
		      			 (FLG <>) ;DR (VAL <>) DF CD)
	 #DECL ((PERSON WHERE) OBJECT)
	 <SET GT <GET ,GOAL-TABLES <SET CHR <GETP .PERSON ,P?CHARACTER>>>>
	 <SET OL <LOC .PERSON>>
	 <SET DIR <DIR-FROM .OL .WHERE>>
	 <SET PUSHCART ", pushing his cart">
	 ;<COND (<==? <PTSIZE <SET DR <GETPT .OL .DIR>>> ,DEXIT>
		<SET DR <GETB .DR ,DEXITOBJ>>
		<COND (<NOT <FSET? .DR ,OPENBIT>>
		       <FSET .DR ,OPENBIT>
		       ;<COND (<NOT <FSET? .DR ,LOCKED>> <FSET .DR ,OPENBIT>)>)
		      (T <SET DR <>>)>)
	       (T <SET DR <>>)>
	 <COND (<AND <==? .OL ,HERE>
		     <NOT <FSET? .PERSON ,INVISIBLE>>>
		<SET FLG T>
		<START-SENTENCE .PERSON>
		<COND (<==? .DIR ,P?OUT>
		       <TELL " leaves the room">
		       <COND (<==? .PERSON ,DELIVERY-BOY> <TELL .PUSHCART>)>
		       <TELL "." CR>)
		      (<==? .DIR ,P?IN>
		       ;<COND (.DR
			      <TELL " opens the " D .DR " and">)>
		       <TELL " goes into another room">
		       ;<COND (<AND .DR
				   <FSET? .DR ,LOCKED>>
			      ;<FCLEAR .DR ,OPENBIT>
			      <TELL ", locking the door again">)>
		       <TELL "." CR>)
		      (T
		       ;<COND (.DR
			      <TELL " opens the " D .DR " and">)>
		       <TELL " heads ">
		       <COND (<AND <L? <GETP ,HERE ,P?LINE> ,TRAWLER-LINE-C>
				   <NOT <EQUAL? .DIR ,P?UP ,P?DOWN>>>
			      <TELL "off to ">)>
		       <DIR-PRINT .DIR>
		       ;<COND (<AND .DR
				   <FSET? .DR ,LOCKED>>
			      ;<FCLEAR .DR ,OPENBIT>
			      <TELL ", locking the door again">)>
		       <COND (<==? .PERSON ,DELIVERY-BOY> <TELL .PUSHCART>)>
		       <TELL "." CR>)>)
	       (<AND <==? .WHERE ,HERE>
		     <NOT <FSET? .PERSON ,INVISIBLE>>>
		<SET FLG ,M-FATAL>
		<COND (<NOT <==? ,HERE <GET .GT ,GOAL-F>>>
		       <START-SENTENCE .PERSON>
		       <TELL " walks ">
		       <COND (<AND <VERB? WALK>
				   <==? .WHERE ,HERE>
				   <==? .OL ,LAST-PLAYER-LOC>>
			      <TELL "along with">)
			     (T <TELL "past">)>
		       <TELL " you">
		       <COND (<==? .PERSON ,DELIVERY-BOY> <TELL .PUSHCART>)>
		       <TELL "." CR>)>)
	       (<AND <SET COR <GETP ,HERE ,P?CORRIDOR>>
		     <NOT <FSET? .PERSON ,INVISIBLE>>>
		<COND (<AND <SET PCOR <GETP .OL ,P?CORRIDOR>>
			    <NOT <==? <BAND .COR .PCOR> 0>>>
		       <SET FLG T>
		       <COND (<NOT <GETP .WHERE ,P?CORRIDOR>>
			      <START-SENTENCE .PERSON>
			      <TELL ", off to ">
			      <DIR-PRINT <COR-DIR ,HERE .OL>>
			      <TELL ",">
			      ;<COND (.DR
				     <TELL " opens a door and">)>
			      <TELL " leaves your view">
			      <TELL " to ">
			      <DIR-PRINT <DIR-FROM .OL .WHERE>>
			      ;<COND (<AND .DR
					  <FSET? .DR ,LOCKED>>
				     ;<FCLEAR .DR ,OPENBIT>
				     <TELL ", locking the door again">)>
			      <COND (<==? .PERSON ,DELIVERY-BOY>
				     <TELL .PUSHCART>)>
			      <TELL "." CR>)
			     (<0? <BAND .COR <GETP .WHERE ,P?CORRIDOR>>>
			      <START-SENTENCE .PERSON>
			      <TELL ", off to ">
			      <DIR-PRINT <COR-DIR ,HERE .OL>>
			      <TELL ", disappears from sight to ">
			      <DIR-PRINT <SET PCOR <DIR-FROM .OL .WHERE>>>
			      <COND (<==? .PERSON ,DELIVERY-BOY>
				     <TELL .PUSHCART>)>
			      <TELL "." CR>)
			     (T
			      <START-SENTENCE .PERSON>
			      <TELL " is to ">
			      <DIR-PRINT <SET CD <COR-DIR ,HERE .WHERE>>>
			      <TELL ", heading ">
			      <COND (<==? .CD <SET DF <DIR-FROM .OL .WHERE>>>
				     <TELL "away from you">)
				    (T
				     <TELL "toward ">
			      	     <DIR-PRINT .DF>)>
			      <COND (<==? .PERSON ,DELIVERY-BOY>
				     <TELL .PUSHCART>)>
			      <TELL "." CR>)>)
		      (<AND <SET PCOR <GETP .WHERE ,P?CORRIDOR>>
			    <NOT <==? <BAND .COR .PCOR> 0>>>
		       <SET FLG T>
		       <TELL "To ">
		       <DIR-PRINT <COR-DIR ,HERE .WHERE>>
		       <TELL " ">
		       <THE? .PERSON>
		       <TELL D .PERSON " comes into view from ">
		       <DIR-PRINT <DIR-FROM .WHERE .OL>>
		       <COND (<==? .PERSON ,DELIVERY-BOY> <TELL .PUSHCART>)>
		       <TELL "." CR>)>)>
	 ;<WHERE-UPDATE .PERSON .FLG>
	 <MOVE .PERSON .WHERE>
	 <COND (<==? <GET .GT ,GOAL-F> .WHERE>
		<COND (<AND <NOT <SET VAL <GOAL-REACHED .PERSON>>>
			    <==? ,HERE .WHERE>
			    <NOT <FSET? .PERSON ,INVISIBLE>>>
		       <SET FLG ,M-FATAL>
		       <START-SENTENCE .PERSON>
		       <TELL " stops here." CR>)>)
	       (T <APPLY <GET .GT ,GOAL-FUNCTION> ,G-ENROUTE>)>
	;<COND (,DEBUG
	       <TELL "[">
	       <START-SENTENCE .PERSON>
	       <TELL " just went into ">
	       <THE? .WHERE>
	       <TELL D .WHERE ".]" CR>)>
	 <COND (<==? .VAL ,M-FATAL> .VAL)
	       (T .FLG)>>

<ROUTINE DIR-FROM (HERE THERE "AUX" (V <>) (P 0) L Z O)
	 #DECL ((HERE THERE O) OBJECT (P L) FIX)
 <REPEAT ()
	 <COND (<0? <SET P <NEXTP .HERE .P>>>
		<RETURN .V>)
	       (<EQUAL? .P ,P?IN ,P?OUT> T)
	       (<NOT <L? .P ,LOW-DIRECTION>>
		<SET Z <GETPT .HERE .P>>
		<SET L <PTSIZE .Z>>
		<COND (<AND <EQUAL? .L ,DEXIT ,UEXIT ,CEXIT>
			    <==? <GETB .Z ,REXIT> .THERE>>
		       <COND (<EQUAL? .P ,P?UP ,P?DOWN>
			      <SET V .P>)
			     (T <RETURN .P>)>)
		      (<AND <NOT .V>
			    <EQUAL? .L ,FEXIT>>
		       <SET V .P>)>)>>>

;<ROUTINE WHERE-UPDATE (PERSON "OPTIONAL" (FLG <>) "AUX" WT NC (CNT 0))
	 <SET NC <GETP .PERSON ,P?CHARACTER>>
	 <SET WT <GET ,WHERE-TABLES .NC>>
	 <REPEAT ()
		 <COND (<G? .CNT ,CHARACTER-MAX> <RETURN>)
		       (<==? .CNT .NC>)
		       (<OR <AND <0? .CNT> .FLG>
			    <IN? <GET ,CHARACTER-TABLE .CNT> <LOC .PERSON>>>
			<PUT .WT .CNT ,PRESENT-TIME>
			<PUT <GET ,WHERE-TABLES .CNT> .NC ,PRESENT-TIME>)>
		 <SET CNT <+ .CNT 1>>>>

;<GLOBAL WHERE-TABLES
        <TABLE <TABLE 0 0 0 0 0>
	       <TABLE 0 0 0 0 0>
	       <TABLE 0 0 0 0 0>
	       <TABLE 0 0 0 0 0>
	       <TABLE 0 0 0 0 0>>>