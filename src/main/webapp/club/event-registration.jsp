<%-- 
    Document   : test-profile
    Created on : Sep 26, 2024, 3:50:35 PM
    Author     : TRINHHUY
--%>

<style>
    .input__btn w-20 input__btn-fixed{
        padding-right: 50px;
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
                        <div class="create__input-wrapper">

                            <form action="your-backend-action" method="POST">
                                <!-- Nhap Event Title -->
                                <div class="singel__input-field mb-15">
                                    <label class="input__field-text">Event Name</label>
                                    <input type="text" name="fullname" required>
                                </div>
                                <div class="event__input mb-15">
                                    <label class="input__field-text">Event Details</label>
                                    <textarea  placeholder=""></textarea>
                                </div>
                                <div class="row g-20">
                                    <div class="col-xxl-6 col-xl-6 col-lg-6">
                                        <div class="singel__input-field is-color-change mb-15">
                                            <label class="input__field-text">Register Limit</label>
                                            <input type="text" name="register-limit" required>
                                        </div>
                                    </div>
                                    <div class="col-xxl-6 col-xl-6 col-lg-6">
                                        <div class="singel__input-field is-color-change mb-15">
                                            <label class="input__field-text">Limit Time</label>
                                            <input type="time" name="limit_time" value="00:00" required>
                                        </div>
                                    </div>
                                    <div class="col-xxl-6 col-xl-6 col-lg-6">
                                        <div class="singel__input-field is-color-change mb-15">
                                            <label class="input__field-text">Collaborator Limit</label>
                                            <input type="text" name="collaborator-limit" required>
                                        </div>
                                    </div>
                                    <div class="col-xxl-6 col-xl-6 col-lg-6">
                                        <div class="singel__input-field is-color-change mb-15">
                                            <label class="input__field-text">Limit Time</label>
                                            <input type="time" name="limit_time" value="00:00" required>
                                        </div>
                                    </div>
                                </div>

                            </form>
                        </div>
                    </div>
                    <form action="your-backend-action" method="POST">
                        <div class="row g-20">
                            <div class="col-xxl-6 col-xl-6 col-lg-6">
                                <label class="input__field-text">Location</label>
                                <div class="contact__select">
                                    <select name="event_location" required>
                                        <option value="1">.......</option>
                                        <option value="1">Room 215-Building Alpha</option>
                                        <option value="2">Room 315-Building Alpha</option>
                                        <option value="3">Penrose Hall-Building Belta</option>
                                        <option value="4">Main Yard</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-xxl-6 col-xl-6 col-lg-6">
                                <label class="input__field-text">Event Type</label>
                                <div class="contact__select">
                                    <select name="event_type" required>
                                        <option value="1">.......</option>
                                        <option value="1">ACADEMIC</option>
                                        <option value="2">SEMINAR</option>
                                        <option value="3">WORKSHOP</option>
                                        <option value="4">SPORT</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    <div>
                        <div class="row g-20">
                            <div class="col-xxl-6 col-xl-6 col-lg-6">
                                <div class="singel__input-field is-color-change mb-15">
                                    <label class="input__field-text">Start Date</label>
                                    <input type="date" name="start_date" required>
                                </div>
                            </div>
                            <div class="col-xxl-6 col-xl-6 col-lg-6">
                                <div class="singel__input-field is-color-change mb-15">
                                    <label class="input__field-text">Start Time</label>
                                    <input type="time" name="start_time" value="13:30" required>
                                </div>
                            </div>
                            <div class="col-xxl-6 col-xl-6 col-lg-6">
                                <div class="singel__input-field is-color-change mb-15">
                                    <label class="input__field-text">End Date</label>
                                    <input type="date" name="end_date" required>
                                </div>
                            </div>
                            <div class="col-xxl-6 col-xl-6 col-lg-6">
                                <div class="singel__input-field is-color-change mb-15">
                                    <label class="input__field-text">End Time</label>
                                    <input type="time" name="end_time" value="13:30" required>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </form>                         
            </div>
            <br>
            <button class="input__btn w-20 input__btn-fixed" type="submit" style="float: right; margin-right: 50px;">Submit</button>
        </div>
        

</section>

<%@include file="../include/master-footer.jsp" %>
