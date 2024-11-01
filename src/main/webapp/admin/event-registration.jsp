<%-- 
    Document   : event-registration
    Created on : Sep 26, 2024, 3:50:35 PM
    Author     : TRINHHUY
--%>

<style>
    .input__btn w-20 input__btn-fixed{
        padding-right: 50px;
    }
</style>

<%@include file="../include/admin-layout-header.jsp"%>

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
                                    <li><span><a href="<c:url value="/admin/dashboard" />">Dashboard</a></span></li>
                                    <li class="active"><span>Create Event</span></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xxl-12">
                <div class="create__event-area">
                    <div class="body__card-wrapper">
                        <div class="card__header-top">
                            <div class="card__title-inner">
                                <h4 class="event__information-title">Event Information</h4>
                            </div>
                        </div>
                        <form action="register-event" method="POST" enctype="multipart/form-data">
                            <div class="create__event-main pt-25">
                                <div class="event__left-box">
                                    <div class="create__input-wrapper">
                                        <div class="singel__input-field mb-15">
                                            <label class="input__field-text">Event name</label>
                                            <input type="text" name="fullname" required>
                                        </div>
                                        <div class="event__input mb-15">
                                            <label class="input__field-text">Event description</label>
                                            <textarea name="description" style="resize: vertical" required></textarea>
                                        </div>
                                    </div>
                                    <div class="event__update-wrapper">
                                        <span>Add image</span>
                                        <br/>
                                        <span>(First image will be event avatar by default, 2:3 image for most compatible)</span>
                                        <div class="event__update-file" id="image-wrapper">
                                            <div class="event__update-thumb">
                                                <div class="box__input">
                                                    <input type="file" name="images" id="file" class="box__file" multiple required>
                                                    <label class="input__field-text" for="file"><span><i class="fa-regular fa-plus"></i></span><span>Add Image</span></label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="event__right-box">
                                    <div class="create__input-wrapper">
                                        <div class="row g-20">
                                            <div class="col-xxl-6 col-xl-6 col-lg-6">
                                                <label class="input__field-text">Location</label>
                                                <div class="contact__select">
                                                    <select name="locationId" required>
                                                        <c:forEach var="location" items="${locations}">
                                                            <option value="${location.id}">${location.name}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-xxl-6 col-xl-6 col-lg-6">
                                                <label class="input__field-text">Event category</label>
                                                <div class="contact__select">
                                                    <select name="categoryId" required>
                                                        ${categories}
                                                        <c:forEach var="category" items="${categories}">
                                                            <option value="${category.id}">${category.name}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-xl-12">
                                                <div class="singel__input-field is-color-change mb-15">
                                                    <label class="input__field-text">Date of event</label>
                                                    <input type="date" name="dateOfEvent" required>
                                                </div>
                                            </div>
                                            <div class="col-xl-6">
                                                <div class="singel__input-field is-color-change mb-15">
                                                    <label class="input__field-text">Start time</label>
                                                    <input type="time" name="startTime" required>
                                                </div>
                                            </div>
                                            <div class="col-xxl-6 col-xl-6 col-lg-6">
                                                <div class="singel__input-field is-color-change mb-15">
                                                    <label class="input__field-text">End time</label>
                                                    <input type="time" name="endTime" required>
                                                </div>
                                            </div>
                                            <div class="col-xxl-6 col-xl-6 col-lg-6">
                                                <div class="singel__input-field is-color-change mb-15">
                                                    <label class="input__field-text">Guest limit</label>
                                                    <input type="number" name="guestRegisterLimit" value="0"> 
                                                </div>
                                            </div>
                                            <div class="col-xxl-6 col-xl-6 col-lg-6">
                                                <div class="singel__input-field is-color-change mb-15">
                                                    <label class="input__field-text">Guest register deadline</label>
                                                    <input type="date" name="guestRegisterDeadline">
                                                </div>
                                            </div>
                                            <div class="col-xxl-6 col-xl-6 col-lg-6">
                                                <div class="singel__input-field is-color-change mb-15">
                                                    <label class="input__field-text">Collaborator Limit</label>
                                                    <input type="text" name="collaboratorRegisterLimit" value="0">
                                                </div>
                                            </div>
                                            <div class="col-xxl-6 col-xl-6 col-lg-6">
                                                <div class="singel__input-field is-color-change mb-15">
                                                    <label class="input__field-text">Collaborator register deadline</label>
                                                    <input type="date" name="collaboratorRegisterDeadline">
                                                </div>
                                            </div>
                                        </div>
                                        <br/>
                                        <c:if test="${not empty error}">
                                            <p class="text-danger">${error}</p>
                                        </c:if>
                                        <c:if test="${not empty message}">
                                            <p class="text-success">${message}</p>
                                        </c:if>
                                        <button class="input__btn w-100" type="submit">Register</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script type="text/javascript">
    let previewWrapper = document.getElementById("image-wrapper");
    console.log(previewWrapper);
    let fileInput = document.getElementById("file");

    fileInput.onchange = function () {
        for (let i = 0; i < fileInput.files.length; i++) {
            let divWrapper = document.createElement("div");
            divWrapper.className = "event__update-thumb";
            let previewImage = document.createElement("img");
            previewImage.src = URL.createObjectURL(fileInput.files[i]);
            previewImage.style.width = '150px';
            previewImage.style.height = '100px';
            previewImage.style.margin = '10px';
            
            divWrapper.append(previewImage);
            previewWrapper.append(divWrapper);
        }
    };
</script>

<%@include file="../include/master-footer.jsp" %>