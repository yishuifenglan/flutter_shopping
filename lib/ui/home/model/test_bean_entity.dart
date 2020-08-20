import 'package:flutter_shopping/generated/json/base/json_convert_content.dart';

class TestBeanEntity with JsonConvert<TestBeanEntity> {
	String type1;
	int type2;
	TestBeanType3 type3;
	List<String> type4;
	bool type5;
	dynamic type6;
}

class TestBeanType3 with JsonConvert<TestBeanType3> {
	String name;
}
