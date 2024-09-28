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
                                        <c:forEach var="event" items="${event}">
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
                                                        <span>${event.fullname}</a></span>
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
                           <div class="basic__pagination d-flex align-items-center justify-content-end">
                              <nav> 
                                 <ul>
                                    <li>
                                       <a href="#">1</a>
                                    </li>
                                    <li>
                                       <span class="current">2</span>
                                    </li>
                                    <li>
                                       <a href="#">3</a>
                                    </li>
                                    <li>
                                       <a href="#">4</a>
                                    </li>
                                    <li>
                                       <a href="#">
                                          <i class="fa-regular fa-arrow-right-long"></i>
                                       </a>
                                    </li>
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