package net.wg.gui.components.controls.achievements 
{
    import net.wg.data.constants.*;
    import net.wg.gui.events.*;
    
    public class AchievementCommon extends net.wg.gui.components.controls.achievements.AchievementProgress
    {
        public function AchievementCommon()
        {
            super();
            return;
        }

        protected override function applyData():void
        {
            var loc6:*=false;
            var loc7:*=false;
            if (data == null) 
            {
                return;
            }
            var loc1:*=getDataOwnValue("type", "");
            var loc2:*=getDataOwnValue("section", "");
            var loc3:*=getDataOwnValue("value", NaN);
            var loc4:*;
            var loc5:*=(loc4 = getDataOwnValue("lvlUpTotalValue", 0)) - getDataOwnValue("lvlUpValue", 0);
            loc6 = getDataOwnValue("isRare", false);
            loader.alpha = 1;
            if (loc6) 
            {
                hideProgress();
                counterType = net.wg.gui.components.controls.achievements.AchievementCounter.NONE;
            }
            else if (loc1) 
            {
                var loc8:*=loc1;
                switch (loc8) 
                {
                    case net.wg.data.constants.AchievementType.REPEATABLE:
                    {
                        loc8 = loc2;
                        switch (loc8) 
                        {
                            case net.wg.data.constants.AchievementSection.SPECIAL:
                            {
                                this.checkReceived(loc3, net.wg.gui.components.controls.achievements.AchievementCounter.RED);
                                if (loc4 > 0) 
                                {
                                    this.showProgress();
                                }
                                else 
                                {
                                    hideProgress();
                                }
                                break;
                            }
                            default:
                            {
                                this.checkReceived(loc3, net.wg.gui.components.controls.achievements.AchievementCounter.RED);
                                hideProgress();
                            }
                        }
                        break;
                    }
                    case net.wg.data.constants.AchievementType.SERIES:
                    {
                        loc8 = loc2;
                        switch (loc8) 
                        {
                            case net.wg.data.constants.AchievementSection.SPECIAL:
                            {
                                counterType = net.wg.gui.components.controls.achievements.AchievementCounter.NONE;
                                this.setRecordRepeatable(net.wg.gui.components.controls.achievements.AchievementCounter.YELLOW);
                                if (!isNaN(loc3) && loc5 / loc4 >= 0.9) 
                                {
                                    this.showProgress();
                                }
                                else 
                                {
                                    hideProgress();
                                }
                                break;
                            }
                            default:
                            {
                                this.setRecordRepeatable(net.wg.gui.components.controls.achievements.AchievementCounter.YELLOW);
                                hideProgress();
                            }
                        }
                        break;
                    }
                    case net.wg.data.constants.AchievementType.CUSTOM:
                    {
                        loc8 = loc2;
                        switch (loc8) 
                        {
                            case net.wg.data.constants.AchievementSection.SPECIAL:
                            {
                                counterType = net.wg.gui.components.controls.achievements.AchievementCounter.NONE;
                                if (loc7 = getDataOwnValue("isInDossier", false)) 
                                {
                                    this.showIcon();
                                    hideProgress();
                                }
                                else 
                                {
                                    this.hideIcon();
                                    this.showProgress();
                                }
                                break;
                            }
                            default:
                            {
                                this.showProgress();
                            }
                        }
                        break;
                    }
                    case net.wg.data.constants.AchievementType.CLASS:
                    {
                        loc8 = loc2;
                        switch (loc8) 
                        {
                            case net.wg.data.constants.AchievementSection.CLASS:
                            {
                                this.checkReceived(loc3, net.wg.gui.components.controls.achievements.AchievementCounter.BEIGE);
                                counterType = net.wg.gui.components.controls.achievements.AchievementCounter.BEIGE;
                                if (loc5 == loc4) 
                                {
                                    hideProgress();
                                }
                                else 
                                {
                                    this.showProgress();
                                }
                                break;
                            }
                        }
                        break;
                    }
                    default:
                    {
                        this.showProgress();
                    }
                }
            }
            super.applyData();
            return;
        }

        protected override function showProgress():void
        {
            if (!getDataOwnValue("isDossierForCurrentUser", null)) 
            {
                return;
            }
            super.showProgress();
            return;
        }

        protected override function tryToLoadRareAchievement():void
        {
            var loc1:*=getDataOwnValue("rareIconId", null);
            if (loc1) 
            {
                loader.source = "img://" + loc1;
                loader.addEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onComplete);
            }
            else 
            {
                loader.startLoadAlt();
                dispatchEvent(new net.wg.gui.components.controls.achievements.AchievementEvent(net.wg.gui.components.controls.achievements.AchievementEvent.REQUEST_RARE_ACHIEVEMENT, true));
            }
            return;
        }

        protected override function onComplete(arg1:net.wg.gui.events.UILoaderEvent):void
        {
            super.onComplete(arg1);
            return;
        }

        protected function setRecordRepeatable(arg1:String):void
        {
            if (getDataOwnValue("isInDossier", false)) 
            {
                this.showIcon();
            }
            else 
            {
                this.hideIcon();
            }
            this.counterType = arg1;
            return;
        }

        protected function checkReceived(arg1:Number, arg2:String):void
        {
            if (arg1 <= 0) 
            {
                counterType = net.wg.gui.components.controls.achievements.AchievementCounter.NONE;
                this.hideIcon();
            }
            else 
            {
                this.counterType = arg2;
                this.showIcon();
            }
            hideProgress();
            return;
        }

        internal function hideIcon():void
        {
            loader.alpha = 0.2;
            return;
        }

        internal function showIcon():void
        {
            loader.alpha = 1;
            return;
        }

        public override function dispose():void
        {
            if (counter && contains(counter)) 
            {
                removeChild(counter);
            }
            super.dispose();
            return;
        }
    }
}
