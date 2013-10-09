class DrUtils extends Object;

const MAXROT = 32768;
const DEFAULT_CAM_HEIGHT = 700;

/* Returns the base attached to the room on which the Actor is attached to */
static function Actor GetRoomBase( Actor Act )
{
	local Actor Res;

	Res = Act;
	while ( Res != none && DrSectionRoom( Res ) == none ) {
		Res = Res.Base;
	}

    if ( Res == none ) {
        `log ( "Actor " @ Act @ " is not connected to a room " );
    }

	return Res;
}

static function Actor GetBaseSection( Actor Act )
{
    local Actor Res;

	Res = Act;
	while ( Res != none && DrSection( Res ) == none ) {
		Res = Res.Base;
	}

    if ( Res == none ) {
        `log ( "Actor " @ Act @ " is not connected to a section " );
    }

	return Res;
}
DefaultProperties
{
}
