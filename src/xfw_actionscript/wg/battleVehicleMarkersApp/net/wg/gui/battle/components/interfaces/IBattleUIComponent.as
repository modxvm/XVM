package net.wg.gui.battle.components.interfaces
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.IMovieClip;
    import flash.events.Event;

    public interface IBattleUIComponent extends IDisposable, IMovieClip
    {

        function validateNow(param1:Event = null) : void;

        function get initialized() : Boolean;

        function invalidate(param1:uint = 4.294967295E9) : void;
    }
}
