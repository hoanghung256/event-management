<%-- 
    Document   : edit-event
    Created on : Oct 20, 2024, 3:00:56 PM
    Author     : ADMIN
--%>
<style>
    .event__update-thumb {
        display: inline-block; /* Giúp các ?nh n?m c?nh nhau mà không tràn ra */
        overflow: hidden; /* ?n ph?n ?nh tràn ra */
        width: 300px; /* Chi?u r?ng cho khung ?nh */
        height: 200px; /* Chi?u cao cho khung ?nh */
        margin: 10px; /* Kho?ng cách gi?a các ?nh */
        position: relative; /* ?? ??nh v? nút xóa */
        transition: transform 0.3s; /* Hi?u ?ng n?i lên */
    }

    .event__update-thumb:hover {
        transform: scale(1.05); /* N?i lên khi hover */
    }

    .delete-btn {
        position: absolute; /* ??nh v? nút xóa */
        top: 10px; /* ?i?u ch?nh v? trí nút xóa */
        right: 10px; /* ?i?u ch?nh v? trí nút xóa */
        background-color: transparent; /* Màu n?n trong su?t */
        color: white;
        border: none;
        border-radius: 5px; /* Bo tròn góc */
        cursor: pointer;
        padding: 5px; /* Kích th??c nút xóa nh? h?n */
        font-weight: bold; /* Ch? ??m */
        display: none; /* ?n nút xóa */
        transition: background-color 0.3s; /* Hi?u ?ng chuy?n màu */
    }

    .delete-btn:hover {
        background-color: rgba(255, 0, 0, 0.6); /* Thay ??i màu khi hover */
    }

    .event__update-thumb:hover .delete-btn {
        display: block; /* Hi?n nút xóa khi hover vào ?nh */
    }

    .event__update-thumb img {
        width: 100%; /* ??t ?nh chi?m toàn b? chi?u r?ng c?a khung */
        height: 100%; /* ??t chi?u cao b?ng v?i chi?u cao c?a khung */
        object-fit: cover; /* Gi? t? l? ?nh và không b? bi?n d?ng */
        border-radius: 5px; /* Bo tròn góc ?nh */
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); /* Thêm bóng ?? cho ?nh */
        transition: transform 0.3s; /* Hi?u ?ng khi hover */
    }

    .event__update-file {
        display: flex; /* S? d?ng flexbox ?? c?n ch?nh các ?nh */
        flex-direction: column; /* X?p d?c cho khung */
        align-items: flex-start; /* C?n trái */
        width: 100%; /* ??t khung chi?m toàn b? chi?u r?ng */
    }

    #image-wrapper {
        display: flex; /* S? d?ng flexbox ?? s?p x?p ?nh */
        flex-wrap: wrap; /* Cho phép ?nh tràn sang dòng m?i n?u không ?? không gian */
        width: 100%; /* ??t khung ch?a ?nh chi?m toàn b? chi?u r?ng */
        max-width: 100%; /* ??m b?o không v??t quá chi?u r?ng c?a ph?n t? cha */
        margin-top: 10px; /* Kho?ng cách trên v?i ph?n t? phía trên */
    }

    .event__image-preview {
        display: flex; /* ??t flex cho ?nh ?ã t?i lên */
        flex-wrap: wrap; /* Cho phép ?nh tràn sang dòng m?i n?u không ?? không gian */
        width: 100%; /* ??t chi?u r?ng cho khung hi?n th? ?nh */
    }
</style>

