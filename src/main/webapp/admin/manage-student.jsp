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


    /* ??nh d?ng các input */
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

    /* ??nh d?ng nút submit */
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
            <div class="breadcrumb__wrapper mb-35">
                <div class="breadcrumb__main">
                    <div class="breadcrumb__inner">
                        <div class="breadcrumb__icon">
                            <i class="flaticon-home"></i>
                        </div>
                        <div class="breadcrumb__menu">
                            <nav>
                                <ul>
                                    <li><span><a href="<c:url value='/home'/>">Home</a></span></li>
                                    <li class="active"><span>Manage Student</span></li>
                                </ul>
                            </nav>
                        </div>


                    </div>
                    <div class="search_add d-flex justify-content-between align-items-center">
                        <form method="get" action="${pageContext.request.contextPath}/admin/manage-student">
                            <div class="search_add d-flex justify-content-between align-items-center">
                                <div class="search__bar d-flex">
                                    <input type="text" id="searchValue" name="searchValue" placeholder="Search by..." aria-label="Search students" />

                                </div>
                                <div class="col-md-1 input d-flex "  style="padding-bottom: 18px; margin-left: 20px;" >
                                    <button type="submit" " class="btn element__btn border-yellow find-button" >Find</button>
                                </div>
                                <div class="breadcrum__button">
                                    <a class="breadcrum__btn event__popup-active" style="width: 160px;">Add student<i class="fa-regular fa-plus"></i></a>
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
                <h3>Are you sure you want to delete this student?</h3>
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

        <!-- Popup for Add New User -->
        <div class="popup__overlay" id="addUserPopup">
            <div class="popup__content">
                <span class="popup__close" id="closePopup"></span>
                <h3>Add New Student</h3>
                <form action="${pageContext.request.contextPath}/admin/manage-student" method="post">
                    <input type="hidden" name="action" value="add" />
                    <div class="singel__input-field mb-15 ">
                        <label class="input__field-text">Full Name</label>
                        <input type="text" name="fullname" required>
                    </div>
                    <div class="singel__input-field mb-15">
                        <label class="input__field-text">Email</label>
                        <input type="email" name="email" required>
                    </div>
                    <div class="input-row mb-15">
                        <div class="singel__input-field">
                            <label class="input__field-text">Student ID</label>
                            <input type="text" name="studentId" required>
                        </div>
                        <div class="singel__input-field">
                            <label class="input__field-text">Gender</label>
                            <select name="gender" style="height: 60%;" required>
                                <option value="MALE">Male</option>
                                <option value="FEMALE">Female</option>
                                <option value="OTHER">Other</option>
                            </select>
                        </div>
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
                            document.getElementById('addUserPopup').style.display = 'flex';
                        </script>
                    </c:if>

                    <button class="input__btn w-100" type="submit">Submit</button>
                </form>
            </div>
        </div>

        <!-- Popup for Edit -->
        <div class="popup__overlay" id="editStudent">
            <div class="popup__content">
                <span class="popup__close" id="closePopup"></span>
                <h3>Edit Student</h3>
                <form action="${pageContext.request.contextPath}/admin/manage-student" method="post">
                    <input type="hidden" name="action" value="edit" />
                    <input type="hidden" name="id" id="edit-id" />
                    <div class="singel__input-field mb-15 ">
                        <label class="input__field-text">Full Name</label>
                        <input type="text" name="fullname" required id="edit-fullname">
                    </div>
                    <div class="singel__input-field mb-15">
                        <label class="input__field-text">Email</label>
                        <input type="email" name="email" id="edit-email" required>
                    </div>   
                    <div class="input-row mb-15">
                        <div class="singel__input-field">
                            <label class="input__field-text">Student ID</label>
                            <input type="text" name="studentId" id="edit-studentId" required>
                        </div>
                        <div  class="singel__input-field"  >
                            <label class="input__field-text">Gender</label>
                            <select name="gender" id="edit-gender" style="height: 60%;">
                                <option value="MALE">MALE</option>
                                <option value="FEMALE">FEMALE</option>
                                <option value="OTHER">OTHER</option>
                                <select/>
                        </div>
                    </div>
                    <c:if test="${not empty editError}">
                        <div class="error-message" style="color: red; margin-bottom: 15px;">${editError}</div>
                        <script>
                            document.getElementById('editStudent').style.display = 'flex';
                        </script>
                    </c:if>
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

                    <c:if test="${not empty addError}">
                        <div class="alert alert-danger" role="alert">
                            ${addError}
                        </div>
                    </c:if>

                    <c:if test="${not empty editError}">
                        <div class="alert alert-danger" role="alert">
                            ${editError}
                        </div>
                    </c:if>

                </div>
                <div class="body__card-wrapper">
                    <div class="attendant__wrapper mb-35">
                        <table>
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Student ID</th>
                                    <th>Gender </th>
                                    <th>Email</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <!--List result find-->
                            <tbody>
                                <c:forEach var="student" items="${students}">
                                    <tr data-student-id="${student.studentId}">
                                        <td>
                                            <div class="attendant__user-item">
                                                <div class="attendant__user-title">
                                                    <span id="fullname-${student.id}">${student.fullname}</span>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="attendant__user-id">
                                                <span id="studentId-${student.id}">${student.studentId}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="attendant__user-gender">
                                                <span id="gender-${student.id}">${student.gender}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="attendant__email">
                                                <span id="email-${student.id}">${student.email}</span>
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
                                                            <a class="dropdown__item" onclick="editStudentById('${student.id}')">Edit</a>
                                                            <form action="${pageContext.request.contextPath}/manage-student" method="post" style="display: inline;">
                                                                <input type="hidden" name="studentId" value="${student.studentId}" />
                                                                <input type="hidden" name="action" value="delete" />
                                                                <a class="dropdown__item" href="javascript:void(0)" onclick="showDeleteConfirmation('${student.studentId}')">Delete</a>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>

                            <tbody>
                                <c:forEach var="student" items="${page.datas}">
                                    <tr data-student-id="${student.studentId}">
                                        <td>
                                            <div class="attendant__user-item">
                                                <div class="attendant__user-title">
                                                    <span id="fullname-${student.id}">${student.fullname}</span>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="attendant__user-id">
                                                <span id="studentId-${student.id}">${student.studentId}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="attendant__user-gender">
                                                <span id="gender-${student.id}">${student.gender}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="attendant__email">
                                                <span id="email-${student.id}">${student.email}</span>
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
                                                            <a class="dropdown__item" onclick="editStudentById('${student.id}')">Edit</a>
                                                            <form action="${pageContext.request.contextPath}/manage-student" method="post" style="display: inline;">
                                                                <input type="hidden" name="studentId" value="${student.studentId}" />
                                                                <input type="hidden" name="action" value="delete" />
                                                                <a class="dropdown__item" href="javascript:void(0)" onclick="showDeleteConfirmation('${student.studentId}')">Delete</a>
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
                        <!<!-- pagination controls -->
                        <div class="basic__pagination d-flex align-items-center justify-content-end">
                            <nav>
                                <ul>
                                    <c:forEach var="i" begin="0" end="${page.totalPage}">
                                        <c:choose>
                                            <c:when test="${i == 0 && page.currentPage > 0}">
                                                <li>
                                                    <a href="manage-student?page=${page.currentPage - 1}">
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
                                                            <a href="manage-student?page=${i}">${i + 1}</a>
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:when test="${i == page.currentPage + 5 && page.currentPage + 5 < page.totalPage - 1}">
                                                <li> ... </li>
                                                </c:when>
                                                <c:when test="${i == page.totalPage - 1 && page.currentPage + 5 < page.totalPage - 1}">
                                                <li>
                                                    <a href="manage-student?page=${page.totalPage - 1}">
                                                        ${page.totalPage}
                                                    </a>
                                                </li>
                                            </c:when>
                                            <c:when test="${i == page.totalPage - 1 && page.currentPage < page.totalPage - 1}">
                                                <li>
                                                    <a href="manage-student?page=${page.currentPage + 1}">
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
    // Open popup ?? thêm sinh viên
    document.querySelector('.breadcrum__btn').addEventListener('click', function (event) {
        event.preventDefault();
        document.getElementById('addUserPopup').style.display = 'flex';
    });

    // Close popup thêm sinh viên
    document.getElementById('closePopup').addEventListener('click', function () {
        document.getElementById('addUserPopup').style.display = 'none';
    });

    // Close popup khi nh?p bên ngoài n?i dung
    window.addEventListener('click', function (event) {
        const addPopup = document.getElementById('addUserPopup');
        const editPopup = document.getElementById('editStudent'); // Popup ch?nh s?a
        if (event.target === addPopup) {
            addPopup.style.display = 'none';
        }
        if (event.target === editPopup) {
            editPopup.style.display = 'none';
        }
    });

    let studentIdToDelete;

    // M? popup xác nh?n xóa
    function showDeleteConfirmation(id) {
        studentIdToDelete = id;
        document.getElementById('deleteConfirmationPopup').style.display = 'flex';
    }

    // X? lý xác nh?n xóa
    document.getElementById('confirmDeleteBtn').addEventListener('click', function () {
        if (studentIdToDelete) {
            const form = document.createElement('form');
            form.method = 'post';
            form.action = `${pageContext.request.contextPath}/admin/manage-student`;

            const inputId = document.createElement('input');
            inputId.type = 'hidden';
            inputId.name = 'studentId';
            inputId.value = studentIdToDelete;

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

    // ?óng popup xác nh?n xóa
    document.getElementById('closeDeletePopup').addEventListener('click', function () {
        document.getElementById('deleteConfirmationPopup').style.display = 'none';
    });

    // ?óng popup khi nh?n vào nút "Cancel"
    document.getElementById('cancelDeleteBtn').addEventListener('click', function () {
        document.getElementById('deleteConfirmationPopup').style.display = 'none';
    });

    window.addEventListener('click', function (event) {
        const deletePopup = document.getElementById('deleteConfirmationPopup');
        if (event.target === deletePopup) {
            deletePopup.style.display = 'none';
        }
    });

//        document.querySelector('.edit-button').addEventListener('click', function (event) {
//            event.preventDefault();
//            document.getElementById('editStudent').style.display = 'flex';
//        });


    function editStudentById(id) {
        // L?y thông tin c?a sinh viên t? server (b?n có th? ?i?u ch?nh ?? l?y thông tin phù h?p)
        const fullname = document.getElementById('fullname-' + id).innerHTML;
        const email = document.getElementById('email-' + id).innerHTML;
        const studentId = document.getElementById('studentId-' + id).innerHTML;
        const gender = document.getElementById('gender-' + id).innerHTML;
        console.log(gender);

//            // ?i?n thông tin vào modal
        document.getElementById("edit-fullname").value = fullname;
        document.getElementById("edit-email").value = email;
        document.getElementById("edit-studentId").value = studentId;
        document.getElementById("edit-id").value = id;

        let selectTag = document.getElementById("edit-gender");
        let options = selectTag.querySelectorAll('option');

        for (let i = 0; i < 2; i++) {
            if (options[i].value === gender) {
                console.log(options[i]);
                options[i].selected = true;
            }
        }

        // M? modal
        document.getElementById('editStudent').style.display = 'flex';
    }
    ;
</script>






</section>

<%@include file="../include/master-footer.jsp"%>
