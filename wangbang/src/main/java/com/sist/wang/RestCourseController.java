package com.sist.wang;

import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RestCourseController {

    @RequestMapping(value="course/recommand_data.do")//course/recommand_data.do
    public String chart_recommand_data(int no){
    	
    	no=no==0?1:no;
    	String result="";
    	if(no==1)
    		result="�ٴ�,ȣ��,�߰�,�ü��� ����,������,����";
    	else if(no==2)
    		result="���,�ػ깰,����,�ѽ�,���,������,�,������,�и�,����";
    	else if(no==3)
    		result="�߰�,����,��å,���,��ȭ,���,����,������,�ٴ�";
    	
    	return result;
    }
    
	
}
