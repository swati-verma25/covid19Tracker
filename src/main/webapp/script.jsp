 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
 
  <script src="${contextPath}/resources/vendor/jquery/jquery.min.js"></script>
  <script src="${contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="${contextPath}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
  <script src="${contextPath}/resources/vendor/chart.js/Chart.min.js"></script>
  <script src="${contextPath}/resources/js/app.min.js"></script>
  <script src="${contextPath}/resources/js/blockUI.js"></script>
  <script src="${contextPath}/resources/js/global.js"></script>
  <script src="${contextPath}/resources/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
 <%--  <script src="${contextPath}/resources/dt/dataTables.bootstrap4.min.js"></script> --%>
  <script src="${contextPath}/resources/dt/jquery.dataTables.min.js"></script>
  <script>
  $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI); 
  </script>
