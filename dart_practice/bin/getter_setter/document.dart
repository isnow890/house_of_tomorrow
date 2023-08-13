class Document {
  // 내용
  String _content;

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  // 읽은 횟수
  int readCount = 0;

  // 수정 횟수
  int updateCount = 0;

  // 통계
  String get statistic => "readCount : $readCount / updateCount : $updateCount";

  Document(this._content);
}
