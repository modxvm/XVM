/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package xvm.techtree
{
    import com.xvm.*;
    import com.xvm.utils.*;
    import flash.events.*;
    import net.wg.gui.lobby.techtree.data.state.*;
    import net.wg.gui.lobby.techtree.data.vo.*;
    import net.wg.gui.lobby.techtree.math.*;
    import org.idmedia.as3commons.util.*;

    public dynamic class UI_ResearchItemNode extends ResearchItemNode
    {
        private var handleAnimation:Boolean = false;

        override public function populateUI():void
        {
            if (Config.config.hangar.hidePricesInTechTree)
            {
                if (stateProps != null && stateProps.visible && stateProps.animation == null)
                {
                    if (stateProps.label == "creditsPriceLabel")
                    {
                        stateProps.animation = new AnimationProperties(150, { alpha:0 }, { alpha:1 } );
                        handleAnimation = true;
                    }
                }
            }

            super.populateUI();
        }

        override protected function handleMouseRollOver(e:MouseEvent):void
        {
            super.handleMouseRollOver(e);
            if (handleAnimation)
            {
                if (button != null)
                    button.startAnimation();
            }
        }

        override protected function handleMouseRollOut(e:MouseEvent):void
        {
            super.handleMouseRollOut(e);
            if (handleAnimation)
            {
                if (button != null)
                    button.endAnimation(false);
            }
        }
    }
}
