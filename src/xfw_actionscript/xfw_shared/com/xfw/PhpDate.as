package com.xfw
{
    import flash.errors.IllegalOperationError;

    /**
     * Date class inspired on the PHP date function (http://php.net/date).
     *
     * <p>Based on the fact that the native Date class of AS3 is, in my opinion,
     * not so great for some tasks, I decided to implement the php-Data function
     * for AS3.
     * If you have questions feel free to contact me (jochen.hilgers[at]gmail.com)
     * or visit my website under http://www.web-programmer.de</p>
     * @example
     * There are several ways to use this class.<br />
     * The first way is to use the static class method <code>format()</code>,
     * such as the follow lines:<br />
     * <listing>
     * <code>
     *    PhpDate.format( "r" );
     *    PhpDate.format( "r", 1211528051 );
     *    PhpDate.format( "r", new Date() );
     * </code></listing>
     * You also can create a instance of this class and call the public method
     * <code>format()</code>, too.
     * <listing><code>
     *   var phpDate:PhpDate = new PhpDate();
     *   phpDate.format( "r" );
     *
     *   var phpDate2:PhpDate = new PhpDate( 1211528051 );
     *   phpDate2.format( "r" );
     *
     *   var date:Date = new Date();
     *   var phpDate3:PhpDate = new PhpDate( date );
     *   phpDate3.format( "r" );
     * </code></listing>
     * <p>
     * If you want to take over a given UNIX-Timestamp or AS3 Date-Object to
     * PhpDate you only have to add the timestamp as a parameter. Remember that
     * only the static <code>format()</code> method accept this, if you use an
     * instance you should add the timestamp/date-object to the constructor.
     * </p>
     * These format chars can be used (taken from the php doc):
     * <listing>
     * <strong>Day</strong>
     *  d   Day of the month, 2 digits with leading zero: 01 to 31
     *  D   A textual representation of the day, three letters: Mon through Sun
     *  j   Day of the month without leading zeros: 1 to 31
     *  l   A full textual representation of the day of the week: Sunday through Monday
     *  N   ISO-8601 numeric representation of the day of the week: 1 (for Monday) through 7 (for Sunday)
     *  S   English ordinal suffix for the day of the month, 2 characters: st, nd, rd or th. Works well with j
     *  w   Numeric representation of the day of the week: 0 (for Sunday) through 6 (for Saturday)
     *  z   The day of the year (starting from 0): 0 through 365
     * <strong>Week</strong>
     *  W   ISO-8601 week number of year, weeks starting on Monday (added in PHP 4.1.0). Example: 42 (the 42nd week in the year)
     * <strong>Month</strong>
     *  F   A full textual representation of a month, such as January or March: January through December
     *  m   Numeric representation of a month, with leading zeros: 01 through 12
     *  M   A short textual representation of a month, three letters: Jan through Dec
     *  n   Numeric representation of a month, without leading zeros: 1 through 12
     *  t   Number of days in the given month: 28 through 31
     * <strong>Year</strong>
     *  L   Whether it's a leap year: 1 if it is a leap year, 0 otherwise.
     *  Y   A full numeric representation of a year, 4 digits. Examples: 1999 or 2003
     *  y   A two digit representation of a year. Examples: 99 or 03
     * <strong>Time</strong>
     *  a   Lowercase Ante meridiem and Post meridiem: am or pm
     *  A   Uppercase Ante meridiem and Post meridiem: AM or PM
     *  B   Swatch Internet time: 000 through 999
     *  g   12-hour format of an hour without leading zeros: 1 through 12
     *  G   24-hour format of an hour without leading zeros: 0 through 23
     *  h   12-hour format of an hour with leading zeros: 01 through 12
     *  H   24-hour format of an hour with leading zeros: 00 through 23
     *  i   Minutes with leading zeros: 00 to 59
     *  s   Seconds, with leading zeros: 00 through 59
     *  u   Milliseconds. Example: 54321
     * <strong>Timezone</strong>
     *  e   Timezone identifier. Examples: UTC, GMT, Atlantic/Azores
     *  I (capital i)   Whether or not the date is in daylight saving time: 1 if Daylight Saving Time, 0 otherwise.
     *  O   Difference to Greenwich time (GMT) in hours. Example: +0200
     *  P   Difference to Greenwich time (GMT) with colon between hours and minutes. Example: +02:00
     *  T   Timezone abbreviation. Examples: EST, MDT ...
     *  Z   Timezone offset in seconds. The offset for timezones west of UTC is always negative, and for those east of UTC is always positive. -43200 through 50400
     * <strong>Full Date/Time</strong>
     *  c   ISO 8601 date: 2004-02-12T15:19:21+00:00
     *  r   RFC 2822 formatted date. Example: Thu, 21 Dec 2000 16:01:07 +0200
     *  U   Seconds since the Unix Epoch (January 1 1970 00:00:00 GMT). See also time()
     * </listing>
     *
     * @author jochen[dot]hilgers[at]gmail[dot].com
     * @version 0.1
     */
    public class PhpDate
    {
        // reference to the original as3 date class
        private var _date:Date;

        // long and short day names
        private static const WEEKDAYS:Array = [
            "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
            "Friday", "Saturday" ];

        // long and short month names
        private static const MONTHS:Array = [
            "January", "February", "March", "April", "May", "June", "July",
            "August", "September", "October", "November", "December" ];

        // timezone abbrevitation
        private static const TIMEZONES:Array = [
            "IDLW", "NT", "HST", "AKST", "PST", "MST", "CST", "EST", "AST",
            "ADT", "AT", "WAT", "GMT", "CET", "EET", "MSK", "ZP4", "ZP5",
            "ZP6", "WAST", "WST", "JST", "AEST", "AEDT", "NZST" ];

        // array to transform the format 0(sun)-6(sat) to 1(mon)-7(sun)
        private static const MONDAY_STARTING_WEEK:Array = [7, 1, 2, 3, 4, 5, 6];

        /**
         * default constructor
         *
         * @param Date object or unix timestamp as an int
         */
        public function PhpDate(date:* = null)
        {
            if (date is Date)
            {
                _date = date as Date;
            }
            else if (date is int)
            {
                var unixTimestamp:int =  date as int;
                _date = new Date(unixTimestamp * 1000);
            }
            else
            {
                _date = new Date();
            }
        }

        /**
         * return a formated date string
         *
         * @param String the format pattern
         * @return the new formated date string
         */
        public function format(format:String):String
        {
            return parseFormatString(format);
        }

        /**
         * returns a formated date string
         * to use if you won't or can't instantiate the PhpDate Class
         *
         * @static
         * @param String the format pattern
         * @param Integer the unix-timestamp, optional
         * @return the new formated date string
         */
        public static function format(format:String, date:* = null):String
        {
            var phpDate:PhpDate = new PhpDate(date);
            return phpDate.parseFormatString(format);
        }

        /**
         * split the format string into pieces and parse it
         *
         * @see parseSingleChar
         * @param String the full format String
         * @return String
         */
        private function parseFormatString(format:String):String
        {
            var result:Array = [];

            // get single chars from the full format string
            var chars:Array =  format.split("");

            // iterating over all chars
            chars.forEach(
                function(item:String, index:int, array:Array):void
                {
                    /*
                     * check if the current char was escaped if true don't
                     * parse it
                     */
                    if ((index > 0 && array[index-1] != "\\") || index == 0)
                    {
                        result.push(parseSingleChar(item));
                    }
                    else
                    {
                        result.push(item);
                    }
                });

            return result.join("");
        }

        /**
         * parses a single char
         *
         * @param item single char of a format string
         * @return String
         */
        private function parseSingleChar(item:String):String
        {
            /*
             * checking if some regexp match to the given char, if false
             * give back the original item
             */
            if (item.match(/a/))
                return getAmPm();

            else if (item.match(/A/))
                return getAmPm(true);

            else if (item.match(/B/))
                return getSwatchInternetTime();

            else if (item.match(/c/))
                return getIso8601();

            else if (item.match(/d/))
                return getDayOfMonth();

            else if (item.match(/D/))
                return getWeekDayAsText(true);

            else if (item.match(/F/))
                return getMonthAsText();

            else if (item.match(/g/))
                return getHours(false, true);

            else if (item.match(/G/))
                return getHours(false);

            else if (item.match(/h/))
                return getHours(true, true);

            else if (item.match(/H/))
                return getHours();

            else if (item.match(/i/))
                return getMinutes();

            else if (item.match(/I/))
                return getSummertime();

            else if (item.match(/j/))
                return getDayOfMonth(false);

            else if (item.match(/l/))
                return getWeekDayAsText();

            else if (item.match(/L/))
                return getLeapYear();

            else if (item.match(/m/))
                return getMonth();

            else if (item.match(/M/))
                return getMonthAsText(true);

            else if (item.match(/n/))
                return getMonth(false);

            else if (item.match(/N/))
                return getIso8601Day();

            else if (item.match(/O/))
                return getDifferenceBetweenGmt();

            else if (item.match(/P/))
                return getDifferenceBetweenGmt(":");

            else if (item.match(/r/))
                return getRfc2822();

            else if (item.match(/s/))
                return getSeconds();

            else if (item.match(/S/))
                return getMonthDayOrdinalSuffix();

            else if (item.match(/t/))
                return getDaysOfMonth();

            else if (item.match(/T/))
                return getTimezone();

            else if (item.match(/u/))
                return getMilliseconds();

            else if (item.match(/U/))
                return getUnixTimestamp();

            else if (item.match(/w/))
                return getWeekDay();

            else if (item.match(/W/))
                return getWeekOfYear();

            else if (item.match(/y/))
                return getYear(true);

            else if (item.match(/Y/))
                return getYear();

            else if (item.match(/z/))
                return getDayOfYear();

            else if (item.match(/Z/))
                return getTimezoneOffset();

            else
                return item;
        }

        /**
         * returns 1 if it is summertime, else 0
         *
         * @see isSummertime()
         * @return String
         */
        private function getSummertime():String
        {
            if (isSummertime())
                return "1";

            return "0";
        }

        /**
         * check if the current date lays in summertime
         *
         * @see getSummertime();
         * @return Boolean
         */
        private function isSummertime():Boolean
        {
            var currentOffset:Number = _date.getTimezoneOffset();
            var referenceOffset:Number;

            var month:Number = 1;

            while (month--) {
                referenceOffset = (new Date(_date.getFullYear(), month, 1))
                    .getTimezoneOffset();

                if (currentOffset != referenceOffset)
                {
                    if (currentOffset < referenceOffset)
                        return true;
                }
            }

            return false;
        }

        /**
         * returns the unix timestamp(seconds since the 1st January 1970)
         *
         * @return String
         */
        private function getUnixTimestamp():String
        {
            return String(Math.floor(_date.getTime() / 1000));
        }

        /**
         * returns ISO8601 formated date, like 2008-05-22T19:15:21+02:00
         *
         * @return String
         */
        private function getIso8601():String
        {
            return getYear() + "-" + getMonth() + "-" + getDayOfMonth() + "T"
                + getHours() + ":" + getMinutes() + ":" + getSeconds()
                + getDifferenceBetweenGmt(":");
        }

        private function getIso8601Day():String
        {
            return String(MONDAY_STARTING_WEEK[_date.getDay()]);
        }

        /**
         * returns a RFC2822 formated date string,
         * such as Tue, 25 Jan 1983 16:55:00 +0100
         *
         * @return String
         */
        private function getRfc2822():String
        {
            return getWeekDayAsText(true) + ", " + getDayOfMonth() + " "
                + getMonthAsText(true) + " " + getYear() + " "
                + getHours() + ":" + getMinutes() + ":" + getSeconds()
                + " " + getDifferenceBetweenGmt();
        }

        /**
         * returns the current timezone abbrevitation (such as EST, GMT, ...)
         *
         * @return String
         */
        private function getTimezone():String
        {
            var offset:Number = Math.round(11 +
                -(_date.getTimezoneOffset() / 60));

            if (isSummertime())
                offset--;

            return TIMEZONES[offset];
        }

        /**
         * returns the difference to the greenwich time (GMT), with optional
         * separtor between hours and minutes (such as +0200 or +02:00)
         *
         * @param String seperator
         * @return String
         */
        private function getDifferenceBetweenGmt(seperator:String=''):String
        {
            var timezoneOffset:Number = -_date.getTimezoneOffset();

            // sets the prefix
            var pre:String;
            if (timezoneOffset > 0)
                pre = "+";
            else
                pre = "-";

            var hours:Number = Math.floor(timezoneOffset / 60);
            var min:Number = timezoneOffset - (hours * 60);

            // building the return string
            var result:Array = [pre];
            if (hours < 9)
                result.push("0"); // adding leading zero to hours
            result.push(hours.toString());
            result.push(seperator);
            if (min < 9)
                result.push("0"); // adding leading zero to minutes
            result.push(min);

            return result.join("");
        }

        /**
         * returns the timezone offset in seconds(between -43200 - 50400)
         *
         * @return String
         */
        private function getTimezoneOffset():String
        {
            return String(_date.getTimezoneOffset() * 60);
        }

        /**
         * number of days in the current month (such as 28-31)
         *
         * @return Stirng
         */
        private function getDaysOfMonth():String
        {
            return String(new Date(_date.getFullYear(), _date.getMonth() + 1, 0).getDate());
        }

        /**
         * returns the beats of the swatch internet time
         *
         * @return String
         */
        private function getSwatchInternetTime():String
        {
            // get passed seconds for the day
            var daySeconds:int = (_date.getUTCHours() * 3600)
                + (_date.getUTCMinutes() * 60)
                + (_date.getUTCSeconds())
                + 3600; // caused of the BMT Meridian

            // 1day = 1000 .beat ... 1 second = 0.01157 .beat
            return String(Math.round(daySeconds * 0.01157));
        }

        /**
         * return the two chars ordinal suffix of the month day (such as th, st,
         * nd, rd)
         *
         * @retun String;
         */
        private function getMonthDayOrdinalSuffix():String
        {
            var day:String = _date.getDate().toString();
            switch(day.charAt(day.length - 1))
            {
                case "1":
                    return "st";
                    break;

                case "2":
                    return "nd";
                    break;

                case "3":
                    return "rd";
                    break;

                default:
                    return "th";
                    break;
            }
        }

        /**
         * returns the month as text (such as Janury - December or Jan - Dec)
         *
         * @param Boolean flag to get the short version of month, optional
         * @return String
         */
        private function getMonthAsText(short:Boolean = false):String
        {
            if (short == true)
            {
                return String(MONTHS[_date.month]).substr(0, 3);
            }
            return MONTHS[_date.month];
        }

        /**
         * returns the milliseconds (such as 415)
         *
         * @return String
         */
        private function getMilliseconds():String
        {
            return String(_date.getMilliseconds());
        }

        /**
         * return seconds (such as 0-59 or 00-59)
         *
         * @param Flag to add leading zero, optional default = true
         * @return String
         */
        private function getSeconds(leadingZero:Boolean = true):String
        {
            if (leadingZero == true)
            {
                if (_date.getSeconds() <= 9)
                    return "0" + _date.getSeconds().toString();
            }
            return String(_date.getSeconds());
        }

        /**
         * returns the minutes (such as 0-59 or 00-59)
         *
         * @param flag for adding a leading zero, optional default = true
         * @return String
         */
        private function getMinutes(leadingZero:Boolean = true):String
        {
            if (leadingZero == true)
            {
                if (_date.getMinutes() <= 9)
                    return "0" + _date.getMinutes().toString();
            }
            return String(_date.getMinutes());
        }

        /**
         * returns the hours in diffrent formats(such as 0-12, 00-12, 0-23,
         * 00-23)
         *
         * @param Boolean switch to add a leading zero, optional
         * @param Boolean switch to get in in 12h instead 24h, optional
         * @return String
         */
        private function getHours(leadingZero:Boolean = true,
            twelfHours:Boolean = false):String
        {
            var hours:int;
            if (twelfHours == true)
            {
                if (_date.getHours() > 12)
                {
                    hours = _date.getHours() - 12;
                }
            }
            else
            {
                hours = _date.getHours();
            }

            if (leadingZero == true)
            {
                if (hours <= 9)
                    return "0" + hours.toString();
            }
            return String(hours);
        }

        /**
         * returns am (ante meridiem) or pm (post meridiem)
         *
         * @param Boolean flag to get an upper-case string
         * @return String am or pm
         */
        private function getAmPm(upperCase:Boolean = false):String
        {
            var result:String = "am";
            if (_date.hours > 12)
            {
                result = "pm";
            }

            if (upperCase == true)
            {
                return result.toUpperCase();
            }
            return result;
        }

        /**
         * returns the numeric weekday (0 Sunday - 6 Saturday)
         *
         * @return String
         */
        private function getWeekDay():String
        {
            return String(_date.getDay());
        }

        /**
         * returns the weekday in textual presentation (such as Monday or Mon)
         *
         * @param Boolean flag to switch between short and long weekdays
         * @return String
         */
        private function getWeekDayAsText(short:Boolean = false):String
        {
            if (short == true)
            {
                return String(WEEKDAYS[_date.getDay()]).substr(0, 3);
            }
            return WEEKDAYS[_date.getDay()];
        }

        /**
         * returns 1 if leap year, else 0 (as String)
         *
         * return String
         */
        private function getLeapYear():String
        {
            if (isLeapYear())
                return "1";
            return "0"
        }

        /**
         * returns true if the year is a leap year
         *
         * @return Boolean
         */
        private function isLeapYear():Boolean
        {
            if ((_date.getFullYear() % 4 == 0)
                && ((_date.getFullYear() % 100 != 0)
                || (_date.getFullYear() % 400 == 0)))
            {
                return true;
            }
            return false;
        }

        /**
         * returns the number of the current week for the year, a week starts
         * with monday
         *
         * @return String
         */
        private function getWeekOfYear():String
        {
            // number of passed days
            var dayOfYear:Number = Number(getDayOfYear());
            // january 1st of the current year
            var firstDay:Date = new Date(_date.getFullYear(), 0, 1);

            /*
             * remove Days of the first and the current week to get the realy
             * passed weeks
             */
            var fullWeeks:Number = (dayOfYear
                    - (
                        MONDAY_STARTING_WEEK[_date.getDay()]
                        + (7 - MONDAY_STARTING_WEEK[firstDay.getDay()])
                   )) / 7;

            /*
             * the first week of this year only matters if it has more than 3
             * in the current year
             */
            if (MONDAY_STARTING_WEEK[firstDay.getDay()] <= 4)
            {
                fullWeeks++;
            }

            // adding the current week
            fullWeeks++;

            return String(fullWeeks);
        }

        /**
         * returns the day of the year, starting with 0 (0-365)
         *
         * return String
         */
        private function getDayOfYear():String
        {
            var firstDayOfYear:Date = new Date(_date.getFullYear(), 0, 1);
            var millisecondsOffset:Number = _date.getTime()
                - firstDayOfYear.getTime();
            return String(Math.floor(millisecondsOffset / 86400000));
        }

        /**
         * returns the year (such as 2008 or 08)
         *
         * @param Boolean flag to get the year as two digits
         * @return String
         */
        private function getYear(twoDigits:Boolean = false):String
        {
            if (twoDigits == true)
            {
                // cut the year for the last two digits and return it
                return String(_date.getFullYear()).substr(2,2);
            }
            return String(_date.getFullYear());
        }

        /**
         * returns the month (1-12 or 01-12), with optional leading zero
         *
         * @param Boolean optional flag to add a leading zero
         * @return String month (1-12 or 01-12)
         */
        private function getMonth(leadingZero:Boolean = true):String
        {
            var month:Number = _date.getMonth() + 1;
            if (leadingZero == true)
            {
                if (month <= 9)
                    return "0" + String(month);
            }
            return String(month);
        }

        /**
         * returns day of the month (1-31 or 01-31), with optional leading zero
         *
         * @param Boolean optional flag to add a leading zero to the day
         * @return day of the month (1-31 or 01-31)
         */
        private function getDayOfMonth(leadingZero:Boolean = true):String
        {
            if (leadingZero == true)
            {
                if (_date.getDate() <= 9)
                    return "0" + String(_date.getDate());
            }
            return String(_date.getDate());
        }
    }
}
