<%-- 
    Document   : manage-files-admin
    Created on : Oct 22, 2024, 6:34:40 PM
    Author     : hoang hung 
--%>

<%@include file="../include/admin-layout-header.jsp"%>

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
                                    <li><span><a href="<c:url value="/admin/dashboard"/>">Dashboard</a></span></li>
                                    <li class="active"><span>Review files</span></li>
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
                        <div class="card__header-title">
                            <h4>Submitted files</h4>
                        </div>
                    </div>
                </div>
            </div>

            <div class="popup__overlay" id="process-popup">
                <div class="popup__content">
                    <span class="popup__close" id="close"></span>
                    <h3>Processing file application</h3>
                    <hr/>
                    <a id="processing-file-name" style="text-decoration: underline"></a>
                    <c:if test="${not empty error}">
                        <div class="error-message" style="color: red; margin-bottom: 15px;">${error}</div>
                        <script>
                            document.getElementById('deleteConfirmationPopup').style.display = 'flex';
                        </script>
                    </c:if>
                        <form action="<c:url value="/admin/file" />" method="POST">
                            <div class="singel__input-field mb-15">
                                <label class="input__field-text">Process note: </label>
                                <input type="text" name="processNote" required>
                                <input type="text" id="processing-file-id" name="id" hidden>
                            </div>
                            <div class="popup__button-group">
                                <input class="element__btn red-bg h-75" type="submit" name="action" value="Request change">
                                <input class="element__btn green-bg h-75" type="submit" name="action" value="Approved">
                                <input class="element__btn red-bg h-75" type="submit" name="action" value="Rejected">
                            </div>
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
                                                    <th>Send by</th>
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
                                                                <span><a href="/profile?id=${document.submittedBy.id}">${document.submittedBy.acronym}</a></span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="attendant__seminar">
                                                                <span id="file-name-${document.id}">${document.displayName}</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="attendant__seminar">
                                                                <!--<span><a href="">${document}</a></span>-->
                                                                <span>${document.type}</span>
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
                                                                            <a class="dropdown__item" id="file-path-${document.id}" href="<c:url value="${document.path}" />">Download</a>
                                                                            <a class="dropdown__item" href="javascript:void(0)" onclick="processPopup('${document.id}')" />Process</a>
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

                                <!-- Paging control -->
                                <div class="basic__pagination d-flex align-items-center justify-content-end">
                                    <nav>
                                        <ul>
                                            <c:forEach var="i" begin="0" end="${page.totalPage}">
                                                <c:choose>
                                                    <c:when test="${i == 0 && page.currentPage > 0}">
                                                        <li>
                                                            <a href="<c:url value="/admin/file?page=${page.currentPage - 1}"/>">
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
                                                                    <a href="<c:url value="/admin/file?page=${i}"/>">${i + 1}</a>
                                                                </li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:when test="${i == page.currentPage + 5 && page.currentPage + 5 < page.totalPage - 1}">
                                                        <li> ... </li>
                                                        </c:when>
                                                        <c:when test="${i == page.totalPage - 1 && page.currentPage + 5 < page.totalPage - 1}">
                                                        <li>
                                                            <a href="<c:url value="/admin/file?page=${page.totalPage - 1}"/>">
                                                                ${page.totalPage}
                                                            </a>
                                                        </li>
                                                    </c:when>
                                                    <c:when test="${i == page.totalPage - 1 && page.currentPage < page.totalPage - 1}">
                                                        <li>
                                                            <a href="<c:url value="/admin/file?page=${page.currentPage + 1}"/>">
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
                const popup = document.getElementById('process-popup');
                if (event.target === popup) {
                    popup.style.display = 'none';
                }
            });

            function processPopup(fileId) {
                fileName = document.getElementById('file-name-' + fileId).innerHTML;
                filePath = document.getElementById('file-path-' + fileId).href;
                processFileNameHolder = document.getElementById("processing-file-name");
                processFileNameHolder.innerHTML = fileName;
                processFileNameHolder.href = filePath;
                document.getElementById("processing-file-id").value = fileId;
                
                event.preventDefault();
                document.getElementById('process-popup').style.display = 'flex';
            }
        </script>
</section>

<%@include file="../include/master-footer.jsp"%>                            
