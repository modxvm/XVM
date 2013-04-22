import net.wargaming.controls.UILoaderAlt;
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.IconLoader;
/**
 * ...
 * @author sirmax2
 */
intrinsic class com.xvm.PlayerInfo extends MovieClip
{
	static private var s_playersIconSources : Object;
	static private var _instance : Object;

	static public function get instance() : Object;


	static public function createIcon(owner:MovieClip, cfg:Object, dx:Number, dy:Number, team:Number) : UILoaderAlt;

	static public function setSource(icon:UILoaderAlt, nick:String, clan:String);

	public function completeLoadIcon(event);

}