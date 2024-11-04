<%-- 
    Document   : student-particapated-events
    Created on : Sep 27, 2024, 10:25:08?AM
    Author     : ThangNM
--%>

<%@include file="../include/student-layout-header.jsp"%>

<style>
    .popup__overlay {
        display: none; /* ?n popup m?c ??nh */
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

    /* Popup content: khung chính c?a popup */
    .popup__content {
        background-color: white;
        padding: 20px;
        border-radius: 15px;
        width: 700px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        position: relative;
        animation: popupFadeIn 0.3s ease;
    }

    .popup__close {
        position: absolute;
        top: 10px;
        right: 10px;
        width: 20px;
        height: 20px;
        cursor: pointer;
        background: url('close-icon.png') no-repeat center;
        background-size: contain;
    }

    .singel__input-field {
        margin-bottom: 15px;
    }
      @media only screen and (max-width: 768px) {
        .popup__content {
            width: 90%;
        }

        .breadcrumb__wrapper, .basic__pagination, .attendant__wrapper {
            padding: 10px;
        }

        .attendant__user-title span {
            font-size: 14px;
        }

        .status__tag {
            font-size: 0.9em;
        }

        /* Center elements on mobile */
        .breadcrumb__menu, .attendant__action, .attendant__seminar, .attendant__date {
            text-align: center;
        }

        /* Adjust font sizes */
        h3, label, .input__btn {
            font-size: 1rem;
        }
   
    }
</style>

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
                                    <li><span><a class="acolor" href="<c:url value="/home"/>">Home</a></span></li>
                                    <li class="active"><span>Attended Events</span></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--Send feeback popup-->
        <div class="popup__overlay" id="feedback-form">
            <div class="popup__content">
                <span class="popup__close" id="closePopup"></span>
                <h3 id="feedback-event-fullname"></h3>
                <form action="<c:url value="/student/feedback" />" method="POST">
                    <input hidden name="eventId" id="feedback-event-id">
                    <div class="singel__input-field mb-15 ">
                        <label class="input__field-text">Feedback content</label>
                        <textarea id="feedbackContent" name="content" class="form-control" rows="5" required></textarea>
                    </div>
                    <c:if test="${not empty error}">
                        <div style="color: red; margin-bottom: 15px;">${error}</div>
                        <script>
                            document.getElementById('feedback-form').style.display = 'flex';
                        </script>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div style="color: green; margin-bottom: 15px;">${success}</div>
                        <script>
                            document.getElementById('feedback-form').style.display = 'flex';
                        </script>
                    </c:if>
                    <button class="input__btn" type="submit">Send</button>
                </form>
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
                                            <th>Club</th>
                                            <th>Event Name</th>
                                            <th>Date</th>
                                            <th class="text-center">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="eventData" items="${page.datas}">
                                            <c:set var="event" value="${eventData[0]}"/>
                                            <c:set var="isFeedback" value="${eventData[1]}"/>
                                                <tr>
                                                    <td>
                                                        <div class="attendant__user-item">
                                                            <div class="user__portfolio-thumb">
                                                                <img src="<c:url value="${event.organizer.avatarPath}" />" alt="Club Logo">
                                                            </div>
                                                            <div class="attendant__user-title">
                                                                <span>${event.organizer.acronym}</span>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="attendant__seminar">
                                                            <span id="event-fullname-${event.id}">${event.fullname}</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="attendant__date">
                                                            <span id="date">${event.dateOfEvent}</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="attendant__action">
                                                            <c:choose>
                                                                <c:when test="${isFeedback == true}">
                                                                    <span class="status__tag bg-green">Feedback Sent</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <button class="input__btn h-75" onclick="sendFeedback(${event.id})">Feedback</button> 
                                                                </c:otherwise>    
                                                            </c:choose>
                                                                
                                                        </div>
                                                    </td>
                                                </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <!-- pagination controls -->
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

    <script type="text/javascript">
        window.addEventListener('click', function (event) {
            const popup = document.getElementById('feedback-form');
            if (event.target === popup) {
                popup.style.display = 'none';
            }
        });


        function sendFeedback(id) {
            const fullname = document.getElementById('event-fullname-' + id).innerHTML;

            document.getElementById("feedback-event-fullname").textContent = fullname;
            document.getElementById("feedback-event-id").value = id;

            document.getElementById('feedback-form').style.display = 'flex';
        }
        ;
    </script>
</section>

<%@include file="../include/master-footer.jsp" %>