<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
 .date_input{			/* input type="date" 수정	*/
 	width:150px;		/* 넓이는 150px 			*/
 	padding-right:5px; 	/* 우측 5px만큼 간격			*/
 }
 
  .rightBtn{
 	float: right;		/* 저장, 수정, 삭제, 행추가, 인쇄 버튼 우측 정렬 */
 }
</style>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/mres10/paymentStatusMstDetails.js"></script>

<script type="text/javascript">

$(function(){
 
	$(".sub_title").text("설비및수불현황");	//서브타이틀
	var addList = "${addList}";		//add:행추가 / normal:일반 출력

	var selectCalDate = "${selectDate}";	//업무코드		기준년도
	$("#selectCalDate").val(selectCalDate);	//페이지 진입 시 selectBox 선택
	
	//-----
	//행추가
	//-----
	if("add" == addList){
		
		$("#tableUp").text("수정 완료");			//수정 버튼의 글자를	 수정 완료로 변경
		$("#tableSave").attr("disabled", true);	//저장 버튼 비활성화	 수정 중일 때 
		$("#tableDel").attr("disabled", true);	//삭제 버튼 비활성화	 수정 중일 때 
		$("#tableAdd").attr("disabled", true);	//행추가 버튼 비활성화 수정 중일 때 
		
	};//if
   	
});

</script>

<body>
		
	<div class="search_wrap">
	
		<!-- 버튼 모음입니다. --> 
		<button id="tablePrint"	class="basin_btn rightBtn" onclick="window.print()">인쇄</button>
		<button id="tableAdd"	class="basin_btn rightBtn">행추가</button>	
		<button id="tableDel"	class="basin_btn rightBtn">삭제</button>	
		<button id="tableUp"	class="basin_btn rightBtn">수정</button>	
		<button id="tableSave"	class="basin_btn rightBtn">저장</button>	
		
		<!-- 달력 -->
	 	<div class="search_con">
			<div class="search_title">기준년도</div>
			<select class="default_select w70" id="selectCalDate" name="selectCalDate">
				<c:forEach var="calDate" items="${calDate}" varStatus="calDateNum">
					<option value="${calDate}">${calDate}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	
	
	<!-- 셀렉트박스 조회용 히든 폼 -->
	<form id="selectForm" name="selectForm"  action="paymentStatusList" autocomplete="off">
		<input type="hidden" id="baseYear"	name="baseYear"	value ="">
		<input type="hidden" id="addList" 	name ="addList" value ="">
		<input type="hidden" id="selectDate" name ="selectDate" value ="">
	</form>
	
<!-- 게시글 있을 때. --> 
	<table class="view_top_center_table">
		<tr>
			<td>체크</td>
			<td>품명</td>
			<td>단위</td>
			<td>이월재고</td>
			<td>입고</td>
			<td>출고</td>
			<td>금월재고</td>
			<td>비고</td>
		</tr>
		<c:set var="number" value="${paymentStatusCnt}" />
		<c:forEach var="paymentStatusList" items="${paymentStatusList}" varStatus="paymentStatusNum">
			<c:if test = "${paymentStatusList.payment_status_seq == 0}">
				<tr>	
					<td><input type="checkbox" id="table_check" name="table_check" value="${paymentStatusList.payment_status_seq}" checked></td>
					<td><input class="default_input con_wrap_100" id="" 	type="text"	value="${paymentStatusList.product_name}" maxlength="25"></td>
					<td><input class="default_input con_wrap_100" id="" 	type="text"	value="${paymentStatusList.product_unit}" maxlength="10"></td>
					<td><input class="default_input con_wrap_100" id="carried_forward" 	type="text"	value="${paymentStatusList.carried_forward}" 	readonly="readonly"></td>
					<td><input class="default_input con_wrap_100" id="enter" 	type="text"	value="${paymentStatusList.enter}" maxlength="21"></td>
					<td><input class="default_input con_wrap_100" id="exodus" 	type="text"	value="${paymentStatusList.exodus}" maxlength="21"></td>
					<td><input class="default_input con_wrap_100" id="" 	type="text"	value="${paymentStatusList.this_month}" 		readonly="readonly"></td>
					<td><input class="default_input con_wrap_100" id="" 	type="text"	value="${paymentStatusList.remark}" maxlength="150"></td>
				</tr>
			</c:if>
			<c:if test = "${paymentStatusList.payment_status_seq != 0}">
				<tr>
					<td><input type="checkbox" id="table_check" name="table_check" value="${paymentStatusList.payment_status_seq}"></td>
					<td><input class="default_input con_wrap_100" id="" 	type="text"	value="${paymentStatusList.product_name}" 		readonly="readonly" maxlength="25"></td>
					<td><input class="default_input con_wrap_100" id="" 	type="text"	value="${paymentStatusList.product_unit}" 		readonly="readonly" maxlength="10"></td>
					<td><input class="default_input con_wrap_100" id="carried_forward" 	type="text"	value="${paymentStatusList.carried_forward}" 	readonly="readonly"></td>
					<td><input class="default_input con_wrap_100" id="enter" 	type="text"	value="${paymentStatusList.enter}" 			readonly="readonly" maxlength="21"></td>
					<td><input class="default_input con_wrap_100" id="exodus" 	type="text"	value="${paymentStatusList.exodus}" 		readonly="readonly" maxlength="21"></td>
					<td><input class="default_input con_wrap_100" id="" 	type="text"	value="${paymentStatusList.this_month}" 		readonly="readonly"></td>
					<td><input class="default_input con_wrap_100" id="" 	type="text"	value="${paymentStatusList.remark}" 			readonly="readonly" maxlength="150"></td>
				</tr>
			</c:if>
		</c:forEach>
	</table>


<div>
</div>