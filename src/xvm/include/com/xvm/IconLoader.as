import net.wargaming.controls.UILoaderAlt;
import com.xvm.Utils;
/**
 * ...
 * @author Maxim Schedriviy
 */
intrinsic class com.xvm.IconLoader
{
	static private var s_failIcons : Array;
	private var m_owner : Object;
	private var m_completeFunc : Function;
	private var m_iconLoader : UILoaderAlt;
	private var m_altIcons : Array;
	private var m_currentIndex : Number;

	public function get currentIcon() : String;


	public function IconLoader(owner:Object, completeFunc:Function);

	public function init(iconLoader:UILoaderAlt, altIcons:Array, useNoImage);

	private function errorLoad(event);

	private function completeLoad(event);

}