/**
 * @author LEMAXHO
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package xvm.hangar.components.Crew
{
    import flash.display.*;
    import flash.events.MouseEvent;
    import net.wg.data.components.*;
    import net.wg.gui.events.ContextMenuEvent;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.gui.lobby.hangar.crew.*;
    import net.wg.utils.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.data.VO.SeparateItem;
    import com.xvm.*;
    import com.xvm.utils.*;
    import com.xvm.l10n.Locale;

    public class CrewLoader extends Sprite
    {
        private static var _instance:CrewLoader = null;
        private static function get instance():CrewLoader
        {
            if (_instance == null)
                _instance = new CrewLoader();
            return _instance;
        }

        public static function init(page:Hangar):void
        {
            instance.page = page;
            page.crew.addEventListener(MouseEvent.CLICK, instance.handleMouseRelease, false, 0, true);
        }

        // PRIVATE

        private var page:Hangar;

        function CrewLoader():void
        {
            page = null;
        }

        private function handleMouseRelease(e:MouseEvent):void
        {
return;
            var item:CrewItemRenderer = e.target as CrewItemRenderer;
            if (item == null)
                return;
            var renderer:RecruitRendererVO = RecruitRendererVO(item.data);

            if (App.utils.commons.isRightButton(e))
            {
                if (!renderer.tankmanID && item.enabled)
                {
                    App.contextMenuMgr.show(Vector.<IContextItem>([
                        new ContextItem("PutOwnCrew", Locale.get("PutOwnCrew")),
                        new SeparateItem(),
                        new ContextItem("PutBestCrew", Locale.get("PutBestCrew")),
                        new SeparateItem(),
                        new ContextItem("PutClassCrew", Locale.get("PutClassCrew"))]),
                        this, this.onContextMenuAction);
                }
            }
        }

/*        function setTankmenImpl(data)
        {
            base.setTankmen(data);
            //com.xvm.Logger.addObject(wrapper.list, "list", 2);
            CrewLoader.s_defaultCrew = wrapper.list._dataProvider; // save the crewlist
        }*/

        private function onContextMenuAction(e:ContextMenuEvent):void
        {
            try
            {
                var tankmans:Vector.<Object> = new Vector.<Object>();
                switch (e.id)
                {
                    case "PutOwnCrew":
                        tankmans = GetCrew(CheckOwn);
                        break;

                    case "PutBestCrew":
                        tankmans = GetCrew(CheckBest);
                        break;

                    case "PutClassCrew":
                        tankmans = GetCrew(CheckClass);
                        break;
                }

                //Logger.addObject(tankmans);
                for each (var tankman:Object in tankmans)
                    page.crew.equipTankman(tankman.id, tankman.slot);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function GetCrew(checkFunc:Function):Vector.<Object>
        {
            //var tnkObj:Object = s_defaultCrew[0];
            var tankmans:Vector.<Object> = new Vector.<Object>();

            //Logger.addObject(page.crew.list.dataProvider, "data", 2);
            for each (var renderer:RecruitRendererVO in page.crew.list.dataProvider)
            {
                if (renderer.inTank == true)
                    continue;
                var slot:int = renderer.slot;

                var best:Object = null;
                for (var i:int = 1; i < renderer.recruitList.length; ++i)
                {
                    var tankman:Object = renderer.recruitList[i];
                    if (tankman.inTank == true || tankmans.indexOf(tankman.tankmanID) >= 0)
                        continue;
                    //if (!checkFunc(tankman, best, renderer.recruitList[0]))
                        continue;
                    best = tankman;
                }
                if (best != null)
                    tankmans.push( { id:best.tankmanID, slot:slot } );
            }
            return tankmans;
        }

        private function CheckOwn(tankman:Object, best:Object, slot:Object):Boolean
        {
            if (tankman.vehicleType != slot.vehicleType)
                return false;
            return CheckBest(tankman, best, slot);
        }

        private function CheckClass(tankman:Object, best:Object, slot:Object):Boolean
        {
            if (tankman.tankType != slot.tankType)
                return false;
            return CheckBest(tankman, best, slot);
        }

        private function CheckBest(tankman:Object, best:Object, slot:Object):Boolean
        {
            // No bestTankman : select first tankman met
            //if (best == null)
                return true;

            //var current:Number = getPenality(actualTankman, theTank);
            //var best:Number = getPenality(bestTankman, theTank);
//
            // CASE 1 : bestTankman is better than actual
            // conserve the bestTankman
            //if (best > current)
                //return false;
//
            // CASE 3 : actual tankman is better than bestTankman
            // select the actualTankman
            //if (best < current)
                //return true;
//
            // CASE 2 : bestTankman's capacity is equal with the actualTankman's skill
            // Need deeper analysis
//
            //CASE 2.1 : bestTankman has more skills than actualTankman
            //conserve the bestTankman
            //if (bestTankman["skills"].length > actualTankman["skills"].length)
                //return false;
//
            //CASE 2.2 : bestTankman has less skills than actualTankman
            //select the actualTankman
            //if (bestTankman["skills"].length < actualTankman["skills"].length)
                //return true;
//
            //CASE 2.3 : bestTankman has the same number of skills that the actualTankman
            //if the bestTankman's lastskilllevel is < that actualTankman's
            //select the actualTankman
            //if (bestTankman["lastSkillLevel"] < actualTankman["lastSkillLevel"])
                //return true;
//
            //return false;
        }

        /**
         * skill tankman penality
         * @param aTankman
         * @param dummyTankman current tank's
         * @return Tankman's efficiencyLevel - penality
         */
        private function getPenality(tankman:Object, dummyTankman:Object):Number
        {
            var res:Number = 1;

            if (tankman["vehicleType"] != dummyTankman["curVehicleName"])
            {
                if (tankman["tankType"] == dummyTankman["curVehicleType"])
                {
                    // 25% penalty same tanktype but tank is different
                    res = (dummyTankman["vehicleElite"] == true) ? 1 : 0.75;
                }
                else
                {
                    // 50% penalty different tanktype
                    res = 0.5;
                }
            }
            return tankman["efficiencyLevel"] * res;
        }

        private function TankmanInArray(list:Array, elem:Object):Boolean
        {
            for (var i:int = 0; i < list.length; ++i)
            {
                if (list[i]["tankmanID"] == elem["tankmanID"])
                    return true;
            }
            return false;
        }
    }
}
