package xvm.profile.UI
{
    import com.xvm.*;
    import fl.transitions.easing.Strong;
    import net.wg.gui.lobby.profile.pages.technique.data.ProfileVehicleDossierVO;
    import net.wg.gui.utils.ExcludeTweenManager;
    import xvm.profile.components.TechniqueStatisticTab;
    import scaleform.clik.motion.Tween;

    public dynamic class UI_TechniqueStatisticTab extends TechniqueStatisticTab_UI
    {
        private const ANIM_SPEED:Number = 500;
        private var isDataInitialized:Boolean = false;
        private var tweenManager:ExcludeTweenManager;

        private var worker:TechniqueStatisticTab;

        public function UI_TechniqueStatisticTab()
        {
            tweenManager = new ExcludeTweenManager();
            super();
            worker = new TechniqueStatisticTab(this);
        }

        override protected function configUI():void
        {
            super.configUI();
            worker.configUI();
        }

        override public function update(arg1:Object):void
        {
            if (_baseDisposed)
                return;

            if (worker.page && worker.page.battlesDropdown && (worker.page.battlesDropdown.selectedItem == PROFILE.PROFILE_DROPDOWN_LABELS_TEAM))
            {
                worker.ratingTF.htmlText = "";
                worker.maxDamageDL.labelTextField.textColor = Defines.UICOLOR_DISABLED;
                worker.maxDamageDL.value = "<font color='#" + Defines.UICOLOR_DISABLED.toString(16) + "' size='12'>--</font>";
                worker.specDamageDL.visible = false;
                worker.avgCaptureDL.visible = false;
                worker.avgDefenceDL.visible = false;
                winsPercentSign.visible = true;
                defeatsPercentSign.visible = true;
                survivePercentSign.visible = true;
                worker.clearTextFields();
                super.update(arg1);
                return;
            }

            worker.maxDamageDL.labelTextField.textColor = Defines.UICOLOR_LABEL;

            if(!isDataInitialized)
            {
                isDataInitialized = true;
                tweenManager.registerAndLaunch(ANIM_SPEED, this, {"alpha":1},
                    {
                        "ease":Strong.easeOut,
                        "onComplete":function(tween:Tween):void { tweenManager.unregister(tween); }
                    }
                );
            }

            worker.update(arg1 as ProfileVehicleDossierVO);
        }

        public function get baseDisposed():Boolean
        {
            return _baseDisposed;
        }
   }
}
