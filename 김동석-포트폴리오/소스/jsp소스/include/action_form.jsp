<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<form id="actionForm" action="/ds/board/index" method="get">
	<input type="hidden" name="pageNum" 
	value="${criteria.pageNum}"/>
	<input type="hidden" name="amount" 
	value="${empty criteria.amount ? '8' : criteria.amount}"/>
	<input type="hidden" name="type" 
	value="${criteria.type}"/>
	<input type="hidden" name="keyword" 
	value="${criteria.keyword}"/>
</form>