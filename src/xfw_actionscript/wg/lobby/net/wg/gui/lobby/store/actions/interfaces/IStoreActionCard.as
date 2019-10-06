package net.wg.gui.lobby.store.actions.interfaces
{
    import net.wg.infrastructure.interfaces.ISprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.store.actions.data.StoreActionCardVo;
    import net.wg.gui.lobby.store.actions.data.StoreActionTimeVo;
    import net.wg.gui.lobby.store.actions.data.CardSettings;

    public interface IStoreActionCard extends ISprite, IDisposable
    {

        function setData(param1:StoreActionCardVo) : void;

        function getPermanentWidth() : Number;

        function getPermanentHeight() : Number;

        function getPermanentBottomMargin() : Number;

        function getPermanentLeftMargin() : Number;

        function updateTime(param1:StoreActionTimeVo) : void;

        function updateStageSize(param1:Number, param2:Number) : void;

        function setSelect() : void;

        function get shiftFromCenterByX() : Number;

        function set shiftFromCenterByX(param1:Number) : void;

        function get cardId() : String;

        function get linkage() : String;

        function set settings(param1:CardSettings) : void;
    }
}
