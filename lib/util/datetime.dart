Map _dateTimeExt = <String, String Function(DateTime time, int len)>{
  "y": (time, len) => time.year.toString().padLeft(len, "0"),
  "M": (time, len) => time.month.toString().padLeft(len, "0"),
  "d": (time, len) => time.day.toString().padLeft(len, "0"),
  "H": (time, len) => time.hour.toString().padLeft(len, "0"),
  "h": (time, len) => (time.hour % 12).toString().padLeft(len, "0"),
  "m": (time, len) => time.minute.toString().padLeft(len, "0"),
  "s": (time, len) => time.second.toString().padLeft(len, "0"),
  "S": (time, len) => time.millisecond.toString().padLeft(len, "0"),
  "E": (time, len) => time.weekday.toString().padLeft(len, "0"),
};

extension DateTimeExt on DateTime {
  bool isYear(DateTime time) {
    if (null == time) {
      return false;
    }
    return this.year == time.year;
  }

  bool isMonth(DateTime time) {
    if (null == time) {
      return false;
    }
    return this.year == time.year && this.month == time.month;
  }

  bool isToDay(DateTime time) {
    if (null == time) {
      return false;
    }
    return this.year == time.year && this.month == time.month && this.day == time.day;
  }

  bool isWeek(DateTime time) {
    if (null == time) {
      return false;
    }
    return this.year == time.year && this.month == time.month && this.weekday == this.weekday;
  }

  bool isHour(DateTime time) {
    if (null == time) {
      return false;
    }
    return this.year == time.year && this.month == time.month && this.day == time.day && this.hour == this.hour;
  }

  bool isMinute(DateTime time) {
    if (null == time) {
      return false;
    }
    return this.year == time.year && this.month == time.month && this.day == time.day && this.hour == this.hour && this.minute == this.minute;
  }

  bool isSecond(DateTime time) {
    if (null == time) {
      return false;
    }
    return this.year == time.year &&
        this.month == time.month &&
        this.day == time.day &&
        this.hour == this.hour &&
        this.minute == this.minute &&
        this.second == this.second;
  }

  String format(String format) {
    if (null == format) {
      return "";
    }

    var temp = StringBuffer();
    for (var item in _dateTimeExt.entries) {
      temp.write("|((${item.key})\\1{1,})+");
    }
    var matches = RegExp(temp.toString().substring(1)).allMatches(format);

    var index = 0;
    temp = StringBuffer();
    for (var item in matches) {
      temp.write(format.substring(index, item.start));
      temp.write(_dateTimeExt[format.substring(item.start, item.start + 1)](this, item.end - item.start));
      index = item.end;
    }
    if (index < format.length) {
      temp.write(format.substring(index));
    }
    return temp.toString();
  }
}

Map _durationExt = <String, String Function(int val, int len)>{
  "D": (val, len) => (val ~/ (1000 * 60 * 60 * 24)).toString().padLeft(len, "0"),
  "H": (val, len) => ((val ~/ (1000 * 60 * 60)) % 60).toString().padLeft(len, "0"),
  "h": (val, len) => (((val ~/ (1000 * 60 * 60)) % 60) % 12).toString().padLeft(len, "0"),
  "m": (val, len) => ((val ~/ (1000 * 60)) % 60).toString().padLeft(len, "0"),
  "s": (val, len) => ((val ~/ 1000) % 60).toString().padLeft(len, "0"),
  "S": (val, len) => (val % 1000).toString().padLeft(len, "0"),
};

extension DurationExt on Duration {
  String format(String format) {
    if (null == format) {
      return "";
    }

    var temp = StringBuffer();
    for (var item in _dateTimeExt.entries) {
      temp.write("|((${item.key})\\1{1,})+");
    }
    var matches = RegExp(temp.toString().substring(1)).allMatches(format);

    var index = 0;
    temp = StringBuffer();
    for (var item in matches) {
      temp.write(format.substring(index, item.start));
      temp.write(_durationExt[format.substring(item.start, item.start + 1)](this.inMilliseconds, item.end - item.start));
      index = item.end;
    }
    if (index < format.length) {
      temp.write(format.substring(index));
    }
    return temp.toString();
  }

  String countDown() {
    var temp = StringBuffer();
    for (var item in _dateTimeExt.entries) {
      temp.write("|((${item.key})\\1{1,})+");
    }

    if (this.inMilliseconds > 1000 * 60 * 60) {
      return "${(this.inMilliseconds ~/ (1000 * 60 * 60)).toString().padLeft(2, "0")}"
          ":${((this.inMilliseconds ~/ (1000 * 60)) % 60).toString().padLeft(2, "0")}"
          ":${((this.inMilliseconds ~/ 1000) % 60).toString().padLeft(2, "0")}";
    } else {
      return "${((this.inMilliseconds ~/ (1000 * 60)) % 60).toString().padLeft(2, "0")}"
          ":${((this.inMilliseconds ~/ 1000) % 60).toString().padLeft(2, "0")}";
    }
    return temp.toString();
  }
}
