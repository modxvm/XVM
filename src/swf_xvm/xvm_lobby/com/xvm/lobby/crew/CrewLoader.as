/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 * @author LEMAXHO
 * @author Maxim Schedriviy <max(at)modxvm.com>
 * @author Pavel Máca
 */
package com.xvm.lobby.crew
{
    import com.xfw.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.gui.lobby.hangar.crew.*;
    import scaleform.clik.controls.*;

    public class CrewLoader extends Sprite
    {
        private static const COMMAND_XVM_CREW_PUT_OWN_CREW:String = 'xvm_crew.as_put_own_crew';
        private static const COMMAND_XVM_CREW_PUT_BEST_CREW:String = 'xvm_crew.as_put_best_crew';
        private static const COMMAND_XVM_CREW_PUT_CLASS_CREW:String = 'xvm_crew.as_put_class_crew';

        private static var _instance:CrewLoader = null;

        private static function get instance():CrewLoader
        {
            if (_instance == null)
                _instance = new CrewLoader();
            return _instance;
        }

        public static function init(page:Hangar):void
        {
            //Logger.add("init");
            instance.init();
            instance.page = page;
            page.crew.addEventListener(MouseEvent.CLICK, instance.handleMouseRelease, false, 0, true);
        }

        public static function dispose(page:Hangar):void
        {
            //Logger.add("dispose");
            instance.dispose();
            page.crew.removeEventListener(MouseEvent.CLICK, instance.handleMouseRelease);
        }

        // PRIVATE

        private var page:Hangar;

        function CrewLoader():void
        {
            page = null;
        }

        public function init():void
        {
            Xfw.addCommandListener(COMMAND_XVM_CREW_PUT_OWN_CREW, PutOwnCrew);
            Xfw.addCommandListener(COMMAND_XVM_CREW_PUT_BEST_CREW, PutBestCrew);
            Xfw.addCommandListener(COMMAND_XVM_CREW_PUT_CLASS_CREW, PutClassCrew);
        }

        public function dispose():void
        {
            page = null;
            Xfw.removeCommandListener(COMMAND_XVM_CREW_PUT_OWN_CREW, PutOwnCrew);
            Xfw.removeCommandListener(COMMAND_XVM_CREW_PUT_BEST_CREW, PutBestCrew);
            Xfw.removeCommandListener(COMMAND_XVM_CREW_PUT_CLASS_CREW, PutClassCrew);
        }

        private function handleMouseRelease(e:MouseEvent):void
        {
            var renderer:CrewItemRenderer = e.target as CrewItemRenderer;
            if (renderer == null)
                return;

            var data:TankmanRoleVO = TankmanRoleVO(renderer.data);

            if (App.utils.commons.isRightButton(e))
            {
                if (renderer.enabled)
                {
                    App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.CREW, this, { "tankmanID": (!data.tankmanID || data.tankmanID < 0) ? 0 : data.tankmanID });
                    App.toolTipMgr.hide();
                }
            }
        }

        private function PutOwnCrew():Object
        {
            GetCrew(CheckOwn);
            return null;
        }

        private function PutBestCrew():Object
        {
            GetCrew(CheckBest);
            return null;
        }

        private function PutClassCrew():Object
        {
            GetCrew(CheckClass);
            return null;
        }

        private function GetCrew(checkFunc:Function):void
        {
            try
            {
                // tankmanId: { tankman:Object, slot:Number }
                var selectedTankmans:Dictionary = new Dictionary();

                for each (var renderer:TankmanRoleVO in (page.crew.list as CoreList).dataProvider)
                {
                    if (renderer.tankman.inTank)
                        continue;

                    var best:Object = null;
                    var len:int = renderer.recruitList.length;
                    for (var i:int = 1; i < len; ++i)
                    {
                        var tankman:Object = renderer.recruitList[i];

                        // already in tank or selected for other slot
                        if (tankman.inTank == true || (tankman.tankmanID in selectedTankmans))
                            continue;

                        // first tankman in RecruitRendererVO.recruitList contain tank info
                        if (checkFunc(tankman, best, renderer.recruitList[0], renderer.vehicleElite))
                        {
                            //Logger.addObject(best, "crew: old best");
                            //Logger.addObject(tankman, "crew: new best");
                            best = tankman;
                        }
                    }
                    if (best)
                    {
                        selectedTankmans[best.tankmanID] = {tankman: best, slot: renderer.slot};
                    }
                }

                for each (var obj:Object in selectedTankmans)
                    page.crew.equipTankman(obj.tankman.tankmanID, obj.slot);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
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
            var lastSkill:Object = (tankman.skills.length ? tankman.skills[tankman.skills.length - 1] : null);
            if (lastSkill)
            {
                if (!("id" in lastSkill))
                {
                    return false;
                }
            }

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
