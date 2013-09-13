/**
 * XVM - lobby
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package xvm.hangar
{
	import com.xvm.*;
	import net.wg.gui.prebattle.squad.SquadWindow;
	import net.wg.infrastructure.events.*;
	import net.wg.infrastructure.interfaces.*;
    import xvm.UI.squadWindow.UI_SquadItemRenderer;
	
	public class SquadWindow extends XvmModBase
	{
		public function SquadWindow(view:IView)
		{
			super(view);
		}
		
		public function get page():net.wg.gui.prebattle.squad.SquadWindow
		{
			return super.view as net.wg.gui.prebattle.squad.SquadWindow;
		}
		
		public override function onAfterPopulate(e:LifeCycleEvent):void
		{
			try
			{
				page.memberList.itemRenderer = UI_SquadItemRenderer;
					//Logger.addObject(page.memberList, "squad memberList", 5);
			}
			catch (ex:Error)
			{
				Logger.add(ex.getStackTrace());
			}
		}
	}

}
