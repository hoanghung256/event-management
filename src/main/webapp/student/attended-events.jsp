<%-- 
    Document   : student-particapated-events
    Created on : Sep 27, 2024, 10:25:08?AM
    Author     : ThangNM
--%>

<%@include file="../include/student-layout-header.jsp"%>

<section>
    <div class="app__slide-wrapper">
            <div class="breadcrumb__area">
               <div class="breadcrumb__wrapper mb-35">
                  <div class="breadcrumb__main">
                     <div class="breadcrumb__inner">
                        <div class="breadcrumb__icon">
                           <i class="flaticon-home"></i>
                        </div>
                        <div class="breadcrumb__menu">
                           <nav>
                              <ul>
                              <li><span><a href="dashboard.html">Home</a></span></li>
                                    <li class="active"><span>Attended Events</span></li>
                              </ul>
                           </nav>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <!--Bat dau content cua page o day-->
          <div class="pb-20">
            <div class="">
               <div class="" id="myTabContent">
                  <div class="" id="day-tab-1-pane" role="tabpanel" aria-labelledby="day-tab-1" tabindex="0">
                      
                        <!--BODY GO HERE-->
                         <div class="body__card-wrapper">
                           <div class="attendant__wrapper mb-35">
                              <table>
                                 <thead>
                                    <tr>
                                       <th>Club Name</th>
                                       <th>Event</th>
                                       <th>Date</th>
                                       <th>Action</th>
                                    </tr>
                                 </thead>
                                 <tbody>
                                        <c:forEach var="event" items="${page.datas}">
                                            <tr>
                                                <td>
                                                    <div class="attendant__user-item">
                                                        <div class="registration__user-thumb">
                                                            <img src="${event.avatarPath}" alt="Club Logo">
                                                        </div>
                                                        <div class="attendant__user-title">
                                                            <span>${event.organizerName}</span>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="attendant__seminar">
                                                        <span>${event.fullname}</span>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="attendant__date">
                                                        <span>${event.dateOfEvent}</span>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="attendant__action">
                                                        <button class="input__btn" type="submit">Feedback</button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                 </tbody>
                              </table>
                           </div>
                             <!<!-- pagination controls -->
                           <div class="basic__pagination d-flex align-items-center justify-content-end">
                             <nav>
                                <ul>
                                    <c:forEach var="i" begin="0" end="${page.totalPage}">
                                        <c:choose>
                                            <c:when test="${i == 0 && page.currentPage > 0}">
                                                <li>
                                                    <a href="attended?page=${page.currentPage - 1}">
                                                        <i class="fa-regular fa-arrow-left-long"></i>
                                                    </a>
                                                </li>
                                            </c:when>
                                            <c:when test="${i >= page.currentPage && i <= page.currentPage + 4}">
                                                <c:choose>
                                                    <c:when test="${i == page.currentPage}">
                                                        <li>
                                                            <span class="current">${i + 1}</span>
                                                        </li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li>
                                                            <a href="attended?page=${i}">${i + 1}</a>
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:when test="${i == page.currentPage + 5 && page.currentPage + 5 < page.totalPage - 1}">
                                                <li> ... </li>
                                            </c:when>
                                            <c:when test="${i == page.totalPage - 1 && page.currentPage + 5 < page.totalPage - 1}">
                                                <li>
                                                    <a href="attended?page=${page.totalPage - 1}">
                                                       ${page.totalPage}
                                                    </a>
                                                </li>
                                            </c:when>
                                            <c:when test="${i == page.totalPage - 1 && page.currentPage < page.totalPage - 1}">
                                                <li>
                                                    <a href="attended?page=${page.currentPage + 1}">
                                                        <i class="fa-regular fa-arrow-right-long"></i>
                                                    </a>
                                                </li>
                                            </c:when>
                                        </c:choose>
                                    </c:forEach>
                                </ul>
                             </nav>
                           </div>
                        </div>
                  </div>
               </div>
            </div>
         </div>
         <!--End content cua page-->
        </div>
</section>

<%@include file="../include/master-footer.jsp" %>