package net.wg.data.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.interfaces.IUserVO;
    import net.wg.infrastructure.interfaces.IUserProps;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class UserVO extends DAAPIDataClass implements IUserVO
    {

        private var _accID:Number = 0;

        private var _dbID:Number = 0;

        private var _fullName:String = "";

        private var _userName:String = "";

        private var _clanAbbrev:String = "";

        private var _region:String = "";

        private var _igrType:int = 0;

        private var _tags:Array;

        private var _badge:int = 0;

        private var _badgeImgStr:String = "";

        private var _userProps:IUserProps = null;

        private var _isTeamKiller:Boolean = false;

        public function UserVO(param1:Object)
        {
            this._tags = [];
            super(param1);
            this._userProps = App.utils.commons.getUserProps(this._userName,this._clanAbbrev,this._region,this._igrType,this._tags,this._badge,this._badgeImgStr);
        }

        override protected function onDispose() : void
        {
            var _loc1_:Object = null;
            if(this._tags)
            {
                for each(_loc1_ in this._tags)
                {
                    if(_loc1_ is IDisposable)
                    {
                        IDisposable(_loc1_).dispose();
                    }
                }
                this._tags.splice(0,this._tags.length);
                this._tags = null;
            }
            if(this._userProps)
            {
                this._userProps = null;
            }
            super.onDispose();
        }

        public function get accID() : Number
        {
            return this._accID;
        }

        public function set accID(param1:Number) : void
        {
            this._accID = param1;
        }

        public function get isTeamKiller() : Boolean
        {
            return this._isTeamKiller;
        }

        public function set isTeamKiller(param1:Boolean) : void
        {
            this._isTeamKiller = param1;
            if(this._userProps)
            {
                this._userProps.isTeamKiller = param1;
            }
        }

        public function get dbID() : Number
        {
            return this._dbID;
        }

        public function set dbID(param1:Number) : void
        {
            this._dbID = param1;
        }

        public function get fullName() : String
        {
            return this._fullName;
        }

        public function set fullName(param1:String) : void
        {
            this._fullName = param1;
        }

        public function get userName() : String
        {
            return this._userName;
        }

        public function set userName(param1:String) : void
        {
            this._userName = param1;
            if(this._userProps)
            {
                this._userProps.userName = param1;
            }
        }

        public function get clanAbbrev() : String
        {
            return this._clanAbbrev;
        }

        public function set clanAbbrev(param1:String) : void
        {
            this._clanAbbrev = param1;
            if(this._userProps)
            {
                this._userProps.clanAbbrev = param1;
            }
        }

        public function get region() : String
        {
            return this._region;
        }

        public function set region(param1:String) : void
        {
            this._region = param1;
            if(this._userProps)
            {
                this._userProps.region = param1;
            }
        }

        public function get igrType() : int
        {
            return this._igrType;
        }

        public function set igrType(param1:int) : void
        {
            this._igrType = param1;
            if(this._userProps)
            {
                this._userProps.igrType = param1;
            }
        }

        public function get uid() : Number
        {
            return this._dbID;
        }

        public function get kickId() : Number
        {
            return this._dbID;
        }

        public function get tags() : Array
        {
            return this._tags;
        }

        public function set tags(param1:Array) : void
        {
            this._tags = param1;
            if(this._userProps)
            {
                this._userProps.tags = param1;
            }
        }

        public function get userProps() : IUserProps
        {
            return this._userProps;
        }

        public function get badge() : int
        {
            return this._badge;
        }

        public function set badge(param1:int) : void
        {
            this._badge = param1;
            if(this._userProps)
            {
                this._userProps.badge = param1;
            }
        }

        public function get badgeImgStr() : String
        {
            return this._badgeImgStr;
        }

        public function set badgeImgStr(param1:String) : void
        {
            this._badgeImgStr = param1;
            if(this._userProps)
            {
                this._userProps.badgeImgStr = param1;
            }
        }
    }
}
