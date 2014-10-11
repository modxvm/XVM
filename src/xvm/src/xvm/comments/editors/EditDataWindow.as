package xvm.comments.editors
{
    import com.xvm.*;
    import com.xvm.components.*;
    import flash.utils.Dictionary;
    import net.wg.data.constants.*;
    import net.wg.gui.components.windows.*;
    import net.wg.infrastructure.base.interfaces.*;
    import net.wg.infrastructure.interfaces.IManagedContainer;
    import net.wg.infrastructure.managers.impl.ContainerManager;
    import scaleform.clik.events.*;
    import xvm.comments.*;

    public dynamic class EditDataWindow extends WindowUI
    {
        // PUBLIC STATIC

        public static function show(view:IAbstractWindowView):EditDataWindow
        {
            try
            {
                var w:EditDataWindow = new EditDataWindow();
                view.setWindow(w);
                w.setWindowContent(view);

                var containersMap:Dictionary = (App.containerMgr as ContainerManager).containersMap;
                for (var key:String in containersMap)
                {
                    if (key == view.as_config.type)
                    {
                        var container:IManagedContainer = containersMap[key];
                        container.addChild(w);
                        container.setFocusedView(view);
                        break;
                    }
                }
                return w;
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
            return null;
        }

        // CTOR

        public function EditDataWindow()
        {
            //Logger.add("EditCommentWindow");
            super();

            this.formBgPadding.top = 135;

            this.useBottomBtns = true;

            addEventListener(ComponentEvent.HIDE, close);
        }

        // PUBLIC

        public function close():void
        {
            App.utils.popupMgr.remove(this);
            dispose();
        }
    }
}
