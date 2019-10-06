package net.wg.gui.interfaces
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.IUserProps;

    public interface IUserVO extends IDisposable
    {

        function get dbID() : Number;

        function get accID() : Number;

        function get tags() : Array;

        function get userName() : String;

        function get clanAbbrev() : String;

        function set clanAbbrev(param1:String) : void;

        function get region() : String;

        function get igrType() : int;

        function get userProps() : IUserProps;

        function get badge() : int;

        function get badgeImgStr() : String;
    }
}
