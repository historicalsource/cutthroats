@MAKE [TEXT]
@STYLE [SPACING 2,JUSTIFICATION NO]
@TITLE [TOA2 Design Notes]
@TabSet [4,8,12,16,20]
@pageheading [draft]
@MAJORHEADING [** Fourth Design 10/20/83 **]

@section [Introduction]

The game will be TIME oriented. The story takes advantage of the clock, with
characters saying something like "Meet me at the Red Boar Inn at 7:15.
Don't be late or we'll leave you behind."  The MC will have a watch
which is what will be displayed on the status line.  A nice side-effect should
be the ability to "synchonize watches".  One of the characters will
suggest it, and the MC will the get to RESET WATCH TO HH:MM.  The status
line would be updated accordingly.  The story cannot operate off of
@u(this) clock -- it must have its own internal clock as well as the
clock displayed on the status line.  Night and day, hunger and thirst,
other characters' movements, etc., can be done independently of what the
MC's watch (STATUS LINE) says.

The brief description of the story is as follows:  The MC has a
reputation for being a "square-shooter" and "great diver (like Mike
Nelson)" and is roped into a plot to salvage a sunken pirate ship off
the coast.  Successfully doing so will mean the player wins.

There will be a number of wrecks (up to 7, all of which would be coded
as table entries), though only one of which contains the treasure for
that particular game.  This method of determining which wreck is worth
investigating, and then determing what equipment will be needed, will be
described later, and comprises a large portion of the player's
early experience.  The computer should generate the ship to be explored at
random, giving replay value.  The actual sunken ship will be a series of
interconnected rooms, with LDESCS being supplied by offsetting into a
table of LDESCS.

@section [Settings]

@Subsection [Seaport Island]
The game starts on the Seaport Island, and the first goal of the player
should be getting off the island with the tools and information he needs
to successfully excavate one of the wrecks.

@begin [enumerate]

The Red Boar Inn -- This is where the MC lives.  He has a small but
nicely furnished room which he rents by the month.  The room overlooks
the port and has marine charts, manuals on diving, etc.  All of his
personal belongings are here.  This location is actually 3 rooms -- the
entrance/downstairs; the upstairs hallway; and the MC's bedroom.

The Shanty -- The Shanty is a local pub/tavern where sailors and
adventurers like to hang about.  There are tables and a bar, and they
owner/bartender serves both food and drink.  The MC is well known to all
of the locals who hang about.  It's a dark but firendly place, with
parrots walking along the bar, insulting customers.  One of the parrots
wears an eyepatch.

Outfitters, Int'l -- This place is a store which has all the naval
stores necessary for a successful expedition.  The owner knows the MC.
The MC will be responsible for purchasing all the supplies necessary for
the expedition.  Stores purchased will depend upon the type of
expedition selected by the computer.

Warehouse -- The warehouse is normally locked, and houses some of the
equipment for Outfitters Int'l.  The MC has no access to this building
by normal means.

Wharf -- The wharf area is near The Shanty and Outfitters, Int'l.  There
are several boats and docks, but is not a good place to go walking about
in the evening.

McGinty Salvage -- A growing concern whose primary function is to
salvage old wrecks.  The MC and his compatriots will go into competition
with them.

Roads --
@begin [enumerate]

The Wharf Road runs along the northern edge of the island and gives
access to the wharf and docks.

The Ocean Road runs along the eastern edge of the island.  To the far
southeast corner is Point Lookout, a small but high cliff giving a far
and wide view of the sea.

The Shore Road goes along the southern edge of the island and ends at
the ferry boat landing.  It is here that all visitors arrive and leave.

The Winding Road travels along the north and heads west, ending at a
lighthouse.  Its southern edge is bordered by impenatrable swamp/marsh.

@end [enumerate]

Ocean -- This is technically a room, though it is there only as a
border.

Marsh -- A multi-room, like the ocean, from which there is no escape.
Many rooms enter, but there are no exits.

