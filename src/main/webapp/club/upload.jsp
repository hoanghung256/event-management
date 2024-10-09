
<%@include file="../include/student-layout-header.jsp"%>

<style>
    .info-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 20px;
    }

    .info-text {
        flex: 1;
    }

    .info-image {
        flex: 0 0 200px; /* Chi?u r?ng c? ??nh cho hình ?nh */
        margin-left: 20px; /* Kho?ng cách gi?a text và hình ?nh */
    }

    .input__btn {
        padding-right: 50px;
    }

    .upload-button {
        margin-top: 10px;
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
                                    <li><span><a href="home">Home</a></span></li>
                                    <li class="active"><span>Register Event</span></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div>
            <div class="create__event-main pt-25">
                <div class="event__left-box">
                    <form action="upload-image" method="post" enctype="multipart/form-data">
                        <div>
                            <label for="id">ID:</label>
                            <input type="text" id="id" name="id" required>
                        </div>
                        <div>
                            <label for="name">Name:</label>
                            <input type="text" id="name" name="name" required>
                        </div>
                        <div class="popup__update">
                            <label for="photo">Upload Image</label>
                            <input type="file" id="photo" name="photo" accept="image/*" required>
                        </div>
                        <div class="popup__update upload-button">
                            <button type="submit">Upload</button>
                        </div>
                    </form>
                </div>
                <div class="info-text">
                        <%
                        String filename = (String) request.getAttribute("filename");
                        %>
                    </div>
                <div class="info-image">
                        <%
                        if (filename != null) {
                        %>
                            <img src="images/<%= filename %>" alt="Uploaded Image" width="200">
                        <%
                        }
                        %>
                    </div>
            </div>
        </div>
    </div>
</section>

<%@include file="../include/master-footer.jsp" %>
