package com.sist.wang;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.json.simple.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.sist.dao.ExperienceDAO;


@Controller
public class MainController {
   @RequestMapping("main/main.do")
   public String main_main(Model model)
   {
	   realData(model);
	   return "main";
   }
   
   public static void realData(Model model) { //�������� ���پ����� static
	   JSONArray list = new JSONArray();
	   ExperienceDAO edao = new ExperienceDAO();
	   list = edao.weather();
	   org.json.JSONArray temp =  (org.json.JSONArray) list.get(0);
		 
       String SKY = "";
       String TEM = "";
       String POP = "";
		 for(int i = 0 ; i < temp.length(); i++ ){
			    org.json.JSONObject temp_i = (org.json.JSONObject)temp.get(i);
	        	
	        	String category = (String) temp_i.get("category");
	        	String fcstValue =   String.valueOf(temp_i.get("fcstValue"));
	        	
	        	if(category.equals("SKY")){
	        		if(Integer.parseInt( fcstValue) >= 0 && Integer.parseInt( fcstValue) <= 5){
	        			SKY = "����";
	        		} else if( Integer.parseInt(fcstValue) >=6 && Integer.parseInt(fcstValue) <= 8){
	        			SKY ="��������";
	        		} else {
	        			SKY ="�帲";
	        		}
	        	}
	        	
	        	if(category.equals("T3H")){
	        		TEM= fcstValue;
	        	}
	        	if(category.equals("POP")){
	        		POP= fcstValue;
	        	}
	        } 
		 SimpleDateFormat day = new SimpleDateFormat ( "yyyy�� MM��dd��");
		 Date time = new Date();
		 String time1 = day.format(time);
		 model.addAttribute("time1", time1);
		 System.out.println("����Ʈ�ǰ��� "+list);
		 model.addAttribute("SKY", SKY);
		 System.out.println("��ī���ǰ���"+SKY);
		 model.addAttribute("TEM", TEM);
		 model.addAttribute("POP", POP);
		 //model.addAttribute("list", list);
   }
}
