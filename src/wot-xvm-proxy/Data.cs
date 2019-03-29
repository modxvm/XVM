using System;
using System.Collections.Generic;

namespace wot
{

    [Serializable]
    public class Stat
    {
        public int id;
        public String name;
        public int eff;
        public int battles;
        public int wins;
    }

    [Serializable]
    public class XVMInfo
    {
        public String ver;
        public String message;
    }

    [Serializable]
    public class Info
    {
        public XVMInfo xvm;
    }

    [Serializable]
    public class Response
    {
        public List<Stat> players;
        public Info info;
    }

    [Serializable]
    public class PlayerInfo
    {
        public Stat stat;

        [NonSerialized]
        public bool httpError;

        [NonSerialized]
        public DateTime errorTime;
    }
}