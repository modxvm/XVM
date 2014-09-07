package net.wg.data.constants
{
    public class Time extends Object
    {
        
        public function Time()
        {
            super();
        }
        
        public static var MILLISECOND_IN_SECOND:uint = 1000;
        
        public static var SECONDS_IN_MINUTE:uint = 60;
        
        public static var MINUTES_IN_HOUR:uint = 60;
        
        public static var HOURS_IN_DAY:uint = 24;
        
        public static var DAYS_IN_WEEK:uint = 7;
        
        public static var WEEKS_IN_MONTH:uint = 4;
        
        public static var MONTHS_IN_YEAR:uint = 12;
        
        public static var DAYS_IN_YEAR:uint = 365;
        
        public static var DAYS_IN_LEAP_YEAR:uint = 366;
        
        public static var MIN_MONTH_DAYS_COUNT:uint = 28;
        
        public static var MAX_MONTH_DAYS_COUNT:uint = 31;
        
        public static var MILLISECOND:uint = 1;
        
        public static var SECOND:uint = MILLISECOND * MILLISECOND_IN_SECOND;
        
        public static var MINUTE:uint = SECOND * SECONDS_IN_MINUTE;
        
        public static var HOUR:uint = MINUTE * MINUTES_IN_HOUR;
        
        public static var DAY:uint = HOUR * HOURS_IN_DAY;
        
        public static var WEEK:uint = DAY * DAYS_IN_WEEK;
        
        public static var MONTH:uint = WEEK * WEEKS_IN_MONTH;
        
        public static var YEAR:uint = DAY * DAYS_IN_YEAR;
        
        public static var LEAP_YEAR:uint = DAY * DAYS_IN_LEAP_YEAR;
        
        public static var FIRST_DAY_IN_MONTH:uint = 1;
        
        public static var PM:String = "PM";
        
        public static var AM:String = "AM";
        
        public static var PREFIX:String = "0";
        
        public static var COUNT_SYMBOLS_WITH_PREFIX:int = 2;
    }
}
