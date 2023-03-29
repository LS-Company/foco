<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false"%>
<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'ID='+=loginId}"/>
<style>
    * {
        margin: 0px;
        box-sizing: border-box;
        font-size: 11px;
    }

    html {
        width: 100%;
        display: flex;
        justify-content: center;
        padding-top: 20px;
        padding-bottom: 20px;
    }

    body {
        width: 45%;
        border: 1px solid black;
    }

    input{
        border: 1px solid black;
        border-radius: 3px;
        line-height: 35px;
        font-size: 12px;
        padding-left: 10px;
        padding-right: 10px;
    }


    .wrapper {
        padding: 10px;
    }

    div {
        padding-top: 3px;
        padding-bottom: 8px;
    }

    .title {
        text-align: center;
        font-weight: 700;
    }

    .email input {
        width: 100%;
    }

    .name input {
        width: 100%;
    }

    .password input {
        width: 100%;
    }

    .passwordCheck input {
        width: 100%;
    }

    .phone {
        display: flex;
        justify-content: space-between;
        line-height: 35px;
    }

    #phone1 {
        width: 18%;
    }

    #phone2 {
        width: 30%;
    }

    #phone3 {
        width: 30%;
    }

    .auth {
        display: flex;
        justify-content: space-between;
    }

    .timer {
        display: flex;
        justify-content: space-between;
    }

    .auth div {
        width: 30%;
        text-align: center;
        font-weight: 700;
        font-size: 15px;
    }

    .auth button {
        width: 70%;
    }

    .timer div {
        width: 30%;
        text-align: center;
        font-weight: 700;
        font-size: 15px;
    }

    .timer button {
        width: 70%;
    }

    .area select {
        width: 100%;
        height: 40px;
    }

    .gender {
        text-align: center;
    }

    .signUp button {
        width: 100%;
        cursor:pointer;
    }

    button{
        cursor: pointer;
        height: 30px;
    }

    .error{
        font-size: 1px;
        height: 20px;
        color:red;
        font-weight: 700;
    }
</style>
<html>
<head>
    <meta charset="UTF-8">
    <title>fastcampus</title>
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
</head>
<body>
<div id="menu">
    <ul>
        <li id="logo">fastcampus</li>
        <li><a href="<c:url value='/'/>">Home</a></li>
        <li><a href="<c:url value='/board/list'/>">Board</a></li>
        <li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
        <li><a href="<c:url value='/registerAdd'/>">Sign in</a></li>
        <li><a href=""><i class="fa fa-search"></i></a></li>
    </ul>
</div>

<div class="wrapper">
    <div class="title"><h1 style="font-size: 21px;">회원가입</h1></div>
    <div class="email">
        <input id="email" type="text" placeholder="이메일을 입력해 주세요.">
        <div id="emailError" class="error"></div>
    </div>
    <div class="name">
        <input id="name"  type="text" placeholder="이름을 입력해 주세요.">
        <div id="nameError" class="error"></div>
    </div>
    <div class="password">
        <input id="password" type="password" placeholder="비밀번호를 입력해 주세요.">
        <div id="passwordError" class="error"></div>
    </div>
    <div class="passwordCheck">
        <input id="passwordCheck" type="password" placeholder="비밀번호를 다시 입력해 주세요.">
        <div id="passwordCheckError" class="error"></div>
    </div>
    <div class="phone">
        <input id="phone1" type="text" size="1" maxlength="3" oninput="changePhone1()"> -
        <input id="phone2" type="text" size="3" maxlength="4" oninput="changePhone2()"> -
        <input id="phone3" type="text" size="3" maxlength="4" oninput="changePhone3()">

    </div>
    <div class="auth">
        <div id="certificationNumber">000000</div>
        <button disabled id="sendMessage" onclick="getToken()">인증번호 전송</button>
    </div>

    <div class="timer">
        <div id="timeLimit">03:00</div>
        <button disabled id="completion" onclick="checkCompletion()">인증확인</button>
    </div>
    <div class="area">
        <select id="area">
            <option selected disabled>Select Language</option>
            <option>한국어</option>
            <option>인천</option>
            <option>경기</option>
        </select>
        <div id="areaError" class="error"></div>
    </div>
    <div class="gender">
        <input id="gender_man" type="radio" name="gender">남성
        <input id="gender_woman" type="radio" name="gender">여성
        <div id="genderError" class="error"></div>
    </div>
    <div class="line">
        <hr>
    </div>
    <div class="signUp">
        <button id="signUpButton" disabled onclick="signUpCheck()">가입하기</button>
    </div>
</div>
</body>
</html>
