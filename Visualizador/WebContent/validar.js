function checkSubmit(){ 

	document.formularioA.button.disabled = true
	document.formularioA.button.value = "Displaying..."
	//Comprobacion de la primera ontologia

	url1 = document.formularioA.urlOntologia1.value
	file1 = document.formularioA.archivoOntologia1.value
	
	if (url1 != "") {
		if (file1 != "") {
		document.formularioA.button.value = "Display"
		document.formularioA.button.disabled = false
		alert ("Sorry, you have entered two ontologyes for Ontology1")
		document.formularioA.urlOntologia1.focus()
		return 0;
		}
		else {
			document.formularioA.modo1.value = "URL"
		}
	}
	else {
		if (file1 == "") {
		document.formularioA.button.value = "Display"
		document.formularioA.button.disabled = false
		alert ("Sorry, you dont have entered an ontology for Ontology1")
		document.formularioA.urlOntologia1.focus() 
		return 0;
		}
		else {
			document.formularioA.modo1.value = "file"
		}
	}

	//Comprobacion de la segunda ontologia

	url2 = document.formularioA.urlOntologia2.value
	file2 = document.formularioA.archivoOntologia2.value
	
	if (url2 != "") {
		if (file2 != "") {
		document.formularioA.button.value = "Display"
		document.formularioA.button.disabled = false
		alert ("Sorry, you have entered two ontologyes for Ontology2")
		document.formularioA.urlOntologia2.focus() 
		return 0;
		}
		else {
			document.formularioA.modo2.value = "URL"
		}
	}
	else {
		if (file2 == "") {
		document.formularioA.button.value = "Display"
		document.formularioA.button.disabled = false
		alert ("Sorry, you dont have entered an ontology for Ontology2")
		document.formularioA.urlOntologia2.focus() 
		return 0;
		}
		else {
			document.formularioA.modo2.value = "file"
		}
	}

	//Comprobacion de la segunda ontologia

	urlA = document.formularioA.urlAlignment.value
	fileA = document.formularioA.archivoAlignment.value
	
	if (urlA != "") {
		if (fileA != "") {
		document.formularioA.button.value = "Display"
		document.formularioA.button.disabled = false
		alert ("Sorry, you have entered two aligments")
		document.formularioA.urlAlignment.focus() 
		return 0;
		}
		else {
			document.formularioA.modoA.value = "URL"
		}
	}
	else {
		if (fileA == "") {
		document.formularioA.button.value = "Display"
		document.formularioA.button.disabled = false
		alert ("Sorry, you dont have entered an aligment")
		document.formularioA.urlAlignment.focus() 
		return 0;
		}
		else {
			document.formularioA.modoA.value = "file"
		}
	}
	

	document.formularioA.submit();
}

