/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.techtree_ui
{
    import com.xfw.*;
    import com.xvm.*;
    import flash.events.*;
    import net.wg.gui.lobby.techtree.data.state.*;

    public dynamic class UI_ResearchItemNode extends ResearchItemNode
    {
        public function UI_ResearchItemNode()
        {
            //Logger.add("UI_ResearchItemNode()");
            super();
        }

        override public function populateUI():void
        {
            if (Config.config.hangar.hidePricesInTechTree)
            {
                if (stateProps != null && stateProps.visible && stateProps.animation == null)
                {
                    if (stateProps.label == "creditsPriceLabel")
                        stateProps.animation = new AnimationProperties(150, { alpha:0 }, { alpha:1 } );
                }
            }

            super.populateUI();
        }

        override public function showContextMenu():void
        {
            super.showContextMenu();
            if (button != null)
                button.endAnimation(false);
        }

        override protected function handleClick(value:uint = 0):void
        {
            super.handleClick(value);
            if  (button != null)
                button.endAnimation(false);
        }

        override protected function handleMouseRollOver(e:MouseEvent):void
        {
            super.handleMouseRollOver(e);
            if (button != null)
                button.startAnimation();
        }

        override protected function handleMouseRollOut(e:MouseEvent):void
        {
            super.handleMouseRollOut(e);
            if (button != null)
                button.endAnimation(false);
        }
    }
}
