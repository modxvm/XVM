package net.wg.gui.lobby.header
{
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import net.wg.infrastructure.interfaces.IDAAPIDataClass;

    public interface IAccountClanPopOverBlock extends IUIComponentEx
    {

        function setData(param1:IDAAPIDataClass) : void;

        function setEmblem(param1:String) : void;
    }
}
