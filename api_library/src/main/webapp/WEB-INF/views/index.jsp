<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body style="background-color:beige;">
<script type="text/javascript">
function click() {
	  $.ajax({
			url : "index",
			type : 'GET',
			dataType : "json",
			contentType : "application/json;charset:UTF-8"
			})
	.done(function(r) {
		console.log(r);
		alert('성공');
		}).fail(function(r) {
		alert('실패');
	});
});
</script>
	<table style="margin: 0 auto; background-color:purple;">
		<tr>
			<td><input type="text" name="detailAddress" id="address" placeholder="장소 검색하기" style="height: 25px;"></td>
			<td><button type="button" id="searchBtn" onclick="click()" style="height: 30px;">찾기</button></td>
		</tr>
	</table>
	<div id="map" style="width: 100%; height: 90vh;"></div>

	<!-- kakao API -->
	<script type="text/javascript">
	</script>
		
	<script>
	// 마커를 담을 배열입니다
		var markers = [];
		var mapContainer = document.getElementById('map') // 지도를 표시할 div
		,mapOption = {
			center : new kakao.maps.LatLng(37.565568, 126.978149), //지도의 중심좌표 
			level : 3	// 지도의 확대 레벨 
		};

		// 지도를 생성
		var map = new kakao.maps.Map(mapContainer, mapOption);
		$('#searchBtn').click(function() { //버튼을 click했을때 

		// 주소-좌표 변환 객체를 생성
		var geocoder = new kakao.maps.services.Geocoder();
		// 주소로 좌표를 검색
		geocoder.addressSearch($('#address').val(),function(result, status) {
		// 정상적으로 검색이 완료됐으면 
		if (status === kakao.maps.services.Status.OK) {
			var coords = new kakao.maps.LatLng(	result[0].y,result[0].x);
					// 결과값으로 받은 위치를 마커로 표시합니다
					var marker = new kakao.maps.Marker({
					map : map,
					position : coords
					});

					// 인포윈도우로 장소에 대한 설명을 표시합니다
					var infowindow = new kakao.maps.InfoWindow({
					content : '<div style="width:150px;text-align:center;padding:6px 0;">장소</div>'
					});
					infowindow.open(map, marker);

					// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					map.setCenter(coords);
					}
				});
			});
		
	</script>
	
	
</body>
</html>