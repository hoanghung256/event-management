<%-- 
    Document   : organized-events
    Created on : Oct 9, 2024, 11:31:58?PM
    Author     : ThangNM
--%>

<%@include file="../include/admin-layout-header.jsp"%>
<%@ page import="com.fuem.models.Event" %>
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
                                    <li><span><a href="<c:url value="/admin/dashboard"/>">Dashboard</a></span></li>
                                    <li class="active"><span>Organized Events</span></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card__wrapper">
            <div class="card__header">
                <div class="card__header-top mb-5">
                    <div class="card__title-inner">
                        <div class="card__header-icon">
                            <i class="flaticon-ticket-1"></i>
                        </div>
                        <div class="card__header-title">
                            <h4>Event Organized List</h4>
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
                                    <!-- Check if organized list is empty -->
                                    <c:if test="${empty organizedList}">
                                        <div class="no-events">
                                            <span>No events registered yet</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty organizedList}">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>Event Name</th>
                                                    <th>Date</th>
                                                    <th>Category</th>
                                                    <th>Location</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="event" items="${organizedList}">
                                                    <tr>
                                                        <td>
                                                            <div class="attendant__seminar">
                                                                <span><a href="">${event.fullname}</a></span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="attendant__date">
                                                                <span>${event.dateOfEvent}</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div>
                                                                <span>${event.category.name}</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div>
                                                                <span>${event.location.description}</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="attendant__action">
                                                                <div class="card__header-dropdown">
                                                                    <div class="dropdown">
                                                                        <button>
                                                                            <svg class="dropdown__svg" width="20" height="4" viewBox="0 0 20 4" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                            <path d="M2 0.75C2.69036 0.75 3.25 1.30964 3.25 2C3.25 2.69036 2.69036 3.25 2 3.25C1.30964 3.25 0.75 2.69036 0.75 2C0.75 1.30964 1.30964 0.75 2 0.75Z" fill="white"></path>
                                                                            <path d="M7 0.75C7.69036 0.75 8.25 1.30964 8.25 2C8.25 2.69036 7.69036 3.25 7 3.25C6.30964 3.25 5.75 2.69036 5.75 2C5.75 1.30964 6.30964 0.75 7 0.75Z" fill="white"></path>
                                                                            <path d="M13.25 2C13.25 1.30964 12.6904 0.75 12 0.75C11.3096 0.75 10.75 1.30964 10.75 2C10.75 2.69036 11.3096 3.25 12 3.25C12.6904 3.25 13.25 2.69036 13.25 2Z" fill="white"></path>
                                                                            </svg>
                                                                        </button>
                                                                        <div class="dropdown-list">
                                                                            <a class="dropdown__item" href="#">Details</a>
                                                                            <a class="dropdown__item" href="#">Feedbacks</a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:if>
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