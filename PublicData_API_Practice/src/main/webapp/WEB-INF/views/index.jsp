<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
</style>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=04a1c15e89e8b9d355902843f002048b&libraries=services"></script>


<!--
<script>
	function addr() {
		new daum.Postcode({
			oncomplete : function(data) {
				var roadAddr = data.roadAddress;
				document.getElementById("addr").value = roadAddr;
				close();
			}
		}).open();
	}
</script>
-->
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<input type="button" id="test" onclick="click()"
		value="공공 데이터 api 불러오기">
	<br>
	<br>
	<div id="map" style="width: 80%; height: 600px; margin-top: 10px;"></div>

	<script type="text/javascript">
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div
				mapOption = {
					center : new kakao.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
					level : 5
				// 지도의 확대 레벨
				};

				//지도를 미리 생성
				var map = new kakao.maps.Map(mapContainer, mapOption);
					
				//마커를 미리 생성
				var marker = new kakao.maps.Marker({
					position : new kakao.maps.LatLng(37.537187, 127.005476),
					map : map
				});
	$('#test').on('click',function() {
		var myurl = '';
			$.ajax({
				url : myurl,
				type : 'GET',
				dataType: 'json'
			}).done(function(data) {
				console.log(data);
				alert('성공');
			}).fail(function(data) {
				alert('실패');
				}); 
	});
</script>
</body>
</html>