<!DOCTYPE html>
<%@include file="../include/club-layout-header.jsp"%>


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
                                    <li><span><a href="home">Home</a></span></li>
                                    <li class="active"><span>Edit Event</span></li>
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
                                <h4 class="event__information-title">Edit Event Information</h4>
                            </div>
                        </div>

                        <form action="edit-event" method="POST" enctype="multipart/form-data">
                            <input type="hidden" name="eventId" value="${event.id}">
                            <div class="create__event-main pt-25">
                                <div class="event__left-box">
                                    <div class="create__input-wrapper">
                                        <div class="singel__input-field mb-15">
                                            <label class="input__field-text">Event name</label>
                                            <input type="text" name="fullname" value="${event.fullname}" required>
                                        </div>
                                        <div class="event__input mb-15">
                                            <label class="input__field-text">Event description</label>
                                            <textarea name="description" style="resize: vertical" required>${event.description}</textarea>
                                        </div>
                                    </div>
                                    <div class="event__update-wrapper">
                                        <span>Add image</span>
                                        <br/>
                                        <span>(Upload new image will delete all images are uploaded)</span>
                                        <div class="event__update-file">
                                            <div class="event__update-thumb">
                                                <div class="box__input">
                                                    <input type="file" name="images" id="file" class="box__file" multiple onchange="deletePreviousPreviewImg()">
                                                    <label class="input__field-text" for="file"><span><i class="fa-regular fa-plus"></i></span><span>Add New Image</span></label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="event__update-file" id="image-wrapper">
                                            <div class="event__image-preview">
                                                <c:forEach var="imagePath" items="${eventImageList}">
                                                    <div class="event__update-thumb">
                                                        <img src="<c:url value="${imagePath}"/>" alt="Event Image"/>
                                                       
                                                        <label class="input__field-text">Remove</label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="event__right-box">
                                    <div class="create__input-wrapper">
                                        <div class="row g-20">
                                            <div class="col-xxl-6">
                                                <label class="input__field-text">Event category</label>
                                                <div class="contact__select">
                                                    <select name="categoryId" required>
                                                        <c:forEach var="category" items="${categories}">
                                                            <option value="${category.id}" 
                                                                    <c:if test="${category.id == event.category.id}">selected</c:if>> 
                                                                ${category.name}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-xxl-6">
                                                <label class="input__field-text">Location</label>
                                                <div class="contact__select">
                                                    <select name="locationId" required>
                                                        <c:forEach var="location" items="${locations}">
                                                            <option value="${location.id}" 
                                                                    <c:if test="${location.id == event.location.id}">selected</c:if>> 
                                                                ${location.name}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-xxl-12">
                                                <div class="singel__input-field is-color-change mb-15">
                                                    <label class="input__field-text">Date of event</label>
                                                    <input type="date" name="dateOfEvent" value="${event.dateOfEvent}" required>
                                                </div>
                                            </div>

                                            <div class="col-xxl-6">
                                                <div class="singel__input-field is-color-change mb-15">
                                                    <label class="input__field-text">Start time</label>
                                                    <input type="time" name="startTime" value="${event.startTime}" required>
                                                </div>
                                            </div>

                                            <div class="col-xxl-6">
                                                <div class="singel__input-field is-color-change mb-15">
                                                    <label class="input__field-text">End time</label>
                                                    <input type="time" name="endTime" value="${event.endTime}" required>
                                                </div>
                                            </div>

                                            <div class="col-xxl-6">
                                                <div class="singel__input-field is-color-change mb-15">
                                                    <label class="input__field-text">Guest limit</label>
                                                    <input type="number" name="guestRegisterLimit" value="${event.guestRegisterLimit}" required> 
                                                </div>
                                            </div>

                                            <div class="col-xxl-6">
                                                <div class="singel__input-field is-color-change mb-15">
                                                    <label class="input__field-text">Guest register deadline</label>
                                                    <input type="date" name="guestRegisterDeadline" value="${event.guestRegisterDeadline}" required>
                                                </div>
                                            </div>

                                            <div class="col-xxl-6">
                                                <div class="singel__input-field is-color-change mb-15">
                                                    <label class="input__field-text">Collaborator Limit</label>
                                                    <input type="number" name="collaboratorRegisterLimit" value="${event.collaboratorRegisterLimit}" required>
                                                </div>
                                            </div>

                                            <div class="col-xxl-6">
                                                <div class="singel__input-field is-color-change mb-15">
                                                    <label class="input__field-text">Collaborator register deadline</label>
                                                    <input type="date" name="collaboratorRegisterDeadline" value="${event.collaboratorRegisterDeadline}" required>
                                                </div>
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
                                    <button class="input__btn w-100" type="submit">Update</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    let previewWrapper = document.getElementById("image-wrapper");
    console.log(previewWrapper);
    let fileInput = document.getElementById("file");

    fileInput.onchange = function () {
        previewWrapper.innerHTML = "";
        
        for (let i = 0; i < fileInput.files.length; i++) {
            let divWrapper = document.createElement("div");
            divWrapper.className = "event__update-thumb";
            let previewImage = document.createElement("img");
            previewImage.src = URL.createObjectURL(fileInput.files[i]);
            
            divWrapper.append(previewImage);
            previewWrapper.append(divWrapper);
        }
    };
     function removeImage(button) {
        const imageThumb = button.closest('.event__update-thumb');
        imageThumb.remove(); // Xóa ?nh
    }
</script>


<%@include file="../include/master-footer.jsp"%>
