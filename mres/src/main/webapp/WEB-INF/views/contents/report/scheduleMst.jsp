<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style> 
 .rightBtn{
 	float: right;		/* 저장, 수정, 삭제, 행추가, 인쇄 버튼 우측 정렬 */
 }
 .defaultLabel{
 	width: 100px;
 }
 
</style>

<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/mres10/scheduleMstDetails.js"></script>
<script type="text/javascript">

$(function(){

	$(".sub_title").text("연간스케쥴");		//서브타이틀
	var selectDivision = "${division}";		//업무코드		AS01:행정업무 / AS02:회계업무 / AS03:조경업무 / AS04:시설업무
	$("#selectCode").val(selectDivision);	//페이지 진입 시 selectBox 선택

	var selectCalDate = "${selectCalDate}";	//업무코드		기준년도
	$("#selectCalDate").val(selectCalDate);	//페이지 진입 시 selectBox 선택
	
	var addList = "${addList}";				//add:행추가 / normal:일반 출력
	
	//-----
	//행추가
	//-----
	if("add" == addList){
		
		$("#tableUp").text("수정 완료");			//수정 버튼의 글자를	 수정 완료로 변경
		$("#tableSave").attr("disabled", true);	//저장 버튼 비활성화	 수정 중일 때 
		$("#tableDel").attr("disabled", true);	//삭제 버튼 비활성화	 수정 중일 때 
		$("#tableAdd").attr("disabled", true);	//행추가 버튼 비활성화 수정 중일 때 
		
	};//if
	
	function maxVauleCheck(str){
		
		var regExp = /[^(가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9)]/gi;
		var result = str;
	
	}//최대 값 체크
});

</script>

