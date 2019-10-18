package com.sist.dao;
import java.io.IOException;
import java.util.*;

import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;
import org.xml.sax.SAXException;

import com.sist.manager.APIWeather;
import com.sist.vo.ExperienceVO;
import com.sist.vo.RestaurantVO;
import com.sist.vo.StayVO;
import com.sist.vo.ThemeTourVO;

@Repository
public class ExperienceDAO {
	@Autowired
	private MongoTemplate mt;

	//�������� ���ϱ�
	public int experienceTotalPage() {
		int total=0;
		Query query=new Query();
		int count=(int)mt.count(query, "Ex");
		total=(int)(Math.ceil(count/8.0)); 
		return total;
	}
	 public List<ExperienceVO> ex_data(int page) {
		 List<ExperienceVO> list = new ArrayList<ExperienceVO>();
		 int rowSize=8;
		 int skip = (page * rowSize) - rowSize;
		 Query query = new Query();
		 query.with(new Sort(Sort.Direction.ASC,"dataSid"));// dataSid�� �����ؼ� �������ڴ�.
		 query.skip(skip).limit(rowSize);//skip ������ limit�ִ�ġ
		 list = mt.find(query, ExperienceVO.class,"Ex");// find = select , findOne = selectOne(�ϳ��������ö�)
		 return list;
	 }
	 public ExperienceVO ex_detail(String dataSid) {
		 ExperienceVO vo = new ExperienceVO();
		 BasicQuery query = new BasicQuery("{dataSid:'"+dataSid+"'}"); //�׳� Query, ������ ���ǰ����ö� BasicQuery
		 vo=mt.findOne(query, ExperienceVO.class,"Ex");
		 return vo;
	 }
	 
	 public JSONArray weather() {
		 JSONArray list = new JSONArray();
		 try {
			APIWeather ap = new APIWeather(); 
			list = ap.APIWeather();
			System.out.println("DAO������ ����Ʈ��"+list);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 return list;
	 }
	 //--------------------------------------------------------------------------------
		//�������� ���ϱ�
		public int stayTotalPage() {
			int total=0;
			Query query=new Query();
			int count=(int)mt.count(query, "stay");
			total=(int)(Math.ceil(count/8.0)); 
			return total;
		}
		 public List<StayVO> stay_data(int page) {
			 List<StayVO> list = new ArrayList<StayVO>();
			 int rowSize=8;
			 int skip = (page * rowSize) - rowSize;
			 Query query = new Query();
			 query.with(new Sort(Sort.Direction.ASC,"dataSid"));// dataSid�� �����ؼ� �������ڴ�.
			 query.skip(skip).limit(rowSize);//skip ������ limit�ִ�ġ
			 list = mt.find(query, StayVO.class,"stay");// find = select , findOne = selectOne(�ϳ��������ö�)
			 return list;
		 }
		 public StayVO stay_detail(String dataSid) {
			 StayVO vo = new StayVO();
			 BasicQuery query = new BasicQuery("{dataSid:'"+dataSid+"'}"); //�׳� Query, ������ ���ǰ����ö� BasicQuery
			 vo=mt.findOne(query, StayVO.class,"stay");
			 return vo;
		 }
}
