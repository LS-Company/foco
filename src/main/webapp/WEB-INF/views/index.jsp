<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false"%>
<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'ID='+=loginId}"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp"
      crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js"></script>
<!DOCTYPE html>
<html>
<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: "Noto Sans KR", sans-serif;
    }
    a {
        text-decoration: none;
        color: black;
    }
    button,
    input {
        border: none;
        outline: none;
    }
    .board-container {
        width: 60%;
        height: 1200px;
        margin: 0 auto;
        /* border: 1px solid black; */
    }
    .search-container {
        background-color: rgb(253, 253, 250);
        width: 100%;
        height: 110px;
        border: 1px solid #ddd;
        margin-top : 50px;
        margin-bottom: 30px;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .search-form {
        height: 37px;
        display: flex;
    }
    .search-option {
        width: 100px;
        height: 100%;
        outline: none;
        margin-right: 5px;
        border: 1px solid #ccc;
        color: gray;
    }
    .search-option > option {
        text-align: center;
    }
    .search-input {
        color: gray;
        background-color: white;
        border: 1px solid #ccc;
        height: 100%;
        width: 300px;
        font-size: 15px;
        padding: 5px 7px;
    }
    .search-input::placeholder {
        color: gray;
    }
    .search-button {
        /* 메뉴바의 검색 버튼 아이콘  */
        width: 20%;
        height: 100%;
        background-color: rgb(22, 22, 22);
        color: rgb(209, 209, 209);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 15px;
    }
    .search-button:hover {
        color: rgb(165, 165, 165);
    }
    table {
        border-collapse: collapse;
        width: 100%;
        border-top: 2px solid rgb(39, 39, 39);
    }
    tr:nth-child(even) {
        background-color: #f0f0f070;
    }
    th,
    td {
        width:300px;
        text-align: center;
        padding: 10px 12px;
        border-bottom: 1px solid #ddd;
    }
    td {
        color: rgb(53, 53, 53);
    }
    .no      { width:150px;}
    .title   { width:50%;  }
    td.title   { text-align: left;  }
    td.writer  { text-align: left;  }
    td.viewcnt { text-align: right; }
    td.title:hover {
        text-decoration: underline;
    }
    .paging {
        color: black;
        width: 100%;
        align-items: center;
    }
    .page {
        color: black;
        padding: 6px;
        margin-right: 10px;
    }
    .paging-active {
        background-color: rgb(216, 216, 216);
        border-radius: 5px;
        color: rgb(24, 24, 24);
    }
    .paging-container {
        width:100%;
        height: 70px;
        display: flex;
        margin-top: 50px;
        margin : auto;
    }
    .btn-write {
        background-color: rgb(236, 236, 236); /* Blue background */
        border: none; /* Remove borders */
        color: black; /* White text */
        padding: 6px 12px; /* Some padding */
        font-size: 16px; /* Set a font size */
        cursor: pointer; /* Mouse pointer on hover */
        border-radius: 5px;
        margin-left: 30px;
    }
    .btn-write:hover {
        text-decoration: underline;
    }
</style>
<head>
    <meta charset="UTF-8">
    <title>fastcampus</title>
    <%--    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">--%>
    <link rel="stylesheet" href="<c:url value='/css/stylepractice.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
</head>
<body>
<div id="menu">
    <ul class="menubar">
        <li id="logo">fastcampus</li>
        <li><a href="<c:url value='/'/>">Home</a></li>
        <li><a href="<c:url value='/board/list'/>">Board</a></li>
        <li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
        <li><a href="<c:url value='/registerAdd'/>">Sign in</a></li>
        <li><a href=""><i class="fa fa-search"></i></a></li>
    </ul>
</div>
<div class="wrap">
    <div class="box1 clearfix">
        <div class="search-container">
            <form action="<c:url value="/board/list"/>" class="search-form" method="get">
                <select class="search-option" name="option">
                    <option value="A" ${option=='A' ? "selected" : ""}>제목+내용</option>
                    <option value="T" ${option=='T' ? "selected" : ""}>제목만</option>
                    <option value="W" ${option=='W' ? "selected" : ""}>작성자</option>
                </select>

                <input type="text" name="keyword" class="search-input" type="text" value="${param.keyword}" placeholder="검색어를 입력해주세요">
                <input type="submit" class="search-button" value="검색">
            </form>
            <button id="writeBtn" class="btn-write" onclick="location.href='<c:url value="/board/write"/>'"><i class="fa fa-pencil"></i> 글쓰기</button>
        </div>

        <table>
            <tr>
                <th class="no">번호</th>
                <th class="title">제목</th>
                <th class="writer">이름</th>
                <th class="regdate">등록일</th>
                <th class="viewcnt">조회수</th>
            </tr>
            <c:forEach var="boardDto" items="${list}">
                <tr>
                    <td class="no">${boardDto.bno}</td>
                    <td class="title"><a href="<c:url value="/board/read?bno=${boardDto.bno}&page=${ph.page}&pageSize=${ph.pageSize}"/>">${boardDto.title}</a></td>
                    <td class="writer">${boardDto.writer}</td>
                    <c:choose>
                        <c:when test="${boardDto.reg_date.time >= startOfToday}">
                            <td class="regdate"><fmt:formatDate value="${boardDto.reg_date}" pattern="HH:mm" type="time"/></td>
                        </c:when>
                        <c:otherwise>
                            <td class="regdate"><fmt:formatDate value="${boardDto.reg_date}" pattern="yyyy-MM-dd" type="date"/></td>
                        </c:otherwise>
                    </c:choose>
                    <td class="viewcnt">${boardDto.view_cnt}</td>
                </tr>
            </c:forEach>
        </table>
        <br>
        <div class="paging-container">
            <div class="paging">
                <c:if test="${totalCnt==null || totalCnt==0}">
                    <div> 게시물이 없습니다. </div>
                </c:if>
                <c:if test="${totalCnt!=null && totalCnt!=0}">
                    <c:if test="${ph.showPrev}">
                        <a class="page" href="<c:url value="/board/list?page=${ph.beginPage-1}"/>">&lt;</a>
                    </c:if>
                    <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
                        <a class="page ${i==ph.page? "paging-active" : ""}" href="<c:url value="/board/list?page=${i}"/>">${i}</a>
                    </c:forEach>
                    <c:if test="${ph.showNext}">
                        <a class="page" href="<c:url value="/board/list?page=${ph.endPage+1}"/>">&gt;</a>
                    </c:if>
                </c:if>
            </div>
        </div>
    </div>
    <div class="box2 clearfix">
        <!-- 환율 -->
        <ul class="money">
            <li><img src= "<c:url value='/img/us.png' />" alt="america"></li>
            <li><a href="#">1111.1&#8361;</a></li>
            <li><img src="<c:url value='/img/us.png' />" alt="america"></li>
            <li><a href="#">2222.2&#8361;</a></li>
            <li><img src="<c:url value='/img/us.png' />" alt="america"></li>
            <li><a href="#">3333.3&#8361;</a></li>
            <li><img src="<c:url value='/img/us.png' />" alt="america"></li>
            <li><a href="#">4444.4&#8361;</a></li>
        </ul>



        <!-- 아티클 -->
        <article>
            <!-- 뉴스 -->
            뉴스
        </article>
        <!--  어사이드 -->
        <aside>
            취업정보
        </aside>
    </div>
</div>
</body>
</html>