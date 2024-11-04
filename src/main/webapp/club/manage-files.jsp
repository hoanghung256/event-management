<%-- 
    Document   : manage-files-club
    Created on : Oct 19, 2024, 10:25:34 PM
    Author     : hoang hung 
--%>

<%@include file="../include/club-layout-header.jsp"%>

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
        width: 500px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        position: relative;
        animation: popupFadeIn 0.3s ease;

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
                                    <li><span><a href="<c:url value="/club/dashboard"/>">Dashboard</a></span></li>
                                    <li class="active"><span>Manage files</span></li>
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
                        <!--                        <div class="card__header-icon">
                                                    <i class="flaticon-ticket-1"></i>
                                                </div>-->
                        <div class="card__header-title">
                            <h4>Submitted files</h4>
                        </div>
                    </div>
                    <div class="breadcrum__button">
                        <a class="breadcrum__btn event__popup-active">Send application<i class="fa-regular fa-plus"></i></a>
                    </div>
                </div>
            </div>

            <div class="popup__overlay" id="send-application-popup">
                <div class="popup__content">
                    <span class="popup__close" id="closePopup"></span>
                    <h3>Send application</h3>
                    <hr/>
                    <form action="<c:url value="/club/file" />" method="POST" enctype="multipart/form-data">
                        <!--<input type="hidden" name="action" value="add" />-->
                        <div class="singel__input-field py-3">
                            <label class="input__field-text">File type: </label>
                            <div class="contact__select">
                                <select name="type" required>
                                    <option value="REPORT" selected>REPORT</option>
                                    <option value="PLAN">PLAN</option>
                                </select>
                            </div>
                        </div>
                        <div class="py-3">
                            <input type="file" name="file" required>
                        </div>
                        <hr/>

                        <c:if test="${not empty error}">
                            <div class="error-message" style="color: red; margin-bottom: 15px;">${error}</div>
                            <script>
                                document.getElementById('send-application-popup').style.display = 'flex';
                            </script>
                        </c:if>
                        <c:if test="${not empty message}">
                            <div class="error-message" style="color: green; margin-bottom: 15px;">${message}</div>
                            <script>
                                document.getElementById('send-application-popup').style.display = 'flex';
                            </script>
                        </c:if>
                        <button class="input__btn w-100" type="submit">Submit</button>
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
                                    <!-- Check if file list is empty -->
                                    <c:if test="${empty page.datas}">
                                        <div class="no-events">
                                            <span>No sent document</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty page.datas}">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>File name</th>
                                                    <th>Type</th>
                                                    <th>Sent date<th>
                                                        Process note
                                                    <th>Process date</th>
                                                    <th>Status</th>
                                                    <th>Action</th> <!-- ??? <th> tag automatically injected-->
                                                    <!--<th>Action</th>-->
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="document" items="${page.datas}">
                                                    <tr>
                                                        <td>
                                                            <div class="attendant__seminar">
                                                                <span>${document.displayName}</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="attendant__seminar">
                                                                <!--<span><a href="">${document}</a></span>-->
                                                                <span><a href="">${document.type}</a></span>
                                                            </div>
                                                        </td>

                                                        <td>
                                                            <div class="attendant__date">
                                                                <span id="datetime">${document.sendTime}</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="attendant__seminar">
                                                                <span>${document.processNote}</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="attendant__seminar">
                                                                <span id="datetime">${document.processTime}</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="attendant__seminar">
                                                                <c:choose>
                                                                    <c:when test="${document.status == 'APPROVED'}">
                                                                        <span class="status__tag bg-green">${document.status}</span>
                                                                    </c:when>
                                                                    <c:when test="${document.status == 'PENDING'}">
                                                                        <span class="status__tag warning-bg">${document.status}</span>
                                                                    </c:when>
                                                                    <c:when test="${document.status == 'REVIEWING'}">
                                                                        <span class="status__tag teal-bg">${document.status}</span>
                                                                    </c:when>
                                                                    <c:when test="${document.status == 'REQUEST_CHANGE'}">
                                                                        <span class="status__tag teal-bg">REQUEST CHANGE</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span>${document.status}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div>
                                                                <a href="<c:url value="${document.path}" />" class="text-decoration-underline">Download</a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:if>
                                </div>

                                <!-- Paging control -->
                                <div class="basic__pagination d-flex align-items-center justify-content-end">
                                    <nav>
                                        <ul>
                                            <c:forEach var="i" begin="0" end="${page.totalPage}">
                                                <c:choose>
                                                    <c:when test="${i == 0 && page.currentPage > 0}">
                                                        <li>
                                                            <a href="<c:url value="/club/file?page=${page.currentPage - 1}"/>">
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
                                                                    <a href="<c:url value="/club/file?page=${i}"/>">${i + 1}</a>
                                                                </li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:when test="${i == page.currentPage + 5 && page.currentPage + 5 < page.totalPage - 1}">
                                                        <li> ... </li>
                                                        </c:when>
                                                        <c:when test="${i == page.totalPage - 1 && page.currentPage + 5 < page.totalPage - 1}">
                                                        <li>
                                                            <a href="<c:url value="/club/file?page=${page.totalPage - 1}"/>">
                                                                ${page.totalPage}
                                                            </a>
                                                        </li>
                                                    </c:when>
                                                    <c:when test="${i == page.totalPage - 1 && page.currentPage < page.totalPage - 1}">
                                                        <li>
                                                            <a href="<c:url value="/club/file?page=${page.currentPage + 1}"/>">
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
            document.querySelector('.breadcrum__btn').addEventListener('click', function (event) {
                event.preventDefault();
                document.getElementById('send-application-popup').style.display = 'flex';
            });

            window.addEventListener('click', function (event) {
                const popup = document.getElementById('send-application-popup');
                if (event.target === popup) {
                    popup.style.display = 'none';
                }
            });
        </script>
</section>

<%@include file="../include/master-footer.jsp" %>
