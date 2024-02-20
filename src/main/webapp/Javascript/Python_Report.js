// JavaScript to handle form submission

function logout() {
	window.location.href = 'logout'; // Redirect to the logout page
}
function uploadFile(input) {
	var fileInput = input;
	var files = fileInput.files;
	if (files.length > 0) {
		fileInput.closest('form').submit();
	}
}
function showSelectedEmail(selectElement) {
	var selectedValue = selectElement.value;
	if (selectedValue === 'logout') {
		window.location.href = 'logout'; // Redirect to the logout page
	} else {
		var emailDisplay = document.getElementById("emailDisplay");
		emailDisplay.innerHTML = selectedValue;
	}
}
function showEmail() {
	var emailDisplay = document.getElementById("emailDisplay");
	emailDisplay.style.display = "block";
}
