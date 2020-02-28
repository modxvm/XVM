package net.wg.gui.lobby.epicBattles.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.Image;
    import net.wg.gui.lobby.epicBattles.data.EpicBattlesWidgetVO;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;

    public class EpicBattlesWidgetComponent extends UIComponentEx
    {

        private static const IMAGE_DEF_SIZE:int = 150;

        private static const IMAGE_SMALL_SIZE:int = 130;

        private static const SMALL_H_RESOLUTION:int = 900;

        public var metaLevelElement:EpicBattlesMetaLevel = null;

        public var ribbon:Image = null;

        private var _epicData:EpicBattlesWidgetVO = null;

        public function EpicBattlesWidgetComponent()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.ribbon.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
            this.ribbon.dispose();
            this.ribbon = null;
            this.metaLevelElement.dispose();
            this.metaLevelElement = null;
            if(this._epicData)
            {
                this._epicData = null;
            }
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            var _loc1_:* = App.appHeight <= SMALL_H_RESOLUTION;
            var _loc2_:int = _loc1_?IMAGE_SMALL_SIZE:IMAGE_DEF_SIZE;
            if(isInvalid(InvalidationType.DATA) && this._epicData != null)
            {
                this.metaLevelElement.setData(this._epicData.epicMetaLevelIconData);
                this.metaLevelElement.setIconSize(_loc2_);
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.metaLevelElement.setIconSize(_loc2_);
                this.ribbon.source = _loc1_?RES_ICONS.MAPS_ICONS_EPICBATTLES_RIBBON_MEDIUM:RES_ICONS.MAPS_ICONS_EPICBATTLES_RIBBON_BIG;
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.metaLevelElement.mouseEnabled = this.metaLevelElement.mouseChildren = false;
            this.ribbon.mouseEnabled = this.ribbon.mouseChildren = false;
            this.ribbon.addEventListener(Event.CHANGE,this.onImageChangeHandler);
        }

        public function setEpicData(param1:EpicBattlesWidgetVO) : void
        {
            this._epicData = param1;
            invalidateData();
        }

        private function onImageChangeHandler(param1:Event) : void
        {
            this.ribbon.x = -this.ribbon.width >> 1;
            this.metaLevelElement.y = this.ribbon.height >> 1;
        }
    }
}
