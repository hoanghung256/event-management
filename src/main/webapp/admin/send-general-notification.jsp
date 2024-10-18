<%-- 
    Document   : send-general-notification
    Created on : Oct 11, 2024, 8:57:22?PM
    Author     : AnhNQ
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../include/admin-layout-header.jsp"%>

<section>
    <div class="app__slide-wrapper">
        <div class="breadcrumb__area">
            <div class="breadcrumb__wrapper mb-35">
                <div class="breadcrumb__main container">
                    <div class="breadcrumb__inner col-md-12">
                        <div class="breadcrumb__icon">
                            <i class="flaticon-home"></i>
                        </div>
                        <div class="breadcrumb__menu">
                            <nav>
                                <ul>
                                    <li><span><a href="<c:url value="/club/dashboard"/>">Dashboard</a></span></li>
                                    <li class="active"><span>Send notification</span></li>
                                </ul>
                            </nav>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Event Table -->
    <div class="pb-20">
        <div class="row">
            <div class="body__card-wrapper">
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="day-tab-1-pane" role="tabpanel">
                        <div>
                            <form action="send-general-notification" method="POST">
                                <div class="mb-3">
                                    <h5>Notification message</h5>
                                </div>
                                <div class="mb-3">
                                    <label for="notificationContent" class="form-label">Message Content</label>
                                    <textarea class="form-control" id="notificationContent" name="content" rows="4" required></textarea>
                                </div>
                                <c:if test="${not empty numberOfReceivers}">
                                    <script>
                                        alert('Notification has been sent to ${numberOfReceivers} users.');
                                    </script>
                                </c:if>
                                <h5>Select receivers to send notification:</h5>
                                <div class="attendant__wrapper mb-35 row">
                                    <div class="mt-10 col-md-6">
                                        <select class="form-select" id="receiver" name="receiver" required>
                                            <option value="" disabled selected>Select receiver group</option>
                                            <option value="student">All Students</option>
                                            <option value="club">All Clubs</option>
                                        </select>
                                    </div>
                                </div>
                                <button type="submit" class="btn element__btn border-yellow">Send Notification</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
</script>
<%@include file="../include/master-footer.jsp" %>
