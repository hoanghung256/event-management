<%-- 
    Document   : registered-event
    Created on : Oct 13, 2024, 4:10:12?PM
    Author     : Administrator
--%>
<style>
    .popup__overlay {
        display: none; /* Hidden by default */
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        justify-content: center;
        align-items: center;
        z-index: 9999;
    }

    .popup__content {
        background-color: white;
        padding: 20px;
        border-radius: 15px;
        width: 400px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        position: relative;
        animation: popupFadeIn 0.3s ease;
    }
.popup__button-group {
        display: flex;
        justify-content: center;
        gap: 15px;
        margin-top: 20px;
    }
    @keyframes popupFadeIn {
        from {
            opacity: 0;
            transform: scale(0.8);
        }
        to {
            opacity: 1;
            transform: scale(1);
        }
    }

    .input__btn {
        padding: 5px 10px;
        font-size: 12px;
        border: 1px solid #ccc;
        border-radius: 4px;
        background-color: #f1f1f1;
        cursor: pointer;
    }

    .input__btn:hover {
        background-color: #e1e1e1;
    }

</style>
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
                                    <li><span><a href="<c:url value="/home"/>">Home</a></span></li>
                                    <li class="active"><span>Register Events</span></li>
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
                                <table id="eventRegistered" class="display" >
                                    <thead>
                                        <tr>
                                            <th>Club Name</th>
                                            <th>Event</th>
                                            <th>Date</th>
                                            <th>Role</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="event" items="${registeredEvents}">
                                            <tr>
                                                <td>
                                                    <div class="attendant__user-item">
                                                        <div class="registration__user-thumb">
                                                            <span>${event.organizer.fullname}</span>
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
                                                    <div class="attendant__role">
                                                        <span>${event.role}</span>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div style="display:flex; width:90%; gap: 10px; justify-content: space-between;">
                                                        <button class="element__btn border-yellow" style="height: 40px; font-size: 13px; padding: 0 10px;" type="submit" onclick="redirectToEventDetails('${event.id}')">Details</button>
                                                        <button class="input__btn" style="height: 40px;padding: 0 10px; font-size: 13px;" type="button" onclick="openPopup('${event.id}', '${event.role}')">Cancel</button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <!--End content cua page-->

</section>
<div class="popup__overlay" id="cancelPopup">
    <div class="popup__content">
        <h3>Confirm cancel registration for this Event?</h3>
        <form id="cancelForm" method="POST" action="<c:url value='/student/registered-event'/>">
            <input type="hidden" name="eventId" id="eventId" value="">
            <input type="hidden" name="action" value="cancel">
            <input type="hidden" name="role" id="role" value="">
            <div class="popup__button-group">
                <button id="cancelDeleteBtn" style="height: 40px;" class="element__btn red-bg " type="button" onclick="closePopup()">No</button>
                <button id="confirmDeleteBtn"  style="height: 40px;" class="element__btn green-bg" type="button" onclick="cancelRegister()">Yes</button>
            </div>
        </form>
    </div>
</div>




<script>
    //phan trang cua js
    $(document).ready(function () {
        $('#eventRegistered').DataTable({
            "pageLength": 0, // Number of rows per page
            "searching": true,
            "lengthChange": false,
            "pagingType": "simple_numbers",
            "paginate": {
                "first": "First",
                "last": "Last",
                "next": "Next",
                "previous": "Previous"
            }

        });
    });
</script>                             
<script>
    function redirectToEventDetails(id) {

        window.location.href = "<c:url value='/event-detail'/>?eventId=" + id;
    }

    function openPopup(eventId, role) {
        document.getElementById('eventId').value = eventId;
        document.getElementById('role').value = role;
        document.getElementById('cancelPopup').style.display = 'flex';
    }

    function closePopup() {
        document.getElementById('cancelPopup').style.display = 'none';
    }

    function cancelRegister() {
        const form = document.getElementById('cancelForm');
        form.submit();
    }
</script>
<%@include file="../include/master-footer.jsp" %>