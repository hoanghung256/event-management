<%-- 
    Document   : organized-event-report
    Created on : Oct 14, 2024, 10:58:02?PM
    Author     : ThangNM
--%>
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
                                    <li><span><a href="<c:url value="/club/dashboard"/>">Dashboard</a></span></li>
                                    <li><span><a href="<c:url value="/club/organized-event"/>">Organized Event</a></span></li>
                                    <li class="active"><span>Details</span></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>


            <div class="pb-20">
                <div>
                    <div id="myTabContent">
                        <div id="day-tab-1-pane" role="tabpanel" aria-labelledby="day-tab-1" tabindex="0">
                            <div class="event__details-area">
                                <!-- Start of statistic Number --> 
                                <div class="row g-20">
                                    <div class="col-xxl-3 col-xl-6 col-lg-6 col-md-6">
                                        <div class="expovent__count-item mb-20">
                                            <div class="expovent__count-thumb include__bg transition-3"
                                                 data-background="assets/img/bg/count-bg.png"></div>
                                            <div class="expovent__count-content">
                                                <h3 class="expovent__count-number">${totalRegister}</h3>
                                                <span class="expovent__count-text">Total Registered</span>
                                            </div>
                                            <div class="expovent__count-icon">
                                                <i class="flaticon-group"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xxl-3 col-xl-6 col-lg-6 col-md-6">
                                        <div class="expovent__count-item mb-20">
                                            <div class="expovent__count-thumb include__bg transition-3"
                                                 data-background="assets/img/bg/count-bg.png"></div>
                                            <div class="expovent__count-content">
                                                <h3 class="expovent__count-number">${totalAttended}</h3>
                                                <span class="expovent__count-text">Total Guest</span>
                                            </div>
                                            <div class="expovent__count-icon">
                                                <i class="flaticon-speaker"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xxl-3 col-xl-6 col-lg-6 col-md-6">
                                        <div class="expovent__count-item mb-20">
                                            <div class="expovent__count-thumb include__bg transition-3"
                                                 data-background="assets/img/bg/count-bg.png"></div>
                                            <div class="expovent__count-content">
                                                <h3 class="expovent__count-number">${totalCollaborator}</h3>
                                                <span class="expovent__count-text">Total Collaborator</span>
                                            </div>
                                            <div class="expovent__count-icon">
                                                <i class="flaticon-reminder"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xxl-3 col-xl-6 col-lg-6 col-md-6">
                                        <div class="expovent__count-item mb-20">
                                            <div class="expovent__count-thumb include__bg transition-3"
                                                 data-background="assets/img/bg/count-bg.png"></div>
                                            <div class="expovent__count-content">
                                                <h3 class="expovent__count-number">${totalCancel}</h3>
                                                <span class="expovent__count-text">Total Cancel Guest</span>
                                            </div>
                                            <div class="expovent__count-icon">
                                                <i class="flaticon-reminder"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--End of statistic number--> 

                                <!-- Chart -->
                                <div class="row g-20">
                                    <div class="col-8">
                                        <canvas id="eventStatisticsChart" width="400" height="250"></canvas>
                                    </div>


                                    <div class="col-4">
                                        <div class="card__wrapper">
                                            <div class="card__header">
                                                <div class="card__header-top">
                                                    <div class="card__title-inner">
                                                        <div class="card__header-icon">
                                                            <i class="flaticon-calendar-3"></i>
                                                        </div>
                                                        <div class="card__header-title">
                                                            <h4>Events To Compared</h4>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <div class="scroll-w-3 card__scroll">
                                                    <div class="card__inner">
                                                        <c:if test="${empty organizedList}">
                                                            <div class="no-events">
                                                                <span>No events organized yet</span>
                                                            </div>
                                                        </c:if>

                                                        <c:if test="${not empty organizedList}">
                                                            <c:forEach var="organizedEvent" items="${organizedList}">
                                                                <div class="news__item">
                                                                    <div class="news__item-inner">
                                                                        <div class="news__content">
                                                                            <div class="news__title">
                                                                                <a href="<c:url value="/club/organized-event-report?action=compared&eventIdSelected=${organizedEvent.id}&eventIdDetail=${event.id}&organizerId=${event.organizer.id}"/>">${organizedEvent.fullname}</a>
                                                                            </div>
                                                                            <div class="news__meta">
                                                                                <div class="news__meta-status">
                                                                                    <span><i class="flaticon-clock"></i></span>
                                                                                    <span>${organizedEvent.dateOfEvent}</span>
                                                                                </div>
                                                                                <div class="news__meta-status">
                                                                                    <span><i class="flaticon-placeholder-1"></i></span>
                                                                                    <span>${organizedEvent.location.description}</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</section>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const totalRegister = ${totalRegister};
    const totalAttended = ${totalAttended};
    const totalCollaborator = ${totalCollaborator};
    const totalCancel = ${totalCancel};
    const ctx = document.getElementById('eventStatisticsChart').getContext('2d');
    const eventStatisticsChart = new Chart(ctx, {
    type: 'bar',
            data: {
            labels: ['Total Registered', 'Total Guest', 'Total Collaborator', 'Total Cancel Guest'], // column label
                    datasets: [{
                    label: '${event.fullname}',
                            data: [totalRegister, totalAttended, totalCollaborator, totalCancel], // column value
                            backgroundColor: [
                                    'rgba(54, 162, 235, 0.5)',
                                    'rgba(54, 162, 235, 0.5)',
                                    'rgba(54, 162, 235, 0.5)',
                                    'rgba(54, 162, 235, 0.5)'
                            ],
                            borderColor: [
                                    'rgba(54, 162, 235, 1)',
                                    'rgba(54, 162, 235, 1)',
                                    'rgba(54, 162, 235, 1)',
                                    'rgba(54, 162, 235, 1)'
                            ],
                            borderWidth: 1
                    }
                <c:if test="${not empty selectedEventName}">
                    ,
                    {
                    label: '${selectedEventName}',
                            data: [${totalSelectedRegister}, ${totalSelectedAttended}, ${totalSelectedCollaborator}, ${totalSelectedCancel}],
                            backgroundColor: [
                                    'rgba(255, 159, 64, 0.5)',
                                    'rgba(255, 159, 64, 0.5)',
                                    'rgba(255, 159, 64, 0.5)',
                                    'rgba(255, 159, 64, 0.5)'
                            ],
                            borderColor: [
                                    'rgba(255, 159, 64, 1)',
                                    'rgba(255, 159, 64, 1)',
                                    'rgba(255, 159, 64, 1)',
                                    'rgba(255, 159, 64, 1)'
                            ],
                            borderWidth: 1
                    }
                </c:if>
                    ]
            },
            options: {
            scales: {
            y: {
            beginAtZero: true
            }
            }
            }
    });
</script>

<%@include file="../include/master-footer.jsp" %>
