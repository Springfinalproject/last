<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.0/react.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.0/react-dom.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.23/browser.min.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function(){
	$('.').click(function(){
		if($('#select1').text()=='' || $('#select2').text()==''){
			alert("위에서부터 순서대로 지정해주세요");
		}else{
			var area=$('#select2_').attr("title");
			$.ajax({
				type:'post',
				url:'../reserve/cheif.do',
				data:{area:area},
				success:function(response){
					$('#print').html(response);
				}
			});
		}
	});
});

</script>
</head>
<body>

	<div id="root">
		
	</div>
		<script type="text/babel">
			class BoardList extends React.Component{
				constructor(props){	
					super(props);
					this.state={
						data_json:[],
						data_detail:{},
						statetype:0
					}
				}
				componentWillMount(){
					var _this=this;
					axios.get('http://localhost:8080/wang/board/list_json.do').then(
						(response)=>{
							_this.setState({data_json:response.data});
							console.log(response.data);
						}
					)
					
				}
				handleClickNew(){
					this.setState({statetype:'new'});
					
				}
				handleClick(m){
					this.setState({data_detail:m,statetype:m.no});
					console.log(this.state.data_detail);
					
				}
				render(){
					const html=this.state.data_json.map((m)=>
						<tr onClick={this.handleClick.bind(this,m)}>
							<td style={{"height":"41px"}}>{m.no!=0?m.no:""}</td>
							<td style={{"height":"41px"}}>{m.subject }</td>
							<td style={{"height":"41px"}}>{m.dbday }</td>
							<td style={{"height":"41px"}}>{m.id }</td>
							<td style={{"height":"41px"}}>{m.repl!=-1?m.repl:""}</td>
						</tr>					
					)	
					
					if(this.state.statetype=='0'){
						var cls=<BoardDefault />;
						
					}else if(this.state.statetype=='new'){
						var cls=<Boardnew />;
						
					}else{
						var cls=<BoardDetail data_detail={this.state.data_detail} />;
						
					}
					console.log(this.state.statetype);

					return(	
	<div className="row">
		<div className="col-6" >
			<div className="card" style={{"height":"600px"}}>
				<div className="card-body">
					{cls}
				</div>
			</div>
		</div>
		<div className="col-6">
			<div className="card">
				<div className="card-body">
					<h4 className="card-title">React Board</h4>
					<div className="table-responsive">
						<table className="table table-striped table-bordered zero-configuration">
							<thead>
								<tr>
									<th>번호</th>
									<th width="400px">제목</th>
									<th>날짜</th>
									<th>id</th>
									<th>댓글수</th>
								</tr>
							</thead>
							<tbody>
								{html}							
							</tbody>
							<tfoot>
								<tr>
									<td colSpan="4" className="text-center"><a>page</a></td>
									<td className="text-right"><a onClick={this.handleClickNew.bind(this)}>새글</a></td>
								</tr>	
							</tfoot>
						</table>
					</div>
				</div>
			</div>
		</div>
		
		
	</div>
	

					)
				}
				componentDidMount(){	//
					
				}
			}
		class BoardDetail extends React.Component{
			render(){
				return(
<div className="container">
     <h4>content</h4>
     <div className="row">
       <table className="table">
        <tr>
         <th width="20%" className="text-center bg-secondary text-white">번호</th>
         <td width="30%" className="text-center no">{this.props.data_detail.no}</td>
         <th width="20%" className="text-center bg-secondary text-white">작성일</th>
         <td width="30%" className="text-center">{this.props.data_detail.dbday}</td>
        </tr>
        <tr>
         <th width="20%" className="text-center bg-secondary text-white">아이디</th>
         <td width="30%" className="text-center">{this.props.data_detail.id}</td>
         <th width="20%" className="text-center bg-secondary text-white">조회수</th>
         <td width="30%" className="text-center">{this.props.data_detail.hit}</td>
        </tr>
        <tr>
         <th width="20%" className="text-center bg-secondary text-white">제목</th>
         <td colSpan="3" className="text-left">{this.props.data_detail.subject}</td>
        </tr>
        <tr>
          <td colSpan="4" valign="top" height="200" className="text-left">
           <pre style={{"background-color":"white","white-space":"pre-wrap"}}>{this.props.data_detail.content}</pre>
          </td>
        </tr>
        <tr>
          <td colSpan="4" className="text-right">
           <form method="post" action="../board/delete.do">
				<input type="submit" value="삭제" className="btn btn-xs btn-danger"/>
				<input type="hidden" name="no" value={this.props.data_detail.no}/>
			</form>
            <form method="post" action="../board/update.do">
				<input type="submit" value="수정" className="btn btn-xs btn-success"/>
				<input type="hidden" name="no" value={this.props.data_detail.no}/>
			</form>
			
          </td>
        </tr>
       </table>
     </div>
     
   </div>
				)
			}
		}

		class BoardDefault extends React.Component{
			render(){
				return(
					<div className="text-center">
						<img src="../images/blank.png" style={{"width":"700px","height":"530px"}} className="img-rounded"/>
					</div>
				)
			}
		}
		class Boardnew extends React.Component{
			render(){
				return(
			
  <div className="container">
   <h4>new content</h4>
   <div className="row">
     <form method="post" action="insert_ok.do">
     <table className="table">
      <tr>
       <th width="15%" className="text-right bg-secondary">제목</th>
       <td width="85%" className="text-left">
         <input type="text" name="subject" size="100"/>
       </td>
      </tr>
	  <br/>
      <tr>
       <th width="15%" className="text-right bg-secondary">내용</th>
       <td width="85%" className="text-left">
         <textarea rows="20" cols="100" name="content"></textarea>
       </td>
      </tr>
      <tr>
        <td colSpan="2" className="text-center">
         <input type="submit" value="글쓰기" className="btn btn-xs btn-danger"/>
         <input type="button" value="취소" className="btn btn-xs btn-primary"
          onclick="javascript:history.back()"/>
        </td>
      </tr>
     </table>
     </form>
   </div>
  </div>
				)
			}
		}
			
		ReactDOM.render(<BoardList />,document.getElementById('root'));
		</script>


</body>
</html>