package net.wg.gui.battle.pveEvent.views.minimap
{
    import net.wg.gui.battle.views.epicDeploymentMap.components.EpicMapContainer;
    import net.wg.gui.components.controls.UILoaderAlt;

    public class EventFullMapContainer extends EpicMapContainer
    {

        public var background:UILoaderAlt = null;

        public function EventFullMapContainer()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.background.dispose();
            this.background = null;
            super.onDispose();
        }

        public function init(param1:String, param2:Number, param3:Number) : void
        {
            this.background.setOriginalWidth(param2);
            this.background.setOriginalHeight(param3);
            this.background.maintainAspectRatio = false;
            this.background.source = param1;
        }
    }
}
