<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	/* String basePath = "";
	if("sars.99bill.net".equals(request.getServerName())){
		basePath = request.getScheme() + "://" + "sars.99bill.net/sor/app-monitor-bank/";
	}else{
		basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	} */
	String basePath = "https://sars.99bill.net/sor/app-monitor-bank/";
%>
<base href="<%=basePath%>">
<script src="jquery-1.9.1/jquery.min.js"></script>
<link href="css/dialog.css" rel="stylesheet">
<script src="js/dialog.js"></script>
