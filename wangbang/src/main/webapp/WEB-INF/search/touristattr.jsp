<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.0/react.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.0/react-dom.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.23/browser.min.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>

    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="images/favicon.png">
    <!-- Custom Stylesheet -->
    <link href="../css/style.css" rel="stylesheet">
    <style type="text/css">
    .form-control1{
    	padding: 0.375rem 0.75rem;
    font-size: 0.875rem;
    line-height: 1.5;
    color: #495057;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    border-radius: 0.25rem;
    transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}
    }
    </style>
</head>
<body>
<div class="card shadow mb-4">
        <div class="row">
	         <div class="card-header py-3">
	              <h2 class="m-0 font-weight-bold text-primary text-center">
						관광 명소
	              </h2>
	              	<div class="header-left" id="root">
	              	 <script type="text/babel">
		class TouristAttr extends React.Component{
			  // 데이터 저장하는 변수 설정  => props(속성:불변) / state(상태:데이터 변경) 
			  constructor(props){
				  super(props);
				  // 변수 선언
				  this.state={
					data_json:[],
					page : 1,
					fd:''
				  }
				this.prevHandler=this.prevHandler.bind(this);
				this.nextHandler=this.nextHandler.bind(this);
				this.handleUserInput=this.handleUserInput.bind(this);
			  }

			handleUserInput(ss){
                  this.setState({fd:ss});
             }

			  //boxoffice_data.do?no=1
			  componentWillMount(){
				  var _this=this;
				  axios.get('http://localhost:8080/wang/search/themetour_data.do',{
					  params:{
						  page:1
					  }
				  }).then((response)=>{
					  _this.setState({data_json:response.data});
				  });
			  }
		
		prevHandler(){
       		this.setState({page:this.state.page>1?this.state.page-1:this.state.page});
      		var _this=this;
       			axios.get('http://localhost:8080/wang/search/touristattr_data.do',{
         	  	 params:{
         	     	  page:_this.state.page-1
            		}
        		}).then(function (response) {
         	   	_this.setState({data_json:response.data});
        		})
			
    	}
        
		nextHandler(){
        	this.setState({page:this.state.page<300?this.state.page+1:this.state.page});
        	var _this=this;
        	axios.get('http://localhost:8080/wang/search/touristattr_data.do',{
            	params:{
                	page:_this.state.page+1
            	}
        	}).then(function (response) {
            _this.setState({data_json:response.data});
        	})
		}

			render(){
					
                 const html=this.state.data_json.map((m)=>{
                      if(m.dataTitle.indexOf(this.state.fd)==-1)
                      {
                          return;
                      }
					return (	 
					<div className="col-md-6 col-lg-3">
                    	<div className="card">
                                    <a href={"../search/touristattr_detail.do?dataSid="+m.dataSid}><img src={m.mainimgthumb} alt="" width="360" height="300"/></a>
                                    <div className="card-body">
                                        <h5 className="card-title">{m.dataTitle }</h5>
                                        <p className="card-text">{m.tel }</p>
                                        <p className="card-text">{m.addr }</p>
                                        <p className="card-text"><small className="text-muted">{m.info }</small>
                                        </p>
                              </div>
                           </div>
					</div>
                 ) 
				});
               return (
                 <div>
				<SearchBar fd={this.state.fd} onUserInput={this.handleUserInput}/>
				<div className="row">
                            {html}
						</div>
                   <div className="text-center">
						
						<div style={{"padding-bottom":"30px"}}>
                  			<input type={"button"} value={"이전"} className={"btn btn-lg btn-danger"} onClick={this.prevHandler}/>
							{this.state.page} page / 300 pages                   			

							<input type={"button"} value={"다음"} className={"btn btn-lg btn-primary"} onClick={this.nextHandler}/>
      					</div> 
                    </div>
				</div>
					
                )
             }
		}

	      class SearchBar extends React.Component{
            constructor(props){
               super(props);
               this.handleChange=this.handleChange.bind(this);
            }
            handleChange()
            {
                this.props.onUserInput(this.filterText.value);
            }
            render(){
                return (
                   <div className="input-group icons" style={{"padding-bottom" : "30px"}}>
	                   <input type="search" style={{"width":"40%", "display": "initial"}} className="form-control1"placeholder="Search Dashboard" aria-label="Search Dashboard" value={this.props.fd}
                            ref={(input)=>this.filterText=input} onChange={this.handleChange}/>
	                    </div>
                )
            }
         }        
				ReactDOM.render(<TouristAttr />,document.getElementById('root'))
						</script>
						
	                </div>
			 </div>
         </div>
</div>
</body>
</html>