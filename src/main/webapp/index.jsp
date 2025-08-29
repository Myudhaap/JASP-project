<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
  String ctx = request.getContextPath();
%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
</head>
<body class="p-relative vh-100 d-flex flex-column overflow-hidden">
  <header class="z-3 shadow-sm">
    <nav class="navbar">
      <div class="w-100 h-100 d-flex justify-content-between align-items-center px-3 py-1">
        <div></div>
        <a href="<%=ctx%>/" class="navbar-brand fs-3 fw-bold">Management User</a>
        <a href="<%=ctx%>/auth/logout" class="btn btn-outline-primary">Log out</a>
      </div>
    </nav>
  </header>
  <main class="z-0 p-4 flex-grow-1 flex-shrink-1 bg-body-tertiary">
    <div class="mb-3">
      <h1 class="fs-3">Dashboard</h1>
      <span>Welcome <b>${userId}</b></span>
    </div>

    <div class="w-100 bg-white h-auto rounded shadow-sm p-3">
      <h2 class="fs-5">User List</h2>

      <div class="table-responsive mt-3">
        <table class="table table-striped table-bordered">
          <thead>
            <tr>
              <th style="width: 2rem">No</th>
              <th>Department</th>
              <th>Student ID</th>
              <th>Marks</th>
              <th>Pass %</th>
            </tr>
          </thead>
          <tbody>
            <c:set var="counter" value="1"/>
            <c:forEach var="dept" items="${students}">
              <c:set var="countPass" value="0"/>
              <c:forEach var="student" items="${dept.getStudents()}">
                <c:if test="${student.getMarks() >= 60}">
                  <c:set var="countPass" value="${countPass + 1}"/>
                </c:if>
              </c:forEach>

              <c:forEach var="student" items="${dept.getStudents()}" varStatus="status">
                <tr>
                  <th class="text-center">${counter}</th>
                  <c:if test="${status.first}">
                    <td rowspan="${dept.getStudents().size()}" style="text-align: center; vertical-align: middle;">
                        ${student.getDepartment().getDepartmentName()}
                    </td>
                  </c:if>
                  <th><span class="text-primary btn-modal" role="button" data-id="${student.getStudentId()}"><u>${student.getStudentId()}</u></span></th>
                  <th style="text-align: end;">${student.getMarks()}</th>
                  <c:if test="${status.first}">
                    <th rowspan="${dept.getStudents().size()}" style="text-align: center; vertical-align: middle;">
                      <c:set var="pers" value="${(countPass / dept.getStudents().size()) * 100}"/>
                      <fmt:formatNumber value="${pers}" type="number" maxFractionDigits="2" minFractionDigits="0" />
                    </th>
                  </c:if>
                </tr>
                <c:set var="counter" value="${counter + 1}"/>
              </c:forEach>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </main>

  <div class="modal fade" id="studentDetailModal" tabindex="-1" aria-labelledby="studentDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h1 class="modal-title fs-5" id="studentDetailModalLabel">Student Detail</h1>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body" id="studentModalBody">

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.min.js" integrity="sha384-G/EV+4j2dNv+tEPo3++6LCgdCROaejBqfUeNjuKAiuXbjrxilcCdDz6ZAVfHWe1Y" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

  <script>
    $(function(){
      $(".btn-modal").on("click", function(e){
        const studentId = $(this).data("id");

        console.log({studentId})
        $.ajax({
          url: "<%=ctx%>/student/detail",
          method: "GET",
          data: {
            id: studentId
          },
          dataType: "json",
          success: function(res) {
            if (res.success){
              const user = res.data
              const studentBodyModal = `
              <div class="row mb-2 g-3">
                <span class="col-md-4 fw-bold">
                  Student ID
                </span>
                <span class="col">
                  \${user.studentId}
                </span>
              </div>
              <div class="row mb-2 g-3">
                <span class="col-md-4 fw-bold">
                  Student Name
                </span>
                <span class="col">
                  \${user.studentName}
                </span>
              </div>
              <div class="row mb-2 g-3">
                <span class="col-md-4 fw-bold">
                  Gender
                </span>
                <span class="col">
                  \${user.studentId ? 'Laki-Laki' : 'Perempuan'}
                </span>
              </div>
              <div class="row mb-2 g-3">
                <span class="col-md-4 fw-bold">
                  Department
                </span>
                <span class="col">
                  \${user.department.departmentId} - \${user.department.departmentName}
                </span>
              </div>
              <div class="row mb-2 g-3">
                <span class="col-md-4 fw-bold">
                  Marks
                </span>
                <span class="col">
                  \${user.marks}
                </span>
              </div>
              <div class="row mb-2 g-3">
                <span class="col-md-4 fw-bold">
                  Status
                </span>
                <span class="col">
                  \${user.marks >= 60 ? 'Lulus' : 'Tidak Lulus'}
                </span>
              </div>
              `

              $("#studentModalBody").html(studentBodyModal)
              $("#studentDetailModal").modal("show")
            } else {
              console.log(res.message)
            }
          },
          error: function(){
            console.log("Interna Server Error")
          }
        })
      })
    })
  </script>
</body>
</html>