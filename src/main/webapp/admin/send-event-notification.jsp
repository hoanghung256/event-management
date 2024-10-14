<%-- 
    Document   : send-notification-for-event
    Created on : Oct 11, 2024, 8:56:37?PM
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
                            <form action="send-event-notification" method="POST" onsubmit="return validateForm()">
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
                                <h5>Select event to send notification:</h5>
                                <div class="attendant__wrapper mb-35">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>ID No</th>
                                                <th>Event Name</th>
                                                <th>Category</th>
                                                <th>Time</th>
                                                <th>Date</th>
                                                <th>Select</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="event" items="${upcomingEvents}">
                                                <tr>
                                                    <td><span>#${event.id}</span></td>
                                                    <td>
                                                        <div class="attendant__seminer">
                                                            <span>
                                                                <a href="<c:url value="/event-detail?eventId=${event.id}"/>">${event.fullname}</a>
                                                            </span>
                                                        </div>
                                                    </td>

                                                    <td><span>${event.category.name}</span></td>
                                                    <td><span id="time">${event.startTime}</span>-<span id="time">${event.endTime}</span></td>
                                                    <td><span id="date">${event.dateOfEvent}</span></td>
                                                    <td>
                                                        <input type="checkbox" id="event${event.id}" name="event-id" value="${event.id}">
                                                        <label for="event${event.id}" class="custom-checkbox"></label>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
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
    function validateForm() {
        const checkboxes = document.querySelectorAll('input[name="event-id"]:checked');
        if (checkboxes.length === 0) {
            alert('Please select at least one event to send the notification.');
            return false;
        }
        return true;
    }
</script>
<%@include file="../include/master-footer.jsp" %>
