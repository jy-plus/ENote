class Model {
  String date; //日期
  String time; //时间
  int id; //序号
  int eIndex; //情绪索引号
  String content; //文字内容

  //转化为Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> tmp = {
      'date': date,
      'time': time,
      'eIndex': eIndex,
      'content': content
    };
    return tmp;
  }

  void init(DateTime dt, String text, int eID) {
    String tmp =
        dt.minute >= 10 ? dt.minute.toString() : '0' + dt.minute.toString();
    this.date = fromDateTime(dt);
    this.time = dt.hour.toString() + ':' + tmp;
    this.content = text;
    this.eIndex = eID == null ? 0 : eID;
  }

  static String fromDateTime(DateTime dt) {
    return dt.year.toString() +
        '-' +
        dt.month.toString() +
        '-' +
        dt.day.toString();
  }

  //从Map初始化数据
  fromMap(Map<String, dynamic> m) {
    date = m['date'];
    time = m['time'];
    id = m['id'];
    eIndex = m['eIndex'];
    content = m['content'];
  }
}