<body>
	
	<div class="search_wrap">

		<!-- 조회용 콤보박스입니다. -->
		<div class="search_con">
			<div class="search_title">업무구분</div>
			<select class="default_select w70" id="selectCode" name="selectCode">
			    <option value="AS01">행정 업무</option>
			    <option value="AS02">회계 업무</option> 
			    <option value="AS03">조경 업무</option>
			    <option value="AS04">시설 업무</option>
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
		
		<!-- 버튼 모음입니다. -->
		<button id="tablePrint"	class="basin_btn rightBtn" onclick="window.print()">인쇄</button>
		<button id="tableAdd"	class="basin_btn rightBtn">행추가</button>	
		<button id="tableDel"	class="basin_btn rightBtn">삭제</button>	
		<button id="tableUp"	class="basin_btn rightBtn">수정</button>	
		<button id="tableSave"	class="basin_btn rightBtn">저장</button>	

	</div>
	
	<!-- 전송할 폼 -->
	<form id="selectForm" name="selectForm"  action="<%=request.getContextPath()%>/scheduleList" autocomplete="off">
		<input id="division" name="division" type="hidden" value ="">
		<input id="addList" name ="addList" type="hidden" value	="">
		<input id="selectDate" name ="selectDate" type="hidden" value	="">
	</form>

	<table class="jq_table"> 
		<tr> 
			<td rowspan="2">체크</td>
			<td rowspan="2">업무내용</td>
			<td rowspan="2">점검주기</td>
			<td colspan="12">년간 월별 업무 일정</td>
			<td rowspan="2">관리주체</td>
			<td rowspan="2">파일첨부</td>
		</tr>
		<tr>
			<td>1월</td>
			<td>2월</td>
			<td>3월</td>
			<td>4월</td>
			<td>5월</td>
			<td>6월</td>
			<td>7월</td>
			<td>8월</td>
			<td>9월</td>
			<td>10월</td>
			<td>11월</td>
			<td>12월</td>
		</tr>
		<c:set var="number" value="${scheduleCnt}" />
		<c:forEach var="scheduleList" items="${scheduleList}" varStatus="scheduleNum">
			<tr>
				<c:if test = "${scheduleList.schedule_seq == 0}">
					<td class="tableCount">	<input name="table_check" type="checkbox"	value="${scheduleList.schedule_seq}" disabled="true" checked></td>
					<td class="" id="">	<input class="default_input w250 maxVal" id="workInfo" 		type="text"		value="${scheduleList.work_info}" maxlength="25"></td>
					<td class=""><input class="default_input w120 check_sycle${scheduleNum.count-1}" value="${scheduleList.check_cycle}" readonly="readonly"></td>
					<td class="tableCheck"><input id="schedule_jan" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_jan}" <c:if test="${scheduleList.schedule_jan ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_feb" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_feb}" <c:if test="${scheduleList.schedule_feb ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_mar" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_mar}" <c:if test="${scheduleList.schedule_mar ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_apr" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_apr}" <c:if test="${scheduleList.schedule_apr ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_may" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_may}" <c:if test="${scheduleList.schedule_may ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_jun" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_jun}" <c:if test="${scheduleList.schedule_jun ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_jul" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_jul}" <c:if test="${scheduleList.schedule_jul ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_aug" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_aug}" <c:if test="${scheduleList.schedule_aug ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_sep" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_sep}" <c:if test="${scheduleList.schedule_sep ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_oct" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_oct}" <c:if test="${scheduleList.schedule_oct ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_nov" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_nov}" <c:if test="${scheduleList.schedule_nov ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_dec" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_dec}" <c:if test="${scheduleList.schedule_dec ne '0'}">checked</c:if>></td>
					<td class=""><input class="default_input w120 maxVal" id="entity" type="text" value="${scheduleList.entity}" maxlength="10"></td>
					<td class=""><input class="default_input w120 uploadBtn" type="button"  value="${scheduleList.file_name}"></td>
				</c:if>	
				<c:if test = "${scheduleList.schedule_seq != 0}">
					<td class="tableCount"><input type="checkbox" name="table_check" value="${scheduleList.schedule_seq}"></td>
					<td class=""><input class="default_input w250 maxVal" id="workInfo" 	type="text"		value="${scheduleList.work_info}" readonly="readonly"></td>
					<td class=""><input class="default_input w120 check_sycle${scheduleNum.count-1}" value="${scheduleList.check_cycle}" readonly="readonly"></td>
					<td class="tableCheck"><input id="schedule_jan" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_jan}" <c:if test="${scheduleList.schedule_jan ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_feb" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_feb}" <c:if test="${scheduleList.schedule_feb ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_mar" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_mar}" <c:if test="${scheduleList.schedule_mar ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_apr" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_apr}" <c:if test="${scheduleList.schedule_apr ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_may" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_may}" <c:if test="${scheduleList.schedule_may ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_jun" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_jun}" <c:if test="${scheduleList.schedule_jun ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_jul" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_jul}" <c:if test="${scheduleList.schedule_jul ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_aug" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_aug}" <c:if test="${scheduleList.schedule_aug ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_sep" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_sep}" <c:if test="${scheduleList.schedule_sep ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_oct" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_oct}" <c:if test="${scheduleList.schedule_oct ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_nov" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_nov}" <c:if test="${scheduleList.schedule_nov ne '0'}">checked</c:if>></td>
					<td class="tableCheck"><input id="schedule_dec" name="checkMonth${scheduleNum.count-1}" type="checkbox" value="${scheduleList.schedule_dec}" <c:if test="${scheduleList.schedule_dec ne '0'}">checked</c:if>></td>
					<td class=""><input class="default_input w120 maxVal" id="entity" type="text" value="${scheduleList.entity}" readonly="readonly"></td>
					<td class=""><input class="default_input w120 uploadBtn" type="button"  value="${scheduleList.file_name}"></td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
 
    
<!-- 공지사항 등록 팝업 -->
<div id="schedule_reg_popup" class="mres_popup">
	<div class="pop" style="width: 545px">
		<div class="pop_top">
			<p class="popup_title">공지사항 등록</p>
			<a class="right schedule_reg_popup_close" href="#;"><img src="<%=request.getContextPath()%>/resources/img/close.png" alt="닫기" width="35px" /></a>
		</div>
		<form id="fileForm" name="fileForm" action="/fileUpload" method="post" autocomplete="off" enctype="multipart/form-data">
		<input type="hidden" id="table_seq" name="table_seq" value=0>
		<input type="hidden" id="table_name" name="table_name" value="">
 		<input type="hidden" id="file_seq" name="file_seq" value=0>
 
		<div class="pop_con">
			<table class="view_top_table">
				<tr>
					<th>첨부파일</th>
					<td>
					<input type="file" placeholder="" class="default_input" id="fileUpId" name="fileUpId">
					<input type="text" class="default_input" id="filename" name="filename" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td><input type="text" class="default_input con_wrap_100" name="file_content" required="required" placeholder="파일 내용"></td>
				</tr>
			</table> 
			<table id="fileTable" class="view_top_table">
				<tr>
					<th>업로드일자</th>
					<th>내용</th>
					<th>파일이름</th>		
				</tr>
			</table>
		</div>
		</form>
		<div class="pop_bottom">
			<a href="#;" class="basin_btn" id="imgUp">저장</a>
			<a href="#;" class="basin_btn schedule_reg_popup_close">취소</a>
		</div>
	</div>
</div>
<!-- 공지사항 등록 팝업 END-->
    
	
<div>
</div>