Field -- Behind the shops and buildings, west of the Ocean Road, is a
large, innocuous field, not worth entering, refered to only in
description.

Ships -- There are two ships, each of which has a different capability,
each of which will be described later.

Mariners' Trust -- A bank, located on the south shore of the Island,
which contains all of the MC's life savings.

@end [enumerate]

@subsection [The Seagoing Vessels]

There are two vessels from which the player may choose.

@begin [enumerate]

The Night Wind (THE TRAWLER) -- The trawler is a sturdy fishing boat,
designed to weather high seas.  It is a sturdy, steady, and rather fast
boat, though not really designed to do deep-sea salvaging.

The Mary Margaret (SALVAGE VESSEL) -- This boat is well outfitted, and a
very seaworthy salvage boat.  The problems it presents is that it is
expensive, and it is slow on the water.  It is also most frequently used
by McGinty, and so not always available.  It is owned by Outfitters
Int'l.

@end [enumerate]

Each ship will have three upper sections -- forward, midships, and aft
-- while below decks there should be cabins, a galley, pantry, head,
etc.

The Night Wind should be used on those wrecks at greater than N fathoms. 
Otherwise, the Trawler should do.  The information relating to each
ship's capabilities will be included in the game package.

One of the ships should have an air compressor, the kind usually used in
filling scuba tanks.

@subsection [Sunken Ships]

The actual number of sunken ships needs to be determined, and will be a
function of the rest of the design.  The wreck itself can be 20 or so
rooms.  If there are 7 wrecks, that would mean that 7 X 20 = 140 LDESCS
in a total of 20 tables for descriptions.  All exit information would be
the same.  I humbly suggest intially building the code to handle any
number of wrecks, with the starting implementation handling 3.

As the player is walking about through the murky waters, he can enter
the hull and find his way up and down ladders, in and through
passageways, etc.  Potential dangers here would be sharks, having his
lifeline of his air hose cut by a falling timber, a slamming trapdoor,
etc.  His pressurized suit could be torn on a nail.  He will have to
successfully deduce what the metal detector he finds on board does, and
how to use it. (See OBJECTS)  By using the detector properly, he will be
able to locate the chest within the wreck.

The information on where the ships are located, at what depth, and a
chart of what the vessel may have originally been carrying will be
provided in the game package.

@section [Characters]

MC, the main character/player will not be fully drawn here.  This
section deals with all secondary characters -- their personalities,
motivations, physical characteristics and goals.

@subsection [McGinty]

McGinty is the owner of McGinty Salvage.  He is a small, nervous man,
thin and always on the move.  He is balding, with thin strings of black
hair swept across his scalp.  His lips are large and pouting, and
invariably clamped around cigars which seem too large for his face.  He
has a hooked nose that, when viewed head-on, almost seems to diasppear
it is so thin.

He abhors physical violence, being easily out-muscled.  If there's a
deal around, McGinty either knows about it already or is soon to find
out.  There isn't a deal on the Island he doesn't have something to do
with.  Business is his life, and making money is all he cares about.  He
would be a retired, wealthy man if it weren't for his fear of other
people.  This fear manifests itself as mistrust and apprehension --
partly as a result of his diminutive stature.

He hears of the deal which our MC will cut with the others and tries to
weasel his way in.  He may succeed in doing so if the Salvager is
needed, since that boat belongs to his company.  He is not to be
trusted, though, as his primary loyalty is to himself and then to money.

@subsection [Pete the Rat]

Pete the rat wears an eye patch and got his name from one of the long,
far-east voyages he shipped out on.  It seems that food was running low
and, as the ship's cook, he did what he had to to supply the crew with
fresh meat.  Needless to say, when the crew found out, they insisted he
be left at the nearest port, which the Captain was happy to do.

Pete the Rat is well-intentioned, though not the brightest of sailors. 
He is well-experienced in the ways of the sea.  He talks slowly, as if
trying to remember the words one at a time, dredging them up from his
long term memory in a painful series of associations.

