class Api {
//    private static final String BASE_9999_HOST = "http://192.168.1.106:9999/";
//    private static final String BASE_9777_HOST = "http://192.168.1.106:9777/";
//    private static final String BASE_9333_HOST = "http://192.168.1.75:9333/";

  static final String BASE_9999_HOST = "https://www.gwxb.top/work/";
  static final String BASE_9777_HOST = "https://www.gwxb.top/questionbank/";
  static final String BASE_9333_HOST = "http://47.92.218.7:9333/";
  static final String BASE_8888_HOST = "https://www.gwxb.top/image/";
  static String BASE_QUESTION_BANK_HOST = "https://www.gwxb.top/questionbank/";

  static final String BASE_URL = "https://www.gwxb.top/";

  ///家长登录
  static final String PARENT_LOGIN = "questionbank/parent/login";

  /// 获取秘钥
  static final String IM_PRIVATEMAPKEY = "questionbank/im/privateMapKey";

  /// 获取科目
  static final String GET_SUBJECT = "questionbank/function/subjectList";

  /// 获取五维度数据
  static final String FIVEDEMENSION =
      "questionbank/indicators/getFiveDemension";

  /// 获取知识点排行
  static final String KNOWLEDGE_RANK = "work/work/analysisStudentByStuID";

  /// 获取错题列表接口
  /// @param targetUrl
  /// @return
  static final String WRONG_LIST = "work/work/wrongTopic";

  /// 获取音视频sing
  /// @param targetUrl
  /// @return
  static final String IM_USING = "questionbank/im/userSing";

  /// 获取作业详情
  /// @param targetUrl
  /// @return
  static final String HOMEWORK_DETAIL = "work/work/getWork";

  /// 获取学生课程
  /// @param targetUrl
  /// @return
  static final String STUDENT_CLASS =
      "questionbank/function/getTimetableByUserId";

  /// 判断是否需要直播判断上课时间
  static final String HOME_WORK_TIME = "questionbank/function/giveTime";

  /// work/work/getWorksByDay
  /// @param targetUrl
  /// @return
  static final String MY_HOMEWORK = "work/work/getWorksByDay";

  static String getBase9777Host(String targetUrl) {
    return BASE_9777_HOST + targetUrl;
  }

  static String getBaseURL(String targetUrl) {
    return BASE_9333_HOST + targetUrl;
  }

  static String getWorkURL(String targetUrl) {
    return BASE_9999_HOST + targetUrl;
  }

  static String getUploadFileURL(String targetUrl) {
    return BASE_8888_HOST + targetUrl;
  }
}
