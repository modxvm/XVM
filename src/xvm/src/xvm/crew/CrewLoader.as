/**
 * @author LEMAXHO
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 * @author Pavel Máca
 */
package xvm.crew
{
    import com.xvm.*;
    import com.xvm.utils.*;
    import flash.display.*;
    import flash.events.MouseEvent;
    import flash.utils.*;
    import net.wg.data.components.*;
    import net.wg.data.VO.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.gui.lobby.hangar.crew.*;
    import net.wg.infrastructure.interfaces.*;

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
                        new ContextItem("PutClassCrew", Locale.get("PutClassCrew"))
                    ]), this, this.onContextMenuAction);
                }
            }
        }

        private function onContextMenuAction(e:ContextMenuEvent):void
        {
            try
            {
                switch (e.id)
                {
                    case "PutOwnCrew":
                        GetCrew(CheckOwn);
                        break;

                    case "PutBestCrew":
                        GetCrew(CheckBest);
                        break;

                    case "PutClassCrew":
                        GetCrew(CheckClass);
                        break;
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function GetCrew(checkFunc:Function):void
        {
            /** tankmanId: { tankman:Object, slot:Number } */
            var selectedTankmans:Dictionary = new Dictionary();

            for each (var renderer:RecruitRendererVO in page.crew.list.dataProvider)
            {
                if (renderer.inTank == true)
                    continue;

                    var best:Object = null;
                    for (var i:int = 1; i < renderer.recruitList.length; i++)
                    {
                        var tankman:Object = renderer.recruitList[i];

                        // already in tank or selected for other slot
                        if (tankman.inTank == true || selectedTankmans.hasOwnProperty(tankman.tankmanID))
                            continue;

                        // first tankman in RecruitRendererVO.recruitList contain tank info
                        if (checkFunc(tankman, best, renderer.recruitList[0], renderer.vehicleElite))
                        {
                            //Logger.addObject(best, "crew: old best");
                            //Logger.addObject(tankman, "crew: new best");
                            best = tankman;
                        }
                    }
                    if (best != null)
                    {
                        selectedTankmans[best.tankmanID] = {tankman: best, slot: renderer.slot};
                    }
            }

            for each (var obj:Object in selectedTankmans)
                page.crew.equipTankman(obj.tankman.tankmanID, obj.slot);
        }

        private function CheckOwn(tankman:Object, best:Object, slot:Object, isPremVehicle:Boolean):Boolean
        {
            if (tankman.vehicleType != slot.vehicleType)
                return false;
            return CheckBest(tankman, best, slot, isPremVehicle);
        }

        private function CheckClass(tankman:Object, best:Object, slot:Object, isPremVehicle:Boolean):Boolean
        {
            if (tankman.tankType != slot.tankType)
                return false;
            return CheckBest(tankman, best, slot, isPremVehicle);
        }

        private function CheckBest(tankman:Object, best:Object, slot:Object, isPremVehicle:Boolean):Boolean
        {
            // No bestTankman : select first tankman met
            if (best == null)
                return true;

            var tankmanPenality:Number = getPenalty(tankman, slot, isPremVehicle);
            var bestPenality:Number = getPenalty(best, slot, isPremVehicle);

            // CASE 1 : bestTankman is better than actual
            // conserve the bestTankman
            if (bestPenality > tankmanPenality)
                return false;

            // CASE 3 : actual tankman is better than bestTankman
            // select the actualTankman
            if (bestPenality < tankmanPenality)
                return true;

            // CASE 2 : bestTankman's capacity is equal with the actualTankman's skill
            // Need deeper analysis

            //CASE 2.1 : bestTankman has more skills than actualTankman
            //conserve the bestTankman
            if (best.skills.length > tankman.skills.length)
                return false;

            //CASE 2.2 : bestTankman has less skills than actualTankman
            //select the actualTankman
            if (best.skills.length < tankman.skills.length)
                return true;

            //CASE 2.3 : actual tankman has last skill unset
            //conserve the bestTankman
            var lastSkill:Object = (tankman.skills.length > 0 ? tankman.skills[tankman.skills.length - 1] : null);
            if (lastSkill != null && !lastSkill.hasOwnProperty("id"))
                return false;

            //CASE 2.4 : bestTankman has the same number of skills that the actualTankman
            //if the bestTankman's lastskilllevel is < that actualTankman's
            //select the actualTankman
            if (best.lastSkillLevel < tankman.lastSkillLevel)
                return true;

            return false;
        }

        /**
         * Skill tankman penalty
         * @param tankman data
         * @param dummy tankman current tank
         * @return tankman's efficiencyLevel - penality (real value)
         */
        private function getPenalty(tankman:Object, slot:Object, isPremVehicle:Boolean):Number
        {
            var coeff:Number;

            if (tankman.vehicleType == slot.vehicleType)
            {
                // CASE 1 : exactly same vehicle = 100%
                coeff = 1;
            }
            else
            {
                if (tankman.tankType == slot.tankType)
                {
                    // CASE 2 : same vehicle type
                    // CASE 2.1 : premium vehicle = 100%
                    if (isPremVehicle)
                        coeff = 1;
                    // CASE 2.2 : non-premium vehicle = 75%
                    else
                        coeff = 0.75;
                }
                else
                {
                    // CASE 3 : different vehicle type
                    // CASE 3.1 : premium vehicle = 75%
                    if (isPremVehicle)
                        coeff = 0.75;
                    // CASE 3.2 : non-premium vehicle = 50%
                    else
                        coeff = 0.50;
                }
            }

            return tankman.efficiencyLevel * coeff;
        }
    }
}
