package net.wg.gui.lobby.hangar.crew
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.SoundButtonEx;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.hangar.crew.ev.CrewDogEvent;

    public class CrewDogItem extends UIComponentEx
    {

        public var icon:UILoaderAlt = null;

        public var dogName:CrewItemLabel = null;

        public var iconRole:TankmenIcons = null;

        public var bg:Sprite = null;

        public var hitMc:Sprite = null;

        public var toMoreInfo:SoundButtonEx = null;

        public var tooltipId:String = null;

        public function CrewDogItem()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.icon.source = RES_COMMON.MAPS_ICONS_TANKMEN_ICONS_SMALL_USSR_DOG_1;
            this.iconRole.imageLoader.source = RES_COMMON.MAPS_ICONS_TANKMEN_ROLES_BIG_DOG;
            this.toMoreInfo.label = MENU.HANGAR_CREW_RODY_DOG_MOREINFOLABEL;
            this.toMoreInfo.addEventListener(ButtonEvent.CLICK,this.onToMoreInfoPressHandler);
            this.hitMc.addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
            this.hitMc.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            this.hitMc.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            this.hitMc.useHandCursor = false;
            this.hitMc.buttonMode = false;
            App.utils.commons.updateChildrenMouseEnabled(this,false);
            this.hitMc.mouseEnabled = true;
            this.toMoreInfo.mouseEnabled = true;
        }

        override protected function draw() : void
        {
            super.draw();
        }

        override protected function onDispose() : void
        {
            this.hitMc.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
            this.hitMc.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            this.hitMc.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            this.hitMc = null;
            this.toMoreInfo.removeEventListener(ButtonEvent.CLICK,this.onToMoreInfoPressHandler);
            this.toMoreInfo.dispose();
            this.toMoreInfo = null;
            this.icon.dispose();
            this.icon = null;
            this.dogName.dispose();
            this.dogName = null;
            this.iconRole.dispose();
            this.iconRole = null;
            this.bg = null;
            this.tooltipId = null;
            super.onDispose();
        }

        public function setData(param1:String) : void
        {
            this.dogName.label = param1;
        }

        public function setTooltip(param1:String) : void
        {
            this.tooltipId = param1;
        }

        private function showTooltip() : void
        {
            if(App.toolTipMgr && enabled)
            {
                App.toolTipMgr.showComplex(this.tooltipId);
            }
        }

        private function hideTooltip() : void
        {
            if(App.toolTipMgr)
            {
                App.toolTipMgr.hide();
            }
        }

        override public function set enabled(param1:Boolean) : void
        {
            this.hitMc.mouseEnabled = param1;
            this.toMoreInfo.enabled = param1;
            super.enabled = param1;
        }

        private function onToMoreInfoPressHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new CrewDogEvent(CrewDogEvent.TO_MORE_INFO_CLICK));
        }

        private function onMouseClickHandler(param1:MouseEvent) : void
        {
            this.hideTooltip();
            dispatchEvent(new CrewDogEvent(CrewDogEvent.ON_ITEM_CLICK));
        }

        private function onMouseOverHandler(param1:MouseEvent) : void
        {
            this.showTooltip();
        }

        private function onMouseOutHandler(param1:MouseEvent) : void
        {
            this.hideTooltip();
        }
    }
}
