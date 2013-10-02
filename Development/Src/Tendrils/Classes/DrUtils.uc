class DrUtils extends Object;

const MAXROT = 32768;
const DEFAULT_CAM_HEIGHT = 700;

static function Actor GetRootBase( Actor Act )
{
	local Actor Res;

	Res = Act;
	while ( Res != none && Res.Base != none ) {
		Res = Res.Base;
	}

	return Res;
}
DefaultProperties
{
}
