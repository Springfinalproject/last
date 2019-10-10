package com.sist.dao;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import com.sist.vo.ExperienceVO;
import com.sist.vo.ThemeTourVO;

@Repository
public class ExperienceDAO {
	@Autowired
	private MongoTemplate mt;
	
	public int experienceTotalPage() {
		int total=0;
		Query query=new Query();
		int count=(int)mt.count(query, "Ex");
		total=(int)(Math.ceil(count/12.0)); //�������� ���ϴ� ���
		return total;
	}
	 public List<ExperienceVO> experience_data(int page){
		 List<ExperienceVO> list = new ArrayList<ExperienceVO>();
		 int rowSize=12;
		 int skip = (page * rowSize) - rowSize;
		 Query query = new Query();
		 query.with(new Sort(Sort.Direction.ASC,"dataSid"));// dataSid�� �����ؼ� �������ڴ�.
		 query.skip(skip).limit(rowSize);//skip ������ limit�ִ�ġ
		 list = mt.find(query, ExperienceVO.class,"Ex");// find = select , findOne = selectOne(�ϳ��������ö�)
		 return list;
	 }
	 
}