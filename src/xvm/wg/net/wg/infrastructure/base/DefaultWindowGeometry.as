package net.wg.infrastructure.base 
{
    import net.wg.infrastructure.interfaces.*;
    
    public class DefaultWindowGeometry extends Object implements net.wg.infrastructure.interfaces.IWindowGeometry
    {
        public function DefaultWindowGeometry()
        {
            super();
            return;
        }

        public function canOverwrite():Boolean
        {
            return true;
        }

        public function setSize(arg1:net.wg.infrastructure.interfaces.IWindow):Boolean
        {
            arg1.updateSize(arg1.getMinWidth(), arg1.getMinHeight());
            return true;
        }

        public function setPosition(arg1:net.wg.infrastructure.interfaces.IWindow):Boolean
        {
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc1:*=arg1.sourceView;
            if (loc1 && loc1.isCentered) 
            {
                loc2 = App.appWidth - arg1.width >> 1;
                loc3 = App.appHeight - arg1.height >> 1;
                if (loc1.isModal) 
                {
                    arg1.x = loc2;
                    arg1.y = loc3;
                }
                else if (this.doPositionOnce) 
                {
                    arg1.x = arg1.x + loc2;
                    arg1.y = arg1.y + loc3;
                    this.doPositionOnce = false;
                }
            }
            return true;
        }

        internal var doPositionOnce:Boolean=true;
    }
}
