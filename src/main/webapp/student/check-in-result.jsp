<%-- 
    Document   : check-in-result
    Created on : Oct 24, 2024, 2:55:41 PM
    Author     : hoang hung 
--%>

<%@include file="../include/student-layout-header.jsp"%>

<section class="pt-5">
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
                                    <li><span><a href="<c:url value="/home"/>">Home</a></span></li>
                                    <li class="active"><span>Check-in</span></li>
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
                <div id="myTabContent">
                    <div class="" id="day-tab-1-pane" role="tabpanel" aria-labelledby="day-tab-1" tabindex="0">

                        <!--BODY GO HERE-->
                        <div class="body__card-wrapper">
                            <div class="attendant__wrapper mb-35">
                                <h2 class="text-success">${message}</h2>
                                <h2 class="text-danger">${error}</h2>
                                <p>Thank you for attendance!</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%@include file="../include/master-footer.jsp" %>
