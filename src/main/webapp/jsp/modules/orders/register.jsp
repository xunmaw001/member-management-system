<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<title>订单注册</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/xznstatic/css/font-awesome.min.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/xznstatic/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/xznstatic/css/animate.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/xznstatic/css/all.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/xznstatic/css/pink-violet.css" id="theme-change" class="style-change color-change">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/xznstatic/css/style-responsive.css">

	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets2/js/jquery.min.js"></script>

	<style type="text/css">
		.error{ color: red; }
	</style>
</head>

<body id="signup-page">
	<div class="page-form">
        <form id="registerForm" action="" method="post" class="form">
            <div class="header-content">
                <h1>订单注册</h1>
            </div>
            <div class="body-content">
                <hr>
                <div class="form-group mbn">
                    <a href="${pageContext.request.contextPath}/jsp/login.jsp" class="btn btn-warning">返 回</a>
                    <button id="submitBtn" type="button" class="btn btn-info pull-right">注 册</button>
                </div>
            </div>
        </form>
    </div>

	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets2/js/bootstrap.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.form.js"></script>
	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resources/js/validate/jquery.validate.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resources/js/validate/messages_zh.js"></script>
	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resources/js/validate/card.js"></script>

	<script type="text/javascript">
		
		<%@ include file="../../utils/menu.jsp"%>
		
		<%@ include file="../../utils/baseUrl.jsp"%>

		// 表单校验
		function validform() {
			return $("#registerForm").validate({ 
				rules: {
							tablename: {
				},
										userid: {
					required: true,
				},
										goodid: {
					required: true,
				},
										goodname: {
				},
										picture: {
				},
										buynumber: {
					required: true,
				},
										price: {
					required: true,
				},
										discountprice: {
					number: true,
				},
										total: {
					required: true,
				},
										discounttotal: {
					number: true,
				},
										type: {
					digits: true,
				},
										status: {
				},
										address: {
				},
									},
				messages: {
					tablename: {
					},
					userid: {
						required: "用户id不能为空",
					},
					goodid: {
						required: "商品id不能为空",
					},
					goodname: {
					},
					picture: {
					},
					buynumber: {
						required: "购买数量不能为空",
					},
					price: {
						required: "价格/积分不能为空",
					},
					discountprice: {
						number: "请输入数字",
					},
					total: {
						required: "总价格/总积分不能为空",
					},
					discounttotal: {
						number: "请输入数字",
					},
					type: {
						digits: "请输入整数",
					},
					status: {
					},
					address: {
					},
				}
			}).form();
		}
		// 添加表单校验方法
		function addValidation(){
			jQuery.validator.addMethod("isPhone", function(value, element) {
				var length = value.length;
				var mobile = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(17[0-9]{1}))+\d{8})$/;
				return this.optional(element) || (length == 11 && mobile.test(value));
			}, "请填写正确的手机号码");
			jQuery.validator.addMethod("isIdCardNo", function(value, element) {
				return this.optional(element) || idCardNoUtil.checkIdCardNo(value);
			}, "请正确输入您的身份证号码");
		}

		// 表单提交
		function submit() {
			if(validform()) {
				let data = {};
				let value = $('#registerForm').serializeArray();
				$.each(value, function (index, item) { 
					data[item.name] = item.value;
				});
				let json = JSON.stringify(data);
				$.ajax({ 
					type: "POST",
					url: baseUrl + "orders/register",
					contentType: "application/json",
					data:json,
					beforeSend: function(xhr) {xhr.setRequestHeader("token", window.sessionStorage.getItem('token'));},
					success: function(res){    
						if(res.code == 0){
						alert("注册成功!");
						window.location.href="${pageContext.request.contextPath}/jsp/login.jsp";
						}else if(res.code == 401){
							<%@ include file="../../static/toLogin.jsp"%> 	
						}else{
							alert(res.msg)
						}
					},
				});      
			}else {
				alert("表单未填完整或有错误");
			}
		}    

		function ready() {
			addValidation();
			//注册表单验证
		    $(validform());
			$('#submitBtn').on('click', function(e) {
				e.preventDefault();
				submit();
			});
		}
		document.addEventListener("DOMContentLoaded", ready);
	</script>
</body>

</html>
