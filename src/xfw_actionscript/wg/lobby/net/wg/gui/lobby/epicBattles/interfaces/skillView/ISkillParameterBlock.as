package net.wg.gui.lobby.epicBattles.interfaces.skillView
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.DisplayObject;

    public interface ISkillParameterBlock extends IDisposable
    {

        function setBlockData(param1:Object) : void;

        function getHeight() : Number;

        function getDisplayObject() : DisplayObject;
    }
}
