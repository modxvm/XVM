module.exports = (function() {
    return {
        MIN_VEHICLE_BATTLES: 100, // vehicles with lower battle count are ignored
        FILTER_BATTLES_LOW_LIMIT: 2000, // do not remove first 1000 battles if total battle count for tanks in calculation is lower then this value
        DEL_FIRST_COUNT: 1000, // count of first battlesto remove
        CLASS_TO_TYPE: {
            "heavyTank": "HT",
            "AT-SPG": "TD",
            "SPG": "SPG",
            "lightTank": "LT",
            "mediumTank": "MT"
        }
    }
})();