He's had some trouble getting another berth in which he functions as a
cook, but our MC should not fear him.  The mistakes Pete made in the
past were simply that -- mistakes from which he has learned.  Pete is
tall and lanky, moves slowly at a shuffling gait, wears black
turtlenecks and jeans even in the dead heat of summer.  The reason for
his dress code is simple: they are the only clothes he owns.  If you
plan to stand next to him, be sure you are not downwind.

@subsection [The Weasel]

The Weasel is a short, wirey guy with darting eyes and thin lips.  He
rarely talks, except to nod his head and say "Got it, chief."  He takes
orders and will do anything -- @u(anything) -- for money.  Whoever pays
him, owns him.

He aspires to little more in life than to survive and retire to the Old
Mariners' Home in Secaucus, N.J.  He isn't the brightest creature on the
planet, but he is quick to pick up new ideas and mesh them with his
slightly-twisted view of how the Universe works.  He picks his teeth
with a knife, and God only knows where that knife has been.

The Weasel has a tatoo on his upper arm which says "Mother?" leading
everyone to wonder whether he really ever had one.

@subsection [Johnny Red]

Johnny Red, whose real name is unknown to everyone on the Island, has
crewed for just about every Captain who sailed the seas.  His name was
derived from his flame-red hair and beard, both of which he has in
enough quantity to make several dozen toupes.  He wears flannel shirts,
with the top several buttons unbuttoned to expose a mat-like carpet of
curly red hair on his chest.  With his shirt sleeves rolled up, he looks
like something you left in your refrigerator for 30 weeks growing red
hair-mold.

Johnny has a barrel chest and weighs in at 300 even.  To say he was
large would be to say a sequoia is just another tree.  He is strong,
reliable, and oddly non-violent, though you would never know that
looking at him.

@section [Play]

What follows are some sample scenarios/plots based on best win, followed
by complications, problems and puzzles.

@subsection [The Best Plot]

The story starts with the MC in his room.  There is a note which has
been slipped under his door, inviting him to meet with the secondary
characters at The Shanty at a set time.

The MC will be invited to join in on the salvage hunt by the secondary
characters at The Shanty.  He will be shown a small piece of treasure
found by Johnny.

The Weasel shows up between 10 and 15 minutes late to the meeting in the
tavern OR he doesn't show up at all (see Complications -- General). 

If he agrees to throw in his lot with the secondary characters, he will
have to get to Mariners' Trust and withdraw his money from his savings
account.  He will need his passbook to do this, and his passbook is in
his room.  He will have to meet Johnny Red at Point Lookout at a
prearranged time with the money.  Johnny Red, carrying the others'
money, will then accompany the MC to Outfitters Int'l.

Once at Outfitters Int'l, the MC will then purchase the supplies
necessary for a successful salvage expedition.  Red will have the list
from the cook, Pete, and other things which they will need.  The MC
tells the man at Outfitters Int'l to deliver the things to the boat
(whichever one the MC decides would be best for this voyage) and then
returns to The Shanty to meet up with the others.

From here, all of the crew go to the boat.  The course is plotted and
the crew takes care of getting the boat to where it needs to be.  They
drop anchor and set up for the dive.

The MC, the underwater expert, then goes overboard and walks on the
ocean floor to find the wreck.  Once there, he successfully locates the
chest of treasure, hooks it up for hoisting, and returns to the ship. 
The treasure is hauled up and all live happily ever after.

@subsection [Complications -- General]

If the player fails to lock the door into the MC's room after he leaves,
the room can be ransacked.  If the passbook was left inside, it will be
gone, stolen by The Weasel.  This means that The Weasel, normally late
for the meeting at the bar, may not show up at all if he has
successfully stolen the passbook.

@subsection [Complications -- McGinty]

After the initial meeting in The Shanty, Johnny Red tells them all that there
is no good reason to tell anyone else what they are planning, and that
all further discussions should be held in private.  Red suggests the
Lighthouse out on Winding Road.  They agree to meet there one-half hour
from now (or at a specific time).  If anyone is late, they'd better have
a good excuse.

