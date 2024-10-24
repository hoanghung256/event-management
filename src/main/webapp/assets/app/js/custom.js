/*======================================
FullScreen Js
========================================*/
function toggleFullScreen() {
	if (
		(document.fullScreenElement && document.fullScreenElement !== null) ||
		(!document.mozFullScreen && !document.webkitIsFullScreen)
	) {
		if (document.documentElement.requestFullScreen) {
			document.documentElement.requestFullScreen();
		} else if (document.documentElement.mozRequestFullScreen) {
			document.documentElement.mozRequestFullScreen();
		} else if (document.documentElement.webkitRequestFullScreen) {
			document.documentElement.webkitRequestFullScreen(
				Element.ALLOW_KEYBOARD_INPUT
			);
		}
	} else {
		if (document.cancelFullScreen) {
			document.cancelFullScreen();
		} else if (document.mozCancelFullScreen) {
			document.mozCancelFullScreen();
		} else if (document.webkitCancelFullScreen) {
			document.webkitCancelFullScreen();
		}
	}
}

document.addEventListener('DOMContentLoaded', function() {
    let dateTags = document.querySelectorAll("#date");
    let timeTags = document.querySelectorAll("#time");
    let datetimeTags = document.querySelectorAll("#datetime");

    if (dateTags !== null) {
        dateTags.forEach(tag => {
            if (tag.textContent === null) {
                tag.textContent = "";
                continue;
            }
            let formatDate = new Date(tag.textContent).toLocaleDateString("en-UK");
            tag.textContent = formatDate;
        });
    }
    
    if (timeTags !== null) {
        timeTags.forEach(tag => {
            if (tag.textContent === null) {
                tag.textContent = "";
                continue;
            }
            let formatTime = tag.textContent.slice(0, 5);
            
            tag.textContent = formatTime;
        });
    }
    
    if (datetimeTags !== null) {
        datetimeTags.forEach(tag => {
            if (tag.textContent === null) {
                tag.textContent = "";
                continue;
            }
            let datetime = new Date(tag.textContent);

            let formattedTime = datetime.toString().substring(16, 21);;
            let formattedDate = `${datetime.getMonth() + 1}/${datetime.getDate()}/${datetime.getFullYear()}`;

            tag.textContent = `${formattedTime} - ${formattedDate}`;
        });
    }
});
