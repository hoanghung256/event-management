<%-- 
    Document   : test
    Created on : Oct 6, 2024, 12:31:42 AM
    Author     : TRINHHUY
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/student-layout-header.jsp"%>

<div class="row">
            <div class="col-xxl-12">
               <div class="create__event-area">
                  <div class="body__card-wrapper">
                     <div class="card__header-top">
                        <div class="card__title-inner">
                           <h4 class="event__information-title">Event Information</h4>
                        </div>
                        <div class="card__header-dropdown">
                           <div class="dropdown">
                              <button>
                                 <svg width="14" height="4" viewBox="0 0 14 4" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M2 0.75C2.69036 0.75 3.25 1.30964 3.25 2C3.25 2.69036 2.69036 3.25 2 3.25C1.30964 3.25 0.75 2.69036 0.75 2C0.75 1.30964 1.30964 0.75 2 0.75Z" fill="#7A7A7A"/>
                                    <path d="M7 0.75C7.69036 0.75 8.25 1.30964 8.25 2C8.25 2.69036 7.69036 3.25 7 3.25C6.30964 3.25 5.75 2.69036 5.75 2C5.75 1.30964 6.30964 0.75 7 0.75Z" fill="#7A7A7A"/>
                                    <path d="M13.25 2C13.25 1.30964 12.6904 0.75 12 0.75C11.3096 0.75 10.75 1.30964 10.75 2C10.75 2.69036 11.3096 3.25 12 3.25C12.6904 3.25 13.25 2.69036 13.25 2Z" fill="#7A7A7A"/>
                                    </svg>                                          
                              </button>
                              <div class="dropdown-list">
                                 <a class="dropdown__item" href="javascript:void(0)">Edit</a>
                                 <a class="dropdown__item" href="javascript:void(0)">Delete</a>
                              </div>
                              </div>
                        </div>
                     </div>
                     <div class="create__event-main pt-25">
                        <div class="event__left-box">
                           <div class="create__input-wrapper">
                              <form action="#">
                                 <div class="singel__input-field mb-15">
                                    <label class="input__field-text">Event Title</label>
                                    <input type="text">
                                 </div>
                                 <div class="col-xxl-12 col-xl-12 col-lg-12">
                                    <div class="singel__input-field mb-15">
                                       <label class="input__field-text"> Location </label>
                                       <input type="text" placeholder="">
                                    </div>
                                 </div>
                              </form>
                           </div>
                           <div class="col-xxl-6 col-xl-6 col-lg-6">
                              <label class="input__field-text">Event Status</label>
                              <div class="contact__select">
                                 <select>
                                    <option value="0">Confirmed</option>
                                    <option value="1">waiting</option>
                                    <option value="1">confused</option>
                                    <option value="3">Option</option>
                                 </select>
                              </div>
                              <br>
                           </div>
                              <form action="#">
                              <div class="row g-20">
                                 <div class="col-xxl-6 col-xl-6 col-lg-6">
                                    <label class="input__field-text">Event Type</label>
                                    <div class="contact__select">
                                       <select>
                                          <option value="0">Select the services</option>
                                          <option value="1">Free</option>
                                          <option value="1">Paid</option>
                                          <option value="3">Option</option>
                                       </select>
                                    </div>
                                 </div>
                              </div>
                              </form>
                        </div>
                        <div class="event__right-box">
                           <div class="create__input-wrapper">
                              <form action="#">
                                 <div class="col-xxl-6 col-xl-6 col-lg-6">
                                    <div class="singel__input-field is-color-change mb-15">
                                       <label class="input__field-text">Date</label>
                                       <input type="date">
                                    </div>
                                 </div>
                                 <div class="col-xxl-6 col-xl-6 col-lg-6">
                                    <div class="singel__input-field is-color-change  mb-15">
                                       <label class="input__field-text">Time</label>
                                       <input type="time" value="13:30">
                                    </div>
                                 </div>
                              </form>
                           </div>
                        </div>
                     </div>
                     <br>
                     <button class="input__btn w-100" type="submit">Register Event</button>
                  </div>
               </div>
            </div>
         </div>
<%@include file="../include/master-footer.jsp" %>