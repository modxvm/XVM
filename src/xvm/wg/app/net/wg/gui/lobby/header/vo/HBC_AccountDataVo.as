package net.wg.gui.lobby.header.vo
{
    import net.wg.data.VO.UserVO;
    
    public class HBC_AccountDataVo extends Object
    {
        
        public function HBC_AccountDataVo()
        {
            super();
        }
        
        public var userVO:UserVO = null;
        
        public var isTeamKiller:Boolean = false;
        
        public var isClan:Boolean = false;
        
        public var clanEmblemId:String = "";
    }
}
