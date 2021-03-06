<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
 
  .leftBtn{
 	float: left;		/* 버튼 좌측 정렬 */
 }
 
 .rightBtn{
 	float: right;		/* 저장, 수정, 삭제, 행추가, 인쇄 버튼 우측 정렬 */
 }
 }
</style>
<script type="text/javascript">

$(function(){

	$(".sub_title").text("시설물점검현황");				//서브타이틀
	var selectDivision = "${inspection_division}";	//업무코드		1:승강기 점검표 2:화재예방 점검표
	$("#selectCode").val(selectDivision);			//페이지 진입 시 selectBox 선택
	
	//------------------
	//셀렉트박스 조회
	//------------------
	$('#selectCode').change(function() {
		
		var inspection_division = $(this).val();			//셀렉트박스	1:승강기 점검표 2:화재예방 점검표
	    $("#inspection_division").val(inspection_division);	//업무구분
	    var selectCalDate = $("#selectCalDate").val();		//기준년도
		$("#selectDate").val(selectCalDate);				//기준년도 FORM
		$("#selectForm").submit();							//서브밋
		
	});
	
	//------------------
	//기준년도 조회
	//------------------
	$('#selectCalDate').change(function() {
		
		var selectCalDate = $(this).val();					//기준년도
		$("#selectDate").val(selectCalDate);				//기준년도 FORM
		var inspection_division = $("#selectCode").val();	//셀렉트박스	1:승강기 점검표 2:화재예방 점검표
	    $("#inspection_division").val(inspection_division);	//업무구분
		$("#selectForm").submit();							//서브밋  
		
	}); 
	
	var selectCalDate = "${selectCalDate}";	//업무코드		기준년도
	$("#selectCalDate").val(selectCalDate);	//페이지 진입 시 selectBox 선택
	
	$("#tableNew").click(function(){
		location.href='./liftContnet?inspection_division=${inspection_division}';
	})	
})

</script>
<body>

	<div class="search_wrap">
	
		<!-- 점검구분 -->
		<div class="search_con">
			<div class="search_title">점검구분</div>
			<select class="default_select w150" id="selectCode" name="selectCode">
			    <option value="1">승강기 점검표</option>
			    <option value="2">화재예방 점검표</option> 
			</select>
		</div>
		
		<!-- 달력 -->
	 	<div class="search_con">
			<div class="search_title">기준년도</div>
			<select class="default_select w70" id="selectCalDate" name="selectCalDate">
				<c:forEach var="calDate" items="${calDate}" varStatus="calDateNum">
					<option value="${calDate}">${calDate}</option>
				</c:forEach>
			</select>
		</div>
			
		<button id="tableNew"	class="basin_btn rightBtn">신규</button>
	</div>
	
	<!-- 셀렉트박스 조회용 히든필드  -->
	<form id="selectForm" name="selectForm"  action="<%=request.getContextPath()%>/liftList" autocomplete="off">
		<input id="inspection_division" name="inspection_division" type="hidden" value ="">
		<input id="selectDate" name ="selectDate" type="hidden" value	="">
	</form>
	
	<table class="view_top_center_table">
		<tr>
			<td>번호</td>
			<td>점검분야</td>
			<td>건물명</td>
			<td>점검업체</td>
			<td>점검일자</td>
		</tr>
		
		<c:set var="number" value="${liftCnt}" />
		<c:forEach var="liftList" items="${liftList}" varStatus="LiftNum">
			<tr id="liftList">
				<td>${liftCnt - LiftNum.index}</td>
				<td>${liftList.inspection_field}</td>
				<td>${liftList.building_name}</td>
				<td><a href="<%=request.getContextPath()%>/liftContnet?lift_seq=${liftList.lift_seq}&inspection_division=${inspection_division}">${liftList.inspection_company}</a></td>
				<td>${liftList.inspection_date}</td>	
			</tr>
		</c:forEach>  
	</table>


<div>
</div>