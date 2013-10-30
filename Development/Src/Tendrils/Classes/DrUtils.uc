class DrUtils extends Object;

const MAXROT = 32768;
const DEFAULT_CAM_HEIGHT = 700;

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