The others leave, letting the MC do what he will for the time he has. 
Part of this time will be in finding the Lighthouse.  Part of the time
will also be eaten up by McGinty, who will demand to know what is going
on, where the MC is off to, who he was talking to, what they were
talking about, etc.  If the MC should let anything slip, then McGinty
will beat them all to the punch, making the entire trip futile.  On
setting out, while at sea, the will see McGinty's ship coming back into
port.  This will also prevent them from using the Salvager.

If he does not satisfy McGinty's questions and sets out directly for the
Lighthouse, McGinty will follow him in the shadows.  Once the MC meets
the secondary characters, McGinty will be seen and The Weasel will stick
a knife between the MC's ribs, calling him a traitor.

@subsection [Complications -- Mariners' Trust]

Without his passbook, the MC will be prevented from getting his money.
His passbook is in his room.  He may have to return there and get the
passbook before the second meeting.  (His passbook, however, may have
been stolen).  He will have the time to do this, but it is something
some players may easily overlook.

There is the potential here for a double-cross (though I'm not sure it's
worthwhile).  The Weasel could be standing outside and attempt to steal
the money from the MC.  This would certainly be in character for The
Weasel, seeing easy and quick money.

McGinty could also be at the bank and decide to follow the MC to he
second meeting.

@subsection [Complications -- Second Metting]

Once the plans have been made at the Lighthouse, the second meeting is
arranged, that to occur at 6:00 pm between the MC and Johnny Red at
Point Lookout.  Both are to have their money.

If the MC does not show up at all, or if he shows up late (with or
without the money) Red's body is found with bullet holes in it,
McGinty's ship is gone, and the police arrest the MC in town.  The gun
was found in his room.

If the MC shows up without the money, Red tells him they will go on
without him and the game ends.

If the MC shows up more than 5 minutes early, McGinty will appear there,
preventing Red from arriving, thus blowing then entire affair, ending in
a lose.

@subsection [Complications -- Outfitting]

Two kinds of complications can occur at Outfitters Int'l:

@begin [enumerate]

Buying the wrong supplies.

Buying the supplies in front of McGinty.

@end [enumerate]

If the MC purchases the wrong supplies, the expedition will utimately
fail.  If the MC continues to purchase supplies after McGinty walks in,
McGinty will get wise and beat them all to the punch.  It will be
necessary for the MC to instruct McGinty to leave or to get Red to
physically remove McGinty.

@subsection [Complications -- The Wrong Boat]

Taking the wrong boat will ultimately lead to a lose.  The exact
methods, reasons and complications are as yet unknown.

@subsection [Puzzles]

There is the "mysterious black-box" problem, where the black-box is
actually a metal detector or some strange origin.  This could be useful
in locating the treasure in the wreck.

@subsection [Objects]

Bed in MC's room.

A note which was slipped under his door.

A door under which the note was slipped.

A Passbook for his savings & loan account.

A Ditty bag (shades of TOA1's knapsack!)

A scuba tank, wet suit, mask and flippers.

Characters:
@begin [enumerate]
McGinty

Johnny Red

Pete the Rat

The Weasel

The Parrot

The bartender/waiter/outfitter/bank teller
@end [enumerate]

A table around which the characters can sit in the bar/tavern.

A chair in which the player can sit.

An envelope of money which the player will get at the bank.

A key to the MC's room.

The Ocean Map will have to be provided with the game package, but should
be included as an object (as the cube was in TOA1) to tell them to look
in their game package.

A wrist watch, which the player should be wearing.  It should be
possible to break the watch, and not breaking the watch should be the
goal in one interaction between the player & the environment.

A strand of red hair.  This will be described as simply a strand of
hair.  If the player picks it up and examines it, it will described as
being red hair.  This strand of hair will appear in a place where Johnny
Red shouldn't have been, but was, thus giving the player a much needed
clue as to what is going on.

Shipboard Objects:
@begin [enumerate]
A Navigational beacon finder black-box frobbie, used to find out where
you are by using LORAN.  This will be aboard only one of the boats.

Bunks

Chart table

Small Machine: The metal detector will be found onboard the Mary
Margaret and will work as follows.  There will be a (label) on the small
machine, though the letters should be so well-worn as to render the
label useless.  There will be an off/on switch and a compartment inside
it for batteries.  By switching it on with a live battery, it will make
a ticking sound when brought near metal.  This will require some objects
to have a METAL bit. Proximity is going to present a bit of a problem.

Label (on the small machine)

Off/On switch (on the small machine)

Batteries (for the small machine)

@end [enumerate]

@section [Package Elements]

@subsection [Tides]
Included in the game package should be a tidal chart, good for the week
of this game.  Since the game play takes about three days, it is
important that the chart give low and high tides.

Sailing without the tidal chart may prove to be disasterous.

@subsection [Ocean Map]
This map should be an ocean "chart" with various depth soundings, marker
bouys, latitude and longitude markings, etc.  It should also indicate
where the various wrecks are located.

@SECTION [Sequence of Events]
What follows is a rough guess as to where everyone is at any specified
time.  When they move from one place to another on their own, it will be
marked with an asterik within parens, like so: (*).

(*) @u(NOTE:  The Ferry Boat leaves the Island every 2nd hour, starting
at 8:00 AM and arrives every second hour starting at 9:00 AM.  Normal
ferry service stops at 6:00 PM.)

@subsection [Day 1: Tuesday, November 7th]
8:00 AM
@begin [enumerate]
Main Character is in bed.  The note has already been slipped under his door.
The note is signed by Johnny Red.

McGinty is in his office in McGinty Salvage.

The others are sitting in The Shanty, having their morning grog.
@end [enumerate]

8:15 AM -- The Weasel's Move
@begin [enumerate]
(*) The Weasel makes for MC's room.  If he is there, he says "Hi, how
'bout comin' down to the Shanty for a talk."  If MC is not there, he
tries to open the door.  If locked, he returns to the Shanty.  If not
locked, he enters the room and searches for the passbook.
@end [enumerate]

8:20 - 8:25 AM
@begin [enumerate]
(*) The Weasel makes for either the Shanty or the Mariner's Trust.
@end [enumerate]

8:30 AM -- Time for the meeting
@begin [enumerate]
If the MC is present...

And if The Weasel is present... The skecthes of a deal is made and
accepted by the MC.  If the the MC shows no interest he dies of old age
in an old sailor's home (<JIGS-UP "">)

A meeting is set up by the lighthouse, where the plans can be discussed
in utmost privacy.  The Shanty is not the place to be discussing private
plans.  They agree to meet at the Lighthouse at 9:30, at which point all
will be made clearer.

If The Weasel is not present... NO MENTION OF A DEAL is made. Johnny
insists on waiting for The Weasel to show.  If The Weasel shows up by
8:45 then after he explains he was ducking McGinty's tail, they shoot
the idea of a deal to the MC.  (If The Weasel doesn't show by 8:45, it can be
assumed he has found the MC's bankbook and is making his way to the
bank.)

If the MC is not present...

(*) They wait until 9:00 for him to show up.  At which point, they go to the
outfitters, get a ship, then sail off.  <JIGS-UP "The ship sailed
without you.">
@end [enumerate]

8:45 AM -- McGinty's trip
@begin [enumerate]
(*) McGinty leaves his office and heads for the Outfitters Intl.  He
needs some supplies for a trip he's planning and so wants to go over a
list he has with the man behind the counter (a spear-carrier at best).
@end [enumerate]

9:00 AM
@begin [enumerate]
(*) All secondary characters leave the bar and head for the lighthouse
one at a time, spacing their exits in three minute intervals.

They leave in the following order:

(*) The weasel

(*) Pete the rat

(*) Johnny Red

(*) McGinty leave Outfitter's Intl and waits outside The Shanty,
checking it out.
@end [enumerate]

9:15 -- McGinty makes a move

@begin [enumerate]
McGinty is hanging around outside The Shanty.  He will wait here until
9:15 at which time he will head back to his office.

IF the MC leaves The Shanty before 9:15 then McGinty will follow him.

(*) 9:16 -- McGinty heads back to his office if MC has not yet left The
Shanty.
@end [enumerate]

9:30 - 9:45 -- The Lighthouse Meeting
@begin [enumerate]
The characters will wait until the MC shows up OR until 9:45, whichever
comes first.  If he shows later than 9:45 he may see them walking along,
heading back to the shanty, the bank, etc. as described in their later
actions.

(*) IF McGinty follows him there, the crowd begins to walk back to The
Shanty, afraid the MC has double-crossed them.

IF the MC arrives before 9:45... All of the characters, with the
exception of McGinty, will be there.  Here, the plan is laid out in
greater detail.  Johnny Red will captain the boat.  The Weasel will be
an all-around deckhand.  Pete the Rat will be the cook.  The MC will be
the diver, since he has the equipment and the experience (see OBJECTS).

A second meeting is set up for 10:45 AM, to take place at Lookout Point.
Johnny Red and the MC are to meet there and then go to Outfitters Int'l
with the money.  All have put in their life savings on this venture, and
the MC is expected to do the same.

Pete the Rat mentions that the tide is in between 4 and 5 PM, and if
they plan to get things in gear, they had better plan on leaving then.

The characters then leave this area one by one, at three minute intervals, in the following order:
@begin [enumerate]
(*) Johnny Red (going to the Outfitters).

(*) Pete the Rat (going to The Shanty).

(*) The Weasel (going to the Shanty).
@end [enumerate]
@end [enumerate]

10:45 -- Second Meeting (Lookout Point)
@begin [enumerate]
Johnny Red will wait here until 11:00 AM.

(*) IF the MC does not show by 11:00... Johnny Red will go back to The
Shanty and a <JIGS-UP "The ship sailed without you"> will occur.

(*) IF the MC shows up before 11:00... AND IF he has the money, they
will both walk to Outfitter's Int'l. (Actually, Johnny Red, after seeing
the MC's green, will walk to the Outfitters, expecting the MC to walk
along with him.  It is the MC's decision as to whether or not to
accompany Johnny Red.)

(*) IF the MC shows up before 11:00... AND IF he DOES NOT have the
money, Johnny Red will be forced to push the MC off the cliff to silence
him. <JIGS-UP>.
@END [ENUMERATE]

11:10 - 11:45 (or so) -- At the Outfitters...

We can assume, at this point, that the meeting at the Lookout Point took
place between the MC and Johnny.

@begin [enumerate]
The MC and Johnny Red buy provisions for their trip and rent one of the
seagoing vessels.  (Deciding which boat to rent will be placed on the
shoulders of the MC.)  Johnny will hang around for awhile, telling the
ship's store what he needs in the way of provisions.

(*) Johnny will leave the store at between 11:45 and Noon.  He is
heading for luncheon at (you guessed it) The Shanty.
@end [enumerate]

MC NOTE: The MC will be expected to get his equipment to the proper dock
before 4:00, so it can be loaded aboard the proper vessel.  The other
characters will not wait for him, and there is a high probability that if he
leaves his things unattended, they will be stolen.

3:10 - 3:30 -- The Weasel Attempts Another Nasty...
@begin [enumerate]
(*) From wherever The Wease is now, at 3:10, he starts down to the dock
where they will be sailing from.  His arrival there will be anywhere
around 3:15 to 3:30.  This will enable him to check out the docks for
anything which is purloinable.

(*) IF he finds something worth stealing (eg: MC's possessions)... The
Wease takes what he can handle, assuming no one else is around, and
makes his way up to the Outfitters to pawn it.

(*) IF the MC asks him to keep an eye on his things... The wease still
steals what he can and hocks it.  He then goes to the Ferry Landing to
get the hell out of there.  (The Wease is not the brightest nor is he
the most relizble of creatures known to modern man, ergo, his actions
are within character.)
@END [ENUMERATE]