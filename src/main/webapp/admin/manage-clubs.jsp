<%@include file="../include/admin-layout-header.jsp"%>
<style>
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

    /* Popup content: khung ch�nh c?a popup */
    .popup__content {
        background-color: white;
        padding: 20px;
        border-radius: 15px;
        width: 500px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        position: relative;
        animation: popupFadeIn 0.3s ease;

    }
    .search__bar input {
        margin-right: auto;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        width: 500px;
    }

    /* Hi?u ?ng fade in cho popup */
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

    .popup__content h3 {
        margin-top: 0;
        font-size: 18px;
        text-align: center;
        margin-bottom: 15px;
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


    /* ??nh d?ng c�c input */
    .singel__input-field {
        margin-bottom: 15px;
    }

    .singel__input-field input,
    .singel__input-field select {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 20px;
    }

    /* ??nh d?ng n�t submit */
    .input__btn {
        background-color: #28a745;
        color: white;
        border: none;
        padding: 10px 15px;
        cursor: pointer;
        border-radius: 5px;
        font-size: 14px;
    }

    .input__btn:hover {
        background-color: #218838;
    }
    .popup__button-group {
        display: flex;
        justify-content: center;
        gap: 15px;
        margin-top: 20px;
    }
    .search_add{
        display: flex;
        margin-left: auto;
    }
    .breadcrum__button{
        display: flex;
        padding-left: 120px;
    }
    .search__bar input {
        border: 1px solid #ccc;
        border-radius: 15px;
        width: 400px;
        height: fit-content;
    }


    .input-row {
        display: flex;
        justify-content: space-between;
    }

    .input-row .singel__input-field {
        flex: 1;
        margin-right: 15px;
    }

    .input-row .singel__input-field:last-child {
        margin-right: 0;
    }



</style>

<section>
    <div class="app__slide-wrapper">
        <div class="breadcrumb__area">
            <div class="breadcrumb__wrapper mb-35" style="padding: 0px;">
                <div class="breadcrumb__main">
                    <div class="breadcrumb__inner">
                        <div class="breadcrumb__icon">
                            <i class="flaticon-home"></i>
                        </div>
                        <div class="breadcrumb__menu">
                            <nav>
                                <ul>
                                    <li><span><a href="<c:url value='/admin/dashboard'/>">Dashboard</a></span></li>
                                    <li class="active"><span>Manage Clubs</span></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                    <div class="search_add d-flex justify-content-between align-items-center">
                        <form method="get" action="${pageContext.request.contextPath}/admin/manage-clubs">
                            <div class="search_add d-flex justify-content-between align-items-center">
                                <div class="search__bar d-flex">
                                    <input type="text" id="searchValue" name="searchValue" placeholder="Search by..." aria-label="Search students" />

                                </div>
                                <div class="col-md-1 input d-flex "  style="padding-bottom: 18px; margin-left: 5px;" >
                                    <button type="submit" " class="btn element__btn border-yellow find-button" >Find</button>
                                </div>
                                <div class="breadcrum__button">
                                    <a class="breadcrum__btn event__popup-active" style="width: 160px;">Add Club<i class="fa-regular fa-plus"></i></a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Popup for Delete Confirmation -->
        <div class="popup__overlay" id="deleteConfirmationPopup">
            <div class="popup__content">
                <span class="popup__close" id="closeDeletePopup"></span>
                <h3>Are you sure you want to delete?</h3>
                <c:if test="${not empty deleteError}">
                    <div class="error-message" style="color: red; margin-bottom: 15px;">${deleteError}</div>
                    <script>
                        document.getElementById('deleteConfirmationPopup').style.display = 'flex';
                    </script>
                </c:if>
                <div class="popup__button-group">
                    <button class="element__btn green-bg" style="height: 80%" id="confirmDeleteBtn" >Yes</button>
                    <button class="element__btn red-bg" style="height: 80%" id="cancelDeleteBtn" >No</button>
                </div>
            </div>
        </div>

        <!--Popup for Add New Clubs -->
        <div class="popup__overlay" id="addClubsPopup">
            <div class="popup__content">
                <span class="popup__close" id="closePopup"></span>
                <h3>Add New Club</h3>
                <form action="${pageContext.request.contextPath}/admin/manage-clubs" method="post">
                    <input type="hidden" name="action" value="add" />
                    <div class="singel__input-field mb-15 ">
                        <label class="input__field-text">Full Name</label>
                        <input type="text" name="fullname" required>
                    </div>
                    <div class="singel__input-field mb-15">
                        <label class="input__field-text"> Acronym </label>
                        <input type="text" name="acronym" required>
                    </div>
                    <div class="singel__input-field mb-15">
                        <label class="input__field-text">Email</label>
                        <input type="email" name="email" required>
                    </div>
                    <div class="singel__input-field mb-15">
                        <label class="input__field-text">Password</label>
                        <input type="password" name="password" required>
                    </div>
                    <div class="singel__input-field mb-15">
                        <label class="input__field-text">Confirm Password </label>
                        <input type="password" name="confirmpassword" required>
                    </div>
                    <c:if test="${not empty addError}">
                        <div class="error-message" style="color: red; margin-bottom: 15px;">${addError}</div>
                        <script>
                            document.getElementById('addClubsPopup').style.display = 'flex';
                        </script>
                    </c:if>
                    <button class="input__btn w-100" type="submit">Submit</button>
                </form>
            </div>
        </div>

        <!--Popup for Edit -->
        <div class="popup__overlay" id="editClub">
            <div class="popup__content">
                <span class="popup__close" id="closePopup"></span>
                <h3>Edit Club</h3>
                <form action="${pageContext.request.contextPath}/admin/manage-clubs" method="post">
                    <input type="hidden" name="action" value="edit" />
                    <input type="hidden" name="id" id="edit-id" />
                    <div class="singel__input-field mb-15 ">
                        <label class="input__field-text">Full Name</label>
                        <input type="text" name="fullname" required id="edit-fullname">
                    </div>
                    <div class="singel__input-field mb-15 ">
                        <label class="input__field-text">Acronym</label>
                        <input type="text" name="acronym" required id="edit-acronym">
                    </div>
                    <div class="singel__input-field mb-15">
                        <label class="input__field-text">Email</label>
                        <input type="email" name="email" id="edit-email" required>
                    </div>   

                    <button class="input__btn w-100" type="submit">Save</button>
                </form>
            </div>
        </div>
    </div>

    <div class="pb-20">
        <div class="">
            <div class="" id="myTabContent">
                <div class="" id="day-tab-1-pane" role="tabpanel" aria-labelledby="day-tab-1" tabindex="0">
                    <c:if test="${not empty searchError}">
                        <div class="alert alert-danger">${searchError}</div> 
                    </c:if>

                    <c:if test="${not empty deleteSuccess}">
                        <div class="alert alert-success" role="alert">
                            ${deleteSuccess}
                        </div>
                    </c:if>

                    <c:if test="${not empty addSuccess}">
                        <div class="alert alert-success" role="alert">
                            ${addSuccess}
                        </div>
                    </c:if>

                    <c:if test="${not empty editSuccess}">
                        <div class="alert alert-success" role="alert">
                            ${editSuccess}
                        </div>
                    </c:if>

                    <c:if test="${not empty deleteError}">
                        <div class="alert alert-danger" role="alert">
                            ${deleteError}
                        </div>
                    </c:if>
                    <c:if test="${not empty editError}">
                        <div class="alert alert-danger" role="alert">
                            ${editError}
                        </div>
                    </c:if>
                    <!--                    /*<c:if test="${not empty editError}">
                                            <div class="error-message" style="color: red; margin-bottom: 15px;">${editError}</div>
                                            <script>
                                                document.getElementById('editClub').style.display = 'flex';
                                            </script>
                    </c:if>*//-->
                </div>
                <div class="body__card-wrapper">
                    <div class="attendant__wrapper mb-35">
                        <c:choose>
                            <c:when test="${not empty page.datas}">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Acronym</th>
                                            <th>Email</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <c:forEach var="organizer" items="${page.datas}">
                                            <tr data-organizer-id="${organizer.id}">
                                                <td>
                                                    <div class="attendant__user-item">
                                                        <div class="attendant__user-title">
                                                            <span id="fullname-${organizer.id}">${organizer.fullname}</span>
                                                            <span style="display: none;" id="id-${organizer.id}">${organizer.id}</span>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="attendant__user-id">
                                                        <span id="acronym-${organizer.id}">${organizer.acronym}</span>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="attendant__email">
                                                        <span id="email-${organizer.id}">${organizer.email != null ? organizer.email : 'N/A'}</span>
                                                    </div>  
                                                </td>
                                                <td>
                                                    <div class="attendant__action">
                                                        <div class="card__header-dropdown">
                                                            <div class="dropdown">
                                                                <button>
                                                                    <svg class="attendant__dot" width="14" height="4" viewBox="0 0 14 4" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                    <path d="M2 0.75C2.69036 0.75 3.25 1.30964 3.25 2C3.25 2.69036 2.69036 3.25 2 3.25C1.30964 3.25 0.75 2.69036 0.75 2C0.75 1.30964 1.30964 0.75 2 0.75Z" fill="white"></path>
                                                                    <path d="M7 0.75C7.69036 0.75 8.25 1.30964 8.25 2C8.25 2.69036 7.69036 3.25 7 3.25C6.30964 3.25 5.75 2.69036 5.75 2C5.75 1.30964 6.30964 0.75 7 0.75Z" fill="white"></path>
                                                                    <path d="M13.25 2C13.25 1.30964 12.6904 0.75 12 0.75C11.3096 0.75 10.75 1.30964 10.75 2C10.75 2.69036 11.3096 3.25 12 3.25C12.6904 3.25 13.25 2.69036 13.25 2Z" fill="white"></path>
                                                                    </svg>
                                                                </button>
                                                                <div class="dropdown-list">
                                                                    <a class="dropdown__item" onclick="editOrganizerById('${organizer.id}')">Edit</a>
                                                                    <form action="${pageContext.request.contextPath}/manage-clubs" method="post" style="display: inline;">
                                                                        <input type="hidden" name="organizerId" value="${organizer.id}" />
                                                                        <input type="hidden" name="action" value="delete" />
                                                                        <a class="dropdown__item" href="javascript:void(0)" onclick="showDeleteConfirmation('${organizer.id}')">Delete</a>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <div>
                                    <div class="alert alert-danger" role="alert" >
                                        No club to show......
                                    </div>

                                </div>
                            </c:otherwise>
                        </c:choose>


                        <!<!-- pagination controls -->
                        <div class="basic__pagination d-flex align-items-center justify-content-end">
                            <nav>
                                <ul>
                                    <c:forEach var="i" begin="0" end="${page.totalPage}">
                                        <c:choose>
                                            <c:when test="${i == 0 && page.currentPage > 0}">
                                                <li>
                                                    <a href="manage-clubs?page=${page.currentPage - 1}&searchValue=${previousSearchValue}">
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
                                                            <a href="manage-clubs?page=${i}&searchValue=${previousSearchValue}">${i + 1}</a>
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:when test="${i == page.currentPage + 5 && page.currentPage + 5 < page.totalPage - 1}">
                                                <li> ... </li>
                                                </c:when>
                                                <c:when test="${i == page.totalPage - 1 && page.currentPage + 5 < page.totalPage - 1}">
                                                <li>
                                                    <a href="manage-clubs?page=${page.totalPage - 1}&searchValue=${previousSearchValue}">
                                                        ${page.totalPage}
                                                    </a>
                                                </li>
                                            </c:when>
                                            <c:when test="${i == page.totalPage - 1 && page.currentPage < page.totalPage - 1}">
                                                <li>
                                                    <a href="manage-clubs?page=${page.currentPage + 1}&searchValue=${previousSearchValue}">
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
</div>
</div>

<script>
    // Open popup ?? th�m clubs
    document.querySelector('.breadcrum__btn').addEventListener('click', function (event) {
        event.preventDefault();
        document.getElementById('addClubsPopup').style.display = 'flex';
    });

    // Close popup th�m clubs
    document.getElementById('closePopup').addEventListener('click', function () {
        document.getElementById('addClubsPopup').style.display = 'none';
    });

    // Close popup khi nh?p b�n ngo�i n?i dung
    window.addEventListener('click', function (event) {
        const addPopup = document.getElementById('addClubsPopup');
        const editPopup = document.getElementById('editClub'); // Popup ch?nh s?a
        if (event.target === addPopup) {
            addPopup.style.display = 'none';
        }
        if (event.target === editPopup) {
            editPopup.style.display = 'none';
        }
    });

    let idToDelete;

// M? popup x�c nh?n x�a
    function showDeleteConfirmation(id) {
        idToDelete = id;
        document.getElementById('deleteConfirmationPopup').style.display = 'flex';
    }

// X? l� x�c nh?n x�a
    document.getElementById('confirmDeleteBtn').addEventListener('click', function () {
        if (idToDelete) {
            const form = document.createElement('form');
            form.method = 'post';
            form.action = `${pageContext.request.contextPath}/admin/manage-clubs`;

            const inputId = document.createElement('input');
            inputId.type = 'hidden';
            inputId.name = 'organizerId';
            inputId.value = idToDelete;

            const inputAction = document.createElement('input');
            inputAction.type = 'hidden';
            inputAction.name = 'action';
            inputAction.value = 'delete';

            form.appendChild(inputId);
            form.appendChild(inputAction);
            document.body.appendChild(form);
            form.submit();
        }
    });

// ?�ng popup khi nh?n v�o n�t "No"
    document.getElementById('cancelDeleteBtn').addEventListener('click', function () {
        document.getElementById('deleteConfirmationPopup').style.display = 'none';
    });

// ?�ng popup khi nh?n b�n ngo�i n?i dung popup
    window.addEventListener('click', function (event) {
        const deletePopup = document.getElementById('deleteConfirmationPopup');
        if (event.target === deletePopup) {
            deletePopup.style.display = 'none';
        }

        // X? l� ?�ng c�c popup kh�c n?u c?n
        const addPopup = document.getElementById('addClubsPopup');
        const editPopup = document.getElementById('edidClub'); // Popup ch?nh s?a
        if (event.target === addPopup) {
            addPopup.style.display = 'none';
        }
        if (event.target === editPopup) {
            editPopup.style.display = 'none';
        }
    });

    function editOrganizerById(id) {
        const fullname = document.getElementById('fullname-' + id).innerHTML;
        const acronym = document.getElementById('acronym-' + id).innerHTML;
        const email = document.getElementById('email-' + id).innerHTML;

        // ?i?n th�ng tin v�o modal
        document.getElementById("edit-fullname").value = fullname;
        document.getElementById("edit-acronym").value = acronym;
        document.getElementById("edit-email").value = email;
        document.getElementById("edit-id").value = id;



        // M? modal
        document.getElementById('editClub').style.display = 'flex';
    }

// ?�ng popup khi nh?n v�o n�t ?�ng
    document.getElementById('closePopup').addEventListener('click', function () {
        document.getElementById('editClub').style.display = 'none';
    });

</script>
</section>
<%@include file="../include/master-footer.jsp"%>
