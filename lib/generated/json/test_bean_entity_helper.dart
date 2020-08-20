import 'package:flutter_shopping/ui/home/model/test_bean_entity.dart';

testBeanEntityFromJson(TestBeanEntity data, Map<String, dynamic> json) {
	if (json['type1'] != null) {
		data.type1 = json['type1']?.toString();
	}
	if (json['type2'] != null) {
		data.type2 = json['type2']?.toInt();
	}
	if (json['type3'] != null) {
		data.type3 = new TestBeanType3().fromJson(json['type3']);
	}
	if (json['type4'] != null) {
		data.type4 = json['type4']?.map((v) => v?.toString())?.toList()?.cast<String>();
	}
	if (json['type5'] != null) {
		data.type5 = json['type5'];
	}
	if (json['type6'] != null) {
		data.type6 = json['type6'];
	}
	return data;
}

Map<String, dynamic> testBeanEntityToJson(TestBeanEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['type1'] = entity.type1;
	data['type2'] = entity.type2;
	if (entity.type3 != null) {
		data['type3'] = entity.type3.toJson();
	}
	data['type4'] = entity.type4;
	data['type5'] = entity.type5;
	data['type6'] = entity.type6;
	return data;
}

testBeanType3FromJson(TestBeanType3 data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	return data;
}

Map<String, dynamic> testBeanType3ToJson(TestBeanType3 entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	return data;
}