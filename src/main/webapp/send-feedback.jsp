<%-- 
    Document   : send-feedback
    Created on : Oct 6, 2024, 1:36:53 PM
    Author     : ADMIN
--%>


<!DOCTYPE html>
<%@include file="../include/student-layout-header.jsp"%>

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
                                    <li><span><a href="dashboard.html">Home page</a></span></li>
                                    <li class="active"><span>Send Feedback</span></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
       
        <div class="feedback__area">
            <h2>Send Your Feedback</h2>
            <form action="FeedbackController" method="post">
                <div class="form-group">
                    <label for="feedbackContent">Your Feedback:</label>
                    <textarea id="feedbackContent" name="feedback" class="form-control" rows="20" required></textarea>
                </div>
                <div class="text-right">
                    <button type="submit" class="btn btn-primary">Send Feedback</button>
                </div>
            </form>
        </div>


<%@include file="../include/master-footer.jsp"%>
