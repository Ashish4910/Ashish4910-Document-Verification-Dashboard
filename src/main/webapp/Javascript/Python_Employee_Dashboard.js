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



function submitForm() {
	document.getElementById("processForm").submit();
}

function processOption(optionValue) {
	if (optionValue === 'download.jsp') {
		window.location.href = 'download.jsp';
	} else if (optionValue === 'Dashboard_1.jsp') {
		window.location.href = 'Dashboard_1.jsp';
	} else if (optionValue === 'Employee_Dashboard.jsp') {
		var statusDisplay = document.getElementById("statusDisplay");
		var statusMessage = document.getElementById("statusMessage").value;
		statusDisplay.innerHTML = statusMessage;
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

function generateAndSetBatchId() {
	var random = Math.floor(Math.random() * 900) + 100;
	var batchId = random;
	alert("Batch Id:-" + batchId);

	// Set the generated batch ID as the value of the hidden input field
	document.getElementById("batchId").value = batchId;
}

