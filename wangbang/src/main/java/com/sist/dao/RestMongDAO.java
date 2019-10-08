package com.sist.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.MongoClient;
import com.sist.vo.RestaurantVO;

@Repository
public class RestMongDAO {
	@Autowired
	private MongoTemplate mt;
	 public int TotalPage() {
	      int total=0;
	      //������������..�Ϲ�����
	      Query query=new Query();
	      int count=(int)mt.count(query, "news");
	      total=(int)(Math.ceil(count/10.0)); //�������� ���ϴ� ���
	      return total;
	   }

}
