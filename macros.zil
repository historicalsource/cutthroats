"MACROS for
			      TOA #2
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved.
"

<COND (<NOT <GASSIGNED? ZSTR-ON>>
       <SETG ZSTR-ON <SETG ZSTR-OFF ,TIME>>)>

<SETG C-ENABLED? 0>
;<SETG C-ENABLED 1>
;<SETG C-DISABLED 0>

<DEFMAC TELL ("ARGS" A)
	<FORM PROG ()
	      !<MAPF ,LIST
		     <FUNCTION ("AUX" E P O)
			  <COND (<EMPTY? .A> <MAPSTOP>)
				(<SET E <NTH .A 1>>
				 <SET A <REST .A>>)>
			  <COND (<TYPE? .E ATOM>
				 <COND (<OR <=? <SET P <SPNAME .E>>
						"CRLF">
					    <=? .P "CR">>
					<MAPRET '<CRLF>>)
				       (<=? .P "PRSO">
					<MAPRET '<PRSO-PRINT>>)
				       (<=? .P "PRSI">
					<MAPRET '<PRSI-PRINT>>)
				       ;(<=? .P "THE-PRSO">
					<MAPRET '<THE-PRSO-PRINT>>)
				       ;(<=? .P "THE-PRSI">
					<MAPRET '<THE-PRSI-PRINT>>)
				       (<EMPTY? .A>
					<ERROR INDICATOR-AT-END? .E>)
				       (ELSE
					<SET O <NTH .A 1>>
					<SET A <REST .A>>
					<COND (<OR <=? <SET P <SPNAME .E>>
						       "DESC">
						   <=? .P "D">
						   <=? .P "OBJ">
						   <=? .P "O">>
					       <MAPRET <FORM DPRINT .O>>)
					      (<OR <=? .P "A">
						   <=? .P "AN">>
					       <MAPRET <FORM APRINT .O>>)
					      (<OR <=? .P "NUM">
						   <=? .P "N">>
					       <MAPRET <FORM PRINTN .O>>)
					      (<OR <=? .P "CHAR">
						   <=? .P "CHR">
						   <=? .P "C">>
					       <MAPRET <FORM PRINTC .O>>)
					      (ELSE
					       <MAPRET
						 <FORM PRINT
						       <FORM GETP .O .E>>>)>)>)
				(<TYPE? .E STRING ZSTRING>
				 <MAPRET <FORM PRINTI .E>>)
				(<TYPE? .E FORM LVAL GVAL>
				 <MAPRET <FORM PRINT .E>>)
				(<TYPE? .E FIX>
				 <MAPRET <FORM PRINTX .E>>)
				(ELSE <ERROR UNKNOWN-TYPE .E>)>>>>>

<DEFMAC VERB? ("ARGS" ATMS)
	<MULTIFROB PRSA .ATMS>>

<DEFMAC PRSO? ("ARGS" ATMS)
	<MULTIFROB PRSO .ATMS>>

<DEFMAC PRSI? ("ARGS" ATMS)
	<MULTIFROB PRSI .ATMS>>

<DEFMAC ROOM? ("ARGS" ATMS)
	<MULTIFROB HERE .ATMS>>

<ZSTR-OFF>

<DEFINE MULTIFROB (X ATMS "AUX" (OO (OR)) (O .OO) (L ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .OO 1> <ERROR .X>)
				       (<LENGTH? .OO 2> <NTH .OO 2>)
				       (ELSE <CHTYPE .OO FORM>)>>)>
		<REPEAT ()
			<COND (<EMPTY? .ATMS> <RETURN!->)>
			<SET ATM <NTH .ATMS 1>>
			<SET L
			     (<COND (<TYPE? .ATM ATOM>
				     <FORM GVAL
					   <COND (<==? .X PRSA>
						  <PARSE
						    <STRING "V?"
							    <SPNAME .ATM>>>)
						 (ELSE .ATM)>>)
				    (ELSE .ATM)>
			      !.L)>
			<SET ATMS <REST .ATMS>>
			<COND (<==? <LENGTH .L> 3> <RETURN!->)>>
		<SET O <REST <PUTREST .O (<FORM EQUAL? <FORM GVAL .X> !.L>)>>>
		<SET L ()>>>

<ZSTR-ON>

<DEFMAC RFATAL ()
	'<PROG () <PUSH 2> <RSTACK>>>

<DEFMAC PROB ('BASE?)
	<FORM G? .BASE? '<RANDOM 100>>>

;<ROUTINE ZPROB
	 (BASE)
	 <COND (,LUCKY <G? .BASE <RANDOM 100>>)
	       (ELSE <G? .BASE <RANDOM 300>>)>>

<ROUTINE PICK-ONE (FROB)
	 <GET .FROB <RANDOM <GET .FROB 0>>>>

<DEFMAC ENABLE ('INT) <FORM PUT .INT ,C-ENABLED? 1>>

<DEFMAC DISABLE ('INT) <FORM PUT .INT ,C-ENABLED? 0>>

<DEFMAC OPENABLE? ('OBJ)
	<FORM OR <FORM FSET? .OBJ ',DOORBIT>
	         <FORM FSET? .OBJ ',CONTBIT>>> 

;<ROUTINE ABS (NUM)
	 <COND (<G? .NUM 0>
		<RETURN .NUM>)
	       (ELSE
		<RETURN <- 0 .NUM>>)>>

<ROUTINE DPRINT (OBJ)
	 <COND (<GETP .OBJ ,P?SDESC>
		<TELL <GETP .OBJ ,P?SDESC>>)
	       (T <PRINTD .OBJ>)>>

<ROUTINE APRINT (OBJ)
	<COND (<OR <FSET? .OBJ ,PERSON>
		   <==? .OBJ ,PETES-PATCH>>
	       <TELL D .OBJ>)
	      (<FSET? .OBJ ,VOWELBIT> <TELL "an " D .OBJ>)
	      (T <TELL "a " D .OBJ>)>>

