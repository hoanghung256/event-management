
(function ($) {
	"use strict";
	var windowOn = $(window);

	/*======================================
	Preloader activation
	========================================*/
	$(window).on('load', function (event) {
		$('#preloader').delay(500).fadeOut(500);
	});


	/*======================================
	Wow Js
	========================================*/
	new WOW().init();

	/*======================================
	Mobile Menu Js
	========================================*/
	$('#mobile-menu').meanmenu({
		meanMenuContainer: '.mobile-menu',
		meanScreenWidth: "991",
		meanExpand: ['<i class="fal fa-plus"></i>'],
	});

	$("#mobile-menu-2").meanmenu({
		meanMenuContainer: ".mobile-menu-2",
		meanScreenWidth: "4000",
		meanExpand: ['<i class="fal fa-plus"></i>'],
	});

	/*======================================
	smoothSctollTop js
	========================================*/
	function smoothSctollTop() {
		$('.smooth a').on('click', function (event) {
			var target = $(this.getAttribute('href'));
			if (target.length) {
				event.preventDefault();
				$('html, body').stop().animate({
					scrollTop: target.offset().top - 100
				}, 1000);
			}
		});
	}
	smoothSctollTop();


	/*======================================
	Sidebar Toggle
	========================================*/
	$(".offcanvas__close,.offcanvas__overlay").on("click", function () {
		$(".offcanvas__info").removeClass("info-open");
		$(".offcanvas__overlay").removeClass("overlay-open");
	});
	$(".sidebar__toggle").on("click", function () {
		$(".offcanvas__info").addClass("info-open");
		$(".offcanvas__overlay").addClass("overlay-open");
	});

	/*======================================
	Body overlay Js
	========================================*/
	$(".body-overlay").on("click", function () {
		$(".offcanvas__area").removeClass("opened");
		$(".body-overlay").removeClass("opened");
	});


	/*======================================
	Sticky Header Js
	========================================*/

	var lastScrollTop = 200;
	$(window).scroll(function (event) {
		var scroll = $(this).scrollTop();
		if (scroll > lastScrollTop) {
			$('#header-sticky').removeClass('sticky');
		} else {
			$('#header-sticky').addClass('sticky');
		}

		if (scroll < 200) {
			$("#header-sticky").removeClass("sticky");
		}
		lastScrollTop = scroll;
	});

	/*======================================
	Data Css js
	========================================*/
	$("[data-background").each(function () {
		$(this).css("background-image", "url( " + $(this).attr("data-background") + "  )");
	});

	$("[data-width]").each(function () {
		$(this).css("width", $(this).attr("data-width"));
	});

	$("[data-bg-color]").each(function () {
		$(this).css("background-color", $(this).attr("data-bg-color"));
	});
	
	/*======================================
	 Cart Quantity Js
	========================================*/
	$(".cart-minus").click(function () {
		var $input = $(this).parent().find("input");
		var count = parseInt($input.val()) - 1;
		count = count < 1 ? 1 : count;
		$input.val(count);
		$input.change();
		return false;
	});

	/*======================================
MagnificPopup image view
	========================================*/
	$('.popup-image').magnificPopup({
		type: 'image',
		gallery: {
			enabled: true
		}
	});

	/*======================================
	MagnificPopup video view
	========================================*/
	$(".popup-video").magnificPopup({
		type: "iframe",
	});

	/*======================================
	Counter Js
	========================================*/

	$('.counter').counterUp({
		delay: 10,
		time: 1000
	});

	/*======================================
	settings append in body Js
	========================================*/
	function bd_settings_append($x) {
		var settings = $('body');
		let dark;
		$x == true ? dark = 'd-block' : dark = 'd-none';
		var settings_html = `<div class="bd-theme-settings-area transition-3">
		<div class="bd-theme-wrapper">
		   <div class="bd-theme-header text-center">
			  <h4 class="bd-theme-header-title">Template Settings</h4>
		   </div>

		   <!-- THEME TOGGLER -->
		   <div class="bd-theme-toggle mb-20 ${dark}">
			  <label class="bd-theme-toggle-main" for="bd-theme-toggler">
				 <span class="bd-theme-toggle-dark"><i class="fa-light fa-moon"></i> Dark</span>
					<input type="checkbox" id="bd-theme-toggler">
					<i class="bd-theme-toggle-slide"></i>
				 <span class="bd-theme-toggle-light active"><i class="fa-light fa-sun-bright"></i> Light</span>
			  </label>
		   </div>

		   <!--  RTL SETTINGS -->
		   <div class="bd-theme-dir mb-20">
			  <label class="bd-theme-dir-main" for="bd-dir-toggler">
				 <span class="bd-theme-dir-rtl"> RTL</span>
					<input type="checkbox" id="bd-dir-toggler">
					<i class="bd-theme-dir-slide"></i>
				 <span class="bd-theme-dir-ltr active"> LTR</span>
			  </label>
		   </div>

		   <!-- COLOR SETTINGS -->
		   <div class="bd-theme-settings">
			  <div class="bd-theme-settings-wrapper">
				 <div class="bd-theme-settings-open">
					<button class="bd-theme-settings-open-btn">
					   <span class="bd-theme-settings-gear">
						  <i class="fa-light fa-gear"></i>
					   </span>
					   <span class="bd-theme-settings-close">
						  <i class="fa-regular fa-xmark"></i>
					   </span>
					</button>
				 </div>
				 <div class="row row-cols-4 gy-2 gx-2">
					<div class="col">
					   <div class="bd-theme-color-item bd-color-active">
						  <button class="bd-theme-color-btn bd-color-settings-btn d-none" data-color-default="#F50963" type="button" data-color="#F50963"></button>
						  <button class="bd-theme-color-btn bd-color-settings-btn" type="button" data-color="#F50963"></button>
					   </div>
					</div>
					<div class="col">
					   <div class="bd-theme-color-item bd-color-active">
						  <button class="bd-theme-color-btn bd-color-settings-btn" type="button" data-color="#008080"></button>
					   </div>
					</div>
					<div class="col">
					   <div class="bd-theme-color-item bd-color-active">
						  <button class="bd-theme-color-btn bd-color-settings-btn" type="button" data-color="#2CAE76"></button>
					   </div>
					</div>
					<div class="col">
					   <div class="bd-theme-color-item bd-color-active">
						  <button class="bd-theme-color-btn bd-color-settings-btn" type="button" data-color="#3661FC"></button>
					   </div>
					</div>
					<div class="col">
					   <div class="bd-theme-color-item bd-color-active">
						  <button class="bd-theme-color-btn bd-color-settings-btn" type="button" data-color="#2CAE76"></button>
					   </div>
					</div>
					<div class="col">
					   <div class="bd-theme-color-item bd-color-active">
						  <button class="bd-theme-color-btn bd-color-settings-btn" type="button" data-color="#F87A58"></button>
					   </div>
					</div>
					<div class="col">
                        <div class="bd-theme-color-item bd-color-active">
                           <button class="bd-theme-color-btn bd-color-settings-btn" type="button" data-color="#03041C"></button>
                        </div>
                     </div>
					<div class="col">
					   <div class="bd-theme-color-item bd-color-active">
						  <button class="bd-theme-color-btn bd-color-settings-btn" type="button" data-color="#ED212C"></button>
					   </div>
					</div>
				 </div>
			  </div>
			  <div class="bd-theme-color-input">
				 <h6>Choose Custom Color</h6>
				 <input type="color" id="bd-color-setings-input" value="#F50963">
				 <label id="bd-theme-color-label" for="bd-color-setings-input"></label>
			  </div>
		   </div>
		</div>
	 </div>`;

		settings.append(settings_html);
	}
	bd_settings_append(true); // if want to enable dark light mode then send "true";

	// settings open btn
	$(".bd-theme-settings-open-btn").on("click", function () {
		$(".bd-theme-settings-area").toggleClass("settings-opened");
	});

	// // rtl settings
	// function bd_rtl_settings() {

	// 	$('#bd-dir-toggler').on("change", function () {
	// 		toggle_rtl();
	// 		window.location.reload(true);

	// 	});


	// 	// set toggle theme scheme
	// 	function bd_set_scheme(bd_dir) {
	// 		localStorage.setItem('bd_dir', bd_dir);
	// 		document.documentElement.setAttribute("dir", bd_dir);

	// 		if (bd_dir === 'rtl') {
	// 			var list = $("[href='assets/app/css/bootstrap.min.css']");
	// 			$(list).attr("href", "assets/app/css/bootstrap.rtl.min.css");
	// 		} else {
	// 			var list = $("[href='assets/app/css/bootstrap.min.css']");
	// 			$(list).attr("href", "assets/app/css/bootstrap.min.css");
	// 		}
	// 	}

	// 	// toogle theme scheme
	// 	function toggle_rtl() {
	// 		if (localStorage.getItem('bd_dir') === 'rtl') {
	// 			bd_set_scheme('ltr');
	// 			var list = $("[href='assets/app/css/bootstrap.rtl.min.css']");
	// 			$(list).attr("href", "assets/app/css/bootstrap.min.css");
	// 		} else {
	// 			bd_set_scheme('rtl');
	// 			var list = $("[href='assets/app/css/bootstrap.min.css']");
	// 			$(list).attr("href", "assets/app/css/bootstrap.rtl.min.css");
	// 		}
	// 	}

	// 	// set the first theme scheme
	// 	function bd_init_dir() {
	// 		if (localStorage.getItem('bd_dir') === 'rtl') {
	// 			bd_set_scheme('rtl');
	// 			var list = $("[href='assets/app/css/bootstrap.min.css']");
	// 			$(list).attr("href", "assets/app/css/bootstrap.rtl.min.css");
	// 			document.getElementById('bd-dir-toggler').checked = true;
	// 		} else {
	// 			bd_set_scheme('ltr');
	// 			document.getElementById('bd-dir-toggler').checked = false;
	// 			var list = $("[href='assets/app/css/bootstrap.min.css']");
	// 			$(list).attr("href", "assets/app/css/bootstrap.min.css");
	// 		}
	// 	}
	// 	bd_init_dir();
	// }
	// if ($("#bd-dir-toggler").length > 0) {
	// 	bd_rtl_settings();
	// }

	// // dark light mode toggler
	// function bd_theme_toggler() {

	// 	$('#bd-theme-toggler').on("change", function () {
	// 		toggleTheme();

	// 	});


	// 	// set toggle theme scheme
	// 	function bd_set_scheme(bd_theme) {
	// 		localStorage.setItem('bd_theme_scheme', bd_theme);
	// 		document.documentElement.setAttribute("bd-theme", bd_theme);
	// 	}

	// 	// toogle theme scheme
	// 	function toggleTheme() {
	// 		if (localStorage.getItem('bd_theme_scheme') === 'bd-theme-light') {
	// 			bd_set_scheme('bd-theme-dark');
	// 		} else {
	// 			bd_set_scheme('bd-theme-light');
	// 		}
	// 	}

	// 	// set the first theme scheme
	// 	function bd_init_theme() {
	// 		if (localStorage.getItem('bd_theme_scheme') === 'bd-theme-light') {
	// 			bd_set_scheme('bd-theme-light');
	// 			document.getElementById('bd-theme-toggler').checked = false;
	// 		} else {
	// 			bd_set_scheme('bd-theme-dark');
	// 			document.getElementById('bd-theme-toggler').checked = true;
	// 		}
	// 	}
	// 	bd_init_theme();
	// }
	// if ($("#bd-theme-toggler").length > 0) {
	// 	bd_theme_toggler();
	// }


	// color settings
	function bd_color_settings() {

		// set color scheme
		function bd_set_color(ep_color_scheme) {
			localStorage.setItem('ep_color_scheme', ep_color_scheme);
			document.querySelector(':root').style.setProperty('--clr-theme-1', ep_color_scheme);
			document.getElementById("bd-color-setings-input").value = ep_color_scheme;
			document.getElementById("bd-theme-color-label").style.backgroundColor = ep_color_scheme;
		}

		// set color
		function bd_set_input() {
			var color = localStorage.getItem('ep_color_scheme');
			document.getElementById("bd-color-setings-input").value = color;
			document.getElementById("bd-theme-color-label").style.backgroundColor = color;


		}
		bd_set_input();

		function bd_init_color() {
			var defaultColor = $(".bd-color-settings-btn").attr('data-color-default');
			var setColor = localStorage.getItem('ep_color_scheme');

			if (setColor != null) {

			} else {
				setColor = defaultColor;
			}

			if (defaultColor !== setColor) {
				document.querySelector(':root').style.setProperty('--clr-theme-1', setColor);
				document.getElementById("bd-color-setings-input").value = setColor;
				document.getElementById("bd-theme-color-label").style.backgroundColor = setColor;
				bd_set_color(setColor);
			} else {
				document.querySelector(':root').style.setProperty('--clr-theme-1', defaultColor);
				document.getElementById("bd-color-setings-input").value = defaultColor;
				document.getElementById("bd-theme-color-label").style.backgroundColor = defaultColor;
				bd_set_color(defaultColor);
			}
		}
		bd_init_color();


		let themeButtons = document.querySelectorAll('.bd-color-settings-btn');

		themeButtons.forEach(color => {
			color.addEventListener('click', () => {
				let datacolor = color.getAttribute('data-color');
				document.querySelector(':root').style.setProperty('--clr-theme-1', datacolor);
				document.getElementById("bd-theme-color-label").style.backgroundColor = datacolor;
				bd_set_color(datacolor);
			});
		});

		const colorInput = document.querySelector('#bd-color-setings-input');
		const colorVariable = '--clr-theme-1';


		colorInput.addEventListener('change', function (e) {
			var clr = e.target.value;
			document.documentElement.style.setProperty(colorVariable, clr);
			bd_set_color(clr);
			bd_set_check(clr);
		});


		function bd_set_check(clr) {
			const arr = Array.from(document.querySelectorAll('[data-color]'));

			var a = localStorage.getItem('ep_color_scheme');

			let test = arr.map(color => {
				let datacolor = color.getAttribute('data-color');

				return datacolor;
			}).filter(color => color == a);

			var arrLength = test.length;

			if (arrLength == 0) {
				$('.bd-color-active').removeClass('active');
			} else {
				$('.bd-color-active').addClass('active');
			}
		}

		function bd_check_color() {
			var a = localStorage.getItem('ep_color_scheme');

			var list = $(`[data-color="${a}"]`);

			list.parent().addClass('active').parent().siblings().find('.bd-color-active').removeClass('active')
		}
		bd_check_color();

		$('.bd-color-active').on('click', function () {
			$(this).addClass('active').parent().siblings().find('.bd-color-active').removeClass('active');
		});

	}
	if (($(".bd-color-settings-btn").length > 0) && ($("#bd-color-setings-input").length > 0) && ($("#bd-theme-color-label").length > 0)) {
		bd_color_settings();
	}


	var bd_rtl = localStorage.getItem('bd_dir');
	let rtl_setting = bd_rtl == 'rtl' ? true : false;

	/*======================================
	Speaker activation js
	========================================*/

	if ($(".speaker__activation").length > 0) {
		$(".speaker__activation").slick({
			// centerMode: true,
			infinite: true,
			speed: 300,
			slidesToShow: 3,
			autoplay: true,
			arrows: false,
			cssEase: 'linear',
			rtl: rtl_setting,
			responsive: [
				{
					breakpoint: 1400,
					settings: {
						centerMode: true,
						centerPadding: "40px",
						slidesToShow: 3,
					},
				},
				{
					breakpoint: 1200,
					settings: {
						centerMode: true,
						centerPadding: "40px",
						slidesToShow: 2,
					},
				},
				{
					breakpoint: 992,
					settings: {
						centerMode: true,
						centerPadding: "40px",
						slidesToShow: 1,
					},
				},
				{
					breakpoint: 768,
					settings: {
						centerMode: true,
						centerPadding: "40px",
						slidesToShow: 1,
					},
				},
				{
					breakpoint: 480,
					settings: {
						centerMode: true,
						centerPadding: "40px",
						slidesToShow: 1,
					},
				},
			],
		});
	}


	/*======================================
	Gallery activation js
	========================================*/

	var gallerySlider1 = new Swiper(".gallery-slider-activation1", {
		slidesPerView: "auto",
		spaceBetween: 10,
		loop: true,
		observeParents: true,
		observer: true,
		rtl: rtl_setting,
		pagination: {
			el: ".swiper-pagination",
			clickable: true,
		},
		breakpoints: {
			1200: {
				slidesPerView: 3,
			},
			992: {
				slidesPerView: 2,
			},
			768: {
				slidesPerView: 1,
			},
			576: {
				slidesPerView: 1,
			},
			0: {
				slidesPerView: 1,
			},
		},
	});
	var gallerySlider2 = new Swiper(".gallery-slider-activation2", {
		slidesPerView: "auto",
		spaceBetween: 10,
		loop: true,
		observeParents: true,
		observer: true,
		rtl: rtl_setting,
		pagination: {
			el: ".swiper-pagination",
			clickable: true,
		},
		breakpoints: {
			1200: {
				slidesPerView: 3,
			},
			992: {
				slidesPerView: 2,
			},
			768: {
				slidesPerView: 1,
			},
			576: {
				slidesPerView: 1,
			},
			0: {
				slidesPerView: 1,
			},
		},
	});

	/*======================================
	Blog activation js
	========================================*/
	var blogSlider = new Swiper('.blog__slider-active', {
		slidesPerView: 3,
		spaceBetween: 30,
		loop: true,
		rtl: rtl_setting,
		pagination: {
			el: ".testimonial-slider-dot",
			clickable: true,
		},
		breakpoints: {
			'1200': {
				slidesPerView: 3,
			},
			'992': {
				slidesPerView: 2,
			},
			'768': {
				slidesPerView: 1,
			},
			'576': {
				slidesPerView: 1,
			},
			'0': {
				slidesPerView: 1,
			},
		},
	});

	/*======================================
	Testimonial activation js
	========================================*/
	$(".testimonial__activation").slick({
		// centerMode: true,
		// infinite: true,
		speed: 300,
		slidesToShow: 1,
		// autoplay: true,
		arrows: true,
		prevArrow: '<button type="button" class="slick-prev"><i class="fa-regular fa-chevron-left"></i></button>',
		nextArrow: '<button type="button" class="slick-next"><i class="fa-regular fa-chevron-right"></i></button>',
		appendArrows: $(".testimonial__navigation"),
		slidesToShow: 1,
		slidesToScroll: 1,
		rtl: rtl_setting,
		responsive: [
			{
				breakpoint: 1400,
				slidesToShow: 1,
			},
			{
				breakpoint: 1200,
				slidesToShow: 1,
			},
			{
				breakpoint: 992,
				slidesToShow: 1,
			},
			{
				breakpoint: 768,
				settings: {
					slidesToShow: 1,
				},
			},
			{
				breakpoint: 480,
				settings: {
					centerMode: false,
					slidesToShow: 1,
				},
			},
		],
	});


	/*======================================
	Mesti Menu Js
	========================================*/

	$(function () {
		$('#menu').metisMenu();
	});


	/*======================================
	Count Down js
	========================================*/

	$(".banner__time").countdown("2023/10/01", function (event) {
		$(this).html(
			event.strftime(
				"<div class='count-down'>%D<span>Day</span></div><div class='count-down'>%H<span>Hour</span></div><div class='count-down'>%M<span>Min</span></div><div class='count-down'>%S<span>Sec</span></div>"
			)
		);
	});

	/*======================================
	Sportlight  js
	========================================*/
	//DOM load event
	window.addEventListener("DOMContentLoaded", () => {

		const spotlight = document.querySelector('.spotlight');

		let spotlightSize = 'transparent 10px, rgba(3, 4, 21, 1) 650px)';

		window.addEventListener('mousemove', e => updateSpotlight(e));

		window.addEventListener('mousedown', e => {

			spotlightSize = 'transparent 10px, rgba(3, 4, 21, 1) 500px)';

			updateSpotlight(e);

		});

		window.addEventListener('mouseup', e => {

			spotlightSize = 'transparent 10px, rgba(3, 4, 21, 1) 650px)';

			updateSpotlight(e);

		});

		function updateSpotlight(e) {
			if (spotlight) {
				spotlight.style.backgroundImage = `radial-gradient(circle at ${e.pageX / window.innerWidth * 100}% ${e.pageY / window.innerHeight * 100}%, ${spotlightSize}`;
			}
		}
	});

	/*======================================
	Paralax js
	========================================*/
	var b = document.getElementsByTagName("BODY")[0];

	b.addEventListener("mousemove", function (event) {
		parallaxed(event);

	});

	function parallaxed(e) {
		var amountMovedX = (e.clientX * -0.3 / 8);
		var amountMovedY = (e.clientY * -0.3 / 8);
		var x = document.getElementsByClassName("parallaxed");
		var i;
		for (i = 0; i < x.length; i++) {
			x[i].style.transform = 'translate(' + amountMovedX + 'px,' + amountMovedY + 'px)'
		}
	}

	/*======================================
	SIdebar js
	========================================*/

	$("#sidebar__active").on("click", function () {
		if (window.innerWidth > 0 && window.innerWidth <= 991) {
			$(".expovent__sidebar").toggleClass("open");
		} else {
			$(".expovent__sidebar").toggleClass("collapsed");
		}
		$(".app__offcanvas-overlay").toggleClass("overlay-open");
	});
	$(".app__offcanvas-overlay").on("click", function () {
		$(".expovent__sidebar").removeClass("collapsed");
		$(".expovent__sidebar").removeClass("open");
		$(".app__offcanvas-overlay").removeClass("overlay-open");
	});


	/*======================================
	Event popup-active js
	========================================*/

	$(".event__popup-active").on("click", function () {
		$(".event__popup-area").addClass("open");
		$(".offcanvas__overlay").addClass("overlay-open");

	});
	$(".offcanvas__overlay").on("click", function () {
		$(".event__popup-area").removeClass("open");
		$(".offcanvas__overlay").removeClass("overlay-open");

	});

	/*======================================
	Speaker popup-active js
	========================================*/

	$(".speaker__popup-active").on("click", function () {
		$(".speaker__popup-area").addClass("open");
		$(".offcanvas__overlay").addClass("overlay-open");

	});
	$(".offcanvas__overlay").on("click", function () {
		$(".speaker__popup-area").removeClass("open");
		$(".offcanvas__overlay").removeClass("overlay-open");

	});


	/*======================================
	Line-chat js
	========================================*/

	if (jQuery("#lineChart").length > 0) {

		var options = {
			series: [{
				name: 'series1',
				data: [31, 60, 50, 71, 55, 90, 100]
			}, {
				name: 'series2',
				data: [30, 65, 40, 60, 45, 100, 90]
			}],
			chart: {
				width: '100%',
				height: 275,
				foreColor: '#f00',
				type: 'line',
				toolbar: {
					show: false
				},
			},
			markers: {
				size: 0,
			},
			grid: {
				borderColor: "rgba(211, 211, 211, 0.5)",
			},
			dataLabels: {
				enabled: false
			},
			colors: ["#F87A58", "#F7426F"],
			stroke: {
				curve: 'smooth',
				width: 4,
				dropShadow: {
					enabled: true,
					top: 1,
					left: 1,
					blur: 2,
					opacity: 0.2,
				}
			},
			xaxis: {
				categories: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
				offsetY: 0,
				offsetX: 5,
				labels: {
					style: {
						colors: '#999999',
						fontSize: '13px',
						fontFamily: 'Inter',
						fontWeight: 400,
						cssClass: 'apexcharts-xaxis-label',
					},
				},
				axisTicks: {
					show: false
				},
				axisBorder: {
					show: false
				},
			},
			yaxis: {
				labels: {
					style: {
						colors: '#999999',
						fontSize: '13px',
						fontFamily: 'Inter',
						fontWeight: 100,

					},
					formatter: function (y) {
						return y.toFixed(0) + "k";
					}
				},
			},
			tooltip: {
				x: {
					format: 'dd/MM/yy HH:mm'
				},
			},
			legend: {
				show: false,
			},
			hollow: {
				margin: 20,
				size: '65%',
				background: '#fff',
				image: undefined,
				imageOffsetX: 0,
				imageOffsetY: 0,
				position: 'front',
				dropShadow: {
					enabled: true,
					top: 3,
					left: 0,
					blur: 10,
					opacity: 0.1
				}
			},
			markers: {
				hover: {
					size: 5,
					sizeOffset: 3
				}
			}

		};

		var chart = new ApexCharts(document.querySelector("#lineChart"), options);
		chart.render();
	}

	/*======================================
	Readialchat js
	========================================*/

	if (jQuery("#radialChart").length > 0) {

		var options = {
			series: [70],
			chart: {
				height: 200,
				type: 'radialBar',
				toolbar: {
					show: false
				}
			},
			plotOptions: {
				radialBar: {
					hollow: {
						size: '75%',
						background: '#2C2C2C',
						imageOffsetX: 0,
						imageOffsetY: 0,
						margin: 10,
					},
					track: {
						background: 'rgba(255, 163, 0, 0.06)',
						strokeWidth: '60%',
					},
					dataLabels: {
						show: true,
						name: {
							offsetY: -7,
							show: true,
							color: '#7C7C7C',
							fontSize: '14px',
							fontFamily: 'Inter, sans-serif',
							fontWeight: 'reguler',
						},
						value: {
							offsetY: 7,
							color: '#fff',
							fontSize: '18px',
							show: true,
							fontFamily: 'Inter, sans-serif',
							fontWeight: 'bold',
						}
					},

				},
			},
			labels: ['Total Seats'],
			fill: {
				type: "gradient",
				gradient: {
					shadeIntensity: 1,
					opacityFrom: 0.7,
					opacityTo: 0.9,
					colorStops: [
						{
							offset: 20,
							color: "#FA631E",
							opacity: 1
						},
						{
							offset: 60,
							color: "#FFAD01",
							opacity: 1
						}
					]
				}
			},
			stroke: {
				lineCap: 'round'
			},

		};

		var chart = new ApexCharts(document.querySelector("#radialChart"), options);
		chart.render();
	}

	/*======================================
	Piechart js
	========================================*/

	if (jQuery("#pieChart").length > 0) {

		var options = {
			series: [30, 30, 25, 15,],
			chart: {
				type: 'donut',
				width: 320,
			},
			stroke: {
				show: true,
				width: 0,
			},
			dataLabels: {
				style: {
					colors: ["#fff"],
					fontSize: '12px',
					fontFamily: 'Inter, sans-serif',
					fontWeight: 600,
				},
			},
			plotOptions: {
				pie: {
					startAngle: 0,
					endAngle: 360,
					expandOnClick: true,
					customScale: 1,
					donut: {
						size: '55%',
						background: '#2C2C2C',
					},
				}
			},
			labels: ["Direct", "Email", "Social", "Others"],
			colors: ["#F7B84B", "#405189", "#299CDB", "#F06548"],
			legend: {
				show: true,
				position: 'bottom',
				verticalAlign: 'bottom',
				align: 'center',
				fontSize: '14px',
				colors: ["#F7B84B"],
				fontWeight: 400,
				labels: {
					colors: ["#7C7C7C"],
				},
				markers: {
					width: 8,
					height: 8,
					strokeWidth: 0,
					strokeColor: '#fff',
					radius: 12,
					offsetX: -2,
					offsetY: 0,
				},
				itemMargin: {
					horizontal: 5,
					vertical: 0
				},
				onItemClick: {
					toggleDataSeries: true
				},
				onItemHover: {
					highlightDataSeries: true
				},
			},
			responsive: [{
				breakpoint: 450,
				options: {
					chart: {
						width: 280
					},
				}
			}]
		};

		var chart = new ApexCharts(document.querySelector("#pieChart"), options);
		chart.render();
	}


	/*======================================
	Ccalendar js
	========================================*/

	const daysTag = document.querySelector(".days"),
		currentDate = document.querySelector(".current-date"),
		prevNextIcon = document.querySelectorAll(".calendar__navigation span");

	// getting new date, current year and month
	let date = new Date(),
		currYear = date.getFullYear(),
		currMonth = date.getMonth();

	// storing full name of all months in array
	const months = ["January", "February", "March", "April", "May", "June", "July",
		"August", "September", "October", "November", "December"];

	const renderCalendar = () => {
		let firstDayofMonth = new Date(currYear, currMonth, 1).getDay(), // getting first day of month
			lastDateofMonth = new Date(currYear, currMonth + 1, 0).getDate(), // getting last date of month
			lastDayofMonth = new Date(currYear, currMonth, lastDateofMonth).getDay(), // getting last day of month
			lastDateofLastMonth = new Date(currYear, currMonth, 0).getDate(); // getting last date of previous month
		let liTag = "";

		for (let i = firstDayofMonth; i > 0; i--) { // creating li of previous month last days
			liTag += `<li class="inactive">${lastDateofLastMonth - i + 1}</li>`;
		}

		for (let i = 1; i <= lastDateofMonth; i++) { // creating li of all days of current month
			// adding active class to li if the current day, month, and year matched
			let isToday = i === date.getDate() && currMonth === new Date().getMonth()
				&& currYear === new Date().getFullYear() ? "active" : "";
			liTag += `<li class="${isToday}">${i}</li>`;
		}

		for (let i = lastDayofMonth; i < 6; i++) { // creating li of next month first days
			liTag += `<li class="inactive">${i - lastDayofMonth + 1}</li>`
		}
		(currentDate) && (currentDate.innerText = `${months[currMonth]} ${currYear}`); // passing current mon and yr as currentDate text
		daysTag && (daysTag.innerHTML = liTag);
	}
	renderCalendar();

	prevNextIcon.forEach(icon => { // getting prev and next icons
		icon.addEventListener("click", () => { // adding click event on both icons
			// if clicked icon is previous icon then decrement current month by 1 else increment it by 1
			currMonth = icon.id === "prev" ? currMonth - 1 : currMonth + 1;

			if (currMonth < 0 || currMonth > 11) { // if current month is less than 0 or greater than 11
				// creating a new date of current year & month and pass it as date value
				date = new Date(currYear, currMonth);
				currYear = date.getFullYear(); // updating current year with new date year
				currMonth = date.getMonth(); // updating current month with new date month
			} else {
				date = new Date(); // pass the current date as date value
			}
			renderCalendar(); // calling renderCalendar function
		});
	});

	/*======================================
	Scrollbar js
	========================================*/

	var Scrollbar = window.Scrollbar;

	const customizeOptions = {
		'damping': 0.1,
		'thumbMinSize': 5,
	}

	$(".card__scroll").map(function (i, element) {
		Scrollbar.init(element, options)
	})

	/*======================================
	Dropdown action  js
	========================================*/

    $(".dropdown").click(function(){
		$(this).find(".dropdown-list").fadeToggle(100);
	  });
	$(document).on("click", function(event){
	  var $trigger = $(".dropdown");
	  if($trigger !== event.target && !$trigger.has(event.target).length){
		$(".dropdown-list").fadeOut(100);
	  }
	});

	/*======================================
	Notifydropdown Js
	========================================*/
	
	$("#notifydropdown").on("click", function () {
		$(".notification__dropdown").toggleClass("notifydropdown-enable");
		$(".body__overlay").toggleClass("notifydropdown-enable");
		$(".email__dropdown").removeClass("email-enable");
		$(".user__dropdown").removeClass("user-enable");
		$(".lang__dropdown").removeClass("lang-enable");
		
	  });
	  $(".body__overlay").on("click", function () {
		$(".notification__dropdown").removeClass("notifydropdown-enable");
		$(".body__overlay").removeClass("notifydropdown-enable");
	  });


	/*======================================
	Emaildropdown Js
	========================================*/

	  $("#emaildropdown").on("click", function () {
		$(".email__dropdown").toggleClass("email-enable");
		$(".body__overlay").toggleClass("email-enable");
		$(".user__dropdown").removeClass("user-enable");
		$(".lang__dropdown").removeClass("lang-enable");
		$(".notification__dropdown").removeClass("notifydropdown-enable");
	  });
	  $(".body__overlay").on("click", function () {
		$(".email__dropdown").removeClass("email-enable");
		$(".body__overlay").removeClass("email-enable");
		
	  });

	/*======================================
	 Userdropdown Js
	========================================*/
	  $("#userportfolio").on("click", function () {
		$(".user__dropdown").toggleClass("user-enable");
		$(".body__overlay").toggleClass("user-enable");
		$(".notification__dropdown").removeClass("notifydropdown-enable");
		$(".email__dropdown").removeClass("email-enable");
		$(".lang__dropdown").removeClass("lang-enable");
	  });
	  $(".body__overlay").on("click", function () {
		$(".user__dropdown").removeClass("user-enable");
		$(".body__overlay").removeClass("user-enable");
	  });

	/*======================================
	 langdropdown Js
	========================================*/
	  $("#langdropdown").on("click", function () {
		$(".lang__dropdown").toggleClass("lang-enable");
		$(".body__overlay").toggleClass("lang-enable");
		$(".notification__dropdown").removeClass("notifydropdown-enable");
		$(".email__dropdown").removeClass("email-enable");
		$(".user__dropdown").removeClass("user-enable");
	  });
	  $(".body__overlay").on("click", function () {
		$(".lang__dropdown").removeClass("lang-enable");
		$(".body__overlay").removeClass("lang-enable");
	  });
	
	  
})(jQuery